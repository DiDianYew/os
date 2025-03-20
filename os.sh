#!/bin/bash

while true; do
    clear
    echo "Patron Maintenance Menu"
    echo ""
    echo "A – Add New Patron Details"
    echo "S – Search a Patron"
    echo "U – Update a Patron Details"
    echo "D – Delete a Patron Details"
    echo "L – Sort Patrons by Last Name"
    echo "P – Sort Patrons by Patron ID"
    echo "J – Sort Patrons by Joined Date"
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
                if [ "${mobilenumber:3:1}" != "-" ]; then
                    mobilenumber="${mobilenumber:0:3}-${mobilenumber:3}"
                fi
                
                while true; do
                    echo -n "Birth Date (MM-DD-YYYY): "
                    read birthdate
                    
                    if [ -z "$birthdate" ]; then
                        echo "Birth date cannot be empty."
                        continue
                    fi
                    
                    if [[ ! "$birthdate" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                        birthdate="${birthdate:0:2}-${birthdate:2:2}-${birthdate:4:4}"
                    fi

                    month="${birthdate:0:2}"
                    day="${birthdate:3:2}"
                    year="${birthdate:6:4}"

                    if (( month < 1 || month > 12 )); then
                        echo "Invalid month."
                    elif (( day < 1 || day > 31 )); then
                        echo "Invalid day."
                    elif (( year < 1900 || year > $(date +"%Y") )); then
                        echo "Invalid year."
                    else
                        break
                    fi
                done
                
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
                        if [ ! -s patron.txt ]; then
                            echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" > patron.txt
                        fi
                        echo "$patronid:$firstname:$lastname:$mobilenumber:$birthdate:$membershiptype:$defaultdate" >> patron.txt
                        break 2 
                    elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                        if [ ! -s patron.txt ]; then
                            echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" > patron.txt
                        fi
                        echo "$patronid:$firstname:$lastname:$mobilenumber:$birthdate:$membershiptype:$defaultdate" >> patron.txt
                        break               
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
                if grep -q "^$patronid:" patron.txt; then
                    patron_data=$(grep "^$patronid:" patron.txt)
                    IFS=':' read -r patronid firstname lastname mobilenumber birthdate membershiptype defaultdate <<< "$patron_data"
                    echo "First Name: $firstname"
                    echo "Last Name: $lastname"
                    echo -n "Mobile Number: "
                    read newmobilenumber
                    if [ -z "$newmobilenumber" ]; then
                        newmobilenumber=$mobilenumber
                    elif [ "${newmobilenumber:3:1}" != "-" ]; then
                        newmobilenumber="${newmobilenumber:0:3}-${newmobilenumber:3}"      
                    fi
                    echo -n "Birth Date (MM-DD-YYYY): "
                    read newbirthdate
                    if [ -z "$newbirthdate" ]; then
                        newbirthdate=$birthdate  
                    elif [[ ! "$newbirthdate" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                        newbirthdate="${newbirthdate:0:2}-${newbirthdate:2:2}-${newbirthdate:4:4}"      
                    fi
                    echo "Membership type: $membershiptype"
                    echo "Joined Date (MM-DD-YYYY): $defaultdate"
                else
                    echo "Patron ID not found"
                fi
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Are you sure you want to $(tput bold)UPDATE$(tput sgr0) the above Patron Details? (y)es or (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                    continue 
                elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                    sed -i "s/^$patronid:.*/$patronid:$firstname:$lastname:$newmobilenumber:$newbirthdate:$membershiptype:$defaultdate/" patron.txt
                    continue 
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
                echo -n "Are you sure you want to $(tput bold)DELETE$(tput sgr0) the above Patron Details? (y)es or (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                    continue 
                elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                    sed -i "/^$patronid:/d" patron.txt
                    continue
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

                tail -n +2 patron.txt | sort -t ':' -k3,3 | while IFS=':' read -r patronid firstname lastname mobilenumber birthdate membershiptype defaultdate; do
                    printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "$lastname" "$firstname" "$mobilenumber" "$defaultdate" "$membershiptype"
                done

                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                    continue 
                elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                    echo -n "Export into (file_name). Enter file name."
                    read filename
                    if [ -n "$filename" ]; then
                        sort -t ':' -k3,3 patron.txt > "$filename"
                        echo "Report exported to $filename."
                    else
                        echo "Invalid file name. Please press enter again."
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
                
                tail -n +2 patron.txt | sort -t ':' -k3,3 | while IFS=':' read -r patronid firstname lastname mobilenumber birthdate membershiptype defaultdate; do
                    printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "$patronid" "$lastname" "$firstname" "$mobilenumber" "$defaultdate"
                done             

                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                    continue 
                elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                     echo -n "Expor into (file_name). Enter file name" #change
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
                
                tail -n +2 patron.txt | sort -t ':' -k3,3 | while IFS=':' read -r patronid firstname lastname mobilenumber birthdate membershiptype defaultdate; do
                    printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "$defaultdate" "$patronid" "$lastname" "$firstname" "$mobilenumber"
                done                   
                
                echo ""
                echo "Press (q) to return to Patron Maintenance Menu."
                echo ""
                echo -n "Would you like to export the report as ASCII text file? (y)es (q)uit: "
                read selection
                selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

                if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                    continue 
                elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                     echo -n "Expor into (file_name). Please enter to continue..." #change
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
