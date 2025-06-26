#!/bin/bash

# Enhanced LaTeX Compiler with Multi-File Support
# Usage: ./compile.sh [filename.tex]
# Example: ./compile.sh resume.tex
#          ./compile.sh cover-letter.tex

# Get filename parameter or default to resume.tex
TEX_FILE=${1:-resume.tex}
BASE_NAME=$(basename "$TEX_FILE" .tex)
OUTPUT_DIR="resume"

echo "🚀 LaTeX Multi-File Compiler"
echo "============================"
echo "📄 Compiling: $TEX_FILE"
echo "📁 Output directory: $OUTPUT_DIR"
echo

# Check if input file exists
if [ ! -f "$TEX_FILE" ]; then
    echo "❌ Error: File '$TEX_FILE' not found!"
    echo "💡 Usage: $0 [filename.tex]"
    echo "   Example: $0 resume.tex"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Method 1: Local pdflatex (primary method with full MacTeX)
if command -v pdflatex &> /dev/null; then
    echo "🔧 Using local pdflatex..."
    
    # Compile with output directory
    pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" "$TEX_FILE"
    
    PDF_OUTPUT="$OUTPUT_DIR/$BASE_NAME.pdf"
    
    if [ $? -eq 0 ] && [ -f "$PDF_OUTPUT" ] && [ -s "$PDF_OUTPUT" ]; then
        # Verify it's actually a PDF
        if file "$PDF_OUTPUT" | grep -q "PDF document"; then
            echo "✅ PDF generated successfully with local pdflatex!"
            echo "📄 Input: $TEX_FILE"
            echo "📄 Output: $PDF_OUTPUT"
            echo "📄 PDF size: $(wc -c < "$PDF_OUTPUT") bytes"
            echo
            echo "🔄 Git workflow:"
            echo "   git add . && git commit -m 'Update $BASE_NAME' && git push"
            echo
            exit 0
        fi
    fi
    echo "❌ Local compilation failed"
    rm -f "$PDF_OUTPUT"
fi

echo "❌ All compilation methods failed!"
echo
echo "📝 Manual options:"
echo "1. Run: pdflatex -output-directory=$OUTPUT_DIR $TEX_FILE"
echo "2. Use Overleaf: https://overleaf.com"
echo "3. Check LaTeX installation: which pdflatex" 