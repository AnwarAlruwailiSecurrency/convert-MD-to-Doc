#!/usr/bin/env bash

echo "Convert the Data related markdown docs into word docs"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null
then
    echo "pandoc could not be found. Please install pandoc to use this script."
    exit
fi

# first argument is the input directory
INPUT_DIR="$1"
# second argument is the github base url for each file
# GITHUB_URL="$2"




if [ -z "$INPUT_DIR" ]; then
    echo "Usage: $0 <input_directory>"
    exit 1
fi

cd "$INPUT_DIR" || exit
mkdir -p word_docs

for file in *.md; do
    # Check if there are no markdown files
    echo "Processing $file..."
  
    # output_file="${file%.md}.docx"
    output_file=$(basename "$file" .md)

    temp_file="temp_$output_file.md"

    # sed "s|../../|$GITHUB_URL/|g" "$file" > "$temp_file" # replace  paht to the file in the repo
    
    sed -E 's/\[([^]]+)\]\(\.\.\/\.\.\/[^\)]+\)/\1/g' "$file" > "$temp_file" # remove the link to the file in the repo

    # Convert the markdown file to docx using pandoc
    pandoc "$temp_file" -s -o  "word_docs/$output_file.docx"

    rm "$temp_file"

    echo "Converted $file to word_docs/$output_file"
    
done
echo "All markdown files have been converted to Word documents."