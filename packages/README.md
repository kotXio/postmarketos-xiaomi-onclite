# Packages and installation

Compiled APKs are attached to GitHub Releases, not stored in Git. The latest
set is
[`v2026.09.11-audio`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.11-audio).

| Package | Purpose |
| --- | --- |
| `linux-postmarketos-qcom-msm8953-7.0.9-r31.apk` | Cumulative USB OTG, QGauge, Sensor Manager and AW87329 kernel. |
| `soc-qcom-msm8953-ucm-19-r4.apk` | Onclite speaker route, PCM-scoped amplifier gate and default Mic2 profile. |

Kernel r28 and the `sns-reg r4` pair from
[`v2026.09.11-sensors`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.11-sensors)
form the required starting point and are not duplicated in this Release.

## Exact compatibility

- Xiaomi Redmi 7 Global (`xiaomi,onclite`, `M1810F6LG`), `aarch64`;
- postmarketOS `v26.06`, Plasma Mobile and PulseAudio;
- Linux runtime ABI `7.0.9-msm8953`;
- cumulative kernel r28 and `sns-reg`/`sns-reg-systemd` r4 installed;
- `soc-qcom-msm8953-ucm-19-r0` installed;
- `msm-firmware-loader-systemd`, tethering `51-r2` and onclite
  gadget-lifecycle `1-r0` installed;
- root and `/boot` on microSD.

The matching phone must expose its own stock `aw87329_kspk.bin` at
`/run/msm-firmware-loader/target/aw87329_kspk.bin`. No amplifier firmware is
included. Keep a local copy of the current UCM r0 APK and the r28 kernel APK
before installing so both packages can be rolled back together.

## Install

Download the two APKs and `SHA256SUMS` from the Release into one empty
directory. Verify the files and target:

```sh
sha256sum -c SHA256SUMS

tr '\0' '\n' < /sys/firmware/devicetree/base/compatible |
  grep -Fx xiaomi,onclite
uname -m
uname -r
findmnt -no SOURCE /
findmnt -no SOURCE /boot
apk info -v linux-postmarketos-qcom-msm8953 \
  soc-qcom-msm8953-ucm \
  msm-firmware-loader-systemd \
  postmarketos-base-ui-networkmanager-usb-tethering \
  postmarketos-onclite-usb-gadget-lifecycle \
  sns-reg sns-reg-systemd
ls -l /run/msm-firmware-loader/target/aw87329_kspk.bin
```

Keep a working lk2nd or TWRP recovery path. Simulate the complete local
transaction:

```sh
sudo apk add --simulate --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r31.apk \
  ./soc-qcom-msm8953-ucm-19-r4.apk
```

Continue only if the simulation upgrades those two packages without removing
or changing unrelated packages. Repeat without `--simulate`, synchronize
storage and reboot:

```sh
sudo apk add --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r31.apk \
  ./soc-qcom-msm8953-ucm-19-r4.apk
sync
sudo reboot
```

After reboot, confirm the package versions and audio defaults:

```sh
apk info -v linux-postmarketos-qcom-msm8953 soc-qcom-msm8953-ucm
pactl list cards | sed -n '/Active Profile:/p'
pactl get-default-sink
pactl get-default-source
```

The expected profile is `HiFi (Mic2, Speaker)`. If needed, select it with:

```sh
pactl set-card-profile 0 'HiFi (Mic2, Speaker)'
```

Before playback, leave audio idle and confirm that the final amplifier gate is
off:

```sh
amixer -c 0 cget name='Speaker Amp Enable Switch'
```

Start playback at a low waveform level and use the default PulseAudio sink.
The amplifier gate must return to `off` after playback closes.

## Roll back

Use kernel r28 from
[`v2026.09.11-sensors`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.11-sensors)
and the UCM r0 APK saved before installation. Verify both files, then simulate
the rollback:

```sh
sudo apk add --simulate --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r28.apk \
  ./soc-qcom-msm8953-ucm-19-r0.apk
```

If no unrelated package changes are proposed, restore both packages and
reboot:

```sh
sudo apk add --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r28.apk \
  ./soc-qcom-msm8953-ucm-19-r0.apk
sync
sudo reboot
```

The Sensor Registry r4 packages remain installed. Package sources used for
this release are retained under
[`linux-postmarketos-qcom-msm8953-r31/`](linux-postmarketos-qcom-msm8953-r31/)
and [`soc-qcom-msm8953-ucm-r4/`](soc-qcom-msm8953-ucm-r4/).
