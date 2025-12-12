#!/bin/bash
set -euo pipefail

# Add TeX Live to PATH (ensure we point to the installed TeX Live bin)
export PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:$PATH"

mkdir -p build
chmod -R 777 build

# Compile IEEE (biblatex + biber)
echo "[build] Compiling IEEE"
latexmk -silent -file-line-error -outdir=build -xelatex main_ieee.tex

# Compile ACM (BibTeX)
echo "[build] Compiling ACM"
latexmk -silent -file-line-error -outdir=build -bibtex -xelatex main_acm.tex

# Compile APA7 (apacite + bibtex)
echo "[build] Compiling APA7"
latexmk -silent -file-line-error -outdir=build -bibtex -xelatex main_apa7.tex

# Clean auxiliary files from root directory
echo "[build] Cleaning auxiliary files"
rm -f *.aux *.bbl *.blg *.fdb_latexmk *.fls *.log *.out *.xdv *.bcf *.run.xml *.fff

# Copy PDFs to pdf/ directory with proper names
echo "[build] Copying PDFs to pdf/"
cp build/main_acm.pdf "pdf/Autogestión_SENA_Desarrollo_Full_Stack_Acelerado_mediante_Colaboración_Humano_IA_acm.pdf"
cp build/main_apa7.pdf "pdf/Autogestión_SENA_Desarrollo_Full_Stack_Acelerado_mediante_Colaboración_Humano_IA_ap7.pdf"
cp build/main_ieee.pdf "pdf/Autogestión_SENA_Desarrollo_Full_Stack_Acelerado_mediante_Colaboración_Humano_IA_ieee.pdf"
