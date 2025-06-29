#!/bin/bash

# Utility script to clean up stray LaTeX files
# These files should be in the logs/ directory, not scattered around

LOGS_DIR="logs"
ROOT_DIR="."
OUTPUT_DIR="resume"
SRC_DIR="src"

echo "🧹 LaTeX File Cleanup Utility"
echo "============================="
echo

# Create logs directory if it doesn't exist
mkdir -p "$LOGS_DIR"

# Function to move stray files
move_stray_files() {
    local from_dir="$1"
    local dir_name="$2"
    local found_files=false
    
    echo "🔍 Checking $dir_name for stray LaTeX files..."
    
    # Check for common LaTeX auxiliary files
    for ext in aux log out toc lof lot fls fdb_latexmk synctex.gz; do
        for file in "$from_dir"/*.$ext; do
            if [ -f "$file" ]; then
                filename=$(basename "$file")
                echo "   📄 Found: $filename → moving to $LOGS_DIR/"
                mv "$file" "$LOGS_DIR/"
                found_files=true
            fi
        done
    done
    
    if [ "$found_files" = false ]; then
        echo "   ✅ No stray files found in $dir_name"
    fi
}

# Clean up root directory
move_stray_files "$ROOT_DIR" "root directory"

# Clean up source directory (shouldn't have auxiliary files)
move_stray_files "$SRC_DIR" "source directory"

# Clean up output directory (should only have PDFs)
echo "🔍 Checking output directory for non-PDF files..."
output_cleaned=false
for file in "$OUTPUT_DIR"/*; do
    if [ -f "$file" ] && [[ ! "$file" =~ \.pdf$ ]]; then
        filename=$(basename "$file")
        # Skip temp directories
        if [[ ! "$filename" =~ ^\.tmp ]]; then
            echo "   📄 Found non-PDF: $filename → moving to $LOGS_DIR/"
            mv "$file" "$LOGS_DIR/"
            output_cleaned=true
        fi
    fi
done

if [ "$output_cleaned" = false ]; then
    echo "   ✅ Output directory is clean (PDFs only)"
fi

echo
echo "📊 Final Status:"
echo "=================="

# Show current organization
echo "📁 Project structure:"
if [ -d "$SRC_DIR" ]; then
    tex_count=$(find "$SRC_DIR" -name "*.tex" | wc -l)
    echo "   📝 $SRC_DIR/: $tex_count LaTeX source files"
fi

if [ -d "$OUTPUT_DIR" ]; then
    pdf_count=$(find "$OUTPUT_DIR" -name "*.pdf" | wc -l)
    echo "   📄 $OUTPUT_DIR/: $pdf_count PDF files"
fi

if [ -d "$LOGS_DIR" ]; then
    log_count=$(find "$LOGS_DIR" -type f | wc -l)
    echo "   📋 $LOGS_DIR/: $log_count auxiliary files"
fi

echo
echo "💡 To prevent stray files in the future:"
echo "   • Always use: ./compile.sh or ./latex.sh compile"
echo "   • Never run: xelatex or pdflatex directly"
echo "   • If you do run LaTeX directly, run this cleanup script after"
echo
echo "✅ Cleanup complete!" 