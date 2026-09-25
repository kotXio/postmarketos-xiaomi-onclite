# Packages and installation

Compiled APKs are attached to GitHub Releases, not stored in Git.

## Rear-camera packages

The rear-camera set is
[`v2026.09.25-cameras`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.25-cameras).

| Package | Purpose |
| --- | --- |
| `linux-postmarketos-qcom-msm8953-7.0.9-r56.apk` | Cumulative kernel with OV12A10 and OV02A10 support. |
| `libcamera-99990.7.1-r6.apk` | Matching libcamera core and Simple pipeline. |
| `libcamera-ipa-99990.7.1-r6.apk` | Matching signed IPA modules. |
| `libcamera-tools-99990.7.1-r6.apk` | `cam` and `lc-compliance` command-line tools. |
| `libcamera-gstreamer-99990.7.1-r6.apk` | Matching GStreamer `libcamerasrc` plugin. |

### Exact compatibility

- Xiaomi Redmi 7 Global (`xiaomi,onclite`, `M1810F6LG`), `aarch64`;
- postmarketOS `v26.06`, Alpine `3.24` and Linux runtime ABI
  `7.0.9-msm8953`;
- microSD root and `/boot`;
- cumulative kernel r31 or the tested intermediate camera kernel r54;
- distribution libcamera/IPA `99990.7.1-r0` as the starting userspace;
- one `cma=128M` kernel command-line entry for full-resolution OV12A10
  capture.

The tools package requires the unmodified Alpine `gtest 1.17.0-r1` runtime.
Install it from the matching configured postmarketOS/Alpine repository if it
is not already present; it is not duplicated in this Release.

Keep the current kernel and libcamera core/IPA APKs before upgrading, and keep
a working recovery path. Close every camera application. Download the five
APKs and `SHA256SUMS` into one empty directory and verify them:

```sh
sha256sum -c SHA256SUMS

tr '\0' '\n' < /sys/firmware/devicetree/base/compatible |
  grep -Fx xiaomi,onclite
uname -m
uname -r
findmnt -no SOURCE /
findmnt -no SOURCE /boot
apk info -v linux-postmarketos-qcom-msm8953 libcamera libcamera-ipa gtest
```

Create the camera CMA setting only if the command line does not already contain
exactly one `cma=128M` entry:

```sh
grep -o 'cma=[^ ]*' /proc/cmdline
sudo install -d -m 0755 /etc/kernel-cmdline.d
printf '%s\n' 'cma=128M' |
  sudo tee /etc/kernel-cmdline.d/91-onclite-camera-cma.conf >/dev/null
```

Simulate the complete local transaction:

```sh
sudo apk add --simulate --no-network --allow-untrusted \
  ./linux-postmarketos-qcom-msm8953-7.0.9-r56.apk \
  ./libcamera-99990.7.1-r6.apk \
  ./libcamera-ipa-99990.7.1-r6.apk \
  ./libcamera-tools-99990.7.1-r6.apk \
  ./libcamera-gstreamer-99990.7.1-r6.apk
```

Continue only if those packages change without removing or changing unrelated
packages. Repeat without `--simulate`, synchronize storage and reboot. The
kernel installation regenerates the initramfs and boot configuration.

After reboot, verify the installed versions, CMA reservation and camera list:

```sh
apk info -v linux-postmarketos-qcom-msm8953 \
  libcamera libcamera-ipa libcamera-tools libcamera-gstreamer
grep -o 'cma=[^ ]*' /proc/cmdline
grep '^CmaTotal:' /proc/meminfo
cam -l
```

Expected native RAW modes are OV12A10 `4096x3072` and OV02A10 `1600x1200`.
See [results and limits](../fixes/rear-cameras.md).

### Roll back

Restore the exact kernel and libcamera core/IPA APKs saved before installation.
Remove `libcamera-tools` and `libcamera-gstreamer` only if they were absent
before this update. Remove
`/etc/kernel-cmdline.d/91-onclite-camera-cma.conf` only if it was created for
this release, then reinstall the previous kernel so the boot configuration is
regenerated. Simulate every package transaction first and reboot after the
kernel rollback. Remove `gtest` only if this release introduced it and no
remaining package depends on it.

The exact source aports are retained under
[`linux-postmarketos-qcom-msm8953-r56/`](linux-postmarketos-qcom-msm8953-r56/)
and [`libcamera-r6/`](libcamera-r6/).

## Speaker and Mic2 packages

The speaker set is
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

## Qt application packages

This userspace update is separate from the kernel/UCM installation above.
It changes no firmware, service, microphone gain or audio route.

| Package | Purpose |
| --- | --- |
| `qt6-qtmultimedia-6.11.1-r1.apk` | Process-local recording queue repair. |
| `qt6-qtmultimedia-ffmpeg-6.11.1-r1.apk` | Matching FFmpeg backend used by KRecorder. |
| `qt6-qtmultimedia-gstreamer-6.11.1-r1.apk` | Matching GStreamer runtime plugin. |
| `qt6-qtwebengine-6.11.1-r10.apk` | Linux V4L2 decoding and multi-planar video presentation. |

Tested baseline: Redmi 7 (`xiaomi,onclite`, `M1810F6LG`), `aarch64`,
postmarketOS `v26.06` / Alpine `3.24`, Plasma Mobile, Qt `6.11.1`,
FFmpeg `8.1.2` and PulseAudio `17.0-r7`, with kernel r31 and UCM r4.
Starting versions were Multimedia `6.11.1-r0` and WebEngine `6.11.1-r3`;
KRecorder and Angelfish `26.04.2-r0` are unchanged.
Do not force these APKs over newer Qt versions or a different ABI.

See [KRecorder](../fixes/krecorder.md) and [Angelfish](../fixes/angelfish.md)
for validation limits. WebEngine is a dated Chromium 140 build, not an ongoing
security-update channel.

Save the four prior APKs and any existing per-user KRecorder/Angelfish desktop
entries before changing them. Close both applications. Download the four
runtime APKs and `SHA256SUMS` from
[`v2026.09.12-qt-apps`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.12-qt-apps),
verify them, and simulate this explicit local transaction:

```sh
sha256sum -c SHA256SUMS
apk info -v | grep -E '^qt6-(qtmultimedia(-ffmpeg|-gstreamer)?|qtwebengine)-[0-9]'
sudo apk add --simulate --no-network --allow-untrusted \
  ./qt6-qtmultimedia-6.11.1-r1.apk \
  ./qt6-qtmultimedia-ffmpeg-6.11.1-r1.apk \
  ./qt6-qtmultimedia-gstreamer-6.11.1-r1.apk \
  ./qt6-qtwebengine-6.11.1-r10.apk
```

Continue only if those four packages are upgraded with nothing else added,
removed or changed. Repeat without `--simulate`; no reboot is required.
`--allow-untrusted` allows these locally signed files but does not establish
publisher authenticity; verify the download source and checksums. It is not
a setting for general package upgrades.

Apply the per-user launcher settings in [KRecorder](../fixes/krecorder.md)
and [Angelfish](../fixes/angelfish.md), then reopen the apps from Plasma icons.
The library packages alone do not enable the application-local settings.

For rollback, close the apps, simulate installing the saved Multimedia r0
base/FFmpeg/GStreamer APKs and WebEngine r3 APK, and proceed only if those four
packages change. Restore the saved desktop entries, or remove only the
overrides created by this procedure if none existed before. Reopen the apps;
do not restore an old APK database or reboot for this library-only change.

Sources are in [Multimedia r1](qt6-qtmultimedia-r1/README.md) and
[WebEngine r10](qt6-qtwebengine-r10/README.md).
