# 📄 Resume Project

Professional LaTeX resume with automated compilation, organized error logging, and Git version control.

## 🚀 Quick Start

### **Compile Resume**
```bash
./compile.sh resume.tex
# or
./latex.sh compile resume.tex
```

### **Watch for Changes**
```bash
./latex.sh watch resume.tex
# Auto-recompiles when you save changes
```

### **View Errors (if compilation fails)**
```bash
./latex.sh errors resume.tex
# Shows detailed error analysis
```

## 📁 Project Structure

```
resume-project/
├── src/                    # 📝 LaTeX source files
│   ├── resume.tex         # Your resume content
│   └── deedy-resume-reversed.cls  # Resume template
├── resume/                 # 📄 Generated PDFs
│   └── resume.pdf         # Final resume
├── logs/                   # 📋 All error logs & auxiliary files
├── docs/                   # 📚 Documentation
│   ├── ERROR-LOGGING-SYSTEM.md   # Error log organization
│   ├── ERROR-DEBUGGING.md        # Debugging guide
│   └── USAGE.md                  # Detailed usage guide
├── compile.sh             # Main compilation script
├── latex.sh               # Master LaTeX manager
├── cleanup-stray-files.sh # File organization utility
└── README.md              # This file
```

## ✨ Features

- **🎯 Organized Error Logging**: All errors automatically saved to `logs/` folder
- **🔍 Structured Error Analysis**: Easy-to-read error categorization
- **🧹 Automatic File Organization**: No stray .aux/.log files
- **👀 Live Watching**: Auto-recompile when files change
- **📋 Multi-file Support**: Compile different documents
- **🚨 No Silent Errors**: All errors are captured and displayed
- **📁 Clean Project Structure**: Each directory has a clear purpose

## 📚 Documentation

- **[📋 Error Logging System](docs/ERROR-LOGGING-SYSTEM.md)** - How all errors are organized
- **[🔍 Error Debugging Guide](docs/ERROR-DEBUGGING.md)** - Troubleshooting help
- **[📖 Usage Guide](docs/USAGE.md)** - Detailed instructions

## 🛠️ Commands

| Command | Description |
|---------|-------------|
| `./latex.sh compile [file.tex]` | Compile once |
| `./latex.sh watch [file.tex]` | Watch and auto-compile |
| `./latex.sh errors [file.tex]` | View error analysis |
| `./latex.sh list` | Show all files |
| `./latex.sh clean` | Clean generated files |
| `./cleanup-stray-files.sh` | Organize stray files |

## 🚨 Important Notes

- **✅ Always use the provided scripts** (`./compile.sh` or `./latex.sh`)
- **❌ Never run `xelatex` or `pdflatex` directly** (creates stray files)
- **📋 All error logs are in `logs/` folder** for easy debugging
- **📄 Only PDFs are kept in `resume/` folder**

## 🔧 Getting Started

1. **Edit your resume**: `src/resume.tex`
2. **Compile**: `./latex.sh compile resume.tex`
3. **Check output**: `resume/resume.pdf`
4. **If errors**: `./latex.sh errors resume.tex`
5. **Commit changes**: `git add . && git commit -m "Update resume"`
