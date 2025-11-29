#!/bin/bash
# build_all.sh: Compila todos los PDFs (IEEE, ACM, APA7) y fuerza la conversión manual si es necesario.
set -e

echo "Compilando todos los formatos con latexmk..."
docker compose run --rm latex

# Forzar conversión manual de ACM si falta el PDF pero existe el XDV
if [ -f build/main_acm.xdv ] && [ ! -f build/main_acm.pdf ]; then
  echo "Generando main_acm.pdf manualmente..."
  docker compose run --rm latex xdvipdfmx -o build/main_acm.pdf build/main_acm.xdv
fi

# Compilar APA7 manualmente si falta el PDF
if [ ! -f build/main_apa7.pdf ]; then
  echo "Compilando main_apa7.tex manualmente..."
  docker compose run --rm latex xelatex -output-directory=build main_apa7.tex
fi
# Forzar conversión manual de APA7 si falta el PDF pero existe el XDV
if [ -f build/main_apa7.xdv ] && [ ! -f build/main_apa7.pdf ]; then
  echo "Generando main_apa7.pdf manualmente..."
  docker compose run --rm latex xdvipdfmx -o build/main_apa7.pdf build/main_apa7.xdv
fi

echo "¡Listo! Los PDFs están en build/"
