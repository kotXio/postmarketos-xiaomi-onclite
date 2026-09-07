# PMI632 USB OTG and USB-gadget recovery

## Result

The Redmi 7 now changes automatically between USB DEVICE and HOST from the
PMI632 RID signal. In HOST it supplies VBUS at an exact `500 mA` limit. On
adapter removal it tears down xHCI within a bounded path, returns to DEVICE and
restores the existing NCM gadget without rebooting.

## Components

- An opt-in `xiaomi,onclite` kernel driver reads and debounces PMI632 RID,
  controls the DWC3 role and enables VBUS only after HOST is active.
- DWC3/xHCI changes make onclite host removal deterministic without changing
  other boards.
- Three PMI632 DCDC fault interrupts force VBUS off and block HOST until the
  attachment is removed.
- A small onclite-only udev helper restores the configfs gadget in DEVICE mode.
- The NetworkManager dispatcher rechecks the role after its intentional delay
  and does not race a transition to HOST.

## Physical validation

One Redmi 7 Global (`M1810F6LG`) passed:

- automatic DEVICE to HOST and HOST to DEVICE transitions;
- empty unpowered adapter attach/remove;
- bus-powered hub with built-in RTL8152 attach/remove;
- measured VBUS of `5.03 V` unloaded and `4.98 V / 0.11 A` with the hub;
- return to high-speed NCM and USB SSH in the same boot;
- one DEVICE-mode `s2idle`/resume cycle followed by working NCM;
- persistent r16 package installation and a normal DEVICE/NCM boot.

The fault IRQs registered with zero counts in normal operation. A deliberate
short circuit or over-current test was not performed.

## Safety boundary

- Use only on Xiaomi Redmi 7 (`xiaomi,onclite`) with the exact package baseline
  in [`../packages/README.md`](../packages/README.md).
- The `500 mA` limit is intentional. Use a separately powered hub for devices
  that may need more current.
- Keep a recovery path and verify an empty adapter before a real peripheral.
- Suspend behavior is a separate unresolved device problem.

The source order and references are in
[`../patches/README.md`](../patches/README.md) and
[`../SOURCES.md`](../SOURCES.md).
