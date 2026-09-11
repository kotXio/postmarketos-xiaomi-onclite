# Source patches

The public source is split by upstream target:

- [`kernel/`](kernel/): cumulative 43-patch series for the MSM8953 kernel;
- [`sns-reg/`](sns-reg/): six Sensor Registry patches;
- [`pmaports/`](pmaports/): the existing USB gadget lifecycle and
  NetworkManager role-race fixes.

## Kernel series

Apply the kernel patches with `git am` in lexical order to
`msm8953-mainline/linux` commit
`5be94b504b80d032481b90d533ee350ee13850f2`:

- `0001..0012`: USB OTG;
- `0013..0028`: QGauge battery telemetry;
- `0029..0032`: QRTR bus and Qualcomm Sensor Manager;
- `0033..0036`: onclite Sensor Manager corrections and ambient light;
- `0037..0043`: AW87329 binding, driver, onclite route and fail-closed
  default.

The result must have tree
`61065c7f576be21329fa75313c31ade5b7f5b409`.

USB patches `0001..0012`, QGauge follow-ups `0019..0028` and sensor patches
`0033..0036` and AW87329 patches `0037..0043` are by Kostiantyn Andriiuk.
QGauge patches `0013..0018` retain Marc Lainez's authorship, and Sensor
Manager patches `0029..0032` retain Yassine Oudjana's authorship.

## Sensor Registry series

Apply [`sns-reg/`](sns-reg/) with `git am` in lexical order to public
`sns-reg` commit `4d238e5f0baba3fb77456fe2bffbf8e8f18a71a0`. The result must have tree
`94a4036c47b1675c68e3086c8b0f5c928eb9dcd3`.

All six additions are by
`Kostiantyn Andriiuk <konstantin@andriyuk.com>`. They provide robust registry
parsing, MSM8953 group maps, padding-key bounds protection and the root-only
runtime service.

## Package sources

Package inputs used for the release are retained separately under
[`../packages/linux-postmarketos-qcom-msm8953-r31/`](../packages/linux-postmarketos-qcom-msm8953-r31/),
[`../packages/soc-qcom-msm8953-ucm-r4/`](../packages/soc-qcom-msm8953-ucm-r4/)
and [`../packages/sns-reg-r4/`](../packages/sns-reg-r4/). The kernel aport is
cumulative; do not apply the review series again on top of it.

Published patch bytes are listed in [`SHA256SUMS`](SHA256SUMS). The series
remains out of tree.
