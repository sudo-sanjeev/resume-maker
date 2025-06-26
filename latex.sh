#!/bin/bash

# LaTeX Multi-File Manager
# Master script for compiling and watching LaTeX files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="resume"

show_help() {
    echo "🚀 LaTeX Multi-File Manager"
    echo "=========================="
    echo
    echo "Usage:"
    echo "  $0 compile [filename.tex]    - Compile once"
    echo "  $0 watch [filename.tex]      - Watch and auto-compile" 
    echo "  $0 list                      - List all .tex files"
    echo "  $0 clean                     - Clean output directory"
    echo "  $0 help                      - Show this help"
    echo
    echo "Examples:"
    echo "  $0 compile resume.tex        - Compile resume.tex"
    echo "  $0 watch cover-letter.tex    - Watch cover-letter.tex"
    echo "  $0 compile                   - Compile resume.tex (default)"
    echo
    echo "📁 All PDFs are saved to: $OUTPUT_DIR/"
}

list_tex_files() {
    echo "📄 Available LaTeX files:"
    echo "========================"
    
    if ls *.tex 1> /dev/null 2>&1; then
        for file in *.tex; do
            if [ -f "$file" ]; then
                size=$(wc -l < "$file")
                echo "  📝 $file ($size lines)"
            fi
        done
    else
        echo "  ❌ No .tex files found in current directory"
    fi
    
    echo
    echo "📁 Generated PDFs:"
    echo "================="
    
    if [ -d "$OUTPUT_DIR" ] && ls "$OUTPUT_DIR"/*.pdf 1> /dev/null 2>&1; then
        for file in "$OUTPUT_DIR"/*.pdf; do
            if [ -f "$file" ]; then
                size=$(wc -c < "$file")
                echo "  📄 $(basename "$file") ($size bytes)"
            fi
        done
    else
        echo "  📂 No PDFs generated yet"
    fi
}

clean_output() {
    echo "🧹 Cleaning output directory..."
    
    if [ -d "$OUTPUT_DIR" ]; then
        # Show what files will be deleted
        if ls "$OUTPUT_DIR"/* 1> /dev/null 2>&1; then
            echo "📄 Files to be removed:"
            for file in "$OUTPUT_DIR"/*; do
                if [ -f "$file" ]; then
                    echo "  🗑️  $(basename "$file")"
                fi
            done
            echo
            
            # Remove all files
            rm -rf "$OUTPUT_DIR"/*
            echo "✅ Cleaned $OUTPUT_DIR/"
            
            # Verify cleanup
            if ls "$OUTPUT_DIR"/* 1> /dev/null 2>&1; then
                echo "⚠️  Warning: Some files may not have been removed"
                ls -la "$OUTPUT_DIR"/
            else
                echo "🎯 All files successfully removed"
            fi
        else
            echo "📂 $OUTPUT_DIR/ is already empty"
        fi
    else
        echo "📂 Output directory doesn't exist"
        echo "💡 Run a compile command first to create it"
    fi
}

# Main command handling
case "$1" in
    "compile"|"c")
        TEX_FILE=${2:-resume.tex}
        echo "🔧 Compiling: $TEX_FILE"
        ./compile.sh "$TEX_FILE"
        ;;
    "watch"|"w")
        TEX_FILE=${2:-resume.tex}  
        echo "👀 Watching: $TEX_FILE"
        ./watch-compile.sh "$TEX_FILE"
        ;;
    "list"|"ls")
        list_tex_files
        ;;
    "clean")
        clean_output
        ;;
    "help"|"--help"|"-h"|"")
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo "💡 Run '$0 help' for usage information"
        exit 1
        ;;
esac 