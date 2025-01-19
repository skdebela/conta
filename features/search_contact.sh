#!/bin/bash

# TODO: highlight matching portions in output for better visibility

function search_contact {
    echo "Search contacts"

    # Check if the data file exists and is not empty
    if [[ ! -s "$DATA_FILE" ]]; then
        echo "No contacts found"
        return 1
    fi

    read -p "Enter search term (name, email, phone, or email): " search_term
    if [[ -z $search_term ]]; then
        echo "Search term cannot be empty. Please try agin."
        return 1
    fi

    echo "Matching contacts for '$search_term':"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    grep -i "$search_term" "$DATA_FILE" | while IFS=":" read -r name phones emails categories; do
        echo "Name: $name"
        echo "Phones: $phones"
        echo "Emails: $emails"
        echo "Categories: $categories"
        echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    done

    if ! grep -iq "$search_term" "$DATA_FILE"; then
        echo "No matching contacts found."
    fi
}

