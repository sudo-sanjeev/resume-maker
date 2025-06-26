#!/bin/bash

echo "🔍 LaTeX Live Preview Compiler"
echo "=============================="
echo "👀 Watching resume.tex for changes..."
echo "📄 PDF will auto-update on save"
echo "🛑 Press Ctrl+C to stop"
echo

# Compile once initially
./compile.sh


# Function to compile and show status
compile_and_notify() {
    echo
    echo "🔄 Change detected at $(date '+%H:%M:%S')"
    echo "📝 Recompiling..."
    
    if ./compile.sh > /dev/null 2>&1; then
        echo "✅ PDF updated successfully!"
    else
        echo "❌ Compilation failed - check errors"
    fi
    echo "👀 Watching for more changes..."
}

# Watch for file changes using fswatch (install if needed)
if command -v fswatch &> /dev/null; then
    echo "🎯 Using fswatch for file monitoring..."
    fswatch -o resume.tex | while read f; do
        compile_and_notify
    done
else
    echo "📥 Installing fswatch for better file watching..."
    brew install fswatch
    echo "🎯 Starting file monitor..."
    fswatch -o resume.tex | while read f; do
        compile_and_notify
    done
fi
