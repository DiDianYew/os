#!/bin/bash

function showNewMenu() {
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                         Add New Patron Details Form                          ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "║  Patron ID: $patronID                                                            ║"      
    echo "║  First Name:                                                                 ║"      
    echo "║  Last Name:                                                                  ║"      
    echo "║  Mobile Number:                                                              ║"      
    echo "║  Birth Date (MM-DD-YYYY):                                                    ║"      
    echo "║  Membership Type (Student / Public):                                         ║"      
    echo "║  Joined Date (MM-DD-YYYY): $defaultDate                                                  ║"      
    echo "║                                                                              ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
}

function showSearchMenu() {
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                            Search a Patron Details                           ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "║  Patron ID:                                                                  ║"      
    echo "║  First Name:                                                                 ║"      
    echo "║  Last Name:                                                                  ║"      
    echo "║  Mobile Number:                                                              ║"      
    echo "║  Birth Date (MM-DD-YYYY):                                                    ║"      
    echo "║  Membership Type (Student / Public):                                         ║"      
    echo "║  Joined Date (MM-DD-YYYY):                                                   ║"      
    echo "║                                                                              ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝" 
}

function showDeleteMenu() {
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                            Delete a Patron Details                           ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "║  Patron ID:                                                                  ║"      
    echo "║  First Name:                                                                 ║"      
    echo "║  Last Name:                                                                  ║"      
    echo "║  Mobile Number:                                                              ║"      
    echo "║  Birth Date (MM-DD-YYYY):                                                    ║"      
    echo "║  Membership Type (Student / Public):                                         ║"      
    echo "║  Joined Date (MM-DD-YYYY):                                                   ║"      
    echo "║                                                                              ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝" 
}

function showUpdateMenu() {
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                             Update a Patron Details                          ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "║  Patron ID:                                                                  ║"      
    echo "║  First Name:                                                                 ║"      
    echo "║  Last Name:                                                                  ║"      
    echo "║  Mobile Number:                                                              ║"      
    echo "║  Birth Date (MM-DD-YYYY):                                                    ║"      
    echo "║  Membership Type (Student / Public):                                         ║"      
    echo "║  Joined Date (MM-DD-YYYY):                                                   ║"      
    echo "║                                                                              ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"  
}

function showSortLastNameMenu() {
    clear
    echo "╔═════════════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                            Patron Details Sorted by Last Name                           ║"
    echo "╠═════════════════╦═════════════════╦═════════════════╦═════════════════╦═════════════════╣"  
    printf "║ %-15s ║ %-15s ║ %-15s ║ %-15s ║ %-15s ║\n" "Last Name" "First Name" "Mobile Number" "Joined Date" "Membership Type"
}

function showSortPatronIDMenu() {
    clear
    echo "╔═════════════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                            Patron Details Sorted by Patron ID                           ║"
    echo "╠═════════════════╦═════════════════╦═════════════════╦═════════════════╦═════════════════╣"  
    printf "║ %-15s ║ %-15s ║ %-15s ║ %-15s ║ %-15s ║\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Birth Date"
}

function showSortJoinedDateMenu() {
    clear
    echo "╔═════════════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                           Patron Details Sorted by Joined Date                          ║"
    echo "╠═════════════════╦═════════════════╦═════════════════╦═════════════════╦═════════════════╣"  
    printf "║ %-15s ║ %-15s ║ %-15s ║ %-15s ║ %-15s ║\n" "Patron ID" "Last Name" "First Name" "Mobile Number" "Joined Date"
}

function showExitMenu() {
    clear
    echo "╔════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                           Thank For Using Our Service                          ║"
    echo "╚════════════════════════════════════════════════════════════════════════════════╝"
}

