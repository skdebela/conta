#!/bin/bash

DATA_FILE="./data/contacts.txt"

# Create data file if it doesn't exist
if [ ! -f "$DATA_FILE" ]; then
    mkdir -p "$(dirname "$DATA_FILE")"
    touch "$DATA_FILE"
fi

# Load feature scripts
for script in "./features"/*.sh; do
    source "$script"
done

# Main menu logic
while true; do
    echo -e "\n"
    echo "========================="
    echo "  Conta Contact Manager"
    echo "========================="
    echo "1. Add Contact"
    echo "2. Remove Contact"
    echo "3. Edit Contact"
    echo "4. Search Contacts"
    echo "5. View All Contacts"
    echo "6. Categorize Contacts"
    echo "7. Sort Contacts"
    echo "8. Import/Export Contacts"
    echo "0. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) add_contact ;;
        2) remove_contact ;;
        3) edit_contact ;;
        4) search_contact ;;
        5) view_contacts ;;
        6) categorize_contacts ;;
        7) sort_contacts ;;
        8) import_export ;;
        0) exit 0 ;;
        *) echo "Invalid option '$choice'. please try again." ;;
    esac
done
