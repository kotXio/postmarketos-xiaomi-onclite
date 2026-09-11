# Qualcomm Sensor Manager and phone sensors

## Result

Cumulative kernel r28 and `sns-reg r4` expose four physical sensor streams:

| Hardware | Linux IIO result |
| --- | --- |
| LIS2HH | three-axis accelerometer |
| AK09918 | three-axis magnetometer |
| stk3x3x primary stream | proximity |
| stk3x3x secondary stream | ambient light |

SensorProxy receives the accelerometer stream, and Plasma Mobile rotates the
display after Auto-rotate is set to `Always`.

## How it works

The sensors are controlled by the Qualcomm ADSP. Linux provides the phone's
stock Sensor Registry over QMI, discovers Sensor Manager over QRTR and exposes
the resulting streams through IIO:

```text
stock persist/sensors/sns.reg
  -> sns-reg-generator
  -> /run/sns-reg/registry.conf
  -> ADSP Sensor Manager
  -> qcom_smgr
  -> Linux IIO
  -> iio-sensor-proxy and Plasma Mobile
```

At boot, `sns-reg` reads the registry through the existing read-only
`msm-firmware-loader` mount. The generated file remains in RAM, owned by root
with mode `0600`. It is specific to that phone and is never included in this
repository or a Release.

## Important fixes

- QRTR service discovery and the Qualcomm Sensor Manager IIO driver;
- correct sensor-array access and a typed QMI cleanup action;
- correct C storage for QMI buffering item counts;
- separate report IDs for simultaneous proximity and light streams;
- C-style registry parsing, 64-bit values and MSM8953 registry group maps;
- bounds protection for padding entries in the registry generator;
- a boot service that prepares the private registry before the display
  manager starts.

## Limits

The magnetometer result confirms a working XYZ stream, not calibration in
every compass application. Proximity does not by itself implement call-screen
blanking, and ambient-light reporting does not enable an automatic-brightness
policy. The ADSP also reports an SX932X SAR sensor that is not exposed here.
No gyroscope or Hall device is reported.
