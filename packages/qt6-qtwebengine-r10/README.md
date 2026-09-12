# Qt WebEngine 6.11.1-r10

This recipe enables Chromium's standard Linux V4L2 decoder and multi-planar
NV12 presentation through Qt's Ozone backend. It is the same aarch64 package
used on Redmi 5 Plus (`vince`), transferred to Redmi 7 (`onclite`).

## Build

Use an isolated Alpine aports checkout at
[`3ca62a2571378ee35a0e149a0e91454b57240737`](https://github.com/alpinelinux/aports/tree/3ca62a2571378ee35a0e149a0e91454b57240737).
From its root, apply the [cumulative aport patch](aports-r10.patch):

```sh
git apply --check /path/to/qt6-qtwebengine-r10/aports-r10.patch
git apply /path/to/qt6-qtwebengine-r10/aports-r10.patch
```

It updates `community/qt6-qtwebengine/APKBUILD` and adds all six source patches
in recipe order. Do not apply the standalone patches again. The included
[APKBUILD](APKBUILD) is a comparison copy; the pinned checkout provides the
unchanged Alpine platform and security patches.

Copy the resulting aport to `temp/qt6-qtwebengine` in a matching postmarketOS
`v26.06` pmaports checkout and build natively on Linux aarch64:

```sh
pmbootstrap build --force qt6-qtwebengine
```

Qt WebEngine `v6.11.1` and Chromium commit
`37b6aeaa3ef9bf7e1901aa02a317a2707557709d` are pinned by the recipe.
It enables `use_v4l2_codec`, disables VA-API and limits nested builds to four
jobs. No bit-for-bit binary reproducibility is claimed.

## Compatibility and limits

Tested on onclite with postmarketOS `v26.06`, Qt `6.11.1`, Plasma Mobile,
kernel `7.0.9-r31` and UCM `19-r4`, starting from WebEngine `6.11.1-r3`.
This package changes no kernel, firmware, audio route or gain.

Angelfish browsing and hardware-decoder use are verified on onclite, including
decoder release and Venus suspension after the video tab closes. Exact
codec/profile coverage and long-duration reliability remain unverified.
Recovered Venus firmware errors were observed in earlier onclite and vince use.

This dated Chromium 140 build is not a maintained security-update channel.
Do not replace newer Qt packages or indefinitely pin this build instead of
distribution security updates.

See [installation and launcher settings](../../fixes/angelfish.md) and
[sources and authors](../../SOURCES.md#qt-applications).
