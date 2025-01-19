#!/bin/bash

function sort_contacts {
    echo "Sort contacts"

    # Check if the data file exists and is not empty
    if [ ! -s "$DATA_FILE" ]; then
        echo "No contacts found"
        return 1
    fi

    echo "Sort by:"
    echo "1. Name"
    echo "2. Phone Numbers"
    echo "3. Emails"
    echo "4. Categories"
    read -p "Choose an option (1-3): " sort_option

    case $sort_option in
        1) sort_key=1 ;;
        2) sort_key=2 ;;
        3) sort_key=3 ;;
        4) sort_key=4 ;;
        *) echo "invalid option"; return 1 ;;
    esac

    # Print sorted contacts
    printf "%-20s %-30s %-30s %-30s\n" "Name" "Phone Numbers" "Emails" "Categories"
    echo "----------------------------------------------------------------------------------------------"

    sort -t ':' -k"$sort_key" "$DATA_FILE" | while IFS=: read -r name phones emails categories; do
        printf "%-20s %-30s %-30s %-30s\n" "$name" "$phones" "$emails" "$categories"
    done
}

