# Packages and installation

Compiled APKs are attached to GitHub Releases, not stored in Git. The latest
set is
[`v2026.09.09-battery`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.09-battery).

| Package | Purpose |
| --- | --- |
| `linux-postmarketos-qcom-msm8953-7.0.9-r25.apk` | Cumulative USB OTG and PMI632 QGauge kernel. |
| `postmarketos-base-ui-networkmanager-usb-tethering-51-r2.apk` | Avoid a delayed gadget rebind after the role changes to HOST. |
| `postmarketos-onclite-usb-gadget-lifecycle-1-r0.apk` | Restore the existing NCM gadget after DEVICE returns. |

The two userspace packages are unchanged from the earlier
[`v2026.09.07-usb-otg`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.07-usb-otg)
release.

## Exact compatibility

- Xiaomi Redmi 7 Global (`xiaomi,onclite`, `M1810F6LG`), `aarch64`;
- postmarketOS `v26.06`, tested with Plasma Mobile;
- Linux runtime ABI `7.0.9-msm8953`;
- tested upgrade from kernel package
  `linux-postmarketos-qcom-msm8953-7.0.9-r16`;
- tethering package `51-r2` and onclite gadget-lifecycle package `1-r0`.

Root and `/boot` were on microSD during testing. The released APKs contain no
installation UUIDs or phone-specific boot image. Other storage layouts and
Redmi 7 variants have not been validated. The persistent upgrade was tested
from r16; a direct r0-to-r25 installation was not physically tested.

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
  postmarketos-base-ui-networkmanager-usb-tethering \
  postmarketos-onclite-usb-gadget-lifecycle
```

The tested target reports `xiaomi,onclite`, `aarch64`, `7.0.9-msm8953` and
the package versions above. Simulate the complete set:

```sh
sudo apk add --simulate --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r25.apk \
  ./postmarketos-base-ui-networkmanager-usb-tethering-51-r2.apk \
  ./postmarketos-onclite-usb-gadget-lifecycle-1-r0.apk
```

Continue only if the simulation shows the expected kernel replacement and no
removal or unrelated package change. Repeat without `--simulate`, run `sync`,
then reboot normally with a working recovery path available.

After reboot, check the kernel, battery and USB DEVICE mode before trying OTG:

```sh
apk info -v linux-postmarketos-qcom-msm8953
uname -r
cat /sys/class/power_supply/qg-battery/status
cat /sys/class/power_supply/qg-battery/capacity
```

Battery capacity is approximate. R25 observes charger state but does not
configure charging policy. Test an empty OTG adapter before a low-power
peripheral and do not use the phone as a supply above `500 mA`.

## Roll back

Download the r16 kernel APK from
[`v2026.09.07-usb-otg`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.07-usb-otg),
verify its SHA-256, then simulate replacing r25:

```sh
sudo apk add --simulate --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r16.apk
```

Continue only if the kernel is the sole package change. Repeat without
`--simulate`, run `sync` and reboot. The USB userspace packages remain
compatible with r16 and do not need to be removed.

The exact tested kernel aports are retained under
[`linux-postmarketos-qcom-msm8953-r25/`](linux-postmarketos-qcom-msm8953-r25/)
and
[`linux-postmarketos-qcom-msm8953-r16/`](linux-postmarketos-qcom-msm8953-r16/).
The userspace sources are introduced by the two patches under
[`../patches/pmaports/`](../patches/pmaports/).
