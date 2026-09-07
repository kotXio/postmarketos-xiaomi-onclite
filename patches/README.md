# Source patches

The public source is split by upstream target:

- [`kernel/`](kernel/): clean 12-patch review series for the MSM8953 kernel;
- [`pmaports/`](pmaports/): two userspace package changes for gadget lifecycle
  and the NetworkManager role race.

Apply the kernel series with `git am` in lexical order to kernel commit
`5be94b504b80d032481b90d533ee350ee13850f2`. The result must have tree
`9c20e5bb67a8d4e6794c9889c4f7ef5b5b321d88`.

Apply the pmaports series with `git am` in lexical order to commit
`6aa48aa00aa3b745f26996b45aaf768532ae7b24`. The result must have tree
`81a222e41fad76df7557f9f895d1842f2f5f3d81`.

The exact kernel package input used for r16 is retained separately under
[`../packages/linux-postmarketos-qcom-msm8953-r16/`](../packages/linux-postmarketos-qcom-msm8953-r16/).
Do not apply the clean kernel review series again on top of that aport.

The deterministic userspace regression can be run after applying the pmaports
series. Run it from the repository root:

```sh
./tests/onclite-usb-gadget-lifecycle-phase3b-test.sh /path/to/pmaports
```

Published patch bytes are listed in [`SHA256SUMS`](SHA256SUMS). The series
represents the physically tested configuration; it has not been submitted
upstream.
