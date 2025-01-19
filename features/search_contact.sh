#!/bin/bash

# TODO: highlight matching portions in output for better visibility

function search_contact {
    echo "Search contacts"

    check_data_file || return 1

    read -p "Enter search term (name, email, phone, or email): " search_term
    if [[ -z $search_term ]]; then
        echo "Search term cannot be empty. Please try agin."
        return 1
    fi

    echo "Matching contacts for '$search_term':"
    matching_contacts=$(grep -i "$search_term" "$DATA_FILE")
    if [[ -z "$matching_contacts" ]]; then
        echo "No matching contacts found."
        return 1
    fi

    display_contacts "$matching_contacts"
}
