#!/bin/sh
#
#
#
DEVICE_SYSFS_PATH="/sys/devices/platform/omap/omap_i2c.2/i2c-2/2-0040"

BLINK_DELAY=1000000
REGADDR=regaddr
REGDATA=regdata
BKLTEN_ADDR=0xC
BKLTEN_DISABLE=0x10
BKLTEN_ENABLE=0x00

echo " "
echo "   This script tests the i2c connectivity between the "
echo "   CPU and the TLC59108.  This requires that the FPGA "
echo "   be programmed with the i2c slave at i2c address 0x40. "
echo " "

# Check to make sure the module is installed
if [[ -f $DEVICE_SYSFS_PATH/$REGADDR ]]
then
        continue
else
        echo "  Error: $DEVICE_SYSFS_PATH not found."
        echo "  Please insmod tlc59108-i2c.ko"
        exit 1
fi

sleep 2

echo "   Blink the backlight a couple of times"
echo " "

# Blink the backlight
echo ${BKLTEN_ADDR} > ${DEVICE_SYSFS_PATH}/${REGADDR}
echo ${BKLTEN_DISABLE} > ${DEVICE_SYSFS_PATH}/${REGDATA}
usleep ${BLINK_DELAY}
echo ${BKLTEN_ENABLE} > ${DEVICE_SYSFS_PATH}/${REGDATA}
usleep ${BLINK_DELAY}
echo ${BKLTEN_DISABLE} > ${DEVICE_SYSFS_PATH}/${REGDATA}
usleep ${BLINK_DELAY}
echo ${BKLTEN_ENABLE} > ${DEVICE_SYSFS_PATH}/${REGDATA}
usleep ${BLINK_DELAY}

echo " "
echo "   Test done."
exit 0


