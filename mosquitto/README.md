# Mosquitto

This plan packages [mosquitto](https://mosquitto.org), a MQTT v3 broker.

## Usage

To use mosquitto via habitat, you need to have `hab` installed, and then run `hab start core/mosquitto`. This will fetch the latest stable version of this plan and run mosquitto.

## Configuration

[Configuration](https://bldr.habitat.sh/#/pkgs/core/mosquitto/latest) (bottom of the page) follows [monit sample config file](https://github.com/eclipse/mosquitto/blob/master/mosquitto.conf).

For client authentication (using habitat's files):

* If you want to use a password file, upload a file named `pwfile`
* If you want to use a PSK file, upload a file named `pskfile`
* If you want to use a ACL file, upload a file named `aclfile`

This package __DOES NOT__ currently support:

* TLS
* Extra listeners
* websockets
* auth plugins

If you need one of these features, feel free to create your own package that will depend on `core/mosquitto`.
