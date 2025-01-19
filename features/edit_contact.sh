#!/bin/bash

# TODO: multiple matches handling
# TODO: error handling (file permission)
# TODO: validation

function edit_contact {
    echo "Edit Contact"

    # Check if the data file exists and is not empty
    if [ ! -s "$DATA_FILE" ]; then
        echo "No contacts found."
        return 1
    fi

    read -p "Enter the name or phone number of the contact to edit: " search_term
    if [[ -z "$search_term" ]]; then
        echo "Search term cannot be empty. Please try again."
        return 1
    fi

    # Search for the contact to edit
    contact_to_edit=$(grep -i "$search_term" "$DATA_FILE")
    if [ -z "$contact_to_edit" ]; then
        echo "No matching contact found."
        return 1
    fi

    echo "Found the following contact to edit:"
    echo "$contact_to_edit"

    # Display current contact details and prompt for updates
    read -p "Do you want to edit this contact? (y/n): " confirm_edit
    if [[ "$confirm_edit" != "y" ]]; then
        echo "Contact edit canceled."
        return 0
    fi

    # Read new values for the contact fields
    read -p "Enter new name (or press Enter to keep the current name): " new_name
    read -p "Enter new phone numbers (comma separated) (or press Enter to keep the current phone numbers): " new_phone
    read -p "Enter new emails (comma separated) (or press Enter to keep the current emails): " new_email
    read -p "Enter new categories (comma separated) (or press Enter to keep the current categories): " new_categories

    # If the user left a field empty, retain the old value
    new_name=${new_name:-$(echo "$contact_to_edit" | cut -d: -f1)}
    new_phone=${new_phone:-$(echo "$contact_to_edit" | cut -d: -f2)}
    new_email=${new_email:-$(echo "$contact_to_edit" | cut -d: -f3)}
    new_categories=${new_categories:-$(echo "$contact_to_edit" | cut -d: -f4)}

    # Prepare the updated contact string
    updated_contact="$new_name:$new_phone:$new_email:$new_categories"

    # Update the contact in the data file
    sed -i "s|$contact_to_edit|$updated_contact|" "$DATA_FILE"
    echo "Contact has been updated."
}

