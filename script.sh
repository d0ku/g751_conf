#!/bin/sh
# ./script.sh 01:00.0 vfio-pci
modprobe $2
# Ensure that the drivers will not run to take ownership of the bus
# echo 0 > /sys/bus/pci/drivers_autoprobe

                # Gather relevant information of the device in BUS
                VENDOR=$(cat /sys/bus/pci/devices/0000\:$1/vendor)
                DEVICE=$(cat /sys/bus/pci/devices/0000\:$1/device)
                if [ -e /sys/bus/pci/devices/0000\:$1/driver ]; then
                    echo 0000:$1 > /sys/bus/pci/devices/0000\:$1/driver/unbind
                fi

                echo  $VENDOR $DEVICE > /sys/bus/pci/drivers/$2/new_id

                # line below should work as Alex Williamson indicates... but not for me
                #echo 0000:$1 > /sys/bus/pci/drivers/$2/bind

                echo   $VENDOR $DEVICE > /sys/bus/pci/drivers/$2/remove_id

                exit 0
