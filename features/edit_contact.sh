#!/bin/bash

# TODO: error handling (file permission)

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
    matches=$(grep -i "$search_term" "$DATA_FILE")
    if [ -z "$matches" ]; then
        echo "No matching contact found."
        return 1
    fi

    echo "Found the following matching contacts:"
    display_contacts_with_id "$matches"

    read -p "Enter the number of the contact you want to edit: " choice

    IFS=$'\n' read -rd '' -a contact_array <<<"$matches"
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#contact_array[@]} )); then
        selected_contact="${contact_array[$((choice - 1))]}"
        display_contact "$selected_contact"

        read -p "Do you want to edit this contact? (y/n): " confirm_edit
        if [[ "$confirm_edit" != "y" ]]; then
            echo "Contact edit canceled."
            return 0
        fi

        # Extract fields from the selected contact
        IFS=':' read -r old_name old_phones old_emails old_categories <<< "$selected_contact"

        # Read new values

        read -p "Enter new name (or press Enter to keep the current name): " new_name
        new_name=${new_name:-$old_name}
    
        while true; do
            read -p "Enter new phone numbers (comma separated) (or press Enter to keep current): " new_phones
            new_phones=${new_phones:-$old_phones}
            # Validate each phone entry
            valid=true
            IFS=',' read -ra phones <<< "$new_phones"
            for phone in "${phones[@]}"; do
                if ! validate_phone "${phone#*=}"; then
                    echo "Invalid phone number: $phone"
                    valid=false
                    break
                fi
            done
            [[ $valid == true ]] && break
        done
    
        while true; do
            read -p "Enter new emails (comma separated) (or press Enter to keep current): " new_emails
            new_emails=${new_emails:-$old_emails}
            # Validate each email entry
            valid=true
            IFS=',' read -ra emails <<< "$new_emails"
            for email in "${emails[@]}"; do
                if ! validate_email "${email#*=}"; then
                    echo "Invalid email: $email"
                    valid=false
                    break
                fi
            done
            [[ $valid == true ]] && break
        done
        
        read -p "Enter new categories (comma separated) (or press Enter to keep the current categories): " new_categories
        new_categories=${new_categories:-old_categories}
    
        # Format to local storage format before writing
        new_phones=$(echo "$new_phones" | tr ',' ';')
        new_emails=$(echo "$new_emails" | tr ',' ';')
        new_categories=$(echo "$new_categories" | tr ',' ';')

        # Prepare the updated contact string
        updated_contact="$new_name:$new_phones:$new_emails:$new_categories"

        # Update the contact in the data file
        sed -i "s|$selected_contact|$updated_contact|" "$DATA_FILE"
        echo "Contact has been updated."
    else
        echo "Invalid choice. Please try again."
    fi
}
