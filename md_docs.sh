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
GITHUB_URL="$2"




if [ -z "$INPUT_DIR" ] || [ -z "$GITHUB_URL"]; then
    echo "Usage: $0 <input_directory> <github_base_url>"
    exit 1
fi

cd "$INPUT_DIR" || exit
mkdir -p word_docs

for file in *.md; do
    # Check if there are no markdown files
    echo "Processing $file..."
  
    output_file="${file%.md}.docx"
    # temp=file="${file%.md}_temp.md"

    # sed "s|../../contracts/\(.*)|$GITHUB_URL/\1|g" "$file" > "$temp"
    # Convert the markdown file to docx using pandoc
    pandoc "$file" -s -o  "word_docs/$output_file"
    
    echo "Converted $file to word_docs/$output_file"
    
done
echo "All markdown files have been converted to Word documents."