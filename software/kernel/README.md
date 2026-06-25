# RT Kernel with UMP support

Install dependencies

```bash
sudo apt install -y bc bison flex libssl-dev libncurses-dev make git
```

Clone the RPi kernel source (check kernel with uname -a). Here we use 6.18

```bash
cd ~
git clone --depth=1 --branch rpi-6.18.y https://github.com/raspberrypi/linux
cd linux
```

Seed config from actual kernel

```bash
sudo modprobe configs
zcat /proc/config.gz > .config
```

Enable the MIDI 2.0 / UMP options
Core UMP + sequencer (pulled in by MIDI_V2 but set explicitly to be safe)

```bash
scripts/config --enable CONFIG_PREEMPT_RT

scripts/config --enable CONFIG_SND_USB_AUDIO_MIDI_V2
scripts/config --module CONFIG_SND_UMP
scripts/config --enable CONFIG_SND_SEQ_UMP
scripts/config --module CONFIG_SND_SEQ_UMP_CLIENT
scripts/config --enable CONFIG_SND_UMP_LEGACY_RAWMIDI
scripts/config --enable CONFIG_USB_CONFIGFS_F_MIDI2
```

Resolve dependencies

```bash
make olddefconfig
```

Verify the config before starting the building

```bash
grep -E 'SND_UMP|SND_SEQ_UMP|MIDI_V2|F_MIDI2|PREEMPT_RT' .config
```

Expected output

```bash
CONFIG_SPREEMPT_RT=y
CONFIG_SND_UMP=m
CONFIG_SND_UMP_LEGACY_RAWMIDI=y
CONFIG_SND_SEQ_UMP=y
CONFIG_SND_SEQ_UMP_CLIENT=m
CONFIG_SND_USB_AUDIO_MIDI_V2=y
CONFIG_USB_CONFIGFS_F_MIDI2=y
```

Run the build with as many cores as possible

```bash
make -j$(nproc) Image.gz modules dtbs
```

WAIT FOR HOURS. Then, once it is done, install modules

```bash
sudo make modules_install
```

Verify boot partition location

```bash
ls /boot/firmware/kernel*.img
```

Expected output

```bash
kernel8.img — generic arm64 (Cortex-A53/A72), for Pi 3 and Pi 4
kernel_2712.img — optimized for Cortex-A76, for Pi 5

```

Install kernel

```bash
sudo cp arch/arm64/boot/Image.gz /boot/firmware/kernel_2712.img
```

# Install DTBs

```bash
sudo cp arch/arm64/boot/dts/broadcom/*.dtb /boot/firmware/
sudo cp arch/arm64/boot/dts/overlays/*.dtb* /boot/firmware/overlays/
```

# Reboot and pray

```bash
sudo reboot
```

```

```
