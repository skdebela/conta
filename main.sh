#!/bin/bash

INSTALL_DIR=$(dirname "$(realpath "$0")")
DATA_FILE="${CONTA_DATA_HOME:-$HOME/.local/share}/conta/data/contacts.txt"
CONFIG_DIR="${CONTA_CONFIG_DIR:-$HOME/.config/conta}"

# Create data file if it doesn't exist
if [ ! -f "$DATA_FILE" ]; then
    mkdir -p "$(dirname "$DATA_FILE")"
    touch "$DATA_FILE"
fi

# Load feature scripts
for script in "$INSTALL_DIR/features"/*.sh; do
    source "$script"
done

# Parse flags and arguments
action=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        -A|--add)
            action="add"
            shift
            ;;
        -C|--categorize)
            action="categorize"
            category="$2"
            shift 2
            ;;
        -S|--search)
            action="search"
            query="$2"
            shift 2
            ;;
        -V|--view)
            action="view"
            shift
            ;;
        -n | --name)
            name="$2"
            shift 2
            ;;
        -p | --phones)
            phones="$2"
            shift 2
            ;;
        -e | --emails)
            emails="$2"
            shift 2
            ;;
        -c | --categories)
            categories="$2"
            shift 2
            ;;
        -h | --help)
            cat "$CONFIG_DIR/USAGE.txt"
            exit 0
            ;;
        *)
            echo "Invalid action: '$1'. Use -h or --help to display the manual."
            exit 1
            ;;
    esac
done

# Execute the action based on the parsed arguments
if [[ -n $action ]]; then
    case $action in
        add)
            add_contact_with_args "$name" "$phones" "$emails" "$categories"
            ;;
        categorize)
            categorize_contacts_with_args "$category"
            ;;
        search)
            search_contact_with_args "$query"
            ;;
        view)
            view_contacts
            ;;
        *)
            echo "No valid action specified."
            ;;
    esac
else
    # Interactive mode (main menu)
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
fi
