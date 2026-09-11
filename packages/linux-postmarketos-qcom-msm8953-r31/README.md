# Cumulative r31 kernel aport

This is the postmarketOS v26.06 aport used for kernel package
`linux-postmarketos-qcom-msm8953-7.0.9-r31`.

It applies all 43 USB OTG, QGauge, Sensor Manager and AW87329 patches to
`msm8953-mainline/linux` tag `v7.0.9-r0`. The final kernel source tree is
`61065c7f576be21329fa75313c31ade5b7f5b409`.

The package is built with Clang/LLVM. Do not apply the separate review series
on top of this aport: its patch set is already complete.
