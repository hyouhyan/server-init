#!/bin/bash

if [ ! -e /etc/rc.local ]; then
    sudo touch /etc/rc.local
    echo '#!/bin/sh -e' | sudo tee /etc/rc.local
fi

echo "
# Turn Off PWR LED
echo 0 | sudo tee /sys/class/leds/PWR/brightness

# Turn Off ACT LED
echo none | sudo tee /sys/class/leds/ACT/trigger

exit 0
" | sudo tee -a /etc/rc.local

sudo chmod +x /etc/rc.local
