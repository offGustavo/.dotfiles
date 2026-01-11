#!/usr/bin/env bash
#             __ _       _     _            _              _   _
#  _ __ ___  / _(_)     | |__ | |_   _  ___| |_ ___   ___ | |_| |__
# | '__/ _ \| |_| |_____| '_ \| | | | |/ _ \ __/ _ \ / _ \| __| '_ \
# | | | (_) |  _| |_____| |_) | | |_| |  __/ || (_) | (_) | |_| | | |
# |_|  \___/|_| |_|     |_.__/|_|\__,_|\___|\__\___/ \___/ \__|_| |_|
#
# Author: Nick Clyde (clydedroid)
# Improved with real-time updates and better device management
#
# A script that generates a rofi menu that uses bluetoothctl to
# connect to bluetooth devices and display status info.
#
# Inspired by networkmanager-dmenu (https://github.com/firecat53/networkmanager-dmenu)
# Thanks to x70b1 (https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-bluetooth-bluetoothctl)
#
# Depends on:
#   Arch repositories: rofi, bluez-utils (contains bluetoothctl)

# Import Current Theme
DIR="$HOME/.config/i3"
RASI="$DIR/rofi/config.rasi"

# Constants
goback="󰁍 Back"
rescan="󰑐 Rescan Devices"
refresh="󰑐 Refresh List"
divider="─────────"

# Cache file for device list
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/bluetooth-rofi"
DEVICE_CACHE="$CACHE_DIR/devices.cache"
mkdir -p "$CACHE_DIR"

# Rofi command with auto-refresh capability
rofi_command="rofi -theme ${RASI} -dmenu -i -auto-select -me-select-entry '' -me-accept-entry 'MousePrimary' $* -p"
# For testing without theme: rofi_command="rofi -dmenu -i -auto-select $* -p"

# Cleanup function
cleanup() {
    # Kill any background scanning processes
    pkill -f "bluetoothctl scan on" 2>/dev/null || true
    rm -f "$DEVICE_CACHE"
}
trap cleanup EXIT

