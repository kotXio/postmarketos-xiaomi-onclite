# PMI632 USB OTG and USB-gadget recovery

## Result

The Redmi 7 now changes automatically between USB DEVICE and HOST from the
PMI632 RID signal. In HOST it supplies VBUS at an exact `500 mA` limit. On
adapter removal it tears down xHCI within a bounded path, returns to DEVICE and
restores the existing NCM gadget without rebooting.

## Existing Linux building blocks

The implementation uses the existing Linux DWC3 and xHCI drivers, USB
role-switch framework, Qualcomm USB VBUS regulator and configfs NCM gadget.
The existing RTL8152 driver was used for the tested USB Ethernet adapter.

## What this project adds

- A new `drivers/usb/common/qcom-pmi632-micro-usb.c` driver for the PMI632 RID
  detector.
- Device-tree binding and `onclite` DTS integration for RID and fault IRQs.
- Automatic switching between DEVICE and HOST roles.
- VBUS control with a verified `500 mA` current limit.
- Fail-closed handling of all three PMI632 DCDC fault interrupts.
- Bounded DWC3/xHCI teardown when leaving HOST mode.
- An onclite userspace lifecycle helper that restores the NCM gadget.
- A NetworkManager tethering fix that prevents a delayed rebind race.

## Physical validation

Automatic role switching, empty-adapter handling, a bus-powered RTL8152 hub
and same-boot return to high-speed NCM were verified on one Redmi 7 Global
(`M1810F6LG`).

The fault IRQs registered with zero counts in normal operation. A deliberate
short circuit or over-current test was not performed.

## Safety boundary

- Use only on Xiaomi Redmi 7 (`xiaomi,onclite`) with the exact package baseline
  in [`../packages/README.md`](../packages/README.md).
- The `500 mA` limit is intentional. Use a separately powered hub for devices
  that may need more current.
- Keep a recovery path and verify an empty adapter before a real peripheral.
- Manual cable-free `s2idle`/resume works under cumulative r25; automatic idle
  suspend and actual sleep current remain unverified.

The source order and references are in
[`../patches/README.md`](../patches/README.md) and
[`../SOURCES.md`](../SOURCES.md).
