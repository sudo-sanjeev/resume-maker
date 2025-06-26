#!/bin/bash

# Enhanced LaTeX Compiler with Multi-File Support, Source Organization, and Better Error Logging
# Usage: ./compile.sh [filename.tex]
# Example: ./compile.sh resume.tex
#          ./compile.sh cover-letter.tex

# Get filename parameter or default to resume.tex
TEX_FILE=${1:-resume.tex}
BASE_NAME=$(basename "$TEX_FILE" .tex)
SOURCE_DIR="src"
OUTPUT_DIR="resume"
LOGS_DIR="logs"
SOURCE_PATH="$SOURCE_DIR/$TEX_FILE"
ERROR_LOG="$LOGS_DIR/${BASE_NAME}_errors.log"

echo "🚀 LaTeX Multi-File Compiler"
echo "============================"
echo "📄 Compiling: $TEX_FILE"
echo "📁 Source directory: $SOURCE_DIR"
echo "📁 PDF output: $OUTPUT_DIR"
echo "📁 Logs directory: $LOGS_DIR"
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

# Create output and logs directories if they don't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOGS_DIR"

# Function to extract and display LaTeX errors
extract_latex_errors() {
    local log_file="$1"
    local error_log="$2"
    
    echo "🔍 Analyzing LaTeX errors..." >&2
    echo "LaTeX Error Analysis - $(date)" > "$error_log"
    echo "========================================" >> "$error_log"
    echo "" >> "$error_log"
    
    # Extract different types of errors
    local has_errors=false
    
    # Check for LaTeX errors
    if grep -q "^!" "$log_file" 2>/dev/null; then
        echo "❌ LaTeX Errors Found:" >&2
        echo "LaTeX ERRORS:" >> "$error_log"
        echo "-------------" >> "$error_log"
        grep -A 3 "^!" "$log_file" >> "$error_log" 2>/dev/null
        echo "" >> "$error_log"
        has_errors=true
        
        # Show key errors on screen
        echo "📋 Key errors:" >&2
        grep -A 1 "^!" "$log_file" 2>/dev/null | head -10 | while read line; do
            echo "   $line" >&2
        done
    fi
    
    # Check for undefined references
    if grep -q "LaTeX Warning.*undefined" "$log_file" 2>/dev/null; then
        echo "⚠️  Undefined References:" >&2
        echo "UNDEFINED REFERENCES:" >> "$error_log"
        echo "--------------------" >> "$error_log"
        grep "LaTeX Warning.*undefined" "$log_file" >> "$error_log" 2>/dev/null
        echo "" >> "$error_log"
        has_errors=true
        
        # Show on screen
        grep "LaTeX Warning.*undefined" "$log_file" 2>/dev/null | while read line; do
            echo "   $line" >&2
        done
    fi
    
    # Check for missing packages
    if grep -q "File.*not found" "$log_file" 2>/dev/null; then
        echo "📦 Missing Files/Packages:" >&2
        echo "MISSING FILES/PACKAGES:" >> "$error_log"
        echo "----------------------" >> "$error_log"
        grep "File.*not found" "$log_file" >> "$error_log" 2>/dev/null
        echo "" >> "$error_log"
        has_errors=true
        
        # Show on screen
        grep "File.*not found" "$log_file" 2>/dev/null | while read line; do
            echo "   $line" >&2
        done
    fi
    
    # Check for overfull/underfull boxes (common formatting issues)
    if grep -q "Overfull\\|Underfull" "$log_file" 2>/dev/null; then
        echo "FORMATTING WARNINGS:" >> "$error_log"
        echo "-------------------" >> "$error_log"
        grep "Overfull\\|Underfull" "$log_file" | head -10 >> "$error_log" 2>/dev/null
        echo "" >> "$error_log"
    fi
    
    # General warnings
    if grep -q "LaTeX Warning" "$log_file" 2>/dev/null; then
        echo "OTHER WARNINGS:" >> "$error_log"
        echo "--------------" >> "$error_log"
        grep "LaTeX Warning" "$log_file" | head -10 >> "$error_log" 2>/dev/null
        echo "" >> "$error_log"
    fi
    
    if [ "$has_errors" = true ]; then
        echo "" >&2
        echo "📄 Full error details saved to: $error_log" >&2
        echo "💡 Common fixes:" >&2
        echo "   • Check line numbers mentioned in errors" >&2
        echo "   • Verify all packages are installed" >&2
        echo "   • Check for typos in commands" >&2
        echo "   • Make sure all braces {} are balanced" >&2
        return 1
    else
        echo "✅ No critical errors found" >&2
        return 0
    fi
}

