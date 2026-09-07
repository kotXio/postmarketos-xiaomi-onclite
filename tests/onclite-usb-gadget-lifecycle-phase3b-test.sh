#!/bin/sh
set -eu

repo="${1:?usage: $0 PMAPORTS_WORKTREE}"
base_ui="$repo/main/postmarketos-base-ui"
lifecycle="$repo/device/testing/postmarketos-onclite-usb-gadget-lifecycle"
dispatcher="$base_ui/rootfs-usr-lib-NetworkManager-dispatcher.d-50-tethering.sh"
helper="$lifecycle/postmarketos-onclite-usb-gadget-bind"

fail()
{
	printf 'FAIL: %s\n' "$*" >&2
	exit 1
}

[ -f "$dispatcher" ] || fail "dispatcher is missing"
! grep -Fq 'mount -t configfs none /config' "$dispatcher" ||
	fail "dispatcher still creates a secondary /config mount"
! grep -Fq 'rm -rf /config' "$dispatcher" ||
	fail "dispatcher still removes a mounted configfs path"
grep -Fq 'flock -x 9' "$dispatcher" ||
	fail "dispatcher does not serialize gadget changes"
grep -Fq '/sys/kernel/config' "$dispatcher" ||
	fail "dispatcher does not use canonical configfs"

for file in \
	"$lifecycle/APKBUILD" \
	"$helper" \
	"$lifecycle/postmarketos-onclite-usb-gadget-bind@.service" \
	"$lifecycle/90-postmarketos-onclite-usb-gadget.rules"
do
	[ -f "$file" ] || fail "missing $file"
done

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

configfs="$tmp/sys/kernel/config"
role_file="$tmp/sys/class/usb_role/7000000.usb-role-switch/role"
udc_root="$tmp/sys/class/udc"
compatible="$tmp/proc/device-tree/compatible"
lock="$tmp/run/lock/postmarketos-usb-gadget.lock"
gadget="$configfs/usb_gadget/g1"

mkdir -p \
	"$gadget/functions/ncm.usb0" \
	"$gadget/configs/c.1" \
	"$(dirname "$role_file")" \
	"$udc_root/7000000.usb" \
	"$(dirname "$compatible")" \
	"$(dirname "$lock")"
ln -s ../../../../usb_gadget/g1/functions/ncm.usb0 \
	"$gadget/configs/c.1/ncm.usb0"
printf 'xiaomi,onclite\0qcom,sdm632\0' > "$compatible"
printf 'device\n' > "$role_file"
: > "$gadget/UDC"

run_helper()
{
	PMOS_USB_GADGET_TEST=1 \
	PMOS_USB_GADGET_CONFIGFS="$configfs" \
	PMOS_USB_GADGET_ROLE_FILE="$role_file" \
	PMOS_USB_GADGET_UDC_ROOT="$udc_root" \
	PMOS_USB_GADGET_COMPATIBLE="$compatible" \
	PMOS_USB_GADGET_LOCK="$lock" \
		"$helper" 7000000.usb
}

run_helper
[ "$(cat "$gadget/UDC")" = '7000000.usb' ] ||
	fail "DEVICE did not bind the empty gadget"

run_helper
[ "$(cat "$gadget/UDC")" = '7000000.usb' ] ||
	fail "second invocation was not an idempotent no-op"

# Execute the exact dispatcher function against the fake gadget. This checks
# that the intended DHCP reactivation preserves both the UDC binding and the
# function symlink instead of deleting the configfs tree.
dispatcher_function="$tmp/reactivate-gadget.sh"
awk '
	/^reactivate_gadget\(\) \{/ { copy = 1 }
	copy { print }
	copy && /^}/ { exit }
' "$dispatcher" > "$dispatcher_function"
# shellcheck disable=SC1090
. "$dispatcher_function"
logger()
{
	:
}
sleep()
{
	:
}
# Used by the dynamically sourced dispatcher function above.
# shellcheck disable=SC2034
gadget_lock="$lock"
# shellcheck disable=SC2034
PMOS_USB_GADGET_ROLE_FILE="$role_file"
reactivate_gadget
[ "$(cat "$gadget/UDC")" = '7000000.usb' ] ||
	fail "dispatcher did not restore the original UDC"
[ -e "$gadget/configs/c.1/ncm.usb0" ] ||
	fail "dispatcher destroyed the NCM function link"
exec 9>&-

# Reproduce the real delayed-dispatcher race: the gadget is initially bound,
# but the USB role changes to HOST during the intentional one-second gap.
# A safe dispatcher must not attempt to bind a UDC that no longer belongs to
# DEVICE mode; the role-aware udev helper will restore it after DEVICE returns.
race_log="$tmp/dispatcher-race.log"
logger()
{
	printf '%s\n' "$*" >> "$race_log"
}
sleep()
{
	printf 'host\n' > "$role_file"
	chmod 400 "$gadget/UDC"
}
if ! reactivate_gadget; then
	chmod 600 "$gadget/UDC"
	fail "dispatcher tried to rebind after DEVICE changed to HOST"
fi
chmod 600 "$gadget/UDC"
exec 9>&-
[ "$(cat "$role_file")" = 'host' ] ||
	fail "race fixture did not change the USB role to HOST"
[ -z "$(cat "$gadget/UDC")" ] ||
	fail "dispatcher rebound the gadget while the USB role was HOST"
grep -Fq 'USB role is host, skipping gadget rebind' "$race_log" ||
	fail "dispatcher did not log the role-aware no-op"

printf 'device\n' > "$role_file"
run_helper
[ "$(cat "$gadget/UDC")" = '7000000.usb' ] ||
	fail "udev helper did not restore the gadget after DEVICE returned"

: > "$gadget/UDC"
printf 'host\n' > "$role_file"
run_helper
[ ! -s "$gadget/UDC" ] || fail "HOST role unexpectedly bound the gadget"

printf 'device\n' > "$role_file"
printf 'xiaomi,vince\0qcom,msm8953\0' > "$compatible"
run_helper
[ ! -s "$gadget/UDC" ] || fail "non-onclite device unexpectedly bound the gadget"

printf 'xiaomi,onclite\0qcom,sdm632\0' > "$compatible"
rm "$gadget/configs/c.1/ncm.usb0"
run_helper
[ ! -s "$gadget/UDC" ] || fail "incomplete gadget unexpectedly bound"

printf 'PASS: Phase 3b dispatcher and lifecycle helper\n'