# Check if bluetooth service is running
is_bluetooth_service_active() {
    if systemctl is-active --quiet bluetooth 2>/dev/null || \
       rc-service bluetooth status --quiet 2>/dev/null || \
       service bluetooth status --quiet 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Start bluetooth service if needed
ensure_bluetooth_service() {
    if ! is_bluetooth_service_active; then
        echo "Starting Bluetooth service..."
        if command -v systemctl >/dev/null 2>&1; then
            sudo systemctl start bluetooth
        elif command -v rc-service >/dev/null 2>&1; then
            sudo rc-service bluetooth start
        elif command -v service >/dev/null 2>&1; then
            sudo service bluetooth start
        fi
        sleep 2
    fi
}

# Checks if bluetooth controller is powered on
power_on() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles power state
toggle_power() {
    if power_on; then
        bluetoothctl power off
        show_menu
    else
        ensure_bluetooth_service
        if rfkill list bluetooth | grep -q 'blocked: yes'; then
            rfkill unblock bluetooth && sleep 2
        fi
        bluetoothctl power on
        # Start scanning when powering on
        bluetoothctl scan on >/dev/null 2>&1 &
        sleep 2
        show_menu
    fi
}

# Checks if controller is scanning for new devices
scan_on() {
    if bluetoothctl show | grep -q "Discovering: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles scanning state
toggle_scan() {
    if scan_on; then
        pkill -f "bluetoothctl scan on"
        bluetoothctl scan off
        show_menu
    else
        # Start scanning in background and update cache
        bluetoothctl scan on >/dev/null 2>&1 &
        update_device_cache &
        echo "󰑐 Scanning for devices..."
        show_menu
    fi
}

# Force rescan and update device list
force_rescan() {
    # Kill existing scan if running
    pkill -f "bluetoothctl scan on" 2>/dev/null || true
    
    # Clear cache and start fresh scan
    rm -f "$DEVICE_CACHE"
    bluetoothctl scan off >/dev/null 2>&1
    sleep 0.5
    bluetoothctl scan on >/dev/null 2>&1 &
    
    # Update cache with a small delay to find devices
    sleep 3
    update_device_cache
    
    show_menu
}

# Update device cache
update_device_cache() {
    if ! power_on; then
        > "$DEVICE_CACHE"
        return
    fi
    
    # Get paired devices first (they're more important)
    paired_devices=$(bluetoothctl devices Paired 2>/dev/null || bluetoothctl paired-devices 2>/dev/null)
    
    # Get all devices (including unpaired)
    all_devices=$(bluetoothctl devices 2>/dev/null)
    
    # Combine and deduplicate, prioritizing paired devices
    {
        echo "$paired_devices" | while read -r line; do
            if [[ -n "$line" ]]; then
                mac=$(echo "$line" | awk '{print $2}')
                name=$(echo "$line" | cut -d' ' -f3-)
                echo "󰤁 $name|$mac|paired"
            fi
        done
        
        echo "$all_devices" | while read -r line; do
            if [[ -n "$line" ]]; then
                mac=$(echo "$line" | awk '{print $2}')
                name=$(echo "$line" | cut -d' ' -f3-)
                # Skip if already in paired list
                if ! echo "$paired_devices" | grep -q "$mac"; then
                    echo "󰤀 $name|$mac|unpaired"
                fi
            fi
        done
    } | sort -u > "$DEVICE_CACHE"
}

# Get cached devices with connection status
get_devices_menu() {
    if [[ ! -f "$DEVICE_CACHE" ]] || [[ ! -s "$DEVICE_CACHE" ]]; then
        update_device_cache
    fi
    
    while IFS='|' read -r icon_name mac status; do
        # Extract icon and name
        icon="${icon_name:0:1}"
        name="${icon_name:2}"
        
        # Check connection status
        if device_connected "$mac"; then
            echo "󰂱 $name"
        else
            echo "$icon_name"
        fi
    done < "$DEVICE_CACHE"
}

# Checks if a device is connected
device_connected() {
    device_info=$(bluetoothctl info "$1" 2>/dev/null)
    if echo "$device_info" | grep -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

# Checks if a device is paired
device_paired() {
    device_info=$(bluetoothctl info "$1" 2>/dev/null)
    if echo "$device_info" | grep -q "Paired: yes"; then
        return 0
    else
        return 1
    fi
}

# Checks if a device is trusted
device_trusted() {
    device_info=$(bluetoothctl info "$1" 2>/dev/null)
    if echo "$device_info" | grep -q "Trusted: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles device connection with better feedback
toggle_connection() {
    mac=$1
    name=$2
    
    if device_connected "$mac"; then
        notify-send -t 2000 "Bluetooth" "Disconnecting $name..."
        if bluetoothctl disconnect "$mac"; then
            notify-send -t 2000 "Bluetooth" "Disconnected from $name"
        else
            notify-send -t 3000 "Bluetooth" "Failed to disconnect from $name"
        fi
    else
        notify-send -t 2000 "Bluetooth" "Connecting to $name..."
        if bluetoothctl connect "$mac"; then
            notify-send -t 2000 "Bluetooth" "Connected to $name"
        else
            notify-send -t 3000 "Bluetooth" "Failed to connect to $name"
        fi
    fi
    
    # Update cache and show menu
    update_device_cache
    show_menu
}

# Toggles device paired state
toggle_paired() {
    mac=$1
    name=$2
    
    if device_paired "$mac"; then
        notify-send -t 2000 "Bluetooth" "Removing $name..."
        if bluetoothctl remove "$mac"; then
            notify-send -t 2000 "Bluetooth" "Removed $name"
        fi
    else
        notify-send -t 2000 "Bluetooth" "Pairing with $name..."
        if bluetoothctl pair "$mac"; then
            notify-send -t 2000 "Bluetooth" "Paired with $name"
            # Auto-trust after pairing
            bluetoothctl trust "$mac"
        else
            notify-send -t 3000 "Bluetooth" "Failed to pair with $name"
        fi
    fi
    
    update_device_cache
    show_menu
}

# Toggles device trust
toggle_trust() {
    mac=$1
    name=$2
    
    if device_trusted "$mac"; then
        bluetoothctl untrust "$mac"
        notify-send -t 2000 "Bluetooth" "$name is no longer trusted"
    else
        bluetoothctl trust "$mac"
        notify-send -t 2000 "Bluetooth" "$name is now trusted"
    fi
    
    show_menu
}

# Get device info line from cache
get_device_info() {
    name=$1
    grep -F "|$name|" "$DEVICE_CACHE" | head -1
}

# Device submenu
device_menu() {
    display_name=$1
    
    # Get device info from cache
    device_info=$(get_device_info "$display_name")
    if [[ -z "$device_info" ]]; then
        show_menu
        return
    fi
    
    IFS='|' read -r icon_name mac status <<< "$device_info"
    name="${icon_name:2}"
    
    # Build device-specific options
    if device_connected "$mac"; then
        connected="󰂱 Connected"
    else
        connected="󰂱 Connect"
    fi
    
    if device_paired "$mac"; then
        paired="󰢱 Unpair"
    else
        paired="󰢱 Pair"
    fi
    
    if device_trusted "$mac"; then
        trusted="󰅣 Untrust"
    else
        trusted="󰅣 Trust"
    fi
    
    options="$connected\n$paired\n$trusted\n$divider\n$refresh\n$goback"
    
    # Show device menu
    chosen=$(echo -e "$options" | $rofi_command "$name")
    
    case "$chosen" in
        "$connected")
            toggle_connection "$mac" "$name"
            ;;
        "$paired")
            toggle_paired "$mac" "$name"
            ;;
        "$trusted")
            toggle_trust "$mac" "$name"
            ;;
        "$refresh")
            update_device_cache
            device_menu "$display_name"
            ;;
        "$goback")
            show_menu
            ;;
        *)
            show_menu
            ;;
    esac
}

