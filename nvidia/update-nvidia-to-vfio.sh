#!/bin/bash

# Function to bind a device to vfio-pci
# This is used for enable multiple nvidia devices to vfio-pci to be used within VM
# @author: mastershin at gmail.com

bind_to_vfio() {
    local DEVICE=$1
    local ACTION=$2

    # Check if the device is currently bound to a driver
    if [ -e "/sys/bus/pci/devices/$DEVICE/driver" ]; then
        echo "Will unbind $DEVICE from its current driver..."
        if [ "$ACTION" == "update" ]; then
            echo $DEVICE > /sys/bus/pci/devices/$DEVICE/driver/unbind
        fi
    else
        echo "$DEVICE is not currently bound to any driver."
    fi

    echo "Will bind $DEVICE to vfio-pci..."
    if [ "$ACTION" == "update" ]; then
        echo "vfio-pci" > /sys/bus/pci/devices/$DEVICE/driver_override
        echo $DEVICE > /sys/bus/pci/drivers/vfio-pci/bind
    fi
}

ACTION=$1  # Capture the action argument

# Automatically detect NVIDIA devices and further filter them by the labels
DEVICES=$(lspci -D | grep -i "nvidia" | grep -E "VGA compatible controller|Audio device|USB|UCSI" | awk '{print $1}')

# Iterate over all detected devices and bind them to vfio-pci
for DEVICE in $DEVICES; do
    bind_to_vfio $DEVICE $ACTION
done

if [ "$ACTION" == "update" ]; then
    echo "All detected NVIDIA devices are now bound to vfio-pci."
else
    echo "Dry run complete. Use './script_name update' to apply changes."
fi

