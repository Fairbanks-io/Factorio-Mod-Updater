# Factorio Mod Updater
Simplify downloading and updating Factorio mods on your server. 

This script assumes:
* You're in the factorio install directory when running it
* You're using the default mod-list.json format
* You want the latest version of the mod

To run it:
* Download it to the factorio install directory
* Ensure a *mod-list.json* file is present ([sample](https://github.com/Fairbanks-io/Factorio-Mod-Updater/blob/master/mod-list.json))
* Set the script as executable: `chmod +x factorio-mod-updater.sh`
* Run it: `./factorio-mod-updater.sh`

For a Docker based Factorio solution, checkout the [Docker image page](https://hub.docker.com/r/jonfairbanks/docker_factorio_server)