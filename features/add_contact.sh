#!/bin/bash

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

        read -p "Enter phone number for label '$label': " number
        if validate_phone "$number"; then
            phones+="${label}=${number};"
        else
            echo "Invalid phone number. Please try again."
        fi
    done
    phones="${phones%;}"

    # Input for emails
    emails=""
    while true; do
        read -p "Enter email label (e.g., Personal, Work) or press enter to finish: " label
        if [[ -z "$label" ]]; then
            break
        fi

        read -p "Enter email for '$label': " email
        if validate_email "$email"; then
            emails+="${label}=${email};"
        else
            echo "Invalid email. Please try again."
        fi
    done
    emails="${emails%;}"  # Remove trailing semicolon


    # Input for categories
    read -p "Enter categories (comma-separated): " categories

    formatted_categories=$(echo "$categories" | tr ',' ';')

    #Store the contact in the data file
    echo "${name}:${phones}:${emails}:${formatted_categories}" >> "$DATA_FILE"
    echo "Contact added successfully!"
}

function add_contact_with_args {
    name="$1"
    phones=$(echo "$2" | tr ',' ';')
    emails=$(echo "$3" | tr ',' ';')
    categories=$(echo "$4" | tr ',' ';')

    if [[ -z "$name" ]]; then
        echo "Name is required for adding a contact."
        return 1
    fi

    echo "${name}:${phones}:${emails}:${categories}" >> "$DATA_FILE"
    echo "Contact added successfully!"
}