#!/bin/bash

function categorize_contacts {
    local category
    echo "Categorize contacts"

    check_data_file || return 1

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
    local category_contacts=$(
        awk -F ':' -v category="$category" '{
            split($4, cat, ";")
            for (i in cat) if (cat[i] == category) print $0
        }' "$DATA_FILE"
    )
    display_contacts <<< "$category_contacts"
}

function categorize_contacts_with_args {
    local category="$1"
    if [[ -z "$category" ]]; then
        echo "Category is required for categorization."
        return 1
    fi

    local category_contacts=$(
        awk -F ':' -v category="$category" '{
            split($4, cat, ";")
            for (i in cat) if (cat[i] == category) print $0
        }' "$DATA_FILE"
    )
    if [[ -n "$category_contacts" ]]; then
        display_contacts <<< "$category_contacts"
    else
        echo "No contacts found in category '$category'."
    fi
}
