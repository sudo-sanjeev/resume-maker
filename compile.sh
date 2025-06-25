#!/bin/bash

echo "🚀 LaTeX Resume Compiler"
echo "======================="

if [ ! -f "resume.tex" ]; then
    echo "❌ resume.tex not found!"
    exit 1
fi

echo "📄 Compiling resume.tex..."
echo ""

echo "🌐 Using LaTeX Online API..."
if command -v curl &> /dev/null; then
    curl -X POST \
         -F "filecontents=@resume.tex" \
         -F "filename=resume.tex" \
         https://latexonline.cc/compile \
         -o resume.pdf
    
    if [ -f "resume.pdf" ] && [ -s "resume.pdf" ]; then
        echo "✅ PDF generated successfully!"
        open resume.pdf 2>/dev/null || echo "   PDF saved as resume.pdf"
    else
        echo "❌ PDF generation failed"
        echo "💡 Alternative: Upload to Overleaf → https://www.overleaf.com/project"
    fi
else
    echo "❌ curl not available"
    echo "💡 Upload resume.tex to Overleaf → https://www.overleaf.com/project"
fi

echo ""
echo "🔄 Git workflow:"
echo "   git add . && git commit -m 'Update resume' && git push"