function addNewDetails() {
    while true; do
        # Check if the patron.txt file exists and not empty
        if [ ! -s patron.txt ]; then
            echo "PatronID:FName:LName:MobileNum:BirthDate:MembershipType:JoinedDate" > patron.txt
        fi

        patronID=""
        
        # Determine next Patron ID
        if [ "$(wc -l < patron.txt)" -gt 1 ]; then
            # Get the highest existing Patron ID, increment it for the new ID
            patronIDCheck=$(grep -o "^P[0-9]\{4\}" patron.txt | sed 's/P//' | sort -n | tail -1)
            # get the last id and + 1
            patronID=$(printf "P%04d" $((patronIDCheck + 1)))
        else
            # If file empty
            patronID="P0001"
        fi

        defaultDate=""
        showNewMenu

        while true; do
            tput cup 5 15  
            printf "%-60s" " "  
            tput cup 5 15  
            read -r firstName

            tput cup 13 3 
            printf "%-76s║" " "

            # if the input is empty
            if [ -z "$firstName" ]; then
                errorMessage="First name cannot be empty."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue  
            # not only letter
            elif [[ ! "$firstName" =~ ^[A-Za-z]+$ ]]; then
                errorMessage="First name can only contain letters."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue 
            else
                break
            fi
        done

        while true; do
            tput cup 6 14  # Move to row 4, column 14 (Patron ID input position)
            printf "%-61s" " "  # clear line
            tput cup 6 14
            read -r lastName

            tput cup 13 3 
            printf "%-76s║" " "

            if [ -z "$lastName" ]; then
                errorMessage="Last name cannot be empty."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif [[ ! "$lastName" =~ ^[A-Za-z]+$ ]]; then
                errorMessage="Last name can only contain letters."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            else
                # echo "successful"
                break
            fi
        done

        while true; do
            tput cup 7 18 
            printf "%-57s" " "  
            tput cup 7 18
            read -r mobileNumber

            tput cup 13 3 
            printf "%-76s║" " "

            if [ -z "$mobileNumber" ]; then
                errorMessage="Mobile Number cannot be empty."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi

            checkNumber="${mobileNumber//-/}"
            length=${#checkNumber}
            checkStartingNumber="${checkNumber:0:3}"
        
            if [[ ! "$checkStartingNumber" =~ ^01[0-9]$ ]]; then
                errorMessage="Invalid mobile number. Must start with 010-019."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi

            if [ "$checkStartingNumber" = "011" ]; then
                # 011 needs 11 digits total
                if [ "$length" -ne 11 ]; then
                    errorMessage="Numbers with 011 must have 11 digits total."
                    tput cup 13 3 
                    printf "%-76s║" "$errorMessage"
                    continue
                fi
            else
                # All other need 10 digits total 
                if [ "$length" -ne 10 ]; then
                    errorMessage="Numbers with ${checkStartingNumber} must have 10 digits total"
                    tput cup 13 3 
                    printf "%-76s║" "$errorMessage"
                    continue
                fi
            fi

            mobileNumber="${checkNumber:0:3}-${checkNumber:3}"
            break
        done

        while true; do
            tput cup 8 28 
            printf "%-47s" " "  
            tput cup 8 28         
            read -r birthDate
            
            tput cup 13 3 
            printf "%-76s║" " "

            # Clear input to only digits
            cleanDate=$(echo "$birthDate" | tr -d -c '0-9')

            # Check if empty
            if [ -z "$cleanDate" ]; then
                errorMessage="Birth date cannot be empty."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            
            # Check if has 8 digits
            if [[ "${#cleanDate}" -ne 8 ]]; then
                errorMessage="Invalid date format. Must be 8 digits (MMDDYYYY)."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            
            # Extract date parts
            month="${cleanDate:0:2}"
            day="${cleanDate:2:2}"
            year="${cleanDate:4:4}"
            
            # Format for display
            birthDate="${month}-${day}-${year}"
            
            # ALWAYS validate ranges regardless of date -d result
            if (( month < 1 || month > 12 )); then
                errorMessage="Month must be between 1-12."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( day < 1 || day > 31 )); then
                errorMessage="Day must be between 1-31."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( year < 1900 )); then
                maxYear=$(($(date +"%Y") - 12))
                errorMessage="Year must be between 1900-$maxYear."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            
            # Calculate mnimum 12 years old
            currentYear=$(date +"%Y")
            currentMonth=$(date +"%m")
            currentDay=$(date +"%d")
            minYear=$((currentYear - 12))

            if (( year > minYear )); then
                errorMessage="Must be at least 12 years old."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( year == minYear && month > currentMonth )); then
                errorMessage="Must be at least 12 years old."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( year == minYear && month == currentMonth && day > currentDay )); then
                errorMessage="Must be at least 12 years old."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            
            # Check if date is valid calendar date (Feb 30, etc.)
            birthDateCheck="${month}/${day}/${year}"
            if ! date -d "$birthDateCheck" "+%m-%d-%Y" > /dev/null 2>&1; then
                errorMessage="Invalid calendar date (e.g., Feb 30 doesn't exist)."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            break
        done
        
        while true; do
            tput cup 9 39 
            printf "%-36s" " "  
            tput cup 9 39                
            read -r membershipType

            tput cup 13 3 
            printf "%-76s║" " "

            # to lower , then set first to upper
            membershipType=$(echo "$membershipType" | tr '[:upper:]' '[:lower:]')
            if [ "$membershipType" = "student" ]; then
                membershipType="Student"
                break
            elif [ "$membershipType" = "public" ]; then
                membershipType="Public"
                break
            else
                errorMessage="Invalid membership type"
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
        done

        tput cup 10 29 
        defaultDate=$(date +"%m-%d-%Y")  
        echo "$defaultDate"

        tput cup 12 0
        echo "║  Press (q) to return to Patron Maintenance Menu.                             ║"
        echo "╠══════════════════════════════════════════════════════════════════════════════╣"
        while true; do 
            tput cup 14 0 
            echo "║  Add another new patron details? (y)es or (q)uit:                            ║"
            echo "╚══════════════════════════════════════════════════════════════════════════════╝"
            tput cup 14 52
            read -r selection
            selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]') 
            if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                if [ ! -s patron.txt ]; then
                    echo "PatronID:FName:LName:MobileNum:BirthDate:MembershipType:JoinedDate" > patron.txt
                fi
                echo "$patronID:$firstName:$lastName:$mobileNumber:$birthDate:$membershipType:$defaultDate" >> patron.txt
                break 2     # break 2 loop to quit
            elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                if [ ! -s patron.txt ]; then
                    echo "PatronID:FName:LName:MobileNum:BirthDate:MembershipType:JoinedDate" > patron.txt
                fi
                echo "$patronID:$firstName:$lastName:$mobileNumber:$birthDate:$membershipType:$defaultDate" >> patron.txt
                break    # break 1 loop to continue add patron
            else
                errorMessage="Invalid choice (Press any key to continue)"
                tput cup 14 3 
                printf "%-76s║" "$errorMessage"
                tput cup 14 0
                read -r -n 1 
            fi
        done
    done
}

