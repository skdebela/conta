# Conta - simple UNIX shell contact manager

A modular contact manager application built using UNIX shell scripting.
The project allows users to manage contacts directly from the terminal by running individual scripts, with future plans for packanging and installation.

## Features

1. **Add Contacts**: Add new contact information (name, phone number, email, relation).
1. **Remove Contacts**: Delete existing contacts.
1. **Edit Contacts**: Modify contact details.
1. **Search Contacts**: Search for specific contacts.
1. **View All Contacts**: Display all contacts.
1. **Sorting Functionalities**: Sort contacts alphabetically or by other criteria.
1. **Contact Categorization**: Group contacts by type (e.g., family, work).
1. **Import/Export**: Import and export contacts in CSV format.

## project Structure

```plaintext
.
├── contribution.md        # Collaboration guidelines and documentation
├── data                    # Directory for contact data storage                    
│   └── contacts.txt
├── features                # Directory with modular feature scripts
│   ├── add_contact.sh
│   ├── categorize_contacts.sh
│   └── ...
├── install.sh              # Installation script
├── main.sh                 # Entry point script to run the contact manager
└── README.md
```

## How to Run

1. Clone the repository:

    ```bash
    git clone https://github.com/skdebela/conta
    cd conta
    ```

1. Make install script executable and run it:

    ```bash
    chmod +x ./install.sh
    ./install.sh
    ```

1. Run the application:

    ```bash
    conta -h
    ```

1. During development, you can also run individual feature scripts directly:

    ```bash
    ./features/add_contact.sh
    ```

## Future Work

Once the application is stable, we plan to package it as an installable application, enabling easier installation and usage.
