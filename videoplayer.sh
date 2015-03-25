#!/bin/sh

# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

# set here the path to the directory containing your videos
VIDEOPATH="/home/pi/videos" 

# you can normally leave this alone
SERVICE="omxplayer"


#LED Pin - wiringPi pin 0 is BCM_GPIO 17.
gpio mode 0 out

# now for our infinite loop!
while true; do
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
        sleep 0.5;
else
        for entry in $VIDEOPATH/*
        do
                clear
                omxplayer $entry > /dev/null
        done
fi
done