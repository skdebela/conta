#!/bin/bash

# TODO: multiple match handling
# TODO: error handling (file permission)

function remove_contact {
    echo "Remove contact function"

    # Check if the data file exists and is not empty
    if [[ ! -s "$DATA_FILE" ]]; then
        echo "No contacts found."
        return 1
    fi

    read -p "Enter the name or phone number of contact to remove: " search_term
    if [[ -z "$search_term" ]]; then
        echo "Search term cannot be empty. Please try again."
        return 1
    fi

    # Search the matching contacts and display
    contact_to_remove=$(grep -i "$search_term" "$DATA_FILE")
    if [[ -z "$contact_to_remove" ]]; then
        echo "No matching contact found."
        return 1
    fi

    echo "Found the following contact(s) to remove:"
    echo "$contact_to_remove"
    echo "Are you sure you want to delete this contact? (y/n)"
    read -p "Choice: " confirm_delete

    if [[ "$confirm_delete" != "y" ]]; then
        echo "Contact removal canceled."
        return 0
    fi

    # Remove the contact by filtering it out
    grep -i -v "$search_term" "$DATA_FILE" > "$DATA_FILE.tmp" 
    mv "$DATA_FILE.tmp" "$DATA_FILE"

    echo "Contact has been removed."
}

