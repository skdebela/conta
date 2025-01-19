#!/bin/bash

function check_data_file() {
    # Check availablity of contacts in storage
    if [[ ! -s "$DATA_FILE" ]]; then
        echo "No contacts found."
        return 1
    fi
}

function display_contacts() {
    # Display multiple contacts
    printf "%-20s %-30s %-30s %-30s\n" "Name" "Phone Numbers" "Emails" "Categories"
    echo "----------------------------------------------------------------------------------------------"
    while IFS=":" read -r name phones emails categories; do
        printf "%-20s %-30s %-30s %-30s\n" "$name" "$phones" "$emails" "$categories"
    done | less
}

function display_contacts_with_id() {
    # Display multiple contacts with prefix number for choice
    IFS=$'\n' read -rd '' -a contacts_array <<<"$matches"

    printf "%-5s %-20s %-30s %-30s %-30s\n" "ID" "Name" "Phone Numbers" "Emails" "Categories"
    echo "----------------------------------------------------------------------------------------------"
    i=1
    while IFS=":" read -r name phones emails categories; do
        printf "%-5s %-20s %-30s %-30s %-30s\n" "$i" "$name" "$phones" "$emails" "$categories"
        i=$(($i+1))
    done
}

function validate_phone() {
    # Validate phone number
    # allowing local numbers with formats 0912345678, 912345678, +251912345678
    local phone=$1
    if [[ "$phone" =~ ^(\+251|0)?[7|9][0-9]{8}$ ]]; then
        return 0
    else
        return 1
    fi
}


function validate_email() {
    # Validate email address
    local email=$1
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}
