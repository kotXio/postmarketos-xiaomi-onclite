# Project history

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
