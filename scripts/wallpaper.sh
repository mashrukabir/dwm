#!/bin/bash

wallpaper_dir="$HOME/Pictures/Wallpapers"

# Check if the wallpaper directory exists
if [ ! -d "$wallpaper_dir" ]; then
    echo "Error: Wallpaper directory does not exist."
    exit 1
fi

# Function to display wallpaper options using dmenu
show_wallpaper_options() {
    # List all image files using dmenu
    wallpapers=$(find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -exec basename {} \; | sort)

    chosen_wallpaper=$(echo "$wallpapers" | dmenu -l 10)
    echo "$chosen_wallpaper"
}

main() {
    chosen_wallpaper=$(show_wallpaper_options)

    if [ -n "$chosen_wallpaper" ]; then
        feh --bg-fill "$wallpaper_dir/$chosen_wallpaper"
    fi
}

main
