#!/bin/bash

# LaTeX Multi-File Manager with Source Organization and Separated Output
# Master script for compiling and watching LaTeX files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="src"
OUTPUT_DIR="resume"
LOGS_DIR="logs"

show_help() {
    echo "🚀 LaTeX Multi-File Manager"
    echo "=========================="
    echo
    echo "Usage:"
    echo "  $0 compile [filename.tex]    - Compile once"
    echo "  $0 watch [filename.tex]      - Watch and auto-compile" 
    echo "  $0 list                      - List all .tex files"
    echo "  $0 clean                     - Clean output directory"
    echo "  $0 errors [filename.tex]     - Show recent errors for file"
    echo "  $0 help                      - Show this help"
    echo
    echo "Examples:"
    echo "  $0 compile resume.tex        - Compile resume.tex"
    echo "  $0 watch cover-letter.tex    - Watch cover-letter.tex"
    echo "  $0 errors resume.tex         - Show errors from last compile"
    echo "  $0 compile                   - Compile resume.tex (default)"
    echo
    echo "📁 Source files: $SOURCE_DIR/"
    echo "📁 Generated PDFs: $OUTPUT_DIR/"
    echo "📁 Log files: $LOGS_DIR/"
}

list_tex_files() {
    echo "📄 Available LaTeX files:"
    echo "========================"
    
    if [ -d "$SOURCE_DIR" ] && ls "$SOURCE_DIR"/*.tex 1> /dev/null 2>&1; then
        for file in "$SOURCE_DIR"/*.tex; do
            if [ -f "$file" ]; then
                size=$(wc -l < "$file")
                echo "  📝 $(basename "$file") ($size lines)"
            fi
        done
    else
        echo "  ❌ No .tex files found in $SOURCE_DIR/"
        if [ ! -d "$SOURCE_DIR" ]; then
            echo "  💡 Create source directory: mkdir $SOURCE_DIR"
            echo "  💡 Move your .tex files to: $SOURCE_DIR/"
        fi
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
    
    echo
    echo "📋 Log Files:"
    echo "============"
    
    if [ -d "$LOGS_DIR" ] && ls "$LOGS_DIR"/* 1> /dev/null 2>&1; then
        local log_count=0
        for file in "$LOGS_DIR"/*; do
            if [ -f "$file" ]; then
                log_count=$((log_count + 1))
            fi
        done
        echo "  📋 $log_count log files in $LOGS_DIR/"
        
        # Show recent error logs if any
        if ls "$LOGS_DIR"/*_errors.log 1> /dev/null 2>&1; then
            echo "  🔍 Recent error analyses:"
            for file in "$LOGS_DIR"/*_errors.log; do
                if [ -f "$file" ]; then
                    echo "     📋 $(basename "$file")"
                fi
            done
        fi
    else
        echo "  📂 No log files yet"
    fi
    
    echo
    echo "📊 Project Structure:"
    echo "===================="
    echo "  📁 $SOURCE_DIR/     - LaTeX source files (.tex)"
    echo "  📁 $OUTPUT_DIR/     - Generated PDFs only"
    echo "  📁 $LOGS_DIR/       - All log and auxiliary files"
}

clean_output() {
    echo "🧹 Cleaning output directories..."
    
    local files_removed=false
    
    # Clean PDF output directory
    if [ -d "$OUTPUT_DIR" ]; then
        if ls "$OUTPUT_DIR"/* 1> /dev/null 2>&1; then
            echo "📄 PDFs to be removed:"
            for file in "$OUTPUT_DIR"/*; do
                if [ -f "$file" ]; then
                    echo "  🗑️  $(basename "$file")"
                    files_removed=true
                fi
            done
            rm -rf "$OUTPUT_DIR"/*
        else
            echo "📂 $OUTPUT_DIR/ is already empty"
        fi
    fi
    
    # Clean logs directory
    if [ -d "$LOGS_DIR" ]; then
        if ls "$LOGS_DIR"/* 1> /dev/null 2>&1; then
            echo "📋 Log files to be removed:"
            for file in "$LOGS_DIR"/*; do
                if [ -f "$file" ]; then
                    echo "  🗑️  $(basename "$file")"
                    files_removed=true
                fi
            done
            rm -rf "$LOGS_DIR"/*
        else
            echo "📂 $LOGS_DIR/ is already empty"
        fi
    fi
    
    if [ "$files_removed" = true ]; then
        echo
        echo "✅ Cleaned both $OUTPUT_DIR/ and $LOGS_DIR/"
        echo "🎯 All generated files successfully removed"
    else
        echo "📂 Both directories are already empty"
        echo "💡 Run a compile command first to generate files"
    fi
}

show_errors() {
    local TEX_FILE=${1:-resume.tex}
    local BASE_NAME=$(basename "$TEX_FILE" .tex)
    local ERROR_LOG="$LOGS_DIR/${BASE_NAME}_errors.log"
    local COMPILE_LOG="$LOGS_DIR/${BASE_NAME}_compile.log"
    local LATEX_LOG="$LOGS_DIR/${BASE_NAME}.log"
    
    echo "🔍 Error Analysis for: $TEX_FILE"
    echo "================================"
    echo
    
    # Check for error analysis file
    if [ -f "$ERROR_LOG" ]; then
        echo "📄 Structured Error Analysis:"
        echo "=============================="
        cat "$ERROR_LOG"
        echo
    fi
    
    # Check for compile log
    if [ -f "$COMPILE_LOG" ]; then
        echo "📄 Recent Compilation Output:"
        echo "============================="
        echo "Last 30 lines of compilation:"
        tail -30 "$COMPILE_LOG"
        echo
    fi
    
    # Check for LaTeX log
    if [ -f "$LATEX_LOG" ]; then
        echo "📄 LaTeX Log Summary:"
        echo "===================="
        echo "Recent warnings and errors:"
        grep -E "(Warning|Error|!)" "$LATEX_LOG" | tail -10
        echo
        echo "💡 Full LaTeX log available at: $LATEX_LOG"
    fi
    
    # If no error files found
    if [ ! -f "$ERROR_LOG" ] && [ ! -f "$COMPILE_LOG" ] && [ ! -f "$LATEX_LOG" ]; then
        echo "📂 No error logs found for $TEX_FILE"
        echo "💡 Try compiling first: $0 compile $TEX_FILE"
        echo
        echo "📄 Available log files:"
        if ls "$LOGS_DIR"/*.log 1> /dev/null 2>&1; then
            for file in "$LOGS_DIR"/*.log; do
                echo "  📝 $(basename "$file")"
            done
        else
            echo "  📂 No log files found"
        fi
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
    "errors"|"error"|"e")
        TEX_FILE=${2:-resume.tex}
        show_errors "$TEX_FILE"
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