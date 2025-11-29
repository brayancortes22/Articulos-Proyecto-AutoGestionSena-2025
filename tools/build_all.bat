@echo off
REM build_all.bat: Compila todos los PDFs (IEEE, ACM, APA7) y fuerza la conversión manual si es necesario.

REM Compilar todos los formatos
call docker compose run --rm latex

REM Forzar conversión manual de ACM si falta el PDF pero existe el XDV
if exist build\main_acm.xdv if not exist build\main_acm.pdf (
    echo Generando main_acm.pdf manualmente...
    call docker compose run --rm latex xdvipdfmx -o build/main_acm.pdf build/main_acm.xdv
)

REM Compilar APA7 manualmente si falta el PDF
if not exist build\main_apa7.pdf (
    echo Compilando main_apa7.tex manualmente...
    call docker compose run --rm latex xelatex -output-directory=build main_apa7.tex
)
REM Forzar conversión manual de APA7 si falta el PDF pero existe el XDV
if exist build\main_apa7.xdv if not exist build\main_apa7.pdf (
    echo Generando main_apa7.pdf manualmente...
    call docker compose run --rm latex xdvipdfmx -o build/main_apa7.pdf build/main_apa7.xdv
)

echo ¡Listo! Los PDFs están en build\
