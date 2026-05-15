#!/bin/bash
	#counter=1
	#for file in *.pdf; do
	#       if [ -f "$file" ]; then
	#	       formatted_counter=$(printf "%03d" $counter)
	#	       convert "$file[0]" -resize 600x800 "cover/bookCover_$formatted_counter.jpg"
	#       	       ((counter++))
	#       fi
	#done

#open_convert(){
#		
#}

# Get total number of PDF files
pdf_files=(*.pdf)
total_files=${#pdf_files[@]}

# Check if any PDF files exist
if [ $total_files -eq 0 ]; then
    echo "No PDF files found in the current directory."
    exit 1
fi

# Initialize counter for naming and progress
counter=1
processed=0

# Function to display progress bar
open_convert() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((width * current / total))
    local empty=$((width - filled))
    local bar=""
    
    # Build the progress bar
    for ((i=0; i<filled; i++)); do bar+="#"; done
    for ((i=0; i<empty; i++)); do bar+="-"; done
    
    printf "\rProgress: [%s] %d%% (%d/%d)" "$bar" "$percentage" "$current" "$total"
}

# Loop through all PDF files in the current directory
for file in "${pdf_files[@]}"; do
    if [ -f "$file" ]; then
        # Echo the current file being processed
        echo -e "\nProcessing: $file"
        
        # Format counter to have leading zeros (e.g., 001)
        formatted_counter=$(printf "%03d" $counter)
        
        # Execute the convert command
        convert "$file[0]" -resize 600x800 "cover/output_$formatted_counter.jpg"
        
        # Increment counters
        ((counter++))
        ((processed++))
        
        # Show progress bar
        open_convert $processed $total_files
    fi
done

# Move to new line after progress bar
echo ""
echo "Conversion complete! $processed PDF files processed."
