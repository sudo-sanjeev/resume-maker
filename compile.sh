#!/bin/bash

echo "🚀 LaTeX Resume Compiler"
echo "======================="
echo "📄 Compiling resume.tex..."
echo

# Method 1: Local pdflatex (primary method with full MacTeX)
if command -v pdflatex &> /dev/null; then
    echo "🔧 Using local pdflatex..."
    pdflatex -interaction=nonstopmode resume.tex
    if [ $? -eq 0 ] && [ -f "resume.pdf" ] && [ -s "resume.pdf" ]; then
        # Verify it's actually a PDF
        if file resume.pdf | grep -q "PDF document"; then
            echo "✅ PDF generated successfully with local pdflatex!"
            echo "📄 PDF size: $(wc -c < resume.pdf) bytes"
            echo
            echo "🔄 Git workflow:"
            echo "   git add . && git commit -m 'Update resume' && git push"
            echo
            exit 0
        fi
    fi
    echo "❌ Local compilation failed"
    rm -f resume.pdf
fi

echo "❌ All compilation methods failed!"
echo
echo "📝 Manual options:"
echo "1. Run: pdflatex resume.tex"
echo "2. Use Overleaf: https://overleaf.com"
echo "3. Check LaTeX installation: which pdflatex" 