function searchDetails() {
    while true; do
        showSearchMenu

        # firstName=""
        # lastName=""
        # mobileNumber=""
        # birthDate=""
        # membershipType=""
        # defaultDate=""

        while true; do
            tput cup 4 14  # Move to row 4, column 14
            printf "%-61s" " "  # clear from currect cursor position
            tput cup 4 14
            read -r patronID

            tput cup 13 3 
            printf "%-76s║" " "
            patronID=$(echo "$patronID" | tr '[:lower:]' '[:upper:]')
            if [[ ! "$patronID" =~ ^P[0-9]{4}$ ]]; then
                errorMessage="Invalid ID format, Please insert P + 4 digits. eg. P0001"
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            else
                break 
            fi
        done 

        if grep -q "^$patronID:" patron.txt; then
            patron_data=$(grep "^$patronID:" patron.txt)
            IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate <<< "$patron_data"
            tput cup 5 15
            printf "%-20s" "$firstName"
            tput cup 6 14
            printf "%-20s" "$lastName"
            tput cup 7 18
            printf "%-20s" "$mobileNumber"
            tput cup 8 28
            printf "%-20s" "$birthDate"
            tput cup 9 39
            printf "%-20s" "$membershipType"
            tput cup 10 29
            printf "%-20s" "$defaultDate"
        else
            errorMessage="Patron ID not found."                       
            tput cup 13 3  
            printf "%-76s║" "$errorMessage"
            sleep 0.5 
        fi
        tput cup 12 0
        echo "║  Press (q) to return to Patron Maintenance Menu.                             ║"
        echo "╠══════════════════════════════════════════════════════════════════════════════╣"        
        while true; do
            tput cup 14 0 
            echo "║  Search another patron? (y)es or (q)uit:                                     ║"
            echo "╚══════════════════════════════════════════════════════════════════════════════╝"
            tput cup 14 43
            read -r selection
            selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]') 

            if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                break 2 
            elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                break 
            else
                errorMessage="Invalid choice. Please enter choice again. (Press any key to continue)"
                tput cup 14 3 
                printf "%-76s║" "$errorMessage"
                tput cup 14 0
                read -r -n 1  
            fi
        done
    done
}

function updateDetails() {
    showUpdateMenu
    while true; do
        tput cup 4 14  # Move to row 4, column 14
        printf "%-61s" " "  # clear from currect cursor position
        tput cup 4 14
        read -r patronID

        tput cup 13 3 
        printf "%-76s║" " "

        patronID=$(echo "$patronID" | tr '[:lower:]' '[:upper:]')
        if [[ ! "$patronID" =~ ^P[0-9]{4}$ ]]; then
            errorMessage="Invalid ID format, Please insert P + 4 digits. eg. P0001"
                            tput cup 13 3  
            printf "%-76s║" "$errorMessage"
            continue
        else
            break 
        fi
    done 
    echo ""
    if grep -q "^$patronID:" patron.txt; then
        patron_data=$(grep "^$patronID:" patron.txt)
        IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate <<< "$patron_data"
        tput cup 5 15
        printf "%-20s" "$firstName"
        tput cup 6 14
        printf "%-20s" "$lastName"

        while true; do
            tput cup 7 18 
            printf "%-57s" " "  
            tput cup 7 18
            read -r newmobileNumber

            tput cup 13 3 
            printf "%-76s║" " "

            if [ -z "$newmobileNumber" ]; then
                errorMessage="Mobile number cannot be empty."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi

            checkNumber="${newmobileNumber//-/}"
            length=${#checkNumber}
            checkStartingNumber="${checkNumber:0:3}"
        
            if [[ ! "$checkStartingNumber" =~ ^01[0-9]$ ]]; then
                errorMessage="Invalid mobile number. Must start with 010-019."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi

            if [ "$checkStartingNumber" = "011" ]; then
                # 011 needs 11 digits total
                if [ "$length" -ne 11 ]; then
                    errorMessage="Numbers starting with 011 must have 11 digits total."
                    tput cup 13 3 
                    printf "%-76s║" "$errorMessage"
                    continue
                fi
            else
                # All other need 10 digits total 
                if [ "$length" -ne 10 ]; then
                    errorMessage="Numbers starting with ${checkStartingNumber} must have 10 digits total"
                    tput cup 13 3 
                    printf "%-76s║" "$errorMessage"
                    continue
                fi
            fi

            newmobileNumber="${checkNumber:0:3}-${checkNumber:3}"
            break
        done

        while true; do
            tput cup 8 28 
            printf "%-47s" " "  
            tput cup 8 28         
            read -r NewBirthDate
            
                            tput cup 13 3 
            printf "%-76s║" " "

            # Clear input to only digits
            cleanNewBirthDate=$(echo "$NewBirthDate" | tr -d -c '0-9')

            # Check if empty
            if [ -z "$cleanNewBirthDate" ]; then
                errorMessage="Birth date cannot be empty."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            
            # Check if has 8 digits
            if [[ "${#cleanNewBirthDate}" -ne 8 ]]; then
                errorMessage="Invalid date format. Must be 8 digits (MMDDYYYY)."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            
            # Extract date parts
            month="${cleanNewBirthDate:0:2}"
            day="${cleanNewBirthDate:2:2}"
            year="${cleanNewBirthDate:4:4}"
            
            # Format for display
            NewBirthDate="${month}-${day}-${year}"
            
            # ALWAYS validate ranges regardless of date -d result
            if (( month < 1 || month > 12 )); then
                errorMessage="Month must be between 1-12."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( day < 1 || day > 31 )); then
                errorMessage="Day must be between 1-31."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( year < 1900 )); then
                errorMessage="Year must be between 1900-$(date +"%Y")."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi

            # Calculate mnimum 12 years old
            currentYear=$(date +"%Y")
            currentMonth=$(date +"%m")
            currentDay=$(date +"%d")
            minYear=$((currentYear - 12))

            if (( year > minYear )); then
                errorMessage="Must be at least 12 years old."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( year == minYear && month > currentMonth )); then
                errorMessage="Must be at least 12 years old."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            elif (( year == minYear && month == currentMonth && day > currentDay )); then
                errorMessage="Must be at least 12 years old."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            
            # Check if date is valid calendar date (Feb 30, etc.)
            NewBirthDateCheck="${month}/${day}/${year}"
            if ! date -d "$NewBirthDateCheck" "+%m-%d-%Y" > /dev/null 2>&1; then
                errorMessage="Invalid calendar date (e.g., Feb 30 doesn't exist)."
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            fi
            break
        done

        tput cup 9 39
        printf "%-20s" "$membershipType"
        tput cup 10 29
        printf "%-20s" "$defaultDate"
    else
        errorMessage="Patron ID not found."                       
        tput cup 13 3  
        printf "%-76s║" "$errorMessage"
        sleep 0.5
    fi
    tput cup 12 0
    echo "║  Press (q) to return to Patron Maintenance Menu.                             ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"        
    while true; do
        tput cup 14 0 
        echo "║  Are you sure you want to $(tput bold)UPDATE$(tput sgr0) the above Patron Details? (y)es or (q)uit:  ║"
        echo "╚══════════════════════════════════════════════════════════════════════════════╝"
        tput cup 14 78
        read -r selection
        selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]') 

        if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
            break 2 
        elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
            sed -i "s/^$patronID:.*/$patronID:$firstName:$lastName:$newmobileNumber:$NewBirthDate:$membershipType:$defaultDate/" patron.txt
            break 2
        else
            errorMessage="Invalid choice. Please enter choice again. (Press any key to continue)"
            tput cup 14 3 
            printf "%-76s║" "$errorMessage"
            tput cup 14 0
            read -r -n 1  
        fi
    done
}

