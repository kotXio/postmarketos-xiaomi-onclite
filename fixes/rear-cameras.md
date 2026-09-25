# OV12A10 and OV02A10 rear cameras

## Result

Cumulative kernel r56 and the matching libcamera `0.7.1-r6` packages expose
both physical rear cameras through standard Linux media and libcamera APIs:

| Camera | Native tested output |
| --- | --- |
| OV12A10 rear main | RAW10 `4096x3072` |
| OV02A10 rear auxiliary | RAW10 `1600x1200` |

The persistent installation passed normal boot, sequential auxiliary-then-main
capture, complete resource cleanup, suspend/resume and another camera capture
after resume.

## Hardware paths

The main camera is OV12A10 at CCI0 address `0x10` and enters CAMSS through
CSIPHY0. The auxiliary camera is OV02A10 at CCI1 address `0x3d` and enters
through CSIPHY1. Both tested capture routes use VFE0; the MSM8953 VFE1 path
does not provide the required UB allocation for this capture mode.

The OV02A10 integration keeps the upstream sensor mode and controls, adding
only the onclite power sequence and device-tree wiring. The OV12A10 driver uses
the project-authored fixed modes previously developed for Redmi 5 Plus, with
onclite-specific power, clocks and board wiring.

## Limits

This is native RAW camera support, not a complete phone-camera experience.
Sensor exposure and analogue gain remain fixed/read-only, the Simple IPA has
no device calibration, and production AE, AWB, autofocus, colour tuning and
Plasma Camera integration are not claimed. The front camera is not included.

Exact packages, the required `cma=128M` setting, installation and rollback are
documented in [`../packages/README.md`](../packages/README.md#rear-camera-packages).
Source order and external references are in
[`../patches/README.md`](../patches/README.md) and
[`../SOURCES.md`](../SOURCES.md#rear-cameras).
