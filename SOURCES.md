# Sources and provenance

The USB OTG implementation is project-authored for `xiaomi,onclite`. The
sources below were used as pinned build inputs or technical references; no
downstream driver was copied wholesale.

## Pinned build inputs

- Kernel base: [`msm8953-mainline/linux` tag `v7.0.9-r0`](https://github.com/msm8953-mainline/linux/tree/v7.0.9-r0),
  commit `5be94b504b80d032481b90d533ee350ee13850f2`.
- Kernel review-series result tree:
  `9c20e5bb67a8d4e6794c9889c4f7ef5b5b321d88`.
- pmaports `v26.06` kernel-package base: commit
  [`2b7f90ea7c2ae4d42ae187dc0b528dc163767b04`](https://gitlab.postmarketos.org/postmarketOS/pmaports/-/tree/2b7f90ea7c2ae4d42ae187dc0b528dc163767b04).
- Userspace patch base: pmaports commit
  [`6aa48aa00aa3b745f26996b45aaf768532ae7b24`](https://gitlab.postmarketos.org/postmarketOS/pmaports/-/tree/6aa48aa00aa3b745f26996b45aaf768532ae7b24);
  final review-series tree `81a222e41fad76df7557f9f895d1842f2f5f3d81`.

The exact r16 kernel aport used for the released APK is retained under
[`packages/linux-postmarketos-qcom-msm8953-r16/`](packages/linux-postmarketos-qcom-msm8953-r16/).
The logically split review series produces the same kernel source tree.

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

## Public verification identifiers

- kernel APK SHA-256:
  `3462ccfdede50708f36464d7f5039d40dd22b6979e636d75e9c1ee7a0e828b6d`;
- tethering APK SHA-256:
  `4b63ac0cbeb2a92f91560200b948f7b3b2ec97502fcea3ac0f66d28abf930231`;
- lifecycle APK SHA-256:
  `47dc21a44fb48aabdd98d21e006e024b595aea0778c3b21d33ba27eb8bcebae0`.
