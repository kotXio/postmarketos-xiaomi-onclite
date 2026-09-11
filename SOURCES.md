# Sources and provenance

The USB OTG integration, onclite-specific QGauge follow-ups, Sensor Manager
corrections, Sensor Registry additions and AW87329 audio support are
project-authored for `xiaomi,onclite`. Imported work retains its original
authorship. The sources below were used as pinned build inputs or technical
references.

## Pinned build inputs

- Kernel base: [`msm8953-mainline/linux` tag `v7.0.9-r0`](https://github.com/msm8953-mainline/linux/tree/v7.0.9-r0),
  commit `5be94b504b80d032481b90d533ee350ee13850f2`.
- Cumulative USB OTG and QGauge review-series result tree:
  `9e11793a7bc4ec6fbe0d267fa19f4fe4f78e8633`.
- Cumulative USB OTG, QGauge and Sensor Manager result tree:
  `4fbd4ef990345acae246dcfa6a54124ef4968ce8`.
- Cumulative USB OTG, QGauge, Sensor Manager and AW87329 result tree:
  `61065c7f576be21329fa75313c31ade5b7f5b409`.
- ALSA UCM base:
  [`msm8953-mainline/alsa-ucm-conf`](https://github.com/msm8953-mainline/alsa-ucm-conf/tree/ed9334bda853fe032794751c34cea03ec0d7d4eb),
  commit `ed9334bda853fe032794751c34cea03ec0d7d4eb`.
- Sensor Registry base:
  [`msm8996-mainline/sns-reg`](https://gitlab.com/msm8996-mainline/sns-reg)
  commit `4d238e5f0baba3fb77456fe2bffbf8e8f18a71a0`; six-patch result tree
  `94a4036c47b1675c68e3086c8b0f5c928eb9dcd3`.
- pmaports `v26.06` kernel-package base: commit
  [`2b7f90ea7c2ae4d42ae187dc0b528dc163767b04`](https://gitlab.postmarketos.org/postmarketOS/pmaports/-/tree/2b7f90ea7c2ae4d42ae187dc0b528dc163767b04).
- Userspace patch base: pmaports commit
  [`6aa48aa00aa3b745f26996b45aaf768532ae7b24`](https://gitlab.postmarketos.org/postmarketOS/pmaports/-/tree/6aa48aa00aa3b745f26996b45aaf768532ae7b24);
  final review-series tree `81a222e41fad76df7557f9f895d1842f2f5f3d81`.

The r31, r28, r25 and r16 release aports are retained under
[`packages/linux-postmarketos-qcom-msm8953-r31/`](packages/linux-postmarketos-qcom-msm8953-r31/),
[`packages/linux-postmarketos-qcom-msm8953-r28/`](packages/linux-postmarketos-qcom-msm8953-r28/),
[`packages/linux-postmarketos-qcom-msm8953-r25/`](packages/linux-postmarketos-qcom-msm8953-r25/)
and
[`packages/linux-postmarketos-qcom-msm8953-r16/`](packages/linux-postmarketos-qcom-msm8953-r16/).
The exact `sns-reg r4` aport is retained under
[`packages/sns-reg-r4/`](packages/sns-reg-r4/).
The UCM r4 aport is retained under
[`packages/soc-qcom-msm8953-ucm-r4/`](packages/soc-qcom-msm8953-ucm-r4/).

## Kernel and hardware references

- The exact mainline-derived
  [`onclite` DTS](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/arch/arm64/boot/dts/qcom/sdm632-xiaomi-onclite.dts),
  [PMI632 description](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/arch/arm64/boot/dts/qcom/pmi632.dtsi),
  [DWC3 core](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/usb/dwc3/core.c),
  [DWC3 host glue](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/usb/dwc3/host.c) and
  [xHCI platform driver](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/usb/host/xhci-plat.c)
  defined the target kernel behavior.
- Linux's
  [USB role-switch framework](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/usb/roles/class.c),
  [configfs USB gadget](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/usb/gadget/configfs.c) and
  [NCM gadget function](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/usb/gadget/function/f_ncm.c)
  provided the existing role and USB-networking infrastructure.
- The existing Linux
  [RTL8152 driver](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/net/usb/r8152.c)
  supported the USB Ethernet adapter used during physical validation; it is
  not part of this project's implementation.
- The existing Qualcomm
  [PMIC USB VBUS regulator](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/drivers/regulator/qcom_usb_vbus-regulator.c),
  [PMIC Type-C binding](https://github.com/msm8953-mainline/linux/blob/v7.0.9-r0/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml)
  and Linux
  [USB connector binding](https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/connector/usb-connector.yaml)
  provided the mainline API references.
- Xiaomi/Qualcomm's downstream
  [`sdm450-pmi632.dtsi`](https://github.com/LineageOS/android_kernel_xiaomi_onclite/blob/8aab452e4acd7cb9bcbd173a3db0fec443b35521/arch/arm64/boot/dts/qcom/sdm450-pmi632.dtsi),
  [`pmi632.dtsi`](https://github.com/LineageOS/android_kernel_xiaomi_onclite/blob/8aab452e4acd7cb9bcbd173a3db0fec443b35521/arch/arm64/boot/dts/qcom/pmi632.dtsi) and
  [`smb5-lib.c`](https://github.com/LineageOS/android_kernel_xiaomi_onclite/blob/8aab452e4acd7cb9bcbd173a3db0fec443b35521/drivers/power/supply/qcom/smb5-lib.c)
  were used to identify the PMI632 RID, VBUS and DCDC-fault hardware paths.
- The existing MSM8953
  [role-switch conversion](https://github.com/msm8953-mainline/linux/commit/91c0af870fc6)
  and postmarketOS
  [USB tethering design](https://gitlab.com/postmarketOS/pmaports/-/merge_requests/3819)
  informed the kernel/userspace boundary.

## Battery references

- Marc Lainez's public
  [MSM8953 QGauge series](https://github.com/msm8953-mainline/linux/pull/242)
  supplied the first six QGauge commits. Their original authorship is retained.
- Xiaomi's official kernel source at commit
  `fa577bc566886db1e0dfb1ddf66ff7c528148b2b` supplied the Redmi 7
  [`PMI632` description](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/fa577bc566886db1e0dfb1ddf66ff7c528148b2b/arch/arm64/boot/dts/qcom/pmi632.dtsi),
  [SDM450/632 integration](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/fa577bc566886db1e0dfb1ddf66ff7c528148b2b/arch/arm64/boot/dts/qcom/sdm450-pmi632.dtsi)
  and
  [Coslight `light_4000mAh` profile](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/fa577bc566886db1e0dfb1ddf66ff7c528148b2b/arch/arm64/boot/dts/qcom/qg-batterydata-light-3900mah.dtsi)
  used for the board data.
- Qualcomm's public downstream
  [Qgauge driver](https://android.googlesource.com/kernel/msm.git/+/ed029338e47134f7be5b3242bb222b3ba58974ed/drivers/power/supply/qcom/qpnp-qg.c)
  was used as a register-behaviour reference for FIFO configuration and live
  current reads. Its Android SOC and charger policy were not imported.
- Linux's
  [power-supply ABI](https://github.com/torvalds/linux/blob/master/Documentation/ABI/testing/sysfs-class-power)
  defines the exposed property units and current-sign convention.

## Sensor references

- Kernel patches `0029..0032` preserve Yassine Oudjana's QRTR bus and Qualcomm
  Sensor Manager work from the public postmarketOS
  [draft MR 4118](https://gitlab.com/postmarketOS/pmaports/-/merge_requests/4118).
  The original QRTR commits are
  [`febf87f1`](https://gitlab.com/msm8996-mainline/linux/-/commit/febf87f1)
  and
  [`195e4779`](https://gitlab.com/msm8996-mainline/linux/-/commit/195e4779);
  the Sensor Manager commits are
  [`cf7f780a`](https://gitlab.com/msm8996-mainline/linux/-/commit/cf7f780a)
  and
  [`92672b3e`](https://gitlab.com/msm8996-mainline/linux/-/commit/92672b3e6591ea506b49a454d2fcd01b0def34b5).
  Patches `0033..0036` contain the onclite corrections and ambient-light work
  by Kostiantyn Andriiuk.
- The six-patch userspace series extends the public
  [`sns-reg`](https://gitlab.com/msm8996-mainline/sns-reg) server with robust
  parsing, MSM8953 registry maps and a root-only runtime service. All six
  additions are authored by Kostiantyn Andriiuk.
- Android's public
  [CHRE SMGR mapping](https://android.googlesource.com/platform/system/chre/+/android-8.0.0_r2/platform/slpi/platform_sensor.cc)
  informed sensor-type interpretation.
- Linux documents the
  [IIO buffer ABI](https://docs.kernel.org/iio/iio_devbuf.html) and
  [IIO test tools](https://docs.kernel.org/iio/iio_tools.html).
- The triggerless-buffer support used by postmarketOS
  `iio-sensor-proxy 3.9-r2` is described in
  [MR 368](https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/368).

The stock `persist/sensors/sns.reg` and the generated runtime registry remain
on their own phone. No calibration value, handset identifier or proprietary
sensor configuration is distributed here.

## Audio references

- LineageOS onclite kernel commit
  [`8aab452e`](https://github.com/LineageOS/android_kernel_xiaomi_onclite/tree/8aab452e4acd7cb9bcbd173a3db0fec443b35521)
  and its
  [`aw87329_audio.c`](https://github.com/LineageOS/android_kernel_xiaomi_onclite/blob/8aab452e4acd7cb9bcbd173a3db0fec443b35521/techpack/audio/asoc/codecs/aw87329_audio.c)
  were used to identify the chip, reset line, stock register order and profile
  naming.
- The public
  [`aw87xxx` family driver](https://github.com/gtxaspec/aw87xxx) provided an
  additional family-level reference.
- The public MSM8953
  [ALSA UCM configuration](https://github.com/msm8953-mainline/alsa-ucm-conf/tree/ed9334bda853fe032794751c34cea03ec0d7d4eb)
  is the base for the onclite selector, HiFi route and Speaker PCM.

The downstream drivers were used as references. Patches `0037..0043` provide
a new small ASoC implementation with strict profile validation and
fail-closed reset handling. The proprietary `aw87329_kspk.bin` remains on its
own phone and is not distributed.

## Public verification identifiers

- cumulative r31 kernel APK SHA-256:
  `98ab1af8e97529de56398b531a0831a04b4973a10b2209aa4d5eda1ffbf7d14f`;
- UCM r4 APK SHA-256:
  `81af34d8c608510b2aaf39c88bdb3082d09ddd1c0847514e858fd08098357acc`;
- cumulative r28 kernel APK SHA-256:
  `62c63eb1e77f2b8937195a1eaf998b23219eeb9e8b379df0ca3d2f0841309977`;
- Sensor Registry r4 APK SHA-256:
  `2bc2073fd422ac93505def32050eaa644c53df92ac799c58f68a5b58a3b8bd28`;
- Sensor Registry systemd r4 APK SHA-256:
  `24ba7416b3d9259145d9bc723e2c750b70f817d6e2d482906a2ea8fc5febff45`;
- cumulative r25 kernel APK SHA-256:
  `93b1dca07fb01dc070d766ea94b054d4dd67b4f0bf1b3dd43f33cc509f6e3947`;
- previous r16 kernel APK SHA-256:
  `3462ccfdede50708f36464d7f5039d40dd22b6979e636d75e9c1ee7a0e828b6d`;
- tethering APK SHA-256:
  `4b63ac0cbeb2a92f91560200b948f7b3b2ec97502fcea3ac0f66d28abf930231`;
- lifecycle APK SHA-256:
  `47dc21a44fb48aabdd98d21e006e024b595aea0778c3b21d33ba27eb8bcebae0`.
