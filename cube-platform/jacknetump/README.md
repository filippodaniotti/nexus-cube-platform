# Jacknetumpd setup

[Jacknetumpd](https://github.com/bbouchez/jacknetumpd/tree/main) is a daemon that exposes MIDI 2.0 network endpoint

We use [a custom fork](https://github.com/filippodaniotti/jacknetumpd) of the original implementation

Binaries for arm64 are provided in this repository

If you want to build it yourself you can clone the repo

```bash
git clone https://github.com/filippodaniotti/jacknetumpd
cd jacknetumpd
```

Then build with CMake

```bash
cmake -B build && cmake --build build
```

To start the daemon:

```bash
pw-jack jacknetumpd --localport 5504 --remoteport 5504 --endpoint jacknetumpd --interface wlan0
```

Optionally you can advertise the service in the network with mDNS

```bash
avahi-publish-service --domain=local -s jacknetumpd _midi2._udp 5504
```
