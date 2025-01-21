#!/bin/bash

# TODO: highlight matching portions in output for better visibility

function search_contact {
    local query
    echo "Search contacts"

    check_data_file || return 1

    read -p "Enter search query (name, email, phone, or email): " query
    if [[ -z $query ]]; then
        echo "Search term cannot be empty. Please try agin."
        return 1
    fi

    echo "Matching contacts for '$query':"
    local matching_contacts=$(grep -i "$query" "$DATA_FILE")
    if [[ -z "$matching_contacts" ]]; then
        echo "No matching contacts found."
        return 1
    fi

    display_contacts <<< "$matching_contacts"
}

function search_contact_with_args {
    local query="$1"
    if [[ -z "$query" ]]; then
        echo "Search term cannot be empty."
        return 1
    fi

    local matching_contacts=$(grep -i "$query" "$DATA_FILE")
    if [[ -n "$matching_contacts" ]]; then
        display_contacts <<< "$matching_contacts"
    else
        echo "No matching contact found."
    fi
}
