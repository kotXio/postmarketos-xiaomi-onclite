# Device status

Last updated: 2026-09-05

Tested on one Xiaomi Redmi 7 (`onclite`), `aarch64`, with postmarketOS
`v26.06`, Plasma Mobile and Linux `7.0.9-msm8953`.

A visible driver or API is not classified as working until its end-to-end path
has been exercised on the handset.

| Area | Status | Notes |
| --- | --- | --- |
| Boot and Plasma Mobile | Working | Normal startup and interactive use verified. |
| Display and GPU | Working | `720x1520@60`; Mesa Freedreno reports Adreno 506 (`FD506`) OpenGL ES hardware rendering. |
| Touch | Working | Physical interaction verified. |
| Wi-Fi | Working | 2.4 GHz connectivity and SSH verified. |
| USB networking | Working | USB 2.0 high-speed NCM gadget networking verified. |
| USB OTG | Not working | Automatic host-role selection and phone-sourced VBUS are unavailable in the current postmarketOS port. |
| Indicator LED | Working | Physical output test passed. |
| Vibration | Working | Physical output test passed. |
| Bluetooth | Partial | Controller is powered and exposed; a complete device connection and audio test is pending. |
| Cellular modem | Partial | Modem control and radio visibility work; calls, SMS and mobile data are unverified. |
| GNSS | Unverified | ModemManager exposes GPS capabilities; no position fix has been verified. |
| Earpiece and microphones | Unverified | ALSA/UCM routes exist, but physical playback and capture tests are pending. |
| Bottom speaker | Not working | The external AW87329 amplifier is unsupported by the current mainline port. |
| Hardware video codec | Partial | Qualcomm Venus decoder/encoder V4L2 nodes exist; frame decode and encode are unverified. |
| Battery and charging | Not working | The current mainline port exposes no battery or charger power-supply device. |
| Rear and front cameras | Not working | No camera is exposed by the current postmarketOS port. |
| Accelerometer, proximity, light and compass | Not working | No usable sensor devices are exposed. |
| Fingerprint sensor | Not working | Not exposed by the current postmarketOS port. |
| IR transmitter | Not working | No working Linux integration is available. |
| FM radio | Unverified | Not enabled or tested under postmarketOS. |
| Suspend/resume | Not working usefully | A controlled `s2idle` attempt resumed correctly but exited almost immediately. |

## Status vocabulary

- **Working:** physically verified on the test handset.
- **Partial:** part of the subsystem works, but integration or end-to-end
  validation is incomplete.
- **Unverified:** exposed or expected, but not yet physically proven.
- **Not working:** currently unavailable or known to fail.
