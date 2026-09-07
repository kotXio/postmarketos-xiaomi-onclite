# Packages and installation

Compiled APKs are attached to GitHub Releases, not stored in Git. The first
binary set is
[`v2026.09.07-usb-otg`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.07-usb-otg).

| Package | Purpose |
| --- | --- |
| `linux-postmarketos-qcom-msm8953-7.0.9-r16.apk` | Cumulative onclite USB OTG kernel. |
| `postmarketos-base-ui-networkmanager-usb-tethering-51-r2.apk` | Avoid a delayed gadget rebind after the role changed to HOST. |
| `postmarketos-onclite-usb-gadget-lifecycle-1-r0.apk` | Restore the existing NCM gadget after DEVICE returns. |

## Exact compatibility

- Xiaomi Redmi 7 (`xiaomi,onclite`), `aarch64`;
- postmarketOS `v26.06`, tested with Plasma Mobile;
- Linux runtime ABI `7.0.9-msm8953`;
- starting kernel package
  `linux-postmarketos-qcom-msm8953-7.0.9-r0`;
- starting tethering package
  `postmarketos-base-ui-networkmanager-usb-tethering-51-r0`;
- no pre-existing `postmarketos-onclite-usb-gadget-lifecycle` package.

The test installation used root and `/boot` on microSD. The released APKs do
not contain that installation's UUIDs or a phone-specific boot image, but a
different storage or software layout has not been validated.

## Install

Download the three APKs and `SHA256SUMS` from the Release into one empty
directory. Verify both the files and target before changing packages:

```sh
sha256sum -c SHA256SUMS

tr '\0' '\n' < /sys/firmware/devicetree/base/compatible |
  grep -Fx xiaomi,onclite
uname -m
uname -r
apk info -v linux-postmarketos-qcom-msm8953 \
  postmarketos-base-ui-networkmanager-usb-tethering
```

The expected target is `xiaomi,onclite`, `aarch64`, `7.0.9-msm8953` and the
two exact starting package versions above. Simulate all three changes together:

```sh
sudo apk add --simulate --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r16.apk \
  ./postmarketos-base-ui-networkmanager-usb-tethering-51-r2.apk \
  ./postmarketos-onclite-usb-gadget-lifecycle-1-r0.apk
```

Continue only if the simulation shows the kernel and tethering upgrades, one
new lifecycle package, and no removals or unrelated changes. Repeat the same
command without `--simulate`, run `sync`, then reboot with a recovery path
available.

After reboot, confirm DEVICE/NCM first. Test an empty OTG adapter before trying
a low-power peripheral. Do not use the phone as a supply above `500 mA`.

## Roll back

Use the configured postmarketOS `v26.06` repositories to simulate restoration
of kernel `7.0.9-r0` and tethering `51-r0`, and simulate removal of the
onclite lifecycle package. Continue only if no unrelated package changes. If
those exact versions are unavailable, reinstall the matching official
postmarketOS image rather than mixing package baselines.

The exact r16 kernel aport is in
[`linux-postmarketos-qcom-msm8953-r16/`](linux-postmarketos-qcom-msm8953-r16/).
The userspace package sources are introduced by the two pmaports patches under
[`../patches/pmaports/`](../patches/pmaports/).
