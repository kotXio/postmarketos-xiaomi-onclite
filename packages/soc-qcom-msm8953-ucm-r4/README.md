# MSM8953 UCM r4 aport

This is the postmarketOS v26.06 aport used for
`soc-qcom-msm8953-ucm-19-r4`.

It starts from MSM8953 ALSA UCM commit
`ed9334bda853fe032794751c34cea03ec0d7d4eb` and adds the onclite selector,
HiFi route and dedicated Speaker PCM. The PCM hook controls the final AW87329
gate so that the amplifier is active only while speaker playback is open.

No amplifier firmware is included. The package uses the matching phone's own
stock `aw87329_kspk.bin` through the existing firmware loader.
