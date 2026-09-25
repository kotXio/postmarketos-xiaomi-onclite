# Device status

Last updated: 2026-09-25

Tested on one Xiaomi Redmi 7 (`onclite`), `aarch64`, with postmarketOS
`v26.06`, Plasma Mobile and Linux `7.0.9-msm8953`. The current configuration
uses persistent cumulative kernel package `7.0.9-r56`, matching libcamera
package set `99990.7.1-r6`, UCM package `19-r4`,
Sensor Registry package pair `0.1_git20250706-r4`, tethering package `51-r2`
and onclite gadget-lifecycle package `1-r0`.

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
| Earpiece | Not working | Four PulseAudio and direct ALSA tests were silent; current evidence cannot distinguish incomplete routing or amplification from a failed physical earpiece. |
| Mic1 | Working | The `ADC1 -> DEC1` route captured normal audible voice, but it was quieter and noisier than Mic2. |
| Mic2 | Working | The cleaner and slightly louder internal microphone is the Plasma Mobile default source. |
| Headset microphone | Unverified | Its UCM route remains available but has not been physically tested. |
| Bottom speaker | Working | The AW87329 route provides clear playback and returns the amplifier to reset while idle. |
| KRecorder | Working | Recording, Save and clean playback work with Multimedia r1 and application-local buffering; stopping audio releases the streams and switches the amplifier off. See [configuration](fixes/krecorder.md). |
| Angelfish | Working | Browsing and Venus hardware-decoder use are verified with WebEngine r10; WebGL is disabled and the sandbox remains enabled. See [configuration](fixes/angelfish.md). |
| Hardware video decoding | Working | Angelfish owns the Venus decoder during tested YouTube playback; closing the video tab releases it and returns Venus to idle. Not every codec/profile is verified. |
| Hardware video encoding | Unverified | The Qualcomm Venus V4L2 encoder is exposed, but actual encoding has not been tested. |
| Battery telemetry | Working | QGauge reports presence, voltage, current, temperature, health, status, design data and approximate capacity through Linux, UPower and Plasma. |
| Charging control | Partial | Charging state is visible and cable transitions were tested, but Linux does not configure current, voltage, JEITA, HVDCP or watchdog policy. |
| Rear main camera | Working | OV12A10 captures native RAW10 at `4096x3072` through libcamera. Production 3A and colour tuning are not included. |
| Rear auxiliary camera | Working | OV02A10 captures native RAW10 at `1600x1200`; sequential auxiliary/main use and complete cleanup were verified. |
| Front camera | Not working | The sensor was identified, but this release does not expose a usable front-camera image. |
| Accelerometer and rotation | Working | LIS2HH streams through Linux IIO and SensorProxy; Plasma rotates after Auto-rotate is set to `Always`. |
| Magnetometer | Working | AK09918 provides changing XYZ samples; application-specific compass calibration was not tested. |
| Proximity | Working | The stk3x3x stream repeatedly reports distinct covered and open states; call-UI policy was not tested. |
| Ambient light | Working | The stk3x3x light stream responds independently to covered, room and bright conditions; automatic-brightness policy was not tested. |
| SAR sensor | Partial | The ADSP detects a Semtech SX932X (`0x46`, registry group `1090`), but Linux does not expose it. It is intended for RF body-proximity policy, not screen proximity. Registry groups `2500`, `2610`, `2970`, `2971`, `2980` and `2990` remain unsupported without affecting the working sensors. |
| Gyroscope and Hall sensor | Not working | Neither device is reported by this phone's Sensor Manager. |
| Fingerprint sensor | Not working | Not exposed by the current postmarketOS port. |
| IR transmitter | Not working | No working Linux integration is available. |
| FM radio | Unverified | Not enabled or tested under postmarketOS. |
| Suspend/resume | Partial | Cable-free manual `s2idle` resumes with display, touch, sensors, Wi-Fi, microSD, battery telemetry and rear-camera capture working; automatic idle suspend and sleep current remain unverified. |

## Status vocabulary

- **Working:** physically verified on the test handset.
- **Partial:** part of the subsystem works, but integration or end-to-end
  validation is incomplete.
- **Unverified:** exposed or expected, but not physically tested.
- **Not working:** currently unavailable or known to fail.