function deleteDetails() {
    while true; do
        showDeleteMenu

        while true; do
            tput cup 4 14  # Move to row 4, column 14
            printf "%-61s" " "  # clear from currect cursor position
            tput cup 4 14
            read -r patronID

            tput cup 13 3 
            printf "%-76s║" " "

            patronID=$(echo "$patronID" | tr '[:lower:]' '[:upper:]')
            if [[ ! "$patronID" =~ ^P[0-9]{4}$ ]]; then
                errorMessage="Invalid ID format, Please insert P + 4 digits. eg. P0001"
                tput cup 13 3 
                printf "%-76s║" "$errorMessage"
                continue
            else
                break 
            fi
        done 

        if grep -q "^$patronID:" patron.txt; then
            patron_data=$(grep "^$patronID:" patron.txt)
            IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate <<< "$patron_data"
            tput cup 5 15
            printf "%-20s" "$firstName"
            tput cup 6 14
            printf "%-20s" "$lastName"
            tput cup 7 18
            printf "%-20s" "$mobileNumber"
            tput cup 8 28
            printf "%-20s" "$birthDate"
            tput cup 9 39
            printf "%-20s" "$membershipType"
            tput cup 10 29
            printf "%-20s" "$defaultDate"
        else
            errorMessage="Patron ID not found."                       
            tput cup 13 3  
            printf "%-76s║" "$errorMessage"
            sleep 0.5 
        fi
        tput cup 12 0
        echo "║  Press (q) to return to Patron Maintenance Menu.                             ║"
        echo "╠══════════════════════════════════════════════════════════════════════════════╣"        
        while true; do
            tput cup 14 0 
            echo "║  Are you sure you want to $(tput bold)DELETE$(tput sgr0) above Patron Details? (y)es or (q)uit:      ║"
            echo "╚══════════════════════════════════════════════════════════════════════════════╝"
            tput cup 14 74
            read -r selection
            selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]') 

            if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
                break 2     
            elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
                sed -i "/^$patronID:/d" patron.txt
                break 2
            else
                errorMessage="Invalid choice. Please enter choice again. (Press any key to continue)"
                tput cup 14 3 
                printf "%-76s║" "$errorMessage"
                tput cup 14 0
                read -r -n 1 
            fi
        done
    done
}

