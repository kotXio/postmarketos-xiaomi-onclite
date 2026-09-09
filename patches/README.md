# Source patches

The public source is split by upstream target:

- [`kernel/`](kernel/): cumulative 28-patch review series for the MSM8953
  kernel;
- [`pmaports/`](pmaports/): two userspace package changes for gadget lifecycle
  and the NetworkManager role race.

Apply the kernel series with `git am` in lexical order to kernel commit
`5be94b504b80d032481b90d533ee350ee13850f2`. Patches `0001..0012` implement
USB OTG; patches `0013..0028` add QGauge battery telemetry. The result must
have tree `9e11793a7bc4ec6fbe0d267fa19f4fe4f78e8633`.

The USB series and the project-authored QGauge follow-ups use
`Kostiantyn Andriiuk <konstantin@andriyuk.com>`. QGauge patches `0013..0018`
retain Marc Lainez's original authorship from the public development series.

Apply the pmaports series with `git am` in lexical order to commit
`6aa48aa00aa3b745f26996b45aaf768532ae7b24`. The result must have tree
`81a222e41fad76df7557f9f895d1842f2f5f3d81`.

Exact package inputs are retained separately under
[`../packages/linux-postmarketos-qcom-msm8953-r25/`](../packages/linux-postmarketos-qcom-msm8953-r25/)
and
[`../packages/linux-postmarketos-qcom-msm8953-r16/`](../packages/linux-postmarketos-qcom-msm8953-r16/).
Do not apply the review series again on top of either aport.

The deterministic userspace regression can be run after applying the pmaports
series. Run it from the repository root:

```sh
./tests/onclite-usb-gadget-lifecycle-phase3b-test.sh /path/to/pmaports
```

Published patch bytes are listed in [`SHA256SUMS`](SHA256SUMS). The series
represents the physically tested configuration. It retains diagnostic QGauge
logging and has not been submitted upstream.
