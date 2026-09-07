# Exact tested r16 kernel aport

This directory contains the byte-exact `APKBUILD`, config and patch inputs used
to build `linux-postmarketos-qcom-msm8953-7.0.9-r16.apk`, plus this guide. It
retains the packaging patch layout used during physical testing.

To reproduce it, start from pmaports `v26.06` commit
`2b7f90ea7c2ae4d42ae187dc0b528dc163767b04`. Copy `APKBUILD`,
`config-postmarketos-qcom-msm8953.aarch64` and the 12 numbered patch files from
this directory into `device/community/linux-postmarketos-qcom-msm8953/`, then
run the normal pmbootstrap checksum, kconfig and `aarch64` package build steps.

The separate [`../../patches/kernel/`](../../patches/kernel/) series is split
for review and produces the same final kernel source tree. Do not combine both
patch layouts in one build.
