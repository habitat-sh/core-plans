# zerotier-one

[ZeroTier](https://www.zerotier.com/) delivers the capabilities of VPNs, SDN, and SD-WAN with a single system. Manage all your connected resources across both local and wide area networks as if the whole world is a single data center.

This package contains the [ZeroTierOne](https://github.com/zerotier/ZeroTierOne) client applications with which you can connect a machine to one or more networks.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

1. Before loading the service, you may configure any desired network ID to auto-join. You may skip this step and join any network later with the CLI tool

    ```bash
    mkdir -p /hab/user/zerotier-one/config
    echo 'network = "8056c2e21c000001"' > /hab/user/zerotier-one/config/user.toml
    ```

1. Load the service

    ```bash
    hab svc load core/zerotier-one
    ```

### Optional next steps

* Verify the service is online

    ```bash
    hab pkg exec core/zerotier-one zerotier-cli info
    ```

    Healthy output looks like:

    ```
    200 info 0fa7fa19b7 1.2.10 ONLINE
    ```

* Use the CLI to join a network, if one was not specified via configuration in step 1 or you want to join additional networks

    ```bash
    hab pkg exec core/zerotier-one zerotier-cli join 8056c2e21c000001
    ```

    Healthy output looks like:

    ```
    200 join OK
    ```

* List joined networks

    ```bash
    hab pkg exec core/zerotier-one zerotier-cli listnetworks
    ```

    Healthy output looks like:

    ```
    200 listnetworks <nwid> <name> <mac> <status> <type> <dev> <ZT assigned ips>
    200 listnetworks 8056c2e21c000001 earth.zerotier.net 02:a4:5d:d5:30:a2 OK PUBLIC ztmjfmfyq5 fd80:56c2:e21c:0000:0199:93a4:5dc9:d260/88,29.201.210.235/7
    ```

    In this example, `29.201.210.235` (shown in the last column) is your IPv4 address on the virtual network.