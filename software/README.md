# Software

This folder contains instructions to setup the software stack used by the *Muse Cube* embedded platform. The system is built on open-source components that provide operating system services, wireless networking, service discovery, low-latency audio/MIDI routing, and the main audio processing host.

## Stack

- **Linux**: Base operating system for the embedded platform, handling device support, networking, and audio/MIDI I/O.
- **RaspAP + hostapd**: Used to configure the Cube as a wireless access point so other devices can connect directly without external network infrastructure.
- **dnsmasq**: Lightweight DNS and DHCP service for local address assignment and small-network support.
- **avahi**: Provides Bonjour/mDNS service discovery so compatible applications can automatically find services on the local network.
- **PipeWire**: Manages low-latency audio and MIDI routing between services and applications.
- **jacknetumpd**: Network MIDI 2.0 daemon used to translate UMP over UDP for local music processing.
- **pluginhost**: Central processing node that receives MIDI data, runs audio plugins, and routes the generated audio output.

### Notes
The software architecture is modular, so individual services can be replaced or extended depending on the target use case.