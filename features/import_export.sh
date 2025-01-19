#!/bin/bash

function import_contacts {
    echo "Import contacts from CSV"

    read -p "Enter CSV file path to import from: " import_file
    if [ ! -f "$import_file" ]; then
        echo "The specified file does not exist."
        return 1
    fi

    # Import rows from CSV, starting from 2nd line to skip header
    tail -n +2 "$import_file" | while IFS=',' read -r name phones emails categories; do
        if ! grep -q "^$name:" "$DATA_FILE"; then
            echo "$name:$phones:$emails:$categories" >> "$DATA_FILE"
        else
            echo "Contact '$name' already exists. Skipping."
        fi
    done

    echo "Contacts imported successfully"
}

function export_contacts  {
    echo "Export contacts to CSV"

    read -p "Enter the CSV file path to export to: " export_file

    # Add header
    echo "Name,Phone Numbers,Emails,Categories" > "$export_file"

    # Convert to internal storage format
    awk -F ':' '{
        print $1 "," $2 "," $3 "," $4
    }' "$DATA_FILE" >> "$export_file"
    
    echo "Contacts exported to '$export_file'."
}

function import_export {
    echo "Import/Export Contacts"
    echo "1. Import contacts"
    echo "2. Export contacts"
    echo "0. Return to main menu"
    read -p "Choose an option: " choice

    case $choice in
        1) import_contacts ;;
        2) export_contacts ;;
        0) return ;;
        *) echo "invalid option" ;;
    esac
}
