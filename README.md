# Resume Project

Professional LaTeX resume with Git version control and Google Drive sync.

## Quick Start
1. Edit resume.tex with your information
2. Run: curl -X POST -F "filecontents=@resume.tex" -F "filename=resume.tex" https://latexonline.cc/compile -o resume.pdf
3. Open resume.pdf to review
4. Commit changes: git add . && git commit -m "Update resume"
5. Push to GitHub: git push

## Features
✅ Local editing in Cursor
✅ Online LaTeX compilation
✅ Git version control
✅ Google Drive auto-sync
✅ Separate from corporate Git config
