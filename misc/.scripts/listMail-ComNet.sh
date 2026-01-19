#!/bin/bash

# Function to display a text file using "cat"
view_file() {
    clear
    cat /home/raph/Recherche/LIP6/DirectionEquipeCN/Machines/Site_Web/sauvegardes_mailing_lists/2025_janvier/export_$1-2025-01-29.csv
    exit 0
}

# Main menu
while true; do
    CHOICE=$(dialog --stdout --title "Main Menu" --menu "Choose an action:" 12 40 3 \
        1 "permanents" \
        2 "flood" \
        3 "tous" \
        4 "Exit")

    case $CHOICE in
        1) view_file permanents;;
        2) view_file flood;;
        3) view_file tous;;
        4) clear; exit 0 ;;
        *) break ;;
    esac
done

