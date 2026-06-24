# RaspAP setup

We use [RaspAP](https://raspap.com/) to streamline the setup of the software access point and satellite functionalities, specifically hostapd, dnsmasq, dhcpd

We recommend the [quick installation script](https://docs.raspap.com/get-started/quick-installer/):

```bash
curl -sL https://install.raspap.com | bash -s -- --help
```

We provide some example configurations. Make sure to substitute the network interface to match your hardware

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
