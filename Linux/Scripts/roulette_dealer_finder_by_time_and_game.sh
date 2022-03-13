#!/bin/bash
# $1 = file date
# $2 = time in fill number (01, 09, 10, 11)
# $3 = AM or PM
PS3='Please enter your choice: '
options=("Search Blackjack Dealer on $1 at $2 $3" "Search Roulette Dealer on $1 at $2 $3 " "Search Texas_Hold_EM Dealer on $1 at $2 $3 " "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Search Blackjack Dealer on $1 at $2 $3")
		echo "Blackjack Dealer on the $1: "
            find . -name $1* -exec cat {} + \
		| awk -F ":" '{print $1, $2, $3, $4}' \
		| awk -F " " '{print $1, $4, $5, $6}' \
		| grep -w "$2 $3"
            ;;
        "Search Roulette Dealer on $1 at $2 $3 ")
		echo "Roulette Dealer on the $1: "
		find . -name $1* -exec cat {} + \
                | awk -F ":" '{print $1, $2, $3, $4}' \
                | awk -F " " '{print $1, $4, $7, $8}' \
                | grep -w "$2 $3"
            ;;
        "Search Texas_Hold_EM Dealer on $1 at $2 $3 ")
		echo "Texas_Hold_EM Dealer on the $1: "
            find . -name $1* -exec cat {} + \
                | awk -F ":" '{print $1, $2, $3, $4}' \
                | awk -F " " '{print $1, $4, $9, $10}' \
                | grep -w "$2 $3"
            ;;
        "Quit")
            break
            ;;
        *) echo "no game found at number $REPLY";;
    esac
done
