# Device status

Last updated: 2026-09-11

Tested on one Xiaomi Redmi 7 (`onclite`), `aarch64`, with postmarketOS
`v26.06`, Plasma Mobile and Linux `7.0.9-msm8953`. The current configuration
uses persistent cumulative kernel package `7.0.9-r28`, Sensor Registry package
pair `0.1_git20250706-r4`, tethering package `51-r2` and onclite
gadget-lifecycle package `1-r0`.

| Area | Status | Notes |
| --- | --- | --- |
| Boot and Plasma Mobile | Working | Normal startup and interactive use verified. |
| Display and GPU | Working | `720x1520@60`; Mesa Freedreno reports Adreno 506 (`FD506`) OpenGL ES hardware rendering. |
| Touch | Working | Physical interaction verified. |
| Wi-Fi | Working | 2.4 GHz connectivity and SSH verified. |
| USB networking | Working | USB 2.0 high-speed NCM and same-boot recovery after HOST mode verified. |
| USB OTG | Working | Automatic role switching, `500 mA` VBUS, an empty adapter and a bus-powered RTL8152 hub were tested with cumulative kernel r25. |
| Indicator LED | Working | Physical output test passed. |
| Vibration | Working | Physical output test passed. |
| Bluetooth | Partial | Controller is powered and exposed; device connection and Bluetooth audio have not been tested. |
| Cellular modem | Partial | Modem control and radio visibility work; calls, SMS and mobile data are unverified. |
| GNSS | Unverified | ModemManager exposes GPS capabilities; no position fix has been verified. |
| Earpiece and microphones | Unverified | ALSA/UCM routes exist; physical playback and recording have not been tested. |
| Bottom speaker | Not working | The external AW87329 amplifier is unsupported by the current mainline port. |
| Hardware video codec | Partial | Qualcomm Venus decoder/encoder V4L2 nodes exist; frame decode and encode are unverified. |
| Battery telemetry | Working | QGauge reports presence, voltage, current, temperature, health, status, design data and approximate capacity through Linux, UPower and Plasma. |
| Charging control | Partial | Charging state is visible and cable transitions were tested, but Linux does not configure current, voltage, JEITA, HVDCP or watchdog policy. |
| Rear and front cameras | Not working | No camera is exposed by the current postmarketOS port. |
| Accelerometer and rotation | Working | LIS2HH streams through Linux IIO and SensorProxy; Plasma rotates after Auto-rotate is set to `Always`. |
| Magnetometer | Working | AK09918 provides changing XYZ samples; application-specific compass calibration was not tested. |
| Proximity | Working | The stk3x3x stream repeatedly reports distinct covered and open states; call-UI policy was not tested. |
| Ambient light | Working | The stk3x3x light stream responds independently to covered, room and bright conditions; automatic-brightness policy was not tested. |
| SAR sensor | Partial | The ADSP detects a Semtech SX932X (`0x46`, registry group `1090`), but Linux does not expose it. It is intended for RF body-proximity policy, not screen proximity. Registry groups `2500`, `2610`, `2970`, `2971`, `2980` and `2990` remain unsupported without affecting the working sensors. |
| Gyroscope and Hall sensor | Not working | Neither device is reported by this phone's Sensor Manager. |
| Fingerprint sensor | Not working | Not exposed by the current postmarketOS port. |
| IR transmitter | Not working | No working Linux integration is available. |
| FM radio | Unverified | Not enabled or tested under postmarketOS. |
| Suspend/resume | Partial | Cable-free manual `s2idle` resumes with display, touch, sensors, Wi-Fi, microSD and battery telemetry working; automatic idle suspend and sleep current remain unverified. |

## Status vocabulary

- **Working:** physically verified on the test handset.
- **Partial:** part of the subsystem works, but integration or end-to-end
  validation is incomplete.
- **Unverified:** exposed or expected, but not physically tested.
- **Not working:** currently unavailable or known to fail.
