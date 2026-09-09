# Exact tested r25 kernel aport

This directory contains the byte-exact `APKBUILD`, config and 28 patch inputs
used to build `linux-postmarketos-qcom-msm8953-7.0.9-r25.apk`. It preserves the
packaging layout used for physical testing.

The package is cumulative:

- patches `0001..0012` provide the accepted USB OTG implementation;
- patches `0013..0028` provide PMI632 QGauge battery telemetry.

To reproduce it, start from pmaports `v26.06` commit
`2b7f90ea7c2ae4d42ae187dc0b528dc163767b04`. Copy `APKBUILD`,
`config-postmarketos-qcom-msm8953.aarch64` and all 28 numbered patch files into
`device/community/linux-postmarketos-qcom-msm8953/`, then run the normal
pmbootstrap checksum, kconfig and `aarch64` package build steps.

The expected APK SHA-256 is:

```text
93b1dca07fb01dc070d766ea94b054d4dd67b4f0bf1b3dd43f33cc509f6e3947
```

The separate [`../../patches/kernel/`](../../patches/kernel/) directory is a
logically split review series that produces the same final kernel source tree.
Do not apply both patch layouts in one build.
