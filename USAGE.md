# 🚀 Enhanced Multi-File LaTeX System with Source Organization

## Overview
Your LaTeX system now supports multiple `.tex` files with organized source management. All source files go in the `src/` folder, and all PDFs are generated in the `resume/` folder for maximum organization.

## Quick Start

### Master Command: `./latex.sh`
```bash
./latex.sh help                    # Show all options
./latex.sh list                    # List all .tex files and PDFs
./latex.sh compile [filename.tex]  # Compile once
./latex.sh watch [filename.tex]    # Watch and auto-compile
./latex.sh clean                   # Clean output folder
```

## Usage Examples

### Compile Different Files
```bash
./latex.sh compile resume.tex          # Compile resume.tex from src/
./latex.sh compile cover-letter.tex    # Compile cover-letter.tex from src/
./latex.sh compile                     # Compile resume.tex (default)
```

### Watch Mode (Auto-compile on save)
```bash
./latex.sh watch resume.tex            # Watch src/resume.tex
./latex.sh watch cover-letter.tex      # Watch src/cover-letter.tex
./latex.sh watch                       # Watch src/resume.tex (default)
```

### File Management
```bash
./latex.sh list                        # See all files and PDFs
./latex.sh clean                       # Clean output directory
```

## Organized File Structure
```
resume-project/
├── src/                         # 📁 SOURCE FILES
│   ├── resume.tex              #     Your LaTeX files go here
│   ├── cover-letter.tex        #     (example additional file)
│   └── research-paper.tex      #     (any .tex files)
├── resume/                     # 📁 GENERATED FILES
│   ├── resume.pdf             #     All PDFs
│   ├── resume.aux             #     Auxiliary files
│   ├── resume.log             #     Log files
│   └── cover-letter.pdf       #     Multiple PDFs supported
├── latex.sh                    # 🚀 Master command
├── compile.sh                  # Enhanced compiler
└── watch-compile.sh            # Enhanced watcher
```

## Workflow Examples

### Working on Resume
```bash
# Edit src/resume.tex in Cursor
./latex.sh watch resume.tex

# Save file → PDF auto-compiles → PDF auto-opens in Cursor
# Generated: resume/resume.pdf
```

### Working on Cover Letter
```bash
# Create src/cover-letter.tex
./latex.sh watch cover-letter.tex

# Edit src/cover-letter.tex
# Save → compile → open in Cursor
# Generated: resume/cover-letter.pdf
```

### Multiple Projects
```bash
# List all source files and outputs
./latex.sh list

# Compile specific files
./latex.sh compile resume.tex
./latex.sh compile cover-letter.tex

# All sources in src/, all PDFs in resume/
```

## Key Features

### ✅ **Organized Source Management**
- All `.tex` files go in `src/` folder
- Clean project root directory
- Easy to find and manage source files

### ✅ **Multi-File Support**
- Work with any `.tex` file in `src/`
- Default to `resume.tex` if no file specified
- Each file generates its own PDF in `resume/`

### ✅ **Separated Output**
- All PDFs and auxiliary files go to `resume/` folder
- Keeps sources and outputs completely separate
- Easy to clean up generated files

### ✅ **Smart Compilation**
- Automatic source directory detection
- Error checking for missing files and directories
- Clear feedback about file locations

### ✅ **Auto-Preview in Cursor**
- PDFs open in Cursor (not system viewer)
- Works with PDF Preview extension
- Automatic refresh on file changes

## Migration and Setup

### Setting Up Source Directory
```bash
mkdir src                           # Create source directory
mv *.tex src/                      # Move existing .tex files
./latex.sh list                    # Verify setup
```

### New Project Structure
```bash
# Old way (files scattered):
resume.tex, cover-letter.tex, resume.pdf, resume.aux, etc.

# New organized way:
src/resume.tex, src/cover-letter.tex
resume/resume.pdf, resume/cover-letter.pdf, resume/*.aux
```

## Tips

1. **Use `./latex.sh list`** to see your organized project structure  
2. **Sources in `src/`** - all your `.tex` files go here
3. **Outputs in `resume/`** - all PDFs and auxiliary files here
4. **Default filename is `resume.tex`** - you can omit it
5. **Use short commands:** `./latex.sh c` for compile, `./latex.sh w` for watch
6. **Clean up outputs:** `./latex.sh clean` (sources remain untouched)

## Project Benefits

🎯 **Perfect Organization:** Sources and outputs completely separated  
📁 **Clean Structure:** Easy to navigate and maintain  
🚀 **Scalable:** Add unlimited `.tex` files to `src/`  
🧹 **Easy Cleanup:** Clean outputs without touching sources  
⚡ **Fast Development:** Same workflow, better organization  

Perfect for: Resumes, cover letters, reports, presentations, academic papers! 