# Main menu
show_menu() {
    ensure_bluetooth_service
    
    # Update cache on each menu display
    update_device_cache
    
    if power_on; then
        power="󰂯 Power Off"
        
        # Get device list from cache
        devices=$(get_devices_menu)
        
        # Get controller status
        if scan_on; then
            scan="󰒮 Stop Scan"
        else
            scan="󰒩 Start Scan"
        fi
        
        # Build options
        if [[ -n "$devices" ]]; then
            options="$devices\n$divider\n$power\n$scan\n$rescan\n$refresh\nExit"
        else
            options="No devices found\n$divider\n$power\n$scan\n$rescan\n$refresh\nExit"
        fi
    else
        power="󰂲 Power On"
        options="$power\nExit"
    fi
    
    # Display menu
    chosen=$(echo -e "$options" | $rofi_command "Bluetooth")
    
    # Handle selection
    case "$chosen" in
        ""|"No devices found")
            # Do nothing or show menu again
            ;;
        "$power")
            toggle_power
            ;;
        "$scan"|"󰒩 Start Scan"|"󰒮 Stop Scan")
            toggle_scan
            ;;
        "$rescan")
            force_rescan
            ;;
        "$refresh")
            update_device_cache
            show_menu
            ;;
        "Exit")
            exit 0
            ;;
        *)
            # Check if it's a device (starts with Bluetooth icon)
            if [[ "$chosen" =~ ^󰤁|^󰤀|^󰂱 ]]; then
                # Extract device name (remove icon and space)
                device_name="${chosen#* }"
                device_menu "$device_name"
            else
                show_menu
            fi
            ;;
    esac
}

# Status bar output
print_status() {
    if power_on; then
        printf '󰂯'
        
        # Get connected devices
        connected_count=0
        if [[ -f "$DEVICE_CACHE" ]]; then
            while IFS='|' read -r icon_name mac status; do
                if device_connected "$mac"; then
                    name="${icon_name:2}"
                    if [ $connected_count -eq 0 ]; then
                        printf " %s" "$name"
                    else
                        printf ", %s" "$name"
                    fi
                    ((connected_count++))
                fi
            done < "$DEVICE_CACHE"
        fi
        
        # If no devices connected, just show icon
        if [ $connected_count -eq 0 ]; then
            printf " On"
        fi
        printf "\n"
    else
        printf "󰂲 Off\n"
    fi
}

# Main execution
case "$1" in
    --status)
        print_status
        ;;
    --toggle)
        toggle_power
        ;;
    --connect)
        # Optional: connect to a specific device passed as $2
        if [[ -n "$2" ]]; then
            toggle_connection "$2" "Device"
        else
            show_menu
        fi
        ;;
    *)
        show_menu
        ;;
esac
