#!/bin/bash

# TODO: validation

function add_contact {
    local name phones emails categories
    echo "Add New Contact"

    # Input for name
    read -p "Enter contact name: " name

    if [[ -z "$name" ]]; then
        echo "Name cannot be empty. Please try again."
        return 1
    fi

    # Input for phone numbers
    phones=""
    while true; do
        read -p "Enter phone number label (e.g., Mobile, Work, Home) or press enter to finish: " label

        if [[ -z "$label" ]]; then
            break
        fi

        read -p "Enter phone number for label $label: " number
        phones+="${label}=${number};"
    done
    phones="${phones%;}"

    # Input for emails
    emails=""
    while true; do
        read -p "Enter email label (e.g., Personal, Work) or press enter to finish: " label
        if [[ -z "$label" ]]; then
            break
        fi
        read -p "Enter email for $label: " email
        emails+="${label}=${email};"
    done
    emails="${emails%;}"

    # Input for categories
    read -p "Enter categories (comma-separated): " categories

    formatted_categories=$(echo "$categories" | tr ',' ';')

    #Store the contact in the data file
    echo "${name}:${phones}:${emails}:${formatted_categories}" >> "$DATA_FILE"
    echo "Contact added successfully!"
}