# Function to organize output files
organize_output_files() {
    local base_name="$1"
    
    # Move log files to logs directory
    if [ -f "$OUTPUT_DIR/$base_name.log" ]; then
        mv "$OUTPUT_DIR/$base_name.log" "$LOGS_DIR/"
    fi
    
    if [ -f "$OUTPUT_DIR/$base_name.aux" ]; then
        mv "$OUTPUT_DIR/$base_name.aux" "$LOGS_DIR/"
    fi
    
    if [ -f "$OUTPUT_DIR/$base_name.out" ]; then
        mv "$OUTPUT_DIR/$base_name.out" "$LOGS_DIR/"
    fi
    
    if [ -f "$OUTPUT_DIR/$base_name.toc" ]; then
        mv "$OUTPUT_DIR/$base_name.toc" "$LOGS_DIR/"
    fi
    
    if [ -f "$OUTPUT_DIR/$base_name.lof" ]; then
        mv "$OUTPUT_DIR/$base_name.lof" "$LOGS_DIR/"
    fi
    
    if [ -f "$OUTPUT_DIR/$base_name.lot" ]; then
        mv "$OUTPUT_DIR/$base_name.lot" "$LOGS_DIR/"
    fi
    
    # Keep only PDF in output directory
    echo "📁 Organized output:"
    if [ -f "$OUTPUT_DIR/$base_name.pdf" ]; then
        echo "   📄 PDF: $OUTPUT_DIR/$base_name.pdf"
    fi
    if [ -f "$LOGS_DIR/$base_name.log" ]; then
        echo "   📋 Logs: $LOGS_DIR/$base_name.*"
    fi
}

# Method 1: Local pdflatex (primary method with full MacTeX)
if command -v pdflatex &> /dev/null; then
    echo "🔧 Using local pdflatex..."
    
    # Compile with source and output directories
    # Use -output-directory for output, but need to handle source path properly
    cd "$SOURCE_DIR"
    
    # Create temporary log file for better error handling
    TEMP_LOG="../$LOGS_DIR/${BASE_NAME}_compile.log"
    
    echo "📝 Running pdflatex..."
    pdflatex -interaction=nonstopmode -output-directory="../$OUTPUT_DIR" "$TEX_FILE" > "$TEMP_LOG" 2>&1
    COMPILE_EXIT_CODE=$?
    
    cd ..
    
    PDF_OUTPUT="$OUTPUT_DIR/$BASE_NAME.pdf"
    LOG_OUTPUT="$LOGS_DIR/$BASE_NAME.log"
    
    # Organize output files (move logs to logs directory)
    organize_output_files "$BASE_NAME"
    
    # Check if compilation was successful
    if [ $COMPILE_EXIT_CODE -eq 0 ] && [ -f "$PDF_OUTPUT" ] && [ -s "$PDF_OUTPUT" ]; then
        # Verify it's actually a PDF
        if file "$PDF_OUTPUT" | grep -q "PDF document"; then
            echo "✅ PDF generated successfully with local pdflatex!"
            echo "📄 Input: $SOURCE_PATH"
            echo "📄 PDF: $PDF_OUTPUT"
            echo "📄 PDF size: $(wc -c < "$PDF_OUTPUT") bytes"
            
            # Check for warnings even in successful compilation
            if [ -f "$LOG_OUTPUT" ]; then
                WARNING_COUNT=$(grep -c "LaTeX Warning" "$LOG_OUTPUT" 2>/dev/null || echo "0")
                if [ "$WARNING_COUNT" -gt 0 ]; then
                    echo "⚠️  Compiled successfully but with $WARNING_COUNT warning(s)"
                    echo "📄 Check warnings in: $LOG_OUTPUT"
                fi
            fi
            
            echo
            echo "🔄 Git workflow:"
            echo "   git add . && git commit -m 'Update $BASE_NAME' && git push"
            echo
            exit 0
        fi
    fi
    
    # Compilation failed - extract and show errors
    echo "❌ Compilation failed!"
    echo
    
    # Try to extract errors from the log file
    if [ -f "$LOG_OUTPUT" ]; then
        extract_latex_errors "$LOG_OUTPUT" "$ERROR_LOG"
    elif [ -f "$TEMP_LOG" ]; then
        echo "📄 Raw compilation output:"
        echo "=========================="
        tail -20 "$TEMP_LOG"
        echo
        echo "📄 Full output saved to: $TEMP_LOG"
    fi
    
    echo
    echo "🔧 Troubleshooting steps:"
    echo "1. Check the error details above"
    echo "2. Open $SOURCE_PATH and look at the mentioned line numbers"
    echo "3. Run: cat $ERROR_LOG (if exists) for detailed error analysis"
    echo "4. Common issues:"
    echo "   • Missing packages: Install with 'tlmgr install <package>'"
    echo "   • Syntax errors: Check braces, commands, and special characters"
    echo "   • File not found: Verify file paths and references"
    
    # Clean up failed PDF
    rm -f "$PDF_OUTPUT"
fi

echo "❌ All compilation methods failed!"
echo
echo "📝 Manual options:"
echo "1. Run: cd $SOURCE_DIR && pdflatex -output-directory=../$OUTPUT_DIR $TEX_FILE"
echo "2. Use Overleaf: https://overleaf.com"
echo "3. Check LaTeX installation: which pdflatex"
exit 1 