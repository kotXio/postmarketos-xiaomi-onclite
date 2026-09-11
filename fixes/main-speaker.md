# AW87329 bottom speaker and default Mic2

## Result

Cumulative kernel r31 and UCM r4 provide the Redmi 7 bottom speaker and select
`HiFi (Mic2, Speaker)` in Plasma Mobile. Speaker playback uses the default
PulseAudio sink, while clean mono capture is available from the default Mic2
source.

## Hardware path

The external amplifier is an Awinic AW87329 on Qualcomm I2C5 at address
`0x58`. It reports chip ID `0x39` and uses active-low GPIO139 for reset. The
playback route is:

```text
RX1 -> RX3 -> LINEOUT -> AW87329 -> bottom speaker
```

Mic2 uses the `INP3 -> ADC2 -> DEC1` capture path with `ADC2 Volume=8`.

## Safe amplifier lifecycle

The kernel validates the chip and the expected 11-byte speaker profile. It
asserts reset after invalid firmware or an I2C failure, and during DAPM Off,
suspend, shutdown and driver removal. The amplifier is disabled by default.

UCM prepares the static codec route but opens the final amplifier gate only
while the Speaker PCM is in use. Closing that PCM returns the AW87329 path to
Off and GPIO139 to reset-low.

## Stock firmware

The proprietary `aw87329_kspk.bin` is not included in this repository or any
Release. The matching phone must expose its own vendor copy through the
existing read-only `msm-firmware-loader` path. Do not copy a profile from a
different handset.

## Limits

This implementation is specific to Xiaomi Redmi 7 (`xiaomi,onclite`) and the
compatibility baseline in [`../packages/README.md`](../packages/README.md).
Earpiece playback remained silent in four PulseAudio and direct ALSA tests;
current evidence cannot distinguish incomplete routing or amplification from
a failed physical earpiece. Mic1 works and captured normal audible voice, but
was quieter and noisier than Mic2 in the matched test. Wired headphones and
headset capture have not been physically tested, and the UCM lifecycle has
been used with the current PulseAudio stack.

Source order and provenance are documented in
[`../patches/README.md`](../patches/README.md) and
[`../SOURCES.md`](../SOURCES.md).
