#!/bin/bash

# Script directory
source=${BASH_SOURCE[0]}
while [ -L "$source" ]; do # resolve $source until the file is no longer a symlink
	dir_script=$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)
	source=$(readlink "$source")
	[[ $source != /* ]] && source=$dir/$source # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
dir_script=$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)

# include path
include_path="${dir_script}/inc"

# Base directory where the search is made
base_dir="${HOME}/Documents"

# Choose a folder from ~/Documents using Rofi
selected_dir=$(find "$base_dir" -type d -not -path '*/.*' -exec sh -c 'ls -1 "{}"/*.pdf >/dev/null 2>&1' \; -print | sed "s|^$base_dir||" | rofi -config ${include_path}/rofi-conf.rasi -dmenu -i -p "Choose a folder:")

full_path="${base_dir}/${selected_dir}"
search_history="${include_path}/search-history/${full_path}"

# Check if the user selected a folder
if [ -n "$selected_dir" ]; then

	mkdir -p $search_history

	# Prompt the user to enter a search term
	search_term=$(ls -t "${search_history}" | rofi -config ${include_path}/rofi-conf.rasi -dmenu -i -p "Enter a search term:" | tr '[:uppr:]' '[:lower:]')

	# Check if a search term was provided
	if [ -n "$search_term" ]; then

		pdf_files=$(pdfgrep -i -l -P $search_term ${full_path}/*.pdf)

		# Check if any PDF file containing the search term is found
		if [ -z "$pdf_files" ]; then
			echo "No PDF file found in the current directory and subdirectories containing the term '$search_term'."
			exit 1
		fi

		selected_file=$(echo "$pdf_files" | rofi rofi -config ${include_path}/rofi-conf.rasi -dmenu -i -p "Select a PDF file:")

		# Check if the selected file does not exist
		if [ ! -f "$selected_file" ]; then
			echo "Selected file '$selected_file' does not exist or is not a regular file."
		fi

		# Find the first occurrence of the search term in the PDF file
		page=$(pdfgrep -i -P -n "$search_term" "$selected_file" | head -n 1 | cut -d: -f1)

		# Check if the term is found
		if [ -n "$page" ]; then

			echo -e "\nThe term '$search_term' is found on \n $selected_file\n"

			# Add the search_term to search_history
			touch ${search_history}/$search_term

			# Open Zathura at the page corresponding to the first occurrence of the term
			zathura --page="$page" "$selected_file" &
			exit 0
		else
			echo "The term '$search_term' is not found in the PDF file '$selected_file'."
			exit 1
		fi
	else
		echo "No search term provided."
		exit 1
	fi
else
	echo "No folder selected."
	exit 1
fi
