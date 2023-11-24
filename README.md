# Zookeeper Snap

[![CharmHub Badge](https://snapcraft.io/charmed-zookeeper/badge.svg)](https://snapcraft.io/charmed-zookeeper)
[![Release](https://github.com/canonical/charmed-zookeeper-snap/actions/workflows/publish.yaml/badge.svg)](https://github.com/canonical/charmed-zookeeper-snap/actions/workflows/publish.yaml)

This repository contains the packaging metadata for creating a snap of Zookeeper built from the official Zookeeper release artifacts.  For more information on snaps, visit [snapcraft.io](https://snapcraft.io/). 

## Installing the Snap
The snap can be installed directly from the Stap Store.  Follow the link in the badge below for more information.
<br>

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/zookeeper)


## Building the Snap
The steps outlined below are based on the assumption that you are building the snap with the latest LTS of Ubuntu.  If you are using another version of Ubuntu or another operating system, the process may be different.

### Clone Repository
```bash
git clone git@github.com:canonical/zookeeper-snap.git
cd zookeeper-snap
```
### Installing and Configuring Prerequisites
```bash
sudo snap install snapcraft
sudo snap install lxd
sudo lxd init --auto
```
### Packing and Installing the Snap
```bash
snapcraft pack
sudo snap install ./zookeeper*.charm --devmode
```

## License
The Zookeeper Snap is free software, distributed under the Apache
Software License, version 2.0. See
[LICENSE](https://github.com/canonical/zookeeper-snap/blob/3.6.3/stable/LICENSE)
for more information.