# Angelfish on Redmi 7

Angelfish browsing and Qualcomm Venus hardware-decoder use are verified on
onclite with Qt WebEngine `6.11.1-r10` and application-local rendering flags.
WebGL is disabled; the Chromium sandbox remains enabled.

## Install WebEngine

Use only on Xiaomi Redmi 7 (`xiaomi,onclite`), `aarch64`, postmarketOS
`v26.06` / Alpine `3.24` with Qt `6.11.1`. The tested starting package is
`qt6-qtwebengine-6.11.1-r3`; retain its APK and any existing per-user
Angelfish desktop entry before changing them.

Close Angelfish. Download `qt6-qtwebengine-6.11.1-r10.apk` and `SHA256SUMS`
from
[`v2026.09.12-qt-apps`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.12-qt-apps).
Its checksum list covers all four Qt APKs; download
all four for `sha256sum -c` even when installing only WebEngine. Then verify
and simulate the local transaction:

```sh
sha256sum -c SHA256SUMS
apk info -v | grep '^qt6-qtwebengine-[0-9]'
sudo apk add --simulate --no-network --allow-untrusted \
  ./qt6-qtwebengine-6.11.1-r10.apk
```

Continue only if WebEngine is the sole changed package, with nothing added
or removed. Repeat without `--simulate`; no reboot is needed:

```sh
sudo apk add --no-network --allow-untrusted \
  ./qt6-qtwebengine-6.11.1-r10.apk
```

The APK is locally signed. `--allow-untrusted` permits this explicit file
transaction but does not authenticate its publisher; verify the download
source and SHA-256. No signing key needs to be installed globally.

## Launcher

As the Plasma desktop user, copy
`/usr/share/applications/org.kde.angelfish.desktop` to
`~/.local/share/applications/` if no user override exists. Create the directory
if needed and save any existing override first. Preserve the rest
of the desktop entry and replace its main `Exec=` line with:

```ini
Exec=/usr/bin/env QTWEBENGINE_CHROMIUM_FLAGS="--disable-gpu-rasterization --disable-webgl --enable-features=AcceleratedVideoDecoder" /usr/bin/angelfish %u
```

Fully close the old process and reopen Angelfish from its Plasma icon.
The flags disable GPU rasterization and WebGL, not all hardware graphics.
Do not add `--no-sandbox`, `QTWEBENGINE_DISABLE_SANDBOX=1` or `--disable-gpu`.

## Result and limits

During tested YouTube playback, Angelfish held the Venus decoder device open
and Venus stayed active. Closing the video tab released the decoder and
returned Venus to suspended, with no new matching errors in the test window.

This confirms hardware-decoder use for the observed playback, not every
stream or codec/profile. Another interval showed no Venus activity; its
cause and the active interval's exact codec were not established.
CPU savings were not measured in a controlled comparison on onclite.

The same r10 binary decoded and displayed H.264 on
[vince](https://github.com/kotXio/postmarketos-xiaomi-vince/blob/main/fixes/hardware-video.md).
Recovered Venus firmware errors occurred during longer fullscreen use there;
earlier onclite use also logged recovered firmware errors. Long-duration
reliability remains unverified.

This is a dated Chromium 140 build, not a maintained browser security channel.
Keep distribution security updates; do not force it over newer Qt packages.

## Roll back

To disable the decoder feature, remove only
`--enable-features=AcceleratedVideoDecoder` and restart Angelfish, retaining
the two rendering flags. To restore the library, close Angelfish, simulate
installing the saved r3 APK, and proceed only if WebEngine alone changes:

```sh
sudo apk add --simulate --no-network --allow-untrusted \
  ./qt6-qtwebengine-6.11.1-r3.apk
sudo apk add --no-network --allow-untrusted \
  ./qt6-qtwebengine-6.11.1-r3.apk
```

Restore the previous desktop entry, or remove only the override created by
this procedure if none existed before. No reboot is required.

The [package recipe](../packages/qt6-qtwebengine-r10/README.md) and
[provenance](../SOURCES.md#qt-applications) are included in this repository.
