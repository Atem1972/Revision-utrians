write a bash shell that will help direct people to their seat in a football stadium
write a scrip for automatic self service in a filing station and ask oder question like car wash, bogar
!#/bin/bash




#my game
#!/bin/bash

# Define the winning numbers
winning_numbers=(5 9 13 13)

echo "Choose four numbers between 0 and 70 (separated by spaces):"
read -a user_numbers  # Read multiple inputs into an array

# Validate input to ensure all entries are numeric and in range
for number in "${user_numbers[@]}"; do
    if ! [[ "$number" =~ ^[0-9]+$ ]]; then
        echo "Invalid input! Please enter only numeric values."
        exit 1
    elif [ "$number" -lt 0 ] || [ "$number" -gt 70 ]; then
        echo "Numbers must be between 0 and 70. Please try again."
        exit 1
    fi


# Ensure the user entered exactly 4 numbers
if [ "${#user_numbers[@]}" -ne 4 ]; then
    echo "You must choose exactly four numbers. Please try again."
    exit 1
fi

# Compare user numbers with winning numbers
match_count=0
for user_num in "${user_numbers[@]}"; do
    for win_num in "${winning_numbers[@]}"; do
        if [ "$user_num" -eq "$win_num" ]; then
            ((match_count++))
            break
        fi
    


# Determine the outcome based on matches
if [ "$match_count" -eq 4 ]; then
    echo "Congratulations! You guessed all four winning numbers! You won ten million!"
elif [ "$match_count" -eq 2 ]; then
    echo "Congratulations! You guessed two winning numbers! You won five hundred thousand!"
else
    echo "Sorry, you lost your bet. Better luck next time!"
fi