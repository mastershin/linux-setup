#!/bin/bash

# Given list of /dev/sd* devices, print out disk by id, for creating zpool volume
# The actual command is printed out, but, not executed.  Manually run zfs command.

for DEVICE in $@; do
    # Fetch the symlink target for the device from /dev/disk/by-id/
    for ID_DEVICE in /dev/disk/by-id/*; do
        if [ "$(readlink -f "$ID_DEVICE")" = "/dev/$DEVICE" ]; then
            ID_DEVICES+=("$ID_DEVICE")
            break
        fi
    done
done

# Check if we have found any by-id names
if [ ${#ID_DEVICES[@]} -eq 0 ]; then
    echo "No by-id device names found."
    exit 1
fi

echo "Command Template:"
echo "# zpool create zfs raidz ${ID_DEVICES[@]}"
echo

