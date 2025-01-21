#!/bin/bash

function sort_contacts {
    local sort_option sort_key
    echo "Sort contacts"

    check_data_file || return 1

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
    sort -t ':' -k"$sort_key" "$DATA_FILE" | display_contacts
}

