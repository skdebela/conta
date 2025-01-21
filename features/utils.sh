#!/bin/bash

function check_data_file() {
    # Check availablity of contacts in storage
    if [[ ! -s "$DATA_FILE" ]]; then
        echo "No contacts found."
        return 1
    fi
}

function display_contact() {
    # Display a single contact before confirmation
    local contact=$1
    local name phones emails categories
    IFS=":" read -r name phones emails categories <<<"$contact"

    printf "\n%-20s : %s\n" "Name" "$name"
    printf "%-20s : %s\n" "Phone Numbers" "$phones"
    printf "%-20s : %s\n" "Emails" "$emails"
    printf "%-20s : %s\n" "Categories" "$categories"
    echo
}

function display_contacts() {
    # Display multiple contacts
    local name phones emails categories
    {
        printf "%-20s %-30s %-30s %-30s\n" "Name" "Phone Numbers" "Emails" "Categories"
        echo "----------------------------------------------------------------------------------------------"
        while IFS=":" read -r name phones emails categories; do
            if [[ -n "$name" ]]; then
                printf "%-20s %-30s %-30s %-30s\n" "$name" "$phones" "$emails" "$categories"
            fi
        done < "$DATA_FILE"
    } | less
}


function display_contacts_with_id() {
    # Display multiple contacts with a prefix number for selection
    local matches=$1
    local name phones emails categories

    printf "%-5s %-20s %-30s %-30s %-30s\n" "ID" "Name" "Phone Numbers" "Emails" "Categories"
    echo "----------------------------------------------------------------------------------------------"

    local i=1
    while IFS= read -r line; do
        IFS=":" read -r name phones emails categories <<<"$line"
        printf "%-5s %-20s %-30s %-30s %-30s\n" "$i" "$name" "$phones" "$emails" "$categories"
        i=$((i+1))
    done <<< "$matches"
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
