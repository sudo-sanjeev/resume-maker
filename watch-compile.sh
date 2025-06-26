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

# Function to open PDF in Cursor reliably
open_pdf_in_cursor() {
    echo "📖 Opening PDF in Cursor..."
    
    # Method 1: Use AppleScript to force Cursor to open the file
    osascript -e "
    tell application \"Cursor\"
        activate
        delay 0.5
        open POSIX file \"$(pwd)/$PDF_OUTPUT\"
    end tell" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ PDF opened in Cursor!"
        echo "💡 If it opened in system viewer, install 'PDF Preview' extension:"
        echo "   Cursor -> Extensions -> Search 'PDF Preview' -> Install"
        return 0
    fi
    
    # Method 2: Fallback to direct app opening
    echo "🔄 Trying alternative method..."
    open -a "Cursor" "$PDF_OUTPUT" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ PDF opened with Cursor app!"
        return 0
    fi
    
    # Method 3: Last resort - system default
    echo "⚠️  Falling back to system default viewer..."
    open "$PDF_OUTPUT"
    echo "❌ Could not open in Cursor. Install PDF Preview extension and try again."
    return 1
}

# Function to compile and show status
compile_and_notify() {
    echo
    echo "🔄 Change detected at $(date '+%H:%M:%S')"
    echo "📝 Recompiling $SOURCE_PATH..."
    
    if ./compile.sh "$TEX_FILE" > /dev/null 2>&1; then
        echo "✅ PDF updated successfully!"
        echo "📄 Output: $PDF_OUTPUT"
        # Auto-open PDF in Cursor editor using multiple methods
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open_pdf_in_cursor
        fi
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
