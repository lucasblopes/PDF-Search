#!/bin/bash

# Prompt the user for confirmation
read -p "Are you sure you want to delete ./include/search-history? (y/n): " confirm

# Check the user's response
if [ "$confirm" == "y" ]; then
	# User confirmed, proceed with deletion
	rm -rf ./include/search-history
	echo "Directory ./include/search-history has been deleted."
elif [ "$confirm" == "n" ]; then
	# User declined, display message and exit
	echo "Deletion aborted."
else
	# Invalid input, display error message and exit
	echo "Invalid input. Please enter 'y' for Yes or 'n' for No."
fi
