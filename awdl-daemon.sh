#!/bin/bash

# curl -s https://raw.githubusercontent.com/meterup/awdl_wifi_scripts/main/disable_awdl.sh > ~/disable_awdl.sh
# change dir to current work dir
cd "$(dirname "$0")" || exit 1
pwd
cp ./res/disable_awdl.sh ~/disable_awdl.sh
sudo chmod u+x ~/disable_awdl.sh
# sudo chmod +x ~/disable_awdl.sh
# cd /Library/LaunchDaemons/ && sudo curl -sO https://raw.githubusercontent.com/meterup/awdl_wifi_scripts/main/com.meter.wifi.awdl.plist
sudo cp ./res/com.meter.wifi.awdl.plist /Library/LaunchDaemons/
sudo sed -i -- "s/YOUR_USERNAME/${USER}/g" /Library/LaunchDaemons/com.meter.wifi.awdl.plist
sudo launchctl unload -w /Library/LaunchDaemons/com.meter.wifi.awdl.plist 2> /dev/null
sudo launchctl load -w /Library/LaunchDaemons/com.meter.wifi.awdl.plist
echo "Finished"