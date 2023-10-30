#!/usr/bin/env bash
CONFIG_FILE="./config.conf"
DEVICE_1=""
DEVICE_2=""
CURR_OUT=""

# Load initial setup from config file
while read parameter sign value
do
    case $parameter in
     DEVICE_1)
          DEVICE_1=$value
          ;;
     DEVICE_2)
          DEVICE_2=$value
          ;;
     CURR_OUT)
          CURR_OUT=$value
          ;;
    esac
    
done < $CONFIG_FILE

# Switch audio device with "s" parameter
if [ "$1" == "s" ]
then
    if [ $CURR_OUT == 0 ]
    then
        CURR_OUT=1
        echo "$DEVICE_1"
        nircmd setdefaultsounddevice "$DEVICE_2" 1
    else
        CURR_OUT=0
        nircmd setdefaultsounddevice "$DEVICE_1" 1
    fi
fi

# Change the name of DEVICE_1
if [ "$1" = "d1" ]
then
    DEVICE_1=$2
fi

# Change the name of DEVICE_2
if [ "$1" = "d2" ]
then
    DEVICE_2=$2
fi

# Save new config
echo "DEVICE_1 = $DEVICE_1" > config.conf
echo "DEVICE_2 = $DEVICE_2" >> config.conf
echo "CURR_OUT = $CURR_OUT" >> config.conf