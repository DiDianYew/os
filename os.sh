#!/bin/bash

function addNewDetails() {
    while true; do
        clear
        echo "Add New Patron Details Form"
        echo "==========================="

        while true; do
            echo -n "Patron ID: "
            read patronID

            # if the file is exist and !empty
            if [ ! -s patron.txt ]; then
                echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" > patron.txt
            fi

            # if the input is empty
            if [ -z "$patronID" ]; then
                echo "Patron ID cannot be empty."
                continue
            fi

            # toUpper
            patronID=$(echo "$patronID" | tr 'a-z' 'A-Z')
            # id format start with 'P' + 4 digit. eg P0000
            if [[ ! "$patronID" =~ ^P[0-9]{4}$ ]]; then
                echo "Invalid ID format, must start with \"P\" with 4 digits number. eg. P0001"
                continue
            fi

            if grep -q "^$patronID:" patron.txt; then
                echo "Patron ID already exists."
                continue
            else
                break
            fi
        done

        while true; do
            echo -n "First Name: "
            read firstName

            # if the input is empty
            if [ -z "$firstName" ]; then
                echo "First name cannot be empty."
            # not only letter
            elif [[ ! "$firstName" =~ ^[A-Za-z]+$ ]]; then
                echo "First name can only contain letters."
            # skip the first col, check second col
            elif grep -q "^[^:]*:$firstName:" patron.txt; then
                echo "First name already exists."
                continue
            else
                break
            fi
        done

        while true; do
            echo -n "Last Name: "
            read lastName

            if [ -z "$lastName" ]; then
                echo "Last name cannot be empty."
                continue
            elif [[ ! "$lastName" =~ ^[A-Za-z]+$ ]]; then
                echo "Last name can only contain letters."
                continue
            elif grep -q "^[^:]*:[^:]*:$lastName:" patron.txt; then
                echo "Last name already exists."
                continue
            else
                # echo "successful"
                break
            fi
        done

        while true; do
            echo -n "Mobile Number: "
            read mobileNumber
        
            if [ -z "$mobileNumber" ]; then
                echo "Mobile Number cannot be empty."
                continue
            fi

            length=${#mobileNumber}

            # if user didnt enter "-", then accept 10 or 11 digits
            if [ "${mobileNumber:3:1}" != "-" ]; then
                if [ "$length" -eq 10 ] || [ "$length" -eq 11 ]; then
                    # auto add in the "-"
                    mobileNumber="${mobileNumber:0:3}-${mobileNumber:3}"
                    break
                else
                    echo "Invalid format! Must be 10 or 11 digits without \" - \" ."
                    continue
                fi
            # if user enter "-", then accept 11 or 12 digits
            elif [ "${mobileNumber:3:1}" == "-" ]; then
                if [ "$length" -eq 11 ] || [ "$length" -eq 12 ]; then
                echo "$mobileNumber"
                    break
                else
                    echo "Invalid format! Must be 11 or 12 digits with \" - \" ."
                    continue
                fi
            else 
                echo "Invalid Phone Number! Must be 10 or 11 digits."
                continue
            fi 
        done

        while true; do
            echo -n "Birth Date (MM-DD-YYYY): "
            read birthDate
            
            if [ -z "$birthDate" ]; then
                echo "Birth date cannot be empty."
                continue
            fi
            
            # clear input to only digit
            cleanDate=$(echo "$birthDate" | tr -d -c '0-9')

            #check if has 8 digit
            if [[ "${#cleanDate}" -eq 8 ]]; then
                # add in the "-" for data entry and "/" for checking
                birthDate="${cleanDate:0:2}-${cleanDate:2:2}-${cleanDate:4:4}"
                birthDateCheck="${cleanDate:0:2}/${cleanDate:2:2}/${cleanDate:4:4}"
            else
                echo "Invalid date. Have to include 0."
                continue
            fi

            # echo "Parsed date: $birthDate"
            # echo "Parsed date: $birthDateCheck"

            # check with date -d if its real calender
            if ! date -d "$birthDateCheck" "+%m-%d-%Y" > /dev/null 2>&1; then 
                # get month, day, year 
                month="${birthDate:0:2}"
                day="${birthDate:3:2}"
                year="${birthDate:6:4}"

                # provide error details
                if (( month < 1 || month > 12 )); then
                    echo "Month must be between 1 - 12."
                elif (( day < 1 || day > 31 )); then
                    echo "Day must be between 1 - 30 / 31. [28 / 29 if is February]"
                elif (( year < 1900 || year > $(date +"%Y") )); then
                    echo "Year must be between 1900 - current."
                else
                    echo "Invalid date!"
                fi
                continue 
            else
                break
            fi
        done
        
        while true; do
            echo -n "Membership type (Student / Public): "
            read membershipType
            # to lower , then set first to upper
            membershipType=$(echo "$membershipType" | tr '[:upper:]' '[:lower:]')
            if [ "$membershipType" = "student" ]; then
                membershipType="Student"
                break
            elif [ "$membershipType" = "public" ]; then
                membershipType="Public"
                break
            else
                echo "Invalid membership type"
            fi
        done

        defaultDate=$(date +"%m-%d-%Y")
        echo "Joined Date (MM-DD-YYYY): $defaultDate"

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
                echo "$patronID:$firstName:$lastName:$mobileNumber:$birthDate:$membershipType:$defaultDate" >> patron.txt
                # break 2 loop to quit
                break 2 
            elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                if [ ! -s patron.txt ]; then
                    echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" > patron.txt
                fi
                echo "$patronID:$firstName:$lastName:$mobileNumber:$birthDate:$membershipType:$defaultDate" >> patron.txt
                # break 1 loop to continue add patron
                break               
            else
                echo "Invalid choice"
            fi
        done
    done
}

function searchDetails() {
    while true; do
        clear
        echo "Search a Patron Details"
        echo ""
  
        while true; do
            echo -n "Enter Patron ID: "
            read patronID
            patronID=$(echo "$patronID" | tr 'a-z' 'A-Z')
            if [[ ! "$patronID" =~ ^P[0-9]{4}$ ]]; then
                    echo "Invalid ID format, Please insert P + 4 digits. eg. P0001"
                    echo ""
                    continue
            else
                break 
            fi
        done 

        if grep -q "^$patronID:" patron.txt; then
            patron_data=$(grep "^$patronID:" patron.txt)
            IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate <<< "$patron_data"
            echo "First Name: $firstName"
            echo "Last Name: $lastName"
            echo "Mobile Number: $mobileNumber"
            echo "Birth Date (MM-DD-YYYY): $birthDate"
            echo "Membership type: $membershipType"
            echo "Joined Date (MM-DD-YYYY): $defaultDate"
        else
            echo "Patron ID not found"
        fi
        echo " ________________________________________________"
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
}

function updateDetails() {
    clear
    echo "Update a Patron Details"
    echo ""
    while true; do
        echo -n "Enter Patron ID: "
        read patronID
        patronID=$(echo "$patronID" | tr 'a-z' 'A-Z')
        if [[ ! "$patronID" =~ ^P[0-9]{4}$ ]]; then
                echo "Invalid ID format, Please insert P + 4 digits. eg. P0001"
                echo ""
                continue
        else
            break 
        fi
    done 
    echo "________________________________________________"
    echo ""
    if grep -q "^$patronID:" patron.txt; then
        patron_data=$(grep "^$patronID:" patron.txt)
        IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate <<< "$patron_data"
        echo "First Name: $firstName"
        echo "Last Name: $lastName"

        while true; do
            echo -n "Mobile Number: "
            read newmobileNumber

            if [ -z "$newmobileNumber" ]; then
                echo "Mobile number cannot be empty."
                continue
            fi

            length=${#newmobileNumber}

             # if user didnt enter "-", then accept 10 or 11 digits
            if [ "${newmobileNumber:3:1}" != "-" ]; then
                if [ "$length" -eq 10 ] || [ "$length" -eq 11 ]; then
                    # auto add in the "-"
                    newmobileNumber="${newmobileNumber:0:3}-${newmobileNumber:3}"

                    if [ "$newmobileNumber" = "$mobileNumber" ]; then # same number
                        break
                    fi

                    mobileNumberExists=$(grep ":$newmobileNumber:" patron.txt) # check exists in db
                    if [ -n "$mobileNumberExists" ]; then
                        echo "Mobile number already exists."
                        continue
                    fi
                    break
                else
                    echo "Invalid format! Must be 10 or 11 digits without \" - \" ."
                fi
            # if user enter "-", then accept 11 or 12 digits
            elif [ "${newmobileNumber:3:1}" == "-" ]; then
                if [ "$length" -eq 11 ] || [ "$length" -eq 12 ]; then

                    if [ "$newmobileNumber" = "$mobileNumber" ]; then # same number
                    break
                    fi

                    mobileNumberExists=$(grep ":$newmobileNumber:" patron.txt) # check exists in db
                    if [ -n "$mobileNumberExists" ]; then
                        echo "Mobile number already exists."
                    continue
                    fi
                    break
                else
                    echo "Invalid format! Must be 11 or 12 digits with \" - \" ."
                fi
            else 
                echo "Invalid Phone Number! Must be 10 or 11 digits."
            fi
        done

        while true; do
            echo -n "Birth Date (MM-DD-YYYY): "
            read NewBirthDate
            
            if [ -z "$NewBirthDate" ]; then
                echo "Birth date cannot be empty."
                continue
            fi
            
            # clear input to only digit
            cleanNewBirthDate=$(echo "$NewBirthDate" | tr -d -c '0-9')

            #check if has 8 digit
            if [[ "${#cleanNewBirthDate}" -eq 8 ]]; then
                # add in the "-" for data entry and "/" for checking
                NewBirthDate="${cleanNewBirthDate:0:2}-${cleanNewBirthDate:2:2}-${cleanNewBirthDate:4:4}"
                NewBirthDateCheck="${cleanNewBirthDate:0:2}/${cleanNewBirthDate:2:2}/${cleanNewBirthDate:4:4}"
            else
                echo "Invalid date. Have to include 0."
                continue
            fi

            # check with date -d if its real calender
            if ! date -d "$NewBirthDateCheck" "+%m-%d-%Y" > /dev/null 2>&1; then 
                # get month, day, year 
                month="${NewBirthDate:0:2}"
                day="${NewBirthDate:3:2}"
                year="${NewBirthDate:6:4}"

                if (( month < 1 || month > 12 )); then
                    echo "Month must be between 1 - 12."
                elif (( day < 1 || day > 31 )); then
                    echo "Day must be between 1 - 31."
                elif (( year < 1900 || year > $(date +"%Y") )); then
                    echo "Year must be between 1900 - current."
                fi
                continue
            else
                break
            fi
        done
        
        echo "Membership type: $membershipType"
        echo "Joined Date (MM-DD-YYYY): $defaultDate"
    else
        echo "Patron ID not found"
    fi
    echo "________________________________________________"
    echo ""
    echo "Press (q) to return to Patron Maintenance Menu."
    echo ""
    echo -n "Are you sure you want to $(tput bold)UPDATE$(tput sgr0) the above Patron Details? (y)es or (q)uit: "
    read selection
    selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

    if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
        continue 
    elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
        sed -i "s/^$patronID:.*/$patronID:$firstName:$lastName:$newmobileNumber:$NewBirthDate:$membershipType:$defaultDate/" patron.txt
        continue 
    else
        echo "Invalid choice. Please enter choice again."
    fi
}

function deleteDetails() {
    clear
    echo "Delete a Patron Details"
    echo ""
    
    while true; do
        echo -n "Enter Patron ID: "
        read patronID
        patronID=$(echo "$patronID" | tr 'a-z' 'A-Z')
        if [[ ! "$patronID" =~ ^P[0-9]{4}$ ]]; then
                echo "Invalid ID format, Please insert P + 4 digits. eg. P0001"
                echo ""
                continue
        else
            break 
        fi
    done 

    echo " ________________________________________________"
    if grep -q "^$patronID:" patron.txt; then
        patron_data=$(grep "^$patronID:" patron.txt)
        IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate <<< "$patron_data"
        echo "First Name: $firstName"
        echo "Last Name: $lastName"
        echo "Mobile Number: $mobileNumber"
        echo "Birth Date (MM-DD-YYYY): $birthDate"
        echo "Membership type: $membershipType"
        echo "Joined Date (MM-DD-YYYY): $defaultDate"
    else
        echo "Patron ID not found"
    fi
    echo " ________________________________________________"
    echo ""
    echo "Press (q) to return to Patron Maintenance Menu."
    echo ""
    echo -n "Are you sure you want to $(tput bold)DELETE$(tput sgr0) the above Patron Details? (y)es or (q)uit: "
    read selection
    selection=$(echo "$selection" | tr 'A-Z' 'a-z') 

    if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
        continue 
    elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
        sed -i "/^$patronID:/d" patron.txt
        continue
    else
        echo "Invalid choice. Please enter choice again."
    fi
}

function sortLastName() {
    clear
    col_width=20
    echo "Patron Details Sorted by Last Name"
    echo ""
    echo " _________________________________________________________________________________________"
    printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "Last Name" "First Name" "Mobile Number" "Joined Date" "Membership Type"

    # tail -n +2 patron.txt is used to skip the first line of the file, which is the header.
    # -t ':' is used to specify the delimiter as colon and -k3, 3 is used to sort by the third field, which is the last name.
    # while IFS=':' is used to sets the field separator to colon for the read command
    tail -n +2 patron.txt | sort -t ':' -k3,3 | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do 
        printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "$lastName" "$firstName" "$mobileNumber" "$defaultDate" "$membershipType"
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
        echo -n "Export file. Enter file name: "
        read fileName
        if [ -n "$fileName" ]; then
            # sort -t ':' -k3,3 patron.txt > "$fileName"
            head -n 1 patron.txt > "$fileName"  # Write header
            tail -n +2 patron.txt | sort -t ':' -k3,3 >> "$fileName"
            echo "Report exported to $fileName."
        else
            echo "Invalid file name. Please press enter again."
        fi                
    else
        echo "Invalid choice. Please enter choice again."
    fi
}

function sortPatronID() {
    clear
    col_width=20
    echo "Patron Details Sorted by Patron ID"
    echo ""
    echo " =========================================================================="
    printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Birth Date"
    
    # Same as above, but sorting by the first field, which is the patron ID.
    tail -n +2 patron.txt | sort -t ':' -k1,1 | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do
        printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "$patronID" "$lastName" "$firstName" "$mobileNumber" "$birthDate"
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
        echo -n "Export file. Enter file name: "
        read fileName
        if [ -n "$fileName" ]; then
            head -n 1 patron.txt > "$fileName"  # Write header
            tail -n +2 patron.txt | sort -t ':' -k1,1 >> "$fileName"
            # sort -t ':' -k1,1 patron.txt > "$fileName"
            echo "Report exported to $fileName."
        else
            echo "Invalid file name. Please press enter again."
        fi                
    else
        echo "Invalid choice. Please enter choice again."
    fi
}

function sortJoinedDate() {
    clear
    col_width=20
    echo "Patron Details Sorted by Joined Date"
    echo ""
    echo " =========================================================================="
    printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Joined Date"
    
    # Same as above, but sorting by the seventh field, which is the joined date.
    tail -n +2 patron.txt | sort -t ':' -k7,7 | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do
        printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "$patronID" "$lastName" "$firstName" "$mobileNumber" "$defaultDate"
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
        echo -n "Export file. Enter file name: "
        read fileName
        if [ -n "$fileName" ]; then
            head -n 1 patron.txt > "$fileName"  # Write header
            tail -n +2 patron.txt | sort -t ':' -k7,7 >> "$fileName"
            # sort -t ':' -k7,7 patron.txt > "$fileName"
            echo "Report exported to $fileName."
        else
            echo "Invalid file name. Please press enter again."
        fi
    else
        echo "Invalid choice. Please enter choice again."
    fi
}

function main_menu() {
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
                addNewDetails
                ;;
            "S")
                searchDetails
                ;;
            "U")
                updateDetails
                ;;
            "D")
                deleteDetails
                ;;
            "L")
                sortLastName
                ;;
            "P")
                sortPatronID
                ;;
            "J")
                sortJoinedDate
                ;;
            "Q")
                exit
                ;;
        esac
    done
}

main_menu
