#!/bin/bash

# TODO: pagination, with `less` for large file

function view_contacts {
    echo "View All Contacts"

    # Check if the data file exists and is not empty
    if [ ! -s "$DATA_FILE" ]; then
        echo "No contacts found."
        return 1
    fi

    # Header
    printf "%-20s %-30s %-30s %-30s\n" "Name" "Phone Numbers" "Emails" "Categories"
    echo "----------------------------------------------------------------------------------------------"

    # Read and format each line
    while IFS=: read -r name phones emails categories; do
        # Truncate long values and add ellipses if necessary
        phones=$(echo "$phones" | cut -c 1-28)
        emails=$(echo "$emails" | cut -c 1-28)
        categories=$(echo "$categories" | cut -c 1-28)

        # Print each contact with proper spacing
        printf "%-20s %-30s %-30s %-30s\n" "$name" "$phones" "$emails" "$categories"
    done < "$DATA_FILE"
}

