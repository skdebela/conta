#!/bin/bash

function remove_contact {
    local query
    echo "Remove contact function"

    # Check if the data file exists and is not empty
    check_data_file || return 1

    read -p "Enter the name or phone number of contact to remove: " query
    if [[ -z "$query" ]]; then
        echo "Search query cannot be empty. Please try again."
        return 1
    fi

    # Search the matching contacts and display
    local matches=$(grep -i "$query" "$DATA_FILE")
    if [[ -z "$matches" ]]; then
        echo "No matching contact found."
        return 1
    fi

    echo "Found the following matching contact(s):"
    display_contacts_with_id "$matches"

    read -p "Enter the number of contact you want to remove: " choice

    # Display contact to be deleted and ask for confrimation
    IFS=$'\n' read -rd '' -a contact_array <<< "$matches"
    local selected_contact="${contact_array[$((choice - 1))]}"
    display_contact "$selected_contact"
    read -p "Are you sure you want to delete this contact? (y/n)" confirm_delete

    if [[ "$confirm_delete" != "y" ]]; then
        echo "Contact removal canceled."
        return 0
    fi

    # Remove the contact by filtering it out
    grep -vF "$selected_contact" "$DATA_FILE" > "$DATA_FILE.tmp" 

    # File permission error handling
    if [ ! -w "$DATA_FILE" ]; then
        echo "Error: No write permission for the data file."
        return 1
    fi

    mv "$DATA_FILE.tmp" "$DATA_FILE"

    echo "Contact has been removed."
}

