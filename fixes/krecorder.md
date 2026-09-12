# KRecorder recording and playback

Qt Multimedia `6.11.1-r1` fixes recording that stalled at `0:00:00`.
The recording queue was capped too tightly for the encoder to make progress;
the patch lets PulseAudio choose queue headroom for this application.
Saved recordings were clean. Crackly phone-side playback was a separate
buffering problem, addressed with `PULSE_LATENCY_MSEC=60`.

This changes no microphone gain, UCM route or global PulseAudio setting.
The default Mic2 and Speaker from the [audio release](main-speaker.md)
remain in use.

## Launcher

Install the matching [Qt Multimedia package set](../packages/README.md#qt-application-packages).
Close KRecorder. As the Plasma desktop user, copy
`/usr/share/applications/org.kde.krecorder.desktop` to
`~/.local/share/applications/` if no user override exists. Save any previous
override, create the directory if needed, and preserve the desktop entry's
other fields. Set its main `Exec=`:

```ini
Exec=env QT_MEDIA_BACKEND=ffmpeg QT_PULSEAUDIO_RECORD_USE_SERVER_MAXLENGTH=1 PULSE_LATENCY_MSEC=60 krecorder
```

Reopen KRecorder from its Plasma icon. Use FFmpeg, not a global backend
override. `PULSE_LATENCY_MSEC=60` is an existing libpulse buffering request,
not a volume boost or a guaranteed 60-ms end-to-end latency.

Recording, Save, clean playback and idle cleanup with the app open are
verified on r1 with this launcher.

## Check and undo

Record speech, Save, play the file at a comfortable volume, then Stop.
After recording/playback closes, KRecorder should leave no active audio
stream and the speaker amplifier should return to idle, even with the app open.

To undo the configuration, restore the previous desktop entry, or remove
only the user override created here if none existed before. Package rollback
is described in the [installation notes](../packages/README.md#qt-application-packages).
The [recipe and recording patch](../packages/qt6-qtmultimedia-r1/README.md)
are included in this repository.
