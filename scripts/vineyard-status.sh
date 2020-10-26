#!/usr/bin/env bash
code=$(curl --write-out "%{http_code}" --silent --output /dev/null 'https://video-cdn.angelthump.com/hls/davineyardboystonight453/index.m3u8')
if [ "$code" == "200" ]; then
    if [ ! -f "/dev/shm/vineyard" ]; then
        notify-send "Vineyard is live!" "Joel is now streaming movies on the Vineyard"
        touch /dev/shm/vineyard
    fi
elif [ -f "/dev/shm/vineyard" ]; then
    rm /dev/shm/vineyard
fi
