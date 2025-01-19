#!/bin/bash

function categorize_contacts {
    echo "Categorize contacts"

    if [[ ! -s "$DATA_FILE" ]]; then
        echo "No contacts found to categorize."
        return 1
    fi

    # Display all available categories
    echo "Existing categories in your contacts:"
    cut -d':' -f4 "$DATA_FILE" | tr ';' '\n' | sort | uniq | sed '/^$/d'

    # Input for the category to filter by
    read -p "Enter the category to filter by: " category
    if [[ -z "$category" ]]; then
        echo "Category cannot be empty. Please try again."
        return 1
    fi

    echo "Contacts under category '$category':"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    grep -E ":[^:]*:[^:]*:.*\b${category}\b.*" "$DATA_FILE" |\
        while IFS=":" read -r name phones emails categories; do
            echo "Name: $name"
            echo "Phones: $phones"
            echo "Emails: $emails"
            echo "Categories: $categories"
            echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
        done

}