function sortLastName() {
    showSortLastNameMenu

    if [ ! -f "patron.txt" ]; then
        echo "╠═════════════════╩═════════════════╩═════════════════╩═════════════════╩═════════════════╣"
        echo "║ No patron data file found. Please create patron records first.                          ║"
        echo "╠═════════════════════════════════════════════════════════════════════════════════════════╣"
        echo "║ Press any key to return to Patron Maintenance Menu.                                     ║"
        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
        read -r -n 1
        return
    fi

    echo "╠═════════════════╬═════════════════╬═════════════════╬═════════════════╬═════════════════╣"

    headerRow=5 # including header
    dataRow=$(tail -n +2 patron.txt | grep -c -v '^[[:space:]]*$')
    headerDataCount=$((headerRow + dataRow))
    # tail -n +2 patron.txt is used to skip the first line of the file, which is the header.
    # -t ':' is used to specify the delimiter as colon and -k3, 3 is used to sort by the third field, which is the last name.
    # while IFS=':' is used to sets the field separator to colon for the read command
    tail -n +2 patron.txt | sort -t ':' -k3,3 | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do
        # Skip empty lines 
        if [[ -z "$patronID" && -z "$firstName" && -z "$lastName" && -z "$mobileNumber" && -z "$birthDate" && -z "$membershipType" && -z "$defaultDate" ]]; then
            continue
        fi
        printf "║ %-15s ║ %-15s ║ %-15s ║ %-15s ║ %-15s ║\n" "$lastName" "$firstName" "$mobileNumber" "$defaultDate" "$membershipType"
    done


    echo "╠═════════════════╩═════════════════╩═════════════════╩═════════════════╩═════════════════╣"
    echo "║ Press (q) to return to Patron Maintenance Menu.                                         ║"                            

    while true; do
        tput cup $((headerDataCount + 2)) 0
        echo "║ Would you like to export the report as ASCII text file? (y)es (q)uit:                   ║"
        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
        tput cup $((headerDataCount + 2)) 72
        read -r selection
        selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]')

        if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
            break
        elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
            while true; do
                tput cup $((headerDataCount + 3)) 0
                echo "║ Enter file name:                                                                        ║"
                echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                tput cup $((headerDataCount + 3)) 19
                read -r fileName

                if [ -n "$fileName" ]; then
                    if [ ${#fileName} -gt 12 ]; then
                        tput cup $((headerDataCount + 3)) 0
                        echo "║ File name must be 12 characters or less. (Press any key to continue)                    ║"
                        read -r -n 1 
                        continue
                    fi

                    if [ -e "$fileName" ]; then
                         while true; do  
                            tput cup $((headerDataCount + 3)) 0
                            echo "║ File already exists. Do you want to overwrite the file? (y)es (n)o:                     ║"
                            tput cup $((headerDataCount + 3)) 70
                            read -r overwrite
                            overwrite=$(echo "$overwrite" | tr '[:upper:]' '[:lower:]')
                            
                            if [ "$overwrite" = "y" ] || [ "$overwrite" = "yes" ]; then
                                # Choose to overwrite
                                head -n 1 patron.txt > "$fileName" # Write header
                                tail -n +2 patron.txt | grep -v '^$' | sort -t ':' -k3,3 >> "$fileName" 
                                tput cup $((headerDataCount + 4)) 0
                                printf "║ %-88s║\n" "Report exported to $fileName"
                                echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                                sleep 0.5
                                break 3  
                            elif [ "$overwrite" = "n" ] || [ "$overwrite" = "no" ]; then
                                break 3
                            else 
                                tput cup $((headerDataCount + 3)) 0
                                echo "║ Invalid choice. Please enter choice again. (Press any key to continue)                  ║"
                                read -r -n 1 
                            fi
                        done
                    else
                        head -n 1 patron.txt > "$fileName" # Write header
                        tail -n +2 patron.txt | grep -v '^$' | sort -t ':' -k3,3 >> "$fileName" 
                        tput cup $((headerDataCount + 4)) 0
                        printf "║ %-88s║\n" "Report exported to $fileName"
                        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                        sleep 0.5
                        break 2
                    fi
                else
                    tput cup $((headerDataCount + 3)) 0
                    echo "║ Invalid file name. Please try again. (Press any key to continue)                        ║"
                    read -r -n 1 
                fi
            done
        else
            tput cup $((headerDataCount + 2)) 0
            echo "║ Invalid choice. Please enter choice again. (Press any key to continue)                  ║"
            read -r -n 1 
        fi
    done
}

function sortPatronID() {
    showSortPatronIDMenu

    if [ ! -f "patron.txt" ]; then
        echo "╠═════════════════╩═════════════════╩═════════════════╩═════════════════╩═════════════════╣"
        echo "║ No patron data file found. Please create patron records first.                          ║"
        echo "╠═════════════════════════════════════════════════════════════════════════════════════════╣"
        echo "║ Press any key to return to Patron Maintenance Menu.                                     ║"
        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
        read -r -n 1
        return
    fi

    echo "╠═════════════════╬═════════════════╬═════════════════╬═════════════════╬═════════════════╣"

    headerRow=5 # including header
    dataRow=$(tail -n +2 patron.txt | grep -c -v '^[[:space:]]*$')
    headerDataCount=$((headerRow + dataRow))
    # Same as above, but sorting by the first field, which is the patron ID.
    tail -n +2 patron.txt | sort -t ':' -k1,1 | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do
         # Skip empty lines 
        if [[ -z "$patronID" && -z "$firstName" && -z "$lastName" && -z "$mobileNumber" && -z "$birthDate" && -z "$membershipType" && -z "$defaultDate" ]]; then
            continue
        fi
        printf "║ %-15s ║ %-15s ║ %-15s ║ %-15s ║ %-15s ║\n" "$patronID" "$lastName" "$firstName" "$mobileNumber" "$birthDate"
    done

    echo "╠═════════════════╩═════════════════╩═════════════════╩═════════════════╩═════════════════╣"
    echo "║ Press (q) to return to Patron Maintenance Menu.                                         ║"                            

    while true; do
        tput cup $((headerDataCount + 2)) 0
        echo "║ Would you like to export the report as ASCII text file? (y)es (q)uit:                   ║"
        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
        tput cup $((headerDataCount + 2)) 72
        read -r selection
        selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]')

        if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
            break
        elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
            while true; do
                tput cup $((headerDataCount + 3)) 0
                echo "║ Enter file name:                                                                        ║"
                echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                tput cup $((headerDataCount + 3)) 19
                read -r fileName

                if [ -n "$fileName" ]; then
                    if [ ${#fileName} -gt 12 ]; then
                            tput cup $((headerDataCount + 3)) 0
                            echo "║ File name must be 12 characters or less. (Press any key to continue)                    ║"
                            read -r -n 1 
                            continue
                        fi

                        if [ -e "$fileName" ]; then
                            while true; do  
                                tput cup $((headerDataCount + 3)) 0
                                echo "║ File already exists. Do you want to overwrite the file? (y)es (n)o:                     ║"
                                tput cup $((headerDataCount + 3)) 70
                                read -r overwrite
                                overwrite=$(echo "$overwrite" | tr '[:upper:]' '[:lower:]')
                            
                        
                        if [ "$overwrite" = "y" ] || [ "$overwrite" = "yes" ]; then
                                # Choose to overwrite
                                head -n 1 patron.txt > "$fileName" # Write header
                                tail -n +2 patron.txt | grep -v '^$' | sort -t ':' -k1,1 >> "$fileName" 
                                tput cup $((headerDataCount + 4)) 0
                                printf "║ %-88s║\n" "Report exported to $fileName"
                                echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                                sleep 0.5
                                break 3  
                            elif [ "$overwrite" = "n" ] || [ "$overwrite" = "no" ]; then
                                break 3
                            else 
                                tput cup $((headerDataCount + 3)) 0
                                echo "║ Invalid choice. Please enter choice again. (Press any key to continue)                  ║"
                                read -r -n 1 
                            fi
                        done
                    else
                        head -n 1 patron.txt > "$fileName" # Write header
                        tail -n +2 patron.txt | grep -v '^$' | sort -t ':' -k1,1 >> "$fileName" 
                        tput cup $((headerDataCount + 4)) 0
                        printf "║ %-88s║\n" "Report exported to $fileName"
                        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                        sleep 0.5
                        break 2
                    fi
                else
                    tput cup $((headerDataCount + 3)) 0
                    echo "║ Invalid file name. Please try again. (Press any key to continue)                        ║"
                    read -r -n 1 
                fi
            done
        else
            tput cup $((headerDataCount + 2)) 0
            echo "║ Invalid choice. Please enter choice again. (Press any key to continue)                  ║"
            read -r -n 1 
        fi
    done
}

function sortJoinedDate() {
    showSortJoinedDateMenu

    if [ ! -f "patron.txt" ]; then
        echo "╠═════════════════╩═════════════════╩═════════════════╩═════════════════╩═════════════════╣"
        echo "║ No patron data file found. Please create patron records first.                          ║"
        echo "╠═════════════════════════════════════════════════════════════════════════════════════════╣"
        echo "║ Press any key to return to Patron Maintenance Menu.                                     ║"
        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
        read -r -n 1
        return
    fi

    echo "╠═════════════════╬═════════════════╬═════════════════╬═════════════════╬═════════════════╣"

    headerRow=5 # including header
    dataRow=$(tail -n +2 patron.txt | grep -c -v '^[[:space:]]*$')
    headerDataCount=$((headerRow + dataRow))
    
    # Same as above, but sorting by the seventh field, which is the joined date.
    tail -n +2 patron.txt | sort -t ':' -k7,7r | while IFS=':' read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do
        if [[ -z "$patronID" && -z "$firstName" && -z "$lastName" && -z "$mobileNumber" && -z "$birthDate" && -z "$membershipType" && -z "$defaultDate" ]]; then
            continue
        fi
        printf "║ %-15s ║ %-15s ║ %-15s ║ %-15s ║ %-15s ║\n" "$patronID" "$lastName" "$firstName" "$mobileNumber" "$defaultDate"
    done
    
    echo "╠═════════════════╩═════════════════╩═════════════════╩═════════════════╩═════════════════╣"
    echo "║ Press (q) to return to Patron Maintenance Menu.                                         ║"                            

    while true; do
        tput cup $((headerDataCount + 2)) 0
        echo "║ Would you like to export the report as ASCII text file? (y)es (q)uit:                   ║"
        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
        tput cup $((headerDataCount + 2)) 72
        read -r selection
        selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]')

        if [ "$selection" = "q" ] || [ "$selection" = "quit" ]; then
            break
        elif [ "$selection" = "y" ] || [ "$selection" = "yes" ]; then 
            while true; do
                tput cup $((headerDataCount + 3)) 0
                echo "║ Enter file name:                                                                        ║"
                echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                tput cup $((headerDataCount + 3)) 19
                read -r fileName
                if [ -n "$fileName" ]; then
                    if [ ${#fileName} -gt 12 ]; then
                        tput cup $((headerDataCount + 3)) 0
                        echo "║ File name must be 12 characters or less. (Press any key to continue)                    ║"
                        read -r -n 1 
                        continue
                    fi

                    if [ -e "$fileName" ]; then
                        while true; do  
                            tput cup $((headerDataCount + 3)) 0
                            echo "║ File already exists. Do you want to overwrite the file? (y)es (n)o:                     ║"
                            tput cup $((headerDataCount + 3)) 70
                            read -r overwrite
                            overwrite=$(echo "$overwrite" | tr '[:upper:]' '[:lower:]')
                            
                            if [ "$overwrite" = "y" ] || [ "$overwrite" = "yes" ]; then
                                # Choose to overwrite
                                head -n 1 patron.txt > "$fileName" # Write header
                                tail -n +2 patron.txt | grep -v '^$' | sort -t ':' -k7,7r >> "$fileName" 
                                tput cup $((headerDataCount + 4)) 0
                                printf "║ %-88s║\n" "Report exported to $fileName"
                                echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                                sleep 0.5
                                break 3  
                            elif [ "$overwrite" = "n" ] || [ "$overwrite" = "no" ]; then
                                break 3
                            else 
                                tput cup $((headerDataCount + 3)) 0
                                echo "║ File name must be 12 characters or less. (Press any key to continue)                    ║"
                                read -r -n 1 
                            fi
                        done
                    else
                        head -n 1 patron.txt > "$fileName" # Write header
                        tail -n +2 patron.txt | grep -v '^$' | sort -t ':' -k7,7r >> "$fileName" 
                        tput cup $((headerDataCount + 4)) 0
                        printf "║ %-88s║\n" "Report exported to $fileName"
                        echo "╚═════════════════════════════════════════════════════════════════════════════════════════╝"
                        sleep 0.5
                        break 2
                    fi
                else
                    tput cup $((headerDataCount + 3)) 0
                    echo "║ Invalid file name. Please try again. (Press any key to continue)                        ║"
                    read -r -n 1 
                fi
            done
        else
            tput cup $((headerDataCount + 2)) 0
            echo "║ Invalid choice. Please enter choice again. (Press any key to continue)                  ║"
            read -r -n 1 
        fi
    done
}

function showStatistics() {
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                             Patron Statistics                                ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    
    # Count total patrons
    total=$(tail -n +2 patron.txt | grep -c -v '^[[:space:]]*$')
    printf "║  %-88s║\n" "─── MEMBERSHIP SUMMARY ───"
    printf "║  Total Patrons: %-61s║\n" "$total"
    
    # Count by membership type
    students=$(grep -c ":Student:" patron.txt)
    public=$(grep -c ":Public:" patron.txt)
    
    # Calculate percentages
    if [ "$total" -gt 0 ]; then
        student_percent=$((students * 100 / total))
        public_percent=$((public * 100 / total))
    else
        student_percent=0
        public_percent=0
    fi

    # fixed-width progress bars (20 total width)
    BAR_WIDTH=20
    student_filled=$((student_percent * BAR_WIDTH / 100))
    public_filled=$((public_percent * BAR_WIDTH / 100))
    
    # Create bars with filled and empty 
    student_bar=""
    public_bar=""
    
    for ((i=0; i<BAR_WIDTH; i++)); do
        if [ $i -lt $student_filled ]; then
            student_bar="${student_bar}█"
        else
            student_bar="${student_bar}░"
        fi
        
        if [ $i -lt $public_filled ]; then
            public_bar="${public_bar}█"
        else
            public_bar="${public_bar}░"
        fi
    done

    # progress bars with fixed width 
    printf "║  Student Members: %3d%% │%-20s│%-32s║\n" "$student_percent" "$student_bar" ""
    printf "║  Public Members:  %3d%% │%-20s│%-32s║\n" "$public_percent" "$public_bar" ""
        
    printf "║  %-76s║\n" " "
    printf "║  %-88s║\n" "─── AGE DEMOGRAPHICS ───"
    
    currentYear=$(date +"%Y")
    
    under18=0
    age18to30=0
    age31to50=0
    over50=0

    # Calculate age
    while IFS=: read -r patronID firstName lastName mobileNumber birthDate membershipType defaultDate; do
        if [ "$patronID" = "PatronID" ] || [ -z "$birthDate" ]; then
            continue
        fi
        
        birthYear=$(echo "$birthDate" | cut -d'-' -f3) # break and take year
        age=$((currentYear - birthYear))
        
        if [ "$age" -lt 18 ]; then
            under18=$((under18 + 1))
        elif [ "$age" -le 30 ]; then
            age18to30=$((age18to30 + 1))
        elif [ "$age" -le 50 ]; then
            age31to50=$((age31to50 + 1))
        else
            over50=$((over50 + 1))
        fi
    done < patron.txt

    printf "║  Under 18 years: %-17s                                           ║\n" "$under18"
    printf "║  18-30 years:    %-17s                                           ║\n" "$age18to30"
    printf "║  31-50 years:    %-17s                                           ║\n" "$age31to50"
    printf "║  Over 50 years:  %-17s                                           ║\n" "$over50"
    
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║ Press any key to continue.                                                   ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    tput cuu 2 
    tput cuf 29
    read -r -n 1
}

function backupPatronData() {
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                  Backup Data                                 ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    
    # Check if patron.txt exists
    if [ ! -f patron.txt ]; then
        printf "║  %-76s║\n" "patron.txt not found. Nothing to backup."
        printf "║  %-76s║\n" "Press any key to return to the main menu."
        echo "╚══════════════════════════════════════════════════════════════════════════════╝"
        tput cuu 2 
        tput cuf 45
        read -r -n 1
        return
    fi
    
    # Create backup directory with error checking
    if ! mkdir -p backup 2>/dev/null; then
        printf "║  %-76s║\n" "Failed to create backup directory."
        printf "║  %-76s║\n" "Press any key to return to the main menu."
        echo "╚══════════════════════════════════════════════════════════════════════════════╝"
        read -r -n 1
        return
    fi
    
    # Check if backup directory exists and writable
    if [ ! -d backup ] || [ ! -w backup ]; then
        printf "║  %-76s║\n" "Backup directory does not exist or is not writable."
        printf "║  %-76s║\n" "Press any key to return to the main menu."
        echo "╚══════════════════════════════════════════════════════════════════════════════╝"
        read -r -n 1
        return
    fi
    
    # Create backup with timestamp
    backup_file="backup/backup_$(date +"%Y-%m-%d %H:%M:%S").txt"
    if cp patron.txt "$backup_file" 2>/dev/null; then
        printf "║  %-76s║\n" "Backup created successfully!"
        printf "║  Backup saved to: %-59s║\n" "$backup_file"
    else
        printf "║  %-76s║\n" "Failed to create backup file."
    fi
    
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║  Press any key to continue                                                   ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    tput cuu 2 
    tput cuf 29    
    read -r -n 1
}

function restoreBackupData() {
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                Restore Backup                                ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    
    # Check if backup directory exists
    if [ ! -d backup ] || [ ! -r backup ]; then
        printf "║  %-76s║\n" "Backup directory does not exist or is not readable."
        printf "║  %-76s║\n" "Press any key to return to the main menu."
        echo "╚══════════════════════════════════════════════════════════════════════════════╝"
        read -r -n 1
        return
    fi
    
    # Check if any backup files
    backup_count=0
    for file in backup/backup_*; do
        [ -f "$file" ] && backup_count=$((backup_count + 1))
    done

    if [ "$backup_count" -eq 0 ]; then
        printf "║  %-76s║\n" "No backup files found."
        printf "║  %-76s║\n" "Press any key to return to the main menu."
        echo "╚══════════════════════════════════════════════════════════════════════════════╝"
        read -r -n 1
        return
    fi
    
    # loop to store backup filenames 
    backup_files=()
    for file in backup/backup_*; do
        if [ -f "$file" ]; then
            backup_files+=("${file##*/}")
        fi
    done
    
    count=1
    for file in "${backup_files[@]}"; do
        printf "║  %-3s %-71s ║\n" "[$count]" "$file"
        ((count++))
    done

    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    
    while true; do
        tput cup $((backup_count + 4)) 0
        printf "%-80s" " "  
        tput cup $((backup_count + 4)) 0 
        echo "║  Enter backup number to restore (Press C to cancel):                         ║"
        echo "╚══════════════════════════════════════════════════════════════════════════════╝"
        
        tput cup $((backup_count + 4)) 55
        read -r choice

        choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

        if [[ "$choice" == "c" ]]; then
            return
        elif [[ "$choice" =~ ^[0-9]+$ ]]; then
            selected_file="${backup_files[$((choice-1))]}" # Valid numeric choice within range
            
            if cp "backup/$selected_file" patron.txt 2>/dev/null; then
                clear
                echo "╔══════════════════════════════════════════════════════════════════════════════╗"
                echo "║                                Restore Backup                                ║"
                echo "╠══════════════════════════════════════════════════════════════════════════════╣"
                printf "║  %-76s║\n" "Restore completed successfully!"
                printf "║  Restored from: %-61s║\n" "$selected_file"
                echo "╠══════════════════════════════════════════════════════════════════════════════╣"
                echo "║  Press any key to continue.                                                  ║"
                echo "╚══════════════════════════════════════════════════════════════════════════════╝"
                tput cuu 2 
                tput cuf 30
                read -r -n 1
                return
            else
                clear
                echo "╔══════════════════════════════════════════════════════════════════════════════╗"
                echo "║                                Restore Backup                                ║"
                echo "╠══════════════════════════════════════════════════════════════════════════════╣"
                printf "║  %-76s║\n" "Failed to restore backup file."
                echo "╠══════════════════════════════════════════════════════════════════════════════╣"
                echo "║  Press any key to continue.                                                  ║"
                echo "╚══════════════════════════════════════════════════════════════════════════════╝"
                tput cuu 2 
                tput cuf 30
                read -r -n 1
                return
            fi
        else            
            tput cup $((backup_count + 4)) 0
            printf "%-80s" " "  
            tput cup $((backup_count + 4)) 0
            printf "║  %-76s║" "Please enter a valid number or 'C' to cancel. (Press any key to continue)"
            read -r -n 1
        fi
    done
}

while true; do
    clear
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                           Patron Maintenance Menu                            ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                              ║"
    echo "║  A – Add New Patron Details                L – Sort Patrons by Last Name     ║"
    echo "║  S – Search a Patron                       P – Sort Patrons by Patron ID     ║"
    echo "║  U – Update a Patron Details               J – Sort Patrons by Joined Date   ║"
    echo "║  D – Delete a Patron Details               B – Backup Data                   ║"
    echo "║  T – Statistics Dashboard                  R – Restore Data                  ║"
    echo "║                                            Q – Exit from Program             ║"
    echo "║                                                                              ║"
    echo "╠══════════════════════════════════════════════════════════════════════════════╣"
    echo "║  Please select a choice:                                                     ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    
    tput cuu 2 
    tput cuf 27
    read -r selection

    selection=$(echo "$selection" | tr '[:upper:]' '[:lower:]')

    case $selection in
        "a")
            addNewDetails
            ;;
        "s")
            searchDetails
            ;;
        "u")
            updateDetails
            ;;
        "d")
            deleteDetails
            ;;
        "l")
            sortLastName
            ;;
        "p")
            sortPatronID
            ;;
        "j")
            sortJoinedDate
            ;;
        "t")
            showStatistics
            ;;
        "r")
            restoreBackupData
            ;;
        "b")
            backupPatronData
            ;;
        "q")
            showExitMenu
            exit
            ;;
        *)
            tput cuu 1 
            tput cuf 3
            errorMessage="Invalid Choice, Please Try Again."
            printf "%-76s║" "$errorMessage"
            sleep 0.5
    esac
done