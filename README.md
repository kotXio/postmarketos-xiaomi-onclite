# postmarketOS on Xiaomi Redmi 7 (`onclite`)

Unofficial, reproducible hardware-enablement work for the Xiaomi Redmi 7,
device codename `onclite`, running postmarketOS.

Official device information:
[Xiaomi Redmi 7 (`xiaomi-onclite`) on the postmarketOS wiki](https://wiki.postmarketos.org/wiki/Xiaomi_Redmi_7_%28xiaomi-onclite%29).

This is a small DIY pet project, not a postmarketOS fork or an official
postmarketOS repository. The aim is to make one real phone more useful while
documenting concise source, compatibility and rollback information so another
owner can reproduce the work safely.

## At a glance

- [Current hardware and software status](STATUS.md)
- [Project history](HISTORY.md)
- [Verified fixes](fixes/README.md)
- [Package and installation notes](packages/README.md)
- [Kernel and pmaports patch series](patches/README.md)
- [Pinned sources and provenance](SOURCES.md)

## Verified improvement

- Automatic micro-USB DEVICE/HOST switching from the PMI632 RID signal.
- Phone-supplied VBUS limited to `500 mA`, with readback and fail-closed fault
  handling.
- Clean removal of an empty adapter and a bus-powered hub with RTL8152.
- Same-boot return to DEVICE mode with automatic NCM/USB-network restoration.

## Release

The first binary release is
[`v2026.09.07-usb-otg`](https://github.com/kotXio/postmarketos-xiaomi-onclite/releases/tag/v2026.09.07-usb-otg).
It contains the cumulative kernel and two required userspace packages for
Xiaomi Redmi 7 (`onclite`), `aarch64`, postmarketOS `v26.06` and Linux
`7.0.9-msm8953`.

The three packages were tested on a Redmi 7. Kernel r16 is installed on the
test phone and boots normally. USB networking works, and the PMI632 fault
counters remain at zero. Read the exact compatibility, installation and
rollback information in
[`packages/README.md`](packages/README.md) before using it.

## Known gaps

- The USB VBUS fault interrupts are registered and the driver fails closed,
  but a real short circuit or over-current fault was deliberately not created.
- USB VBUS is intentionally limited to `500 mA`; high-current devices need a
  separately powered hub.

## Licensing

Original project documentation is Copyright 2026 Kostiantyn Andriiuk and is
licensed under
[Creative Commons Attribution-ShareAlike 4.0 International](LICENSE). Kernel
patches, package sources and files adapted from upstream projects retain their
own licenses and notices.

## Important

This is an unofficial community project for Xiaomi Redmi 7 (`onclite`). Keep a
backup and a working recovery path before installing its packages or kernels.
