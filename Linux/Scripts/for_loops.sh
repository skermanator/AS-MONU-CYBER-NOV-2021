#!/bin/bash
states=('Nebraska' 'Hawaii' 'California' 'Alabma' 'Florida')

echo which state would you like to search
read mystate
echo "searching for $mystate....."

for state in ${states[@]}
do
	if [ $state = $mystate ]
 then 
echo "$mystate is the best!"
fi
done
