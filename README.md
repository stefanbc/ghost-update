# ghoster

A small shell script to update your Ghost installation.

## Before usage

Keep in mind that this script requires cURL to download the latest stable version of Ghost.

Before you start the script make sure you modify the `GHOST_INSTALL_PATH` line with the correct path to your Ghost instance.

After that, this script requires execution rights. You can use this command to enable those `chmod +x ghoster.sh`.

In case your Ghost instance is not running on a Digital Ocean droplet you can comment out line 56 and replace line 62 with the command you use to start your Ghost instance.

## Usage

You can use the `./ghoster help` to read about the available commands.

To actually use the script, you can use the `./ghoster update` command, to update your Ghost instance.

## Notice

Please read the [LICENSE](LICENSE) very carefully as the author of this script should not be held accountable for any damages that this script might cause.

## Roadmap

* Ability to chose the Ghost version
* Compatibility with multiple types of Ghost installations
* Ability to downgrade to a previous version of Ghost
* More meaningful error messages