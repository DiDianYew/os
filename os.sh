#!/bin/bash

function addNewDetails() {
    while true; do
        clear
        echo "Add New Patron Details Form"
        echo "==========================="

        while true; do
            echo -n "Patron ID: "
            read patronID

            if [ ! -s patron.txt ]; then
                echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" > patron.txt
            fi

            if [ -z "$patronID" ]; then
                echo "Patron ID cannot be empty."
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

            if [ -z "$firstName" ]; then
                echo "First name cannot be empty."
            elif [[ ! "$firstName" =~ ^[A-Za-z]+$ ]]; then
                echo "First name can only contain letters."
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
            elif [[ ! "$lastName" =~ ^[A-Za-z]+$ ]]; then
                echo "Last name can only contain letters."
            elif grep -q "^[^:]*:[^:]*:$lastName:" patron.txt; then
                echo "Last name already exists."
                continue
            else
                break
            fi
        done

        while true; do
            echo -n "Mobile Number: "
            read mobileNumber

            length=${#mobileNumber}

            if [ "$length" -eq 10 ] || [ "$length" -eq 11 ]; then
                if [ "${mobileNumber:3:1}" != "-" ]; then
                    mobileNumber="${mobileNumber:0:3}-${mobileNumber:3}"
                fi
                break
            else 
                echo "Invalid Phone Number! Must be 10 or 11 digits."
            fi 
        done

        while true; do
            echo -n "Birth Date (MM-DD-YYYY): "
            read birthDate
            
            if [ -z "$birthDate" ]; then
                echo "Birth date cannot be empty."
                continue
            fi
            
            if [[ ! "$birthDate" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                birthDate="${birthDate:0:2}-${birthDate:2:2}-${birthDate:4:4}"
            fi

            month="${birthDate:0:2}"
            day="${birthDate:3:2}"
            year="${birthDate:6:4}"

            if (( month < 1 || month > 12 )); then
                echo "Month must be between 1 - 12."
            elif (( day < 1 || day > 31 )); then
                echo "Day must be between 1 - 31."
            elif (( year < 1900 || year > $(date +"%Y") )); then
                echo "Year must be between 1900 - current."
            else
                break
            fi
        done
        
        while true; do
            echo -n "Membership type (Student / Public): "
            read membershipType
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
                break 2 
            elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                if [ ! -s patron.txt ]; then
                    echo "PatronID:FName:LName:MobileNum:BirthDate:Type:JoinedDate" > patron.txt
                fi
                echo "$patronID:$firstName:$lastName:$mobileNumber:$birthDate:$membershipType:$defaultDate" >> patron.txt
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
        echo -n "Enter Patron ID: "
        read patronID
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
    echo -n "Enter Patron ID: "
    read patronID
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

            if [ "$length" -eq 10 ] || [ "$length" -eq 11 ]; then
                if [ "${newmobileNumber:3:1}" != "-" ]; then
                    newmobileNumber="${newmobileNumber:0:3}-${newmobileNumber:3}"
                fi

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
                echo "Invalid Phone Number! Must be 10 or 11 digits."
            fi 
        done

        while true; do
            echo -n "Birth Date (MM-DD-YYYY): "
            read newbirthDate
            
            if [ -z "$newbirthDate" ]; then
                echo "Birth date cannot be empty."
                continue
            fi
            
            if [[ ! "$newbirthDate" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
                newbirthDate="${newbirthDate:0:2}-${newbirthDate:2:2}-${newbirthDate:4:4}"
            fi

            month="${newbirthDate:0:2}"
            day="${newbirthDate:3:2}"
            year="${newbirthDate:6:4}"

            if (( month < 1 || month > 12 )); then
                echo "Month must be between 1 - 12."
            elif (( day < 1 || day > 31 )); then
                echo "Day must be between 1 - 31."
            elif (( year < 1900 || year > $(date +"%Y") )); then
                echo "Year must be between 1900 - current."
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
        sed -i "s/^$patronID:.*/$patronID:$firstName:$lastName:$newmobileNumber:$newbirthDate:$membershipType:$defaultDate/" patron.txt
        continue 
    else
        echo "Invalid choice. Please enter choice again."
    fi
}

function deleteDetails() {
    clear
    echo "Delete a Patron Details"
    echo ""
    echo -n "Enter Patron ID: "
    read patronID
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
    tail -n +2 patron.txt | sort -t ':' -k3,3 | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do #do we need birthdate?
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
            sort -t ':' -k3,3 patron.txt > "$fileName"
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
            sort -t ':' -k1,1 patron.txt > "$fileName"
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
    printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "Joined Date" "Patron ID" "Last Name" "First Name" "Mobile Number"
    
    # Same as above, but sorting by the seventh field, which is the joined date.
    tail -n +2 patron.txt | sort -t ':' -k7,7 | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do
        printf "%-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s %-${col_width}s\n" "$defaultDate" "$patronID" "$lastName" "$firstName" "$mobileNumber"
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
            sort -t ':' -k7,7 patron.txt > "$fileName"
            echo "Report exported to $fileName."
        else
            echo "Invalid file name. Please press enter again."
        fi
    else
        echo "Invalid choice. Please enter choice again."
    fi
}

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
