# Plantilla LaTeX — Investigación aplicada (IEEE + ACM + APA7)

Este repositorio genera **tres PDFs** desde el mismo contenido: **IEEE**, **ACM** y **APA7**.

## Dependencias
- Docker Desktop (Windows/macOS) o Docker Engine (Linux)
- Conexión a internet (la primera vez se descargará la imagen `texlive-full`, ~6 GB)

No necesitas instalar LaTeX localmente: todo sucede dentro del contenedor.

## Estructura
```
articulo-aplicada/
  Dockerfile          docker-compose.yml   compile.bat
  latexmkrc           README.md            tools/build.sh
  main_*.tex          includes/            sections/
  bibliography/       tables/              code/
```

Las secciones (`sections/*.tex`) se **comparten** entre formatos. Cada *main* define portada y estilo.

## Uso rápido (Docker)
```powershell
# 1) Construir la imagen (solo la primera vez o tras cambios en Dockerfile)
docker compose build latex

# 2) Compilar los tres formatos mediante Docker
docker compose run --rm latex

# En Windows puedes usar el wrapper
.\\compile.bat

# Los PDFs quedan en build/
```

Si necesitas una compilación limpia, elimina el contenido de `build/` y vuelve a ejecutar el comando.

**Configuración de resaltado de código**:
- Por defecto usa `listings` (`\mintedfalse` en `includes/preamble_common.tex`)
- Para usar `minted`: cambie `\mintedfalse` → `\mintedtrue` (requiere Python + pygments)

## Rellenar metadatos
- **IEEE**: edite autores/afiliaciones en `main_ieee.tex`.
- **ACM**: complete `\author`, `\affiliation`, `\email` en `main_acm.tex`.
- **APA7**: complete `\shorttitle`, `\author`, `\affiliation` en `main_apa7.tex`.

## Bibliografía
Agregue o edite referencias en `bibliography/references.bib`.
- IEEE/APA: `biblatex` + `biber` → `\printbibliography`
- ACM: `natbib`/`BibTeX` → `\bibliographystyle{ACM-Reference-Format}` + `\bibliography{bibliography/references}`

## Licencia
Por defecto, **CC BY 4.0** (ajuste si lo desea).

## Reproducibilidad
Incluimos una **plantilla de checklist** en `sections/A1_apendices.tex` y rutas para guardar scripts/datasets en `code/`, `tables/`, `graphics/`.


## Compilación manual de PDFs (ACM y APA7)
Si el comando estándar no genera los archivos `main_acm.pdf` o `main_apa7.pdf` en la carpeta `build/`, puedes generarlos manualmente así:

1. **Para ACM:**
   - Compila normalmente (`docker compose run --rm latex`).
   - Si solo aparece `main_acm.xdv` pero no el PDF, ejecuta:
     ```powershell
     docker compose run --rm latex xdvipdfmx -o build/main_acm.pdf build/main_acm.xdv
     ```

2. **Para APA7:**
   - Ejecuta:
     ```powershell
     docker compose run --rm latex xelatex -output-directory=build main_apa7.tex
     ```
   - Si solo aparece `main_apa7.xdv` pero no el PDF, ejecuta:
     ```powershell
     docker compose run --rm latex xdvipdfmx -o build/main_apa7.pdf build/main_apa7.xdv
     ```

Esto asegura que los tres PDFs (`main_ieee.pdf`, `main_acm.pdf`, `main_apa7.pdf`) se generen correctamente en `build/`.


### Errores de compilación
- **APA7**: Puede mostrar warnings sobre definiciones duplicadas, pero genera el PDF correctamente
- **Bibliografía vacía**: Normal si no hay citas en el documento
- **Minted no disponible**: La plantilla usa `listings` automáticamente como fallback

### Forzar compilación
Si hay errores menores que no impiden la generación del PDF:
```bash
latexmk -pdfxe -shell-escape -outdir=build -f main_apa7.tex
```

## Gráficas y tablas

### Tamaños recomendados para gráficas
Para evitar que las gráficas se salgan del formato, use estos tamaños **optimizados**:

```latex
% Gráficas simples (barras, scatter)
\includegraphics[width=0.48\textwidth]{graphics/archivo.pdf}

% Gráficas complejas (radar, correlaciones)
\includegraphics[width=0.45\textwidth]{graphics/archivo.pdf}

% Gráficas de evolución temporal (líneas múltiples)
\includegraphics[width=0.5\textwidth]{graphics/archivo.pdf}

% Para formato single-column (ACM, APA7) - pueden ser más grandes
\includegraphics[width=0.7\textwidth]{graphics/archivo.pdf}

% Para formato IEEE (columna doble) - máximo recomendado
\includegraphics[width=0.48\textwidth]{graphics/archivo.pdf}
```

**Regla general**: Para IEEE (2 columnas) usar **máximo 0.5\textwidth**. Para formatos single-column (ACM/APA7) se puede usar hasta **0.7\textwidth**.

### Tablas anchas
Para tablas que exceden el ancho de página, **reduzca columnas** y use `\small`:

```latex
\begin{table}[htbp]
\centering
\caption{Título de la tabla}
\label{tab:etiqueta}
\small  % Hace el texto más pequeño
\begin{tabular}{lccc}  % Menos columnas = mejor ajuste
% contenido de la tabla
\end{tabular}
\end{table}
```

**Solo como último recurso** use `\resizebox` (puede hacer el texto ilegible):

```latex
\resizebox{\textwidth}{!}{%
\begin{tabular}{lccccc}
% contenido de la tabla
\end{tabular}%
}
```

### Generación automática de gráficas
Las gráficas se generan ejecutando:
```bash
python code/generate_figures.py
```

Esto crea archivos PDF optimizados para LaTeX en `graphics/` y archivos PNG para vista previa.

---

## Sobre este artículo

Este repositorio contiene el artículo "Autogestión SENA: Desarrollo Full-Stack Acelerado mediante Colaboración Humano-IA" en los formatos IEEE, ACM y APA7. El eje central del trabajo es el uso de la IA como herramienta de aprendizaje colaborativo durante el desarrollo de software; el repositorio incluye el caso de estudio, resultados cualitativos y consideraciones éticas. Los contenidos del artículo se encuentran en `sections/` y pueden personalizarse: actualice `sections/` y los metadatos en los archivos `main_*.tex` para poner autores y afiliaciones.

Si quieres compilar sólo la versión IEEE, ejecuta:

```powershell
latexmk -pdf -outdir=build -f main_ieee.tex
```

Para la versión APA7 (usa `biber`):

```powershell
latexmk -pdf -outdir=build -f main_apa7.tex
```

Y para ACM (BibTeX):

```powershell
latexmk -pdf -outdir=build -f main_acm.tex
```


> Este repositorio fue generado automáticamente por ChatGPT a partir del **Prompt Maestro v2** incluido en `PROMPT.md`.
