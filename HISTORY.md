# Project history

## 2026-09-25 — Rear cameras

Added cumulative kernel r56 and matching libcamera `0.7.1-r6` packages:

- OV12A10 rear-main RAW10 capture at `4096x3072`;
- OV02A10 rear-auxiliary RAW10 capture at `1600x1200`;
- sequential use of both cameras with complete resource cleanup;
- persistent boot and camera operation after suspend/resume.

## 2026-09-12 — KRecorder and Angelfish

- Fixed KRecorder's recording stall with the r1 process-local PulseAudio queue repair.
- Addressed crackly playback with application-local `PULSE_LATENCY_MSEC=60`.
- Transferred the vince WebEngine r10 package and Angelfish rendering settings.
- Confirmed Angelfish uses the Venus hardware decoder on onclite and releases
  it after the video tab closes.

## 2026-09-11 — Main speaker and Mic2

Added cumulative kernel r31 and UCM r4:

- AW87329 bottom-speaker support with the onclite hardware route;
- fail-closed reset handling on idle, faults, suspend and shutdown;
- PCM-scoped amplifier control through UCM;
- `HiFi (Mic2, Speaker)` as the Plasma Mobile default profile.

## 2026-09-11 — Sensor Manager

Added cumulative kernel r28 and the `sns-reg r4` package pair:

- LIS2HH accelerometer and Plasma Mobile automatic rotation;
- AK09918 magnetometer;
- independent stk3x3x proximity and ambient-light streams;
- runtime conversion of the phone's own stock Sensor Registry into a
  root-only RAM file;
- parser, bounds, QMI lifetime and buffering fixes required for stable sensor
  operation.

## 2026-09-09 — Battery telemetry

Added cumulative kernel r25 with the complete USB OTG implementation and
PMI632 QGauge battery reporting:

- standard Linux voltage, current, temperature, health and charge-state data;
- approximate OCV-based capacity in UPower and Plasma Mobile;
- live current response across USB cable transitions.

The implementation observes inherited charger state but does not change
charger current, voltage or thermal policy.

## 2026-09-07 — USB OTG

Completed the first reproducible onclite improvement:

- PMI632 RID-driven automatic DEVICE/HOST switching;
- `500 mA` phone-supplied VBUS with readback and fail-closed fault handling;
- bounded DWC3/xHCI teardown for empty adapters and a loaded RTL8152 hub;
- userspace protection against a delayed USB-gadget rebind race;
- automatic NCM restoration after returning to DEVICE mode.

## 2026-09-05 — Public project

Published the initial concise device-status documentation and project license.
