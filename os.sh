#!/bin/bash

while true; do
    clear
    echo "Patron Maintenance Menu"
    echo ""
    echo "A – Add New Patron Details"
    echo "S – Search a Patron (by Patron ID)"
    echo "U – Update a Patron Details"
    echo "D – Delete a Patron Details"
    echo "L – Sort Patrons by Last Name"
    echo "P – Sort Patrons by Patron ID"
    echo "J – Sort Patrons by Joined Date (Newest to Oldest Date)"
    echo ""
    echo "Q – Exit from Program"
    echo ""
    echo -n "Please select a choice: "
    read selection

    selection=$(echo "$selection" | tr 'a-z' 'A-Z')

    case $selection in
        "A")
            while true; do
                clear
                echo "Add New Patron Details Form"
                echo "==========================="
                echo -n "Patron ID: "
                read patronid
                echo -n "First Name: "
                read firstname
                echo -n "Last Name: "
                read lastname
                echo -n "Mobile Number: "
                read mobilenumber
                echo -n "Birth Date (MM-DD-YYYY): "
                read birthdate
                echo -n "Membership type (Student / Public): "
                read membershiptype
                echo -n "Joined Date (MM-DD-YYYY): "
                read joineddate
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                while true; do
                    echo -n "Add another new patron details? (y)es or (q)uit: "
                    read selection
                    selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                    if ["$selection" = "q"]; then
                        break 2 
                    elif ["$selection" = "y"]; then
                        break 
                    else
                        echo "Invalid choice. Please enter choice again."
                    fi
                done
            done
            ;;
        "S")
            while true; do
            	clear
                echo "Functionality not implemented yet."
                echo -n "Press Enter q to return to the menu..."
                read selection
                selection=$(echo "$selection") 
		if [ "$selection" = "q" ]; then
		    break
		fi
            done
            ;;
        "Q")
            exit
            ;;
    esac
done
