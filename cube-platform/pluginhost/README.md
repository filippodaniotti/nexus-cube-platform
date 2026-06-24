# Plugin host setup

Ensure pipewire, wireplumber and pipewire-jack are available in the system:

```bash
systemctl --user status pipewire.service
systemctl --user status wireplumber.service

which pw-jack
```

Run your plugin host with the `pw-jack` wrapper, e.g. reaper:

```bash
pw-jack reaper &
```

You might need to manually adjust the audio port wiring:

```bash
pw-link reaper:out0 alsa_output.platform-soc_107c000000_sound.stereo-fallback:playback_FL
pw-link reaper:out1 alsa_output.platform-soc_107c000000_sound.stereo-fallback:playback_FR
```

To receive and send MIDI from a `jacknetumpd` endpoint, you need to connect the MIDI ports

```bash
pw-link jacknetumpd:netump_out  "reaper:MIDI Input 1"
pw-link "reaper:MIDI Output 1" jacknetumpd:netump_in
```
