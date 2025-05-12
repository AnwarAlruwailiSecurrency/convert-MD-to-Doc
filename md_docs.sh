#!/usr/bin/env bash

echo "Convert the Data related markdown docs into word docs"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null
then
    echo "pandoc could not be found. Please install pandoc to use this script."
    exit
fi

INPUT_DIR="$1"


if [ -z "$INPUT_DIR" ]; then
    echo "Usage: $0 <input_directory>"
    exit 1
fi

cd "$INPUT_DIR" || exit
mkdir -p word_docs
for file in *.md; do
    # Check if there are no markdown files
    echo "Processing $file..."
    # Check if the file is a markdown file
    # if [[ "$file" == *.md ]]; then
        # Remove the .md extension and add .docx
        output_file="${file%.md}.docx"    
        # Convert the markdown file to docx using pandoc
        pandoc "$file" -s -o  "word_docs/$output_file"
        
        echo "Converted $file to word_docs/$output_file"
    # fi
done
echo "All markdown files have been converted to Word documents."