#!/bin/bash

# TODO: error handling (file permission)

function remove_contact {
    echo "Remove contact function"

    # Check if the data file exists and is not empty
    check_data_file || return 1

    read -p "Enter the name or phone number of contact to remove: " search_term
    if [[ -z "$search_term" ]]; then
        echo "Search term cannot be empty. Please try again."
        return 1
    fi

    # Search the matching contacts and display
    matches=$(grep -i "$search_term" "$DATA_FILE")
    if [[ -z "$matches" ]]; then
        echo "No matching contact found."
        return 1
    fi

    echo "Found the following matching contact(s):"
    display_contacts_with_id "$matches"

    read -p "Enter the number of contact you want to remove: " choice

    # Display contact to be deleted and ask for confrimation
    IFS=$'\n' read -rd '' -a contact_array <<< "$matches"
    selected_contact="${contact_array[$((choice - 1))]}"
    display_contacts <<< "$selected_contact"
    read -p "Are you sure you want to delete this contact? (y/n)" confirm_delete

    if [[ "$confirm_delete" != "y" ]]; then
        echo "Contact removal canceled."
        return 0
    fi

    # Remove the contact by filtering it out
    grep -vF "$selected_contact" "$DATA_FILE" > "$DATA_FILE.tmp" 
    mv "$DATA_FILE.tmp" "$DATA_FILE"

    echo "Contact has been removed."
}

