# LaTeX Multi-File Manager with Source Organization and Separated Output
# Master script for compiling and watching LaTeX files (PowerShell version)

param(
    [string]$Command = "help",
    [string]$TexFile = "resume.tex"
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$SourceDir = "src"
$OutputDir = "resume"
$LogsDir = "logs"

function Show-Help {
    Write-Host "*** LaTeX Multi-File Manager ***" -ForegroundColor Green
    Write-Host "================================="
    Write-Host
    Write-Host "Usage:"
    Write-Host "  .\latex.ps1 compile [filename.tex]    - Compile once"
    Write-Host "  .\latex.ps1 watch [filename.tex]      - Watch and auto-compile"
    Write-Host "  .\latex.ps1 list                      - List all .tex files"
    Write-Host "  .\latex.ps1 clean                     - Clean output directory"
    Write-Host "  .\latex.ps1 errors [filename.tex]     - Show recent errors for file"
    Write-Host "  .\latex.ps1 help                      - Show this help"
    Write-Host
    Write-Host "Examples:"
    Write-Host "  .\latex.ps1 compile resume.tex        - Compile resume.tex"
    Write-Host "  .\latex.ps1 watch cover-letter.tex    - Watch cover-letter.tex"
    Write-Host "  .\latex.ps1 errors resume.tex         - Show errors from last compile"
    Write-Host "  .\latex.ps1 compile                   - Compile resume.tex (default)"
    Write-Host
    Write-Host "Source files: $SourceDir\"
    Write-Host "Generated PDFs: $OutputDir\"
    Write-Host "Log files: $LogsDir\"
    Write-Host
    Write-Host "Note: This PowerShell script looks for supporting scripts in this order:"
    Write-Host "      1. compile.ps1 / watch-compile.ps1 (PowerShell - recommended)"
    Write-Host "      2. compile.bat / watch-compile.bat (Batch files)"
    Write-Host "      3. compile.sh / watch-compile.sh (Bash via WSL or Git Bash)"
}

function Get-TexFiles {
    Write-Host "Available LaTeX files:" -ForegroundColor Yellow
    Write-Host "======================"
    
    if (Test-Path $SourceDir) {
        $texFiles = Get-ChildItem -Path $SourceDir -Filter "*.tex" -ErrorAction SilentlyContinue
        if ($texFiles) {
            foreach ($file in $texFiles) {
                $lineCount = (Get-Content $file.FullName | Measure-Object -Line).Lines
                Write-Host "  * $($file.Name) ($lineCount lines)"
            }
        } else {
            Write-Host "  [!] No .tex files found in $SourceDir\"
        }
    } else {
        Write-Host "  [!] No .tex files found in $SourceDir\"
        Write-Host "  [?] Create source directory: mkdir $SourceDir"
        Write-Host "  [?] Move your .tex files to: $SourceDir\"
    }
    
    Write-Host
    Write-Host "Generated PDFs:" -ForegroundColor Yellow
    Write-Host "==============="
    
    if (Test-Path $OutputDir) {
        $pdfFiles = Get-ChildItem -Path $OutputDir -Filter "*.pdf" -ErrorAction SilentlyContinue
        if ($pdfFiles) {
            foreach ($file in $pdfFiles) {
                $size = $file.Length
                Write-Host "  * $($file.Name) ($size bytes)"
            }
        } else {
            Write-Host "  [-] No PDFs generated yet"
        }
    } else {
        Write-Host "  [-] No PDFs generated yet"
    }
    
    Write-Host
    Write-Host "Log Files:" -ForegroundColor Yellow
    Write-Host "=========="
    
    if (Test-Path $LogsDir) {
        $logFiles = Get-ChildItem -Path $LogsDir -ErrorAction SilentlyContinue
        if ($logFiles) {
            Write-Host "  [+] $($logFiles.Count) log files in $LogsDir\"
            
            # Show recent error logs if any
            $errorLogs = Get-ChildItem -Path $LogsDir -Filter "*_errors.log" -ErrorAction SilentlyContinue
            if ($errorLogs) {
                Write-Host "  [?] Recent error analyses:"
                foreach ($file in $errorLogs) {
                    Write-Host "     * $($file.Name)"
                }
            }
        } else {
            Write-Host "  [-] No log files yet"
        }
    } else {
        Write-Host "  [-] No log files yet"
    }
    
    Write-Host
    Write-Host "Project Structure:" -ForegroundColor Yellow
    Write-Host "=================="
    Write-Host "  $SourceDir\     - LaTeX source files (.tex)"
    Write-Host "  $OutputDir\     - Generated PDFs only"
    Write-Host "  $LogsDir\       - All log and auxiliary files"
}

function Clear-OutputDirectories {
    Write-Host "Cleaning output directories..." -ForegroundColor Yellow
    
    $filesRemoved = $false
    
    # Clean PDF output directory
    if (Test-Path $OutputDir) {
        $outputFiles = Get-ChildItem -Path $OutputDir -ErrorAction SilentlyContinue
        if ($outputFiles) {
            Write-Host "PDFs to be removed:"
            foreach ($file in $outputFiles) {
                Write-Host "  [X] $($file.Name)"
                $filesRemoved = $true
            }
            Remove-Item -Path "$OutputDir\*" -Recurse -Force
        } else {
            Write-Host "[-] $OutputDir\ is already empty"
        }
    }
    
    # Clean logs directory
    if (Test-Path $LogsDir) {
        $logFiles = Get-ChildItem -Path $LogsDir -ErrorAction SilentlyContinue
        if ($logFiles) {
            Write-Host "Log files to be removed:"
            foreach ($file in $logFiles) {
                Write-Host "  [X] $($file.Name)"
                $filesRemoved = $true
            }
            Remove-Item -Path "$LogsDir\*" -Recurse -Force
        } else {
            Write-Host "[-] $LogsDir\ is already empty"
        }
    }
    
    if ($filesRemoved) {
        Write-Host
        Write-Host "[OK] Cleaned both $OutputDir\ and $LogsDir\" -ForegroundColor Green
        Write-Host "[OK] All generated files successfully removed"
    } else {
        Write-Host "[-] Both directories are already empty"
        Write-Host "[?] Run a compile command first to generate files"
    }
}

function Show-Errors {
    param([string]$TexFile = "resume.tex")
    
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($TexFile)
    $errorLog = "$LogsDir\${baseName}_errors.log"
    $compileLog = "$LogsDir\${baseName}_compile.log"
    $latexLog = "$LogsDir\${baseName}.log"
    
    Write-Host "Error Analysis for: $TexFile" -ForegroundColor Yellow
    Write-Host "============================"
    Write-Host
    
    # Check for error analysis file
    if (Test-Path $errorLog) {
        Write-Host "Structured Error Analysis:"
        Write-Host "=========================="
        Get-Content $errorLog
        Write-Host
    }
    
    # Check for compile log
    if (Test-Path $compileLog) {
        Write-Host "Recent Compilation Output:"
        Write-Host "========================="
        Write-Host "Last 30 lines of compilation:"
        Get-Content $compileLog | Select-Object -Last 30
        Write-Host
    }
    
    # Check for LaTeX log
    if (Test-Path $latexLog) {
        Write-Host "LaTeX Log Summary:"
        Write-Host "=================="
        Write-Host "Recent warnings and errors:"
        Get-Content $latexLog | Select-String -Pattern "(Warning|Error|!)" | Select-Object -Last 10
        Write-Host
        Write-Host "[?] Full LaTeX log available at: $latexLog"
    }
    
    # If no error files found
    if (!(Test-Path $errorLog) -and !(Test-Path $compileLog) -and !(Test-Path $latexLog)) {
        Write-Host "[-] No error logs found for $TexFile"
        Write-Host "[?] Try compiling first: .\latex.ps1 compile $TexFile"
        Write-Host
        Write-Host "Available log files:"
        $logFiles = Get-ChildItem -Path $LogsDir -Filter "*.log" -ErrorAction SilentlyContinue
        if ($logFiles) {
            foreach ($file in $logFiles) {
                Write-Host "  * $($file.Name)"
            }
        } else {
            Write-Host "  [-] No log files found"
        }
    }
}

# Main command handling
switch ($Command.ToLower()) {
    { $_ -in @("compile", "c") } {
        Write-Host "[+] Compiling: $TexFile" -ForegroundColor Green
        if (Test-Path "compile.ps1") {
            & ".\compile.ps1" $TexFile
        } elseif (Test-Path "compile.bat") {
            & ".\compile.bat" $TexFile
        } elseif (Test-Path "compile.sh") {
            # Try WSL first, then Git Bash
            if (Get-Command wsl -ErrorAction SilentlyContinue) {
                Write-Host "[WSL] Using WSL to run compile.sh" -ForegroundColor Cyan
                & wsl ./compile.sh $TexFile
            } elseif (Get-Command bash -ErrorAction SilentlyContinue) {
                Write-Host "[BASH] Using Git Bash to run compile.sh" -ForegroundColor Cyan
                & bash ./compile.sh $TexFile
            } else {
                Write-Host "[!] Error: compile.sh found but no bash environment available" -ForegroundColor Red
                Write-Host "[?] Install WSL or Git Bash to use .sh scripts" -ForegroundColor Yellow
            }
        } else {
            Write-Host "[!] Error: No compile script found" -ForegroundColor Red
            Write-Host "[?] Please create one of: compile.ps1, compile.bat, or compile.sh" -ForegroundColor Yellow
        }
    }
    
    { $_ -in @("watch", "w") } {
        Write-Host "[+] Watching: $TexFile" -ForegroundColor Green
        if (Test-Path "watch-compile.ps1") {
            & ".\watch-compile.ps1" $TexFile
        } elseif (Test-Path "watch-compile.bat") {
            & ".\watch-compile.bat" $TexFile
        } elseif (Test-Path "watch-compile.sh") {
            # Try WSL first, then Git Bash
            if (Get-Command wsl -ErrorAction SilentlyContinue) {
                Write-Host "[WSL] Using WSL to run watch-compile.sh" -ForegroundColor Cyan
                & wsl ./watch-compile.sh $TexFile
            } elseif (Get-Command bash -ErrorAction SilentlyContinue) {
                Write-Host "[BASH] Using Git Bash to run watch-compile.sh" -ForegroundColor Cyan
                & bash ./watch-compile.sh $TexFile
            } else {
                Write-Host "[!] Error: watch-compile.sh found but no bash environment available" -ForegroundColor Red
                Write-Host "[?] Install WSL or Git Bash to use .sh scripts" -ForegroundColor Yellow
            }
        } else {
            Write-Host "[!] Error: No watch script found" -ForegroundColor Red
            Write-Host "[?] Please create one of: watch-compile.ps1, watch-compile.bat, or watch-compile.sh" -ForegroundColor Yellow
        }
    }
    
    { $_ -in @("list", "ls") } {
        Get-TexFiles
    }
    
    "clean" {
        Clear-OutputDirectories
    }
    
    { $_ -in @("errors", "error", "e") } {
        Show-Errors $TexFile
    }
    
    { $_ -in @("help", "--help", "-h", "") } {
        Show-Help
    }
    
    default {
        Write-Host "[!] Unknown command: $Command" -ForegroundColor Red
        Write-Host "[?] Run '.\latex.ps1 help' for usage information"
        exit 1
    }
} 