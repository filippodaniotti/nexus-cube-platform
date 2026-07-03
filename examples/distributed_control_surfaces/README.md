# Immersive Visualization and XR MIDI Controller

## jacknetumpd setup

Ensure the binary is under `/usr/bin`

## Plugin-host setup

We use [sushi](https://github.com/elk-audio/sushi) for this demo, but any plug-in host would work (w.g. REAPER)

Ensure:

- sushi binary is under `/usr/bin`
- libtwine is linked: try `ldd sushi` and check output
- VST3 `mda-vst3.vst3` is under `$HOME/.local/share/vst3/`

Move the configuration file under `$HOME/.config``

```bash
mkdir ~/.config/sushi
cp ./* ~/.config/sushi/
```

Move the run script under `/usr/bin/`

```bash
sudo cp ./sushi_nexus.sh /usr/bin/

```

## systemd services setup

Ensure pipewire, wireplumber and pipewire-jack are available in the system:

```bash
systemctl --user status pipewire.service
systemctl --user status wireplumber.service

which pw-jack
```

Copy the systemd unit files into the systemd user folder:

```bash
sudo cp ./systemd/* /usr/lib/systemd/user/
```

Reload the daemon and enable the services:

```bash
systemctl --user daemon-reload

systemctl --user enable jacknetumpd-keyboard.service
systemctl --user enable jacknetumpd-phone.service
systemctl --user enable jacknetumpd-keyboard-mdns.service
systemctl --user enable jacknetumpd-phone-mdns.service
systemctl --user enable sushi.service
```

Start the services:

```bash
systemctl --user start jacknetumpd-keyboard.service
systemctl --user start jacknetumpd-phone.service
systemctl --user start jacknetumpd-keyboard-mdns.service
systemctl --user start jacknetumpd-phone-mdns.service
systemctl --user start sushi.service
```
