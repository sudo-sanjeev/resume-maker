# 🚀 Enhanced Multi-File LaTeX System

## Overview
Your LaTeX system now supports multiple `.tex` files with organized output management. All PDFs are generated in the `resume/` folder to keep your project organized.

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
./latex.sh compile resume.tex          # Compile resume
./latex.sh compile cover-letter.tex    # Compile cover letter
./latex.sh compile                     # Compile resume.tex (default)
```

### Watch Mode (Auto-compile on save)
```bash
./latex.sh watch resume.tex            # Watch resume.tex
./latex.sh watch cover-letter.tex      # Watch cover letter
./latex.sh watch                       # Watch resume.tex (default)
```

### File Management
```bash
./latex.sh list                        # See all files and PDFs
./latex.sh clean                       # Clean output directory
```

## File Structure
```
resume-project/
├── resume.tex                    # Your LaTeX files
├── cover-letter.tex             # (example additional file)
├── resume/                      # 📁 All PDFs go here
│   ├── resume.pdf
│   └── cover-letter.pdf
├── latex.sh                     # 🚀 Master command
├── compile.sh                   # Enhanced compiler
└── watch-compile.sh             # Enhanced watcher
```

## Workflow Examples

### Working on Resume
```bash
# Start watching
./latex.sh watch resume.tex

# Edit resume.tex in Cursor
# Save file → PDF auto-compiles → PDF auto-opens in Cursor
```

### Working on Cover Letter
```bash
# Create cover-letter.tex
# Start watching
./latex.sh watch cover-letter.tex

# Edit cover-letter.tex
# Save → compile → open in Cursor
```

### Multiple Projects
```bash
# List all files
./latex.sh list

# Compile specific file
./latex.sh compile resume.tex
./latex.sh compile cover-letter.tex

# All PDFs organized in resume/ folder
```

## Key Features

### ✅ **Multi-File Support**
- Work with any `.tex` file
- Default to `resume.tex` if no file specified
- Each file generates its own PDF

### ✅ **Organized Output**
- All PDFs go to `resume/` folder
- Keeps your project root clean
- Easy to find generated files

### ✅ **Smart Compilation**
- Error checking for missing files
- Clear feedback and file paths
- Automatic output directory creation

### ✅ **Auto-Preview in Cursor**
- PDFs open in Cursor (not system viewer)
- Works with PDF Preview extension
- Automatic refresh on file changes

## Migration from Old System

### Old Way:
```bash
./compile.sh                    # Only worked with resume.tex
./watch-compile.sh              # Only watched resume.tex
```

### New Way:
```bash
./latex.sh compile [filename]   # Works with any .tex file
./latex.sh watch [filename]     # Watches any .tex file
```

## Tips

1. **Use `./latex.sh list`** to see all your files and PDFs
2. **PDFs are in `resume/` folder** - not in project root
3. **Default filename is `resume.tex`** - you can omit it
4. **Use short commands:** `./latex.sh c` for compile, `./latex.sh w` for watch
5. **Clean up with:** `./latex.sh clean`

🎯 **Perfect for:** Resumes, cover letters, reports, presentations - any LaTeX project! 