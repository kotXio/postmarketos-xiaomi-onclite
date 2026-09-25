# libcamera 0.7.1-r6 aport

This is the postmarketOS `v26.06` aport used for the matching onclite
`libcamera`, `libcamera-ipa`, `libcamera-tools` and `libcamera-gstreamer`
packages at version `99990.7.1-r6`.

The recipe starts from the official libcamera `v0.7.1` source and applies ten
patches in order. The series retains Robert Mader's three Simple/GPU ISP
patches and Kieran Bingham and Milan Zamazal's upstream CPU SoftISP work with
their original authorship. Onclite gain handling, CPU lookup initialization,
request-stop cleanup and the opt-in CPU `udmabuf` allocator are by Kostiantyn
Andriiuk `<konstantin@andriyuk.com>`.

The complete series replays cleanly over `v0.7.1` and produces source tree
`6021c5c4596c2858f8ed357bec5d32c0d1f904c2`. This release uses libcamera for
enumeration and native RAW capture; it does not claim calibrated colour,
automatic exposure, automatic white balance or autofocus.

See [sources and provenance](../../SOURCES.md#rear-cameras) and the
[installation notes](../README.md#rear-camera-packages).
