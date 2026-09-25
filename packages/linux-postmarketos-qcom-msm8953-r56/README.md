# Cumulative r56 kernel aport

This is the postmarketOS `v26.06` aport used for
`linux-postmarketos-qcom-msm8953-7.0.9-r56` on Xiaomi Redmi 7
(`xiaomi,onclite`).

It applies the complete 54-patch series to `msm8953-mainline/linux` tag
`v7.0.9-r0`. Patches `0044..0051` add the OV12A10 rear-main path and patches
`0052..0054` add the OV02A10 rear-auxiliary path. The final kernel source tree
is `d406fc77427fa4d49da1df5b83850206e2db59ae`.

The package is built with Clang/LLVM. The exact tested configuration enables
both camera drivers as modules. Full-resolution OV12A10 capture also requires
one `cma=128M` kernel command-line entry; this is a boot configuration setting,
not part of the kernel APK.

Do not apply the separate review series on top of this aport: all 54 patches
are already included here. See the [camera guide](../../fixes/rear-cameras.md)
and [installation notes](../README.md#rear-camera-packages).
