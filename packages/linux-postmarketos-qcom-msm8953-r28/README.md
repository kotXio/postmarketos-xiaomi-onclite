# Cumulative r28 kernel aport

This is the postmarketOS v26.06 aport used for kernel package
`linux-postmarketos-qcom-msm8953-7.0.9-r28`.

It applies all 36 USB OTG, QGauge and Sensor Manager patches to
`msm8953-mainline/linux` tag `v7.0.9-r0`. The included configuration adds
`CONFIG_IIO_QCOM_SMGR=m`; the remaining accepted USB and battery configuration
is preserved.

The package is built with Clang/LLVM. Do not apply the separate review series
on top of this aport: its patch set is already complete.
