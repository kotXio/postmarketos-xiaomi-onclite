# Qt Multimedia 6.11.1-r1

This recording-only recipe fixes a KRecorder stall at `0:00:00` on the
tested Redmi 7. It lets PulseAudio choose recording queue headroom while
preserving the requested fragment size, audio format and stream flags.
Playback code is unchanged.

Recording, Save, clean playback and app-open idle cleanup are verified with
the [KRecorder launcher](../../fixes/krecorder.md).

The fix is process-local and disabled unless
`QT_PULSEAUDIO_RECORD_USE_SERVER_MAXLENGTH=1` is set.

## Build

The [APKBUILD](APKBUILD) pins Qt Multimedia `6.11.1` and applies:

1. Alpine's `select.patch` build fix;
2. the recording queue patch by Kostiantyn Andriiuk
   <konstantin@andriyuk.com>.

Copy this aport to `temp/qt6-qtmultimedia` in an isolated postmarketOS
`v26.06` pmaports checkout. Build on native Linux aarch64 with
distribution-matched Qt, FFmpeg and PulseAudio dependencies:

```sh
pmbootstrap build --force qt6-qtmultimedia
```

The release uses the base, FFmpeg and GStreamer runtime APKs as a matching
`6.11.1-r1` set. Development and debug packages are not needed.
Qt Declarative dependencies are listed explicitly to retain the QML payload.
ALSA stays disabled and PulseAudio enabled, matching the Alpine baseline.

Recipes and patches retain their upstream license expressions and notices.
See [KRecorder configuration](../../fixes/krecorder.md),
[installation](../README.md#qt-application-packages) and
[provenance](../../SOURCES.md#qt-applications).
