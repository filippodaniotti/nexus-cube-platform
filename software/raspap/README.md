# RaspAP setup

We use [RaspAP](https://raspap.com/) to streamline the setup of the software access point and satellite functionalities, specifically hostapd, dnsmasq, dhcpd

We recommend the [quick installation script](https://docs.raspap.com/get-started/quick-installer/):

```bash
curl -sL https://install.raspap.com | bash -s -- --help
```

We recommend to build `hostapd` from scratch. The upstream release (as of version 2.10) features a bug in network device regulatory domain assignment, which causes potential issues if `hostapd` takes control of the network interface at startup. This behavior can be fixed applying [this patch](https://tildearrow.org/?p=post&month=7&year=2022&item=lar)

To build `hostapd` clone the repository

```bash
git clone git://w1.fi/hostap.git
cd hostap
```

install build dependencies

```bash
sudo apt update
sudo apt install -y build-essential pkg-config libssl-dev libnl-3-dev libnl-genl-3-dev
```

apply the patch

```bash
wget https://tildearrow.org/storage/hostapd-2.10-lar.patch
patch -p1 < hostapd-2.10-lar.patch
```

prepare build config

```bash
cd hostap/hostapd
cp defconfig .config
```

build

```bash
make -j"$(nproc)"
```

replace the `hostapd` binary from your package manager with the patched one

```bash
sudo cp hostapd /usr/bin/hostapd
```

We provide some example configurations for both `hostapd` and `dnsmasqd`. Make sure to substitute the network interface to match your hardware

```bash
sudo cp hostapd.conf /etc/hostapd/
sudo cp 090-wlan0.conf /etc/dnsmasq/
```

## Docker setup

You can use RaspAP through the community-driven RaspAP docker image

Ensure docker is installed and available in the system

```bash
systemctl --user status docker.service
```

Spin up the container stack with compose:

```bash
cd ./raspap
docker compose up -d
```

Apply firewall rules. Make sure to use the correct wireless network interface: change `wlan0` in the example `firewall-rules.sh` to match your hardware

```bash
bash firewall-rules.sh
```
