#!/bin/bash

# TODO: pagination, with `less` for large file

function view_contacts {
    echo "View All Contacts"

    check_data_file || return 1

    display_contacts < "$DATA_FILE"
}

