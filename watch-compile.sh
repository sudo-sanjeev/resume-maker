#!/bin/bash

# Enhanced LaTeX Live Preview Compiler with Multi-File Support and Source Organization
# Usage: ./watch-compile.sh [filename.tex]
# Example: ./watch-compile.sh resume.tex
#          ./watch-compile.sh cover-letter.tex

# Get filename parameter or default to resume.tex
TEX_FILE=${1:-resume.tex}
BASE_NAME=$(basename "$TEX_FILE" .tex)
SOURCE_DIR="src"
OUTPUT_DIR="resume"
LOGS_DIR="logs"
SOURCE_PATH="$SOURCE_DIR/$TEX_FILE"
PDF_OUTPUT="$OUTPUT_DIR/$BASE_NAME.pdf"

echo "🔍 LaTeX Live Preview Compiler"
echo "=============================="
echo "👀 Watching: $SOURCE_PATH for changes..."
echo "📄 PDF output: $PDF_OUTPUT"
echo "🛑 Press Ctrl+C to stop"
echo

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Source directory '$SOURCE_DIR' not found!"
    echo "💡 Create it with: mkdir $SOURCE_DIR"
    echo "💡 Move your .tex files to: $SOURCE_DIR/"
    exit 1
fi

# Check if input file exists in source directory
if [ ! -f "$SOURCE_PATH" ]; then
    echo "❌ Error: File '$SOURCE_PATH' not found!"
    echo "💡 Usage: $0 [filename.tex]"
    echo "💡 Available files in $SOURCE_DIR/:"
    if ls "$SOURCE_DIR"/*.tex 1> /dev/null 2>&1; then
        for file in "$SOURCE_DIR"/*.tex; do
            echo "   📝 $(basename "$file")"
        done
    else
        echo "   📂 No .tex files found"
    fi
    exit 1
fi

# Compile once initially
./compile.sh "$TEX_FILE"


# Function to compile and show status
compile_and_notify() {
    echo
    echo "🔄 Change detected at $(date '+%H:%M:%S')"
    echo "📝 Recompiling $SOURCE_PATH..."
    
    if ./compile.sh "$TEX_FILE" > /dev/null 2>&1; then
        echo "✅ PDF updated successfully!"
        echo "📄 Output: $PDF_OUTPUT"
    else
        echo "❌ Compilation failed - check errors"
    fi
    echo "👀 Watching for more changes..."
}

# Watch for file changes using fswatch (install if needed)
if command -v fswatch &> /dev/null; then
    echo "🎯 Using fswatch for file monitoring..."
    fswatch -o "$SOURCE_PATH" | while read f; do
        compile_and_notify
    done
else
    echo "📥 Installing fswatch for better file watching..."
    brew install fswatch
    echo "🎯 Starting file monitor..."
    fswatch -o "$SOURCE_PATH" | while read f; do
        compile_and_notify
    done
fi
