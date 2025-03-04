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
                patronid=$(echo "$patronid")

                echo -n "First Name: "
                read firstname
                firstname=$(echo "$firstname")

                echo -n "Last Name: "
                read lastname
                lastname=$(echo "$lastname")

                echo -n "Mobile Number: "
                read mobilenumber
                if [ "${mobilenumber:3:1}" != "-" ]; then
                    mobilenumber="${mobilenumber:0:3}-${mobilenumber:3}"
                fi
                
                echo -n "Birth Date (MM-DD-YYYY): "
                read birthdate
                if [[ ! "$birthdate" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                    birthdate="${birthdate:0:2}-${birthdate:2:2}-${birthdate:4:4}"
                fi
                
                while true; do
                    echo -n "Membership type (Student / Public): "
                    read membershiptype
                    membershiptype=$(echo "$membershiptype" | tr '[:upper:]' '[:lower:]')
                    if [ "$membershiptype" = "student" ]; then
                        membershiptype="Student"
                        break
                    elif [ "$membershiptype" = "public" ]; then
                        membershiptype="Public"
                        break
                    else
                        echo "Invalid membership type"
                    fi
                done

                defaultdate=$(date +"%m-%d-%Y")
                echo "Joined Date (MM-DD-YYYY): $defaultdate"

                #Debug
                #echo ""
                #echo "$patronid"
                #echo "$firstname"
                #echo "$lastname"
                #echo "$mobilenumber"
                #echo "$birthdate"
                #echo "$membershiptype"
                #echo "$defaultdate"

                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                while true; do
                    echo -n "Add another new patron details? (y)es or (q)uit: "
                    read selection
                    selection=$(echo "$selection" | tr 'A-Z' 'a-z') 
                    if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                        break 2 
                    elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                        if [ ! -s patron.txt ]; then
                            echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" > patron.txt
                        fi
                        echo "$patronid:$firstname:$lastname:$mobilenumber:$birthdate:$membershiptype:$defaultdate" >> patron.txt
                        break 2              
                    else
                        echo "Invalid choice"
                    fi
                done
            done
            ;;
        "S")
            while true; do
                clear
                echo "Search a Patron Details"
                echo ""
                echo -n "Enter Patron ID: "
                read patronid
                if grep -q "^$patronid:" patron.txt; then
                    patron_data=$(grep "^$patronid:" patron.txt)
                    IFS=':' read -r patronid firstname lastname mobilenumber birthdate membershiptype defaultdate <<< "$patron_data"
                    echo "First Name: $firstname"
                    echo "Last Name: $lastname"
                    echo "Mobile Number: $mobilenumber"
                    echo "Birth Date (MM-DD-YYYY): $birthdate"
                    echo "Membership type: $membershiptype"
                    echo "Joined Date (MM-DD-YYYY): $defaultdate"
                else
                    echo "Patron ID not found"
                fi
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                while true; do
                    echo -n "Search another patron? (y)es or (q)uit: "
                    read selection
                    selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                    if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                        break 2 
                    elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                        break 
                    else
                        echo "Invalid choice. Please enter choice again."
                    fi
                done
            done
            ;;
        "U")
            clear
                echo "Update a Patron Details"
                echo ""
                echo -n "Enter Patron ID: "
                read patronid
                echo "First Name: "
                echo "Last Name: "
                echo -n "Mobile Number: "
                read mobilenumber
                echo -n "Birth Date (MM-DD-YYYY): "
                read birthdate
                echo "Membership type: "
                echo "Joined Date (MM-DD-YYYY): "
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Are you sure you want to \e[1mUPDATE\e[0m the above Patron Details? (y)es or (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ]; then
                    continue 
                elif [ "$selection" = "y" ]; then
                     echo "Save info to file (Need change)"  # save info 
                else
                    echo "Invalid choice. Please enter choice again."
                fi
            ;;
        "D")
            clear
                echo "Delete a Patron Details"
                echo ""
                echo -n "Enter Patron ID: "
                read patronid
                echo "First Name: "
                echo "Last Name: "
                echo "Mobile Number: "
                echo "Birth Date (MM-DD-YYYY): "
                echo "Membership type: "
                echo "Joined Date (MM-DD-YYYY): "
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Are you sure you want to \e[1mDELETE\e[0m the above Patron Details? (y)es or (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ]; then
                    continue 
                elif [ "$selection" = "y" ]; then
                     echo "Delete info to file (Need change)"  # save info 
                else
                    echo "Invalid choice. Please enter choice again."
                fi
            ;;
        "L")
            clear
                col_width=20
                echo "Patron Details Sorted by Last Name"
                echo ""
                printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "Last Name" "First Name" "Mobile Number" "Joined Date" "Membership Type"
                printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "test" "test" "test" "test" "test"
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ]; then
                    continue 
                elif [ "$selection" = "y" ]; then
                     echo -n "Expor into (file_name). Please enter to continue..."
                     read selection 
                     if [ "$selection" = "" ]; then
                        continue 
                     else
                        echo "Invalid choice. Please press enter again."
                     fi 
                else
                    echo "Invalid choice. Please enter choice again."
                fi
            ;;
        "P")
            clear
                col_width=20
                echo "Patron Details Sorted by Patron ID"
                echo ""
                printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Birth Date"
                printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "test" "test" "test" "test" "test"
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ]; then
                    continue 
                elif [ "$selection" = "y" ]; then
                     echo -n "Expor into (file_name). Please enter to continue..."
                     read selection 
                     if [ "$selection" = "" ]; then
                        continue  
                     else
                        echo "Invalid choice. Please press enter again."
                     fi 
                else
                    echo "Invalid choice. Please enter choice again."
                fi
            ;;
        "J")
            clear
                col_width=20
                echo "Patron Details Sorted by Joined Date"
                echo ""
                printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "Joined Date" "Patron ID" "Last Name" "First Name" "Mobile Number"
                printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "test" "test" "test" "test" "test"
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ]; then
                    continue 
                elif [ "$selection" = "y" ]; then
                     echo -n "Expor into (file_name). Please enter to continue..."
                     read selection 
                     if [ "$selection" = "" ]; then
                        continue 
                     else
                        echo "Invalid choice. Please press enter again."
                     fi 
                else
                    echo "Invalid choice. Please enter choice again."
                fi
            ;;
        "Q")
            exit
            ;;
    esac
done
