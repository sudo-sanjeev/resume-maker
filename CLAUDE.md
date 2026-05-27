# Resume-Maker — Claude Code Project Guide

## What this project is
A **LaTeX resume compiler** built around the Deedy Resume template.  
User edits `src/resume.tex` → scripts compile with XeLaTeX → PDF lands in `resume/`.

---

## 🔴 CRITICAL files (almost always what you want)

| File | Why it matters |
|------|---------------|
| `src/resume.tex` | **THE RESUME** — all personal content lives here (155 lines). Edit for content changes. |
| `src/deedy-resume-reversed.cls` | **THE TEMPLATE** — all visual styling, custom LaTeX commands, colors, fonts. Edit for look-and-feel. |
| `compile.sh` | **THE COMPILER** — core compilation logic, file organization, error extraction (301 lines). |

---

## 🟡 SECONDARY files (touch only for tooling changes)

| File | Why |
|------|-----|
| `latex.sh` | Multi-command entry-point (`compile`, `watch`, `errors`, `list`, `clean`, `help`). Edit to add new commands. |
| `watch-compile.sh` | Auto-recompile on save via `fswatch`. Edit only if watch mode breaks. |
| `cleanup-stray-files.sh` | One-off utility to sweep stray `.aux`/`.log` files into `logs/`. Rarely needed. |
| `latex.ps1` | Windows PowerShell mirror of `latex.sh`. Only relevant on Windows. |
| `.gitignore` | `src/resume.tex` is intentionally excluded from git (privacy). PDFs also excluded. |

---

## 🟢 READ-ONLY / reference files (don't edit)

| Path | What it is |
|------|-----------|
| `resume/resume.pdf` | Generated output — never edit directly, always rebuilt by compile. |
| `logs/*.log`, `logs/*.aux`, `logs/*.out` | Compiler artefacts — auto-generated, safe to delete. |
| `logs/resume_errors.log` | Structured error summary produced by `compile.sh` after each run. |
| `docs/USAGE.md` | Detailed usage guide. |
| `docs/ERROR-LOGGING-SYSTEM.md` | How the error-log system works. |
| `docs/ERROR-DEBUGGING.md` | Troubleshooting guide. |
| `README.md` | Project overview and quick-start. |

---

## Key LaTeX commands in `resume.tex`

```latex
\namesection{Firstname}{Lastname}{subtitle / links}   % header block
\section{Section Title}                               % section divider (left or right column)
\runsubsection{Company Name}                          % job/project title
\descript{| Role}                                     % role descriptor
\location{Date | Place}                               % dates / location line
\begin{tightemize} \item ... \end{tightemize}         % compact bullet list
```

Two-column layout via `\begin{minipage}` — left column is **0.60\textwidth**, right is **0.33\textwidth**.

---

## Build commands

```bash
./latex.sh compile            # compile src/resume.tex  → resume/resume.pdf
./latex.sh compile foo.tex    # compile a different .tex in src/
./latex.sh watch              # auto-compile on every save (requires fswatch)
./latex.sh errors             # print structured error summary
./latex.sh list               # show all source files and PDFs
./latex.sh clean              # remove generated files
```

Requires **XeLaTeX** (detected automatically). Install via:  
`brew install --cask mactex` (macOS) or `tlmgr install xelatex`.

---

## Directory layout (mental model)

```
src/        ← EDIT HERE   (resume.tex + .cls template)
resume/     ← READ HERE   (compiled PDF output)
logs/       ← IGNORE      (aux files, error logs — auto-managed)
docs/       ← REFERENCE   (human documentation)
*.sh        ← TOOLING     (compiler and helper scripts)
```

---

## Common tasks → files to open

| Task | File(s) to open |
|------|----------------|
| Update job experience / skills / education | `src/resume.tex` |
| Change fonts, colors, spacing | `src/deedy-resume-reversed.cls` |
| Fix a compilation error | `logs/resume_errors.log`, then `src/resume.tex` |
| Add a new latex command | `src/deedy-resume-reversed.cls` |
| Change where PDFs are saved | `compile.sh` |
| Add a new `./latex.sh` subcommand | `latex.sh` |
| Set up auto-watch | `watch-compile.sh` |
