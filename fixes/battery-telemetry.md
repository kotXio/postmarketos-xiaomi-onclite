# PMI632 QGauge battery telemetry

## Result

Cumulative kernel r25 exposes the Redmi 7 battery through the standard Linux
power-supply interface. UPower and Plasma Mobile receive battery presence,
voltage, current, temperature, health, charging status, design data and an
approximate charge level without a custom userspace daemon.

The driver reads live QGauge current registers, uses the ADC5 battery
thermistor channel and observes selected PMI632 SMB5 status registers. Current
follows the Linux convention: positive while charging and negative while
discharging.

## What was added

- The missing `ADC5_BAT_THERM_100K_PU` channel.
- A reusable Qualcomm QGauge power-supply driver and Device Tree binding.
- The Redmi 7 Coslight battery profile and QGauge board integration.
- Reliable consumption of complete `8/8` hardware FIFO samples.
- Read-only PMI632 charge-state, charge-type and health reporting.
- Live `CURRENT_NOW` and `CURRENT_AVG` values across cable transitions.

## Physical validation

Battery readings, charging and discharging transitions, UPower and Plasma
integration, and operation after suspend/resume were verified on one Redmi 7
Global (`M1810F6LG`). The existing USB OTG and NCM paths remained working.

## Limitations

- Capacity is estimated from an OCV table. It is not learned or
  coulomb-counted and can move with battery load.
- Charging continues from inherited PMIC configuration. R25 does not configure
  FCC, ICL, AICL, JEITA, float voltage, HVDCP or watchdog policy.
- The QGauge patches retain diagnostic checkpoint logging. The tested series
  is suitable for this DIY release but is not an upstream-ready submission.
- Only one Global-model phone, postmarketOS `v26.06`, microSD boot and `s2idle`
  were tested.

Install only the exact cumulative package described in
[`../packages/README.md`](../packages/README.md). Source order and provenance
are documented in [`../patches/README.md`](../patches/README.md) and
[`../SOURCES.md`](../SOURCES.md).
