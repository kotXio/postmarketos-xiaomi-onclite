# Project history

## 2026-09-07 — USB OTG

Completed the first reproducible onclite improvement:

- PMI632 RID-driven automatic DEVICE/HOST switching;
- `500 mA` phone-supplied VBUS with readback and fail-closed fault handling;
- bounded DWC3/xHCI teardown for empty adapters and a loaded RTL8152 hub;
- userspace protection against a delayed USB-gadget rebind race;
- automatic NCM restoration after returning to DEVICE mode.

The three packages were physically tested. Kernel r16 was installed and booted
successfully with USB networking active and no PMI632 fault events.

## 2026-09-05 — Public project

Published the initial concise device-status documentation and project license.
