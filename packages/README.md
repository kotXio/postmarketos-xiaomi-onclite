# Packages and installation

Compiled APKs are attached to GitHub Releases, not stored in Git. The latest
set is
[`v2026.09.11-sensors`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.11-sensors).

| Package | Purpose |
| --- | --- |
| `linux-postmarketos-qcom-msm8953-7.0.9-r28.apk` | Cumulative USB OTG, QGauge and Qualcomm Sensor Manager kernel. |
| `sns-reg-0.1_git20250706-r4.apk` | Sensor Registry server and generator. |
| `sns-reg-systemd-0.1_git20250706-r4.apk` | Starts the registry service early enough for Sensor Manager discovery. |

The existing tethering `51-r2` and onclite gadget-lifecycle `1-r0` packages
from
[`v2026.09.09-battery`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.09-battery)
remain required for complete USB DEVICE/HOST recovery and are not duplicated
in this Release.

## Exact compatibility

- Xiaomi Redmi 7 Global (`xiaomi,onclite`, `M1810F6LG`), `aarch64`;
- postmarketOS `v26.06`, tested with Plasma Mobile;
- Linux runtime ABI `7.0.9-msm8953`;
- cumulative kernel r25 USB/QGauge release as the starting point;
- `msm-firmware-loader-systemd`, tethering `51-r2` and onclite
  gadget-lifecycle `1-r0` installed;
- root and `/boot` on microSD.

The Sensor Registry service reads `persist/sensors/sns.reg` from that phone's
existing read-only firmware mount. Do not copy a registry from another phone.
No registry, calibration value or generated configuration is supplied by this
project.

## Install

Download the three APKs and `SHA256SUMS` from the Release into one empty
directory. Verify the files and target:

```sh
sha256sum -c SHA256SUMS

tr '\0' '\n' < /sys/firmware/devicetree/base/compatible |
  grep -Fx xiaomi,onclite
uname -m
uname -r
apk info -v linux-postmarketos-qcom-msm8953 \
  msm-firmware-loader-systemd \
  postmarketos-base-ui-networkmanager-usb-tethering \
  postmarketos-onclite-usb-gadget-lifecycle \
  sns-reg sns-reg-systemd
```

Keep a working lk2nd or TWRP recovery path. Simulate the complete local
transaction:

```sh
sudo apk add --simulate --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r28.apk \
  ./sns-reg-0.1_git20250706-r4.apk \
  ./sns-reg-systemd-0.1_git20250706-r4.apk
```

Continue only if the simulation shows the expected kernel and Sensor Registry
changes without removing or changing unrelated packages. Repeat without
`--simulate`, enable the service, synchronize storage and reboot:

```sh
sudo apk add --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r28.apk \
  ./sns-reg-0.1_git20250706-r4.apk \
  ./sns-reg-systemd-0.1_git20250706-r4.apk
sudo systemctl daemon-reload
sudo systemctl enable sns-reg.service
sync
sudo reboot
```

After reboot, confirm the package versions, services and IIO devices:

```sh
apk info -v linux-postmarketos-qcom-msm8953 sns-reg sns-reg-systemd
systemctl is-active sns-reg.service iio-sensor-proxy.service
systemctl show -p NRestarts sns-reg.service iio-sensor-proxy.service

for path in /sys/bus/iio/devices/iio:device*; do
  printf '%s: ' "$path"
  cat "$path/name"
done
```

Expected sensor names are `qcom-smgr-accel`, `qcom-smgr-mag`,
`qcom-smgr-prox-light` and `qcom-smgr-light`. In Plasma Mobile, set
Auto-rotate to `Always`.

## Roll back

Use the r25 kernel APK from
[`v2026.09.09-battery`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.09-battery).
Verify its SHA-256, then simulate both parts of the rollback:

```sh
sudo apk add --simulate --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r25.apk
sudo apk del --simulate sns-reg-systemd sns-reg
```

If both simulations are limited to those packages, stop the service, restore
r25, remove the Sensor Registry packages and reboot:

```sh
sudo systemctl disable --now sns-reg.service
sudo apk add --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r25.apk
sudo apk del sns-reg-systemd sns-reg
sudo systemctl daemon-reload
sync
sudo reboot
```

The package sources used for this release are retained under
[`linux-postmarketos-qcom-msm8953-r28/`](linux-postmarketos-qcom-msm8953-r28/)
and [`sns-reg-r4/`](sns-reg-r4/).
