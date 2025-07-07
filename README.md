# 📄 Resume Maker

Professional LaTeX resume template with automated compilation, organized error logging, and Git version control. Create beautiful, ATS-friendly resumes with ease!

## 🚀 Quick Start

### **1. Setup Your Resume**
```bash
# Copy the template to create your personal resume
cp src/resume-template.tex src/resume.tex

# Edit with your information
nano src/resume.tex  # or use your preferred editor
```

### **2. Compile Your Resume**
```bash
./compile.sh resume.tex
# or
./latex.sh compile resume.tex
```

### **3. Watch for Changes (Auto-compile)**
```bash
./latex.sh watch resume.tex
# Auto-recompiles when you save changes
```

### **4. View Errors (if compilation fails)**
```bash
./latex.sh errors resume.tex
# Shows detailed error analysis
```

## 📁 Project Structure

```
resume-maker/
├── src/                    # 📝 LaTeX source files
│   ├── resume-template.tex # Template with placeholder content
│   ├── resume.tex         # Your personal resume (create from template)
│   └── deedy-resume-reversed.cls  # Resume template class
├── resume/                 # 📄 Generated PDFs
│   └── resume.pdf         # Final resume output
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

- **🎯 Professional Template**: Clean, modern design optimized for ATS systems
- **📝 Easy Customization**: Simple LaTeX structure with clear sections
- **🔧 Automated Compilation**: Smart scripts handle all LaTeX complexity
- **🎯 Organized Error Logging**: All errors automatically saved to `logs/` folder
- **🔍 Structured Error Analysis**: Easy-to-read error categorization
- **🧹 Automatic File Organization**: No stray .aux/.log files cluttering your workspace
- **👀 Live Watching**: Auto-recompile when files change
- **📋 Multi-file Support**: Compile different documents
- **🚨 No Silent Errors**: All errors are captured and displayed
- **📁 Clean Project Structure**: Each directory has a clear purpose

## 🎯 Template Features

The resume template includes:
- **Modern Design**: Clean, professional layout
- **ATS Optimized**: Structured for Applicant Tracking Systems
- **Two-Column Layout**: Efficient use of space
- **Multiple Sections**: Experience, Skills, Education, Achievements, Links
- **Easy Customization**: Clear placeholder text for all sections
- **Professional Typography**: Uses XeLaTeX for beautiful fonts

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

## 📋 Prerequisites

- **XeLaTeX**: Required for compilation
  ```bash
  # macOS
  brew install --cask mactex
  
  # Ubuntu/Debian
  sudo apt-get install texlive-xetex
  
  # Windows
  # Install MiKTeX or TeX Live
  ```

## 🚨 Important Notes

- **✅ Always use the provided scripts** (`./compile.sh` or `./latex.sh`)
- **❌ Never run `xelatex` or `pdflatex` directly** (creates stray files)
- **📋 All error logs are in `logs/` folder** for easy debugging
- **📄 Only PDFs are kept in `resume/` folder**
- **🔒 Keep personal resume.tex private** (add to .gitignore if forking)

## 🔧 Getting Started

1. **Clone this repository**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/resume-maker.git
   cd resume-maker
   ```

2. **Create your personal resume**:
   ```bash
   cp src/resume-template.tex src/resume.tex
   ```

3. **Edit your resume**: 
   ```bash
   nano src/resume.tex  # Replace placeholders with your information
   ```

4. **Compile**: 
   ```bash
   ./latex.sh compile resume.tex
   ```

5. **Check output**: 
   ```bash
   open resume/resume.pdf  # macOS
   xdg-open resume/resume.pdf  # Linux
   ```

6. **If errors occur**: 
   ```bash
   ./latex.sh errors resume.tex
   ```

## 🤝 Contributing

Feel free to:
- Report bugs or issues
- Suggest improvements to the template
- Add new features to the compilation scripts
- Share your customizations

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Acknowledgments

- Based on the [Deedy Resume Template](https://github.com/deedy/Deedy-Resume)
- Thanks to all contributors and users of this template

---

**⭐ Star this repository if it helped you create a great resume!**
