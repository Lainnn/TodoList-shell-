#!/bin/bash

if [ $# -eq 0 ];
then
	let choice= 'O'
	while [ "$choice" != 'Q' ]
	do
		echo "Welcome to to-do list manager! Here are your current items.
		"
		files="uncompleted/"
		let "count = 1"
		let "num = 0"
	
		if [ $(ls uncompleted/| wc -l) -eq 0 ];
		then
			echo "You don't have anything in your list yet
			"
		else
	
			for file in "$files"*
			do

				if [ $(ls | wc -l) -gt 0 ];
				then		
					echo -n "$count."
		 			cat $file|head -1
		 			let "count=$count+1"
					let "num=$num+1"
				fi

			done
		fi
	
	echo "What would you like to do?"
	
		if [ $num -eq 0 ];
		then
			echo "		add item to see more information"
		else
			echo "		1-$num) See more information on this item"
		fi

		echo "		A) Mark an item as completed
		B) Add a new item
		C) See completed items
		
		Q) Quit"

		echo "Enter your choice:"
		read choice
		if [[ $choice == [a-zA-z] ]];
		then
			if  [ "$choice" != "A" ] && [ "$choice" != "a" ] && [ "$choice" != "B" ] && [ "$choice" != "b" ] && [ "$choice" != "c" ] && [ "$choice" != "Q" ] && [ "$choice" != "q" ]; 
			then
				echo "The command is invalid! Please enter a valid command :)"
				bash main.sh
			fi

	
			if [ "$choice" = "A" ] || [ "$choice" = "a" ];
			then
				echo "What file you want to mark completed?"
				read comFile
				if [ $comFile -gt $num ]
				then
					echo "This file dosen't esist, please chose from 1 to $num :)"
				else
					let "fn=1"
						for file in "completed/"*
						do
							if [ -f "completed/$fn.txt" ]; then
								fn=$((fn+1))
								echo $file
							else
								break
							fi
							
						done
						mv uncompleted/$comFile.txt completed/$fn.txt
							
				fi
				
				unfinish="uncompleted/"
			
				let "newName=$comFile+1"

				for file in "$unfinish"*
				do							
					if [ $file == "uncompleted/$newName.txt" ]
					then
						let "newName=$newName-1"
						mv "$file" "uncompleted/$newName.txt"
						let "newName=$newName+2"
					fi
				done
			fi

			if [ "$choice" = "B" ] || [ "$choice" = "b" ];
			then
				let "fileNum=1"
				for((; ;))
				do
					if [ -f "uncompleted/$fileNum.txt" ];then
						let "fileNum=$fileNum+1"
					else
						break
					fi
				done

				echo "Enter the file title:"
				read title
				echo $title > uncompleted/$fileNum.txt
				echo "-----------------------" >> uncompleted/$fileNum.txt
				echo "Enter the discription:"
				read discri
				echo $discri >> uncompleted/$fileNum.txt
				echo "Enter the due date:"
				read dueDate
				echo "Due day: $dueDate" >> uncompleted/$fileNum.txt
			fi

			if [ "$choice" = "C" ] || [ "$choice" = "c" ];
			then
				clear
				let "ct=1"
				completed='completed/'
				for f in "$completed"*
				do
					echo -n "
					$ct."
					cat $f|head -1
					let "ct=$ct+1"
				done
			fi

			if [ "$choice" = "Q" ] || [ "$choice" = "q" ];
			then
				exit 0
			fi

		else
	
			if [ $choice -le $(ls uncompleted/| wc -l) ];
			then
				clear
				cat uncompleted/$choice.txt
			else
				echo "The command is invalid! Please enter a valid command :)"
				bash main.sh
			fi
		fi
	done

else

	if [ "$1" = "help" ];
	then
		echo "
			1. list: show all the uncompleted items
			2. complete number: mark the item with the given number as complete
			3. list completed: list the completed items
			4. add title: adds a new item ith the given title
			"
	fi

	if [ "$1" = "list" ];
	then
		if [ "$2" == "completed" ];
		then
			completee="completed/"
			
			for fil in "$completee"*
			do
				cat $fil|head -1
			done
		else
			files="uncompleted/"
			let "count=1"
			
			for file in "$files"*
			do
			
				if [ $(ls uncompleted/| wc -l) -gt 0 ];
				then		
					echo -n "$count."
		 			cat $file|head -1
		 			let "count=$count+1"
				fi
			done
		fi
	fi

	if [ "$1" = "complete" ];
	then
		mv uncompleted/$2.txt completed/$2.txt
	
		let "newName=1"
		unfini="uncompleted/"
	
		for file in "$unfini"*
		do
			mv "$file" "uncompleted/$newName.txt"
		done
	fi

	if [ "$1" = "add" ];
	then
		let "fileNum=1"
	
		for((; ;))
		do
			if [ -f "uncompleted/$fileNum.txt" ];then
				let "fileNum=$fileNum+1"
			else
				break
			fi
		done
	
		echo $2 > uncompleted/$fileNum.txt
	fi	

	if [ "$1" != "add" ] && [ "$1" != "complete" ] && [ "$1" != "list" ] && [ "$1" != "help" ]
	then
		echo "The command is invalid! Please enter a valid command :)"
		bash main.sh help
	fi
fi
