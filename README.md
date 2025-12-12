# "Autogestión SENA": Artículo de Investigación (LaTeX)

Este repositorio contiene el código fuente y los recursos para generar el artículo de investigación **"Autogestión SENA: Desarrollo Full-Stack Acelerado mediante Colaboración Humano-IA"** en tres formatos académicos estándar: **IEEE**, **ACM** y **APA7**.

El proyecto utiliza **Docker** para encapsular todo el entorno de LaTeX, por lo que no necesitas instalar nada complejo en tu máquina local.

## 🚀 Guía Rápida de Generación (Windows)

Si estás en Windows y tienes Docker Desktop instalado y corriendo:

1.  Abre una terminal (PowerShell o CMD) en la carpeta raíz del proyecto.
2.  Ejecuta el siguiente comando:
    ```powershell
    .\compile.bat
    ```
3.  ¡Listo! Los archivos PDF generados aparecerán en la carpeta `build/`:
    - `main_ieee.pdf`
    - `main_acm.pdf`
    - `main_apa7.pdf`

> **Nota:** La primera vez que lo ejecutes, tardará unos minutos en descargar la imagen de Docker (~4-6 GB). Las siguientes veces será mucho más rápido.

## 📋 Requisitos Previos

- **Docker Desktop**: Debe estar instalado y ejecutándose. [Descargar aquí](https://www.docker.com/products/docker-desktop/).
- **Conexión a Internet**: Necesaria para descargar la imagen de Docker y paquetes LaTeX la primera vez.

## 🛠️ Comandos Manuales (Docker Compose)

Si prefieres usar comandos de Docker directamente o estás en Linux/macOS:

1.  **Construir la imagen** (solo necesario la primera vez):
    ```bash
    docker compose build latex
    ```

2.  **Compilar los documentos**:
    ```bash
    docker compose run --rm latex
    ```

3.  **Limpiar archivos temporales** (opcional):
    Si quieres una compilación limpia desde cero, borra el contenido de la carpeta `build/` antes de compilar.

## 📂 Estructura del Proyecto

El contenido del artículo está separado del formato para facilitar la edición:

- **`sections/`**: Aquí está el **texto del artículo**.
  - `00_abstract.tex`: Resumen.
  - `01_introduccion.tex` a `07_conclusiones.tex`: Capítulos del artículo.
  - `A1_apendices.tex`: Apéndices (tablas extra, gráficas).
- **`bibliography/references.bib`**: Archivo de referencias bibliográficas.
- **`tables/`**: Archivos `.tex` que contienen tablas complejas.
- **`graphics/`**: Imágenes y gráficas (PDF, PNG, JPG).
- **`main_*.tex`**: Archivos principales que definen el formato (IEEE, ACM, APA). Aquí se editan el **título** y los **autores**.

## ✏️ Cómo Editar

1.  **Contenido**: Modifica los archivos en la carpeta `sections/`. Los cambios se reflejarán en los tres formatos (IEEE, ACM, APA) automáticamente al recompilar.
2.  **Autores/Título**:
    - Para **IEEE**: Edita `main_ieee.tex`.
    - Para **ACM**: Edita `main_acm.tex`.
    - Para **APA**: Edita `main_apa7.tex`.
3.  **Referencias**: Agrega tus citas en formato BibTeX en `bibliography/references.bib`.

## 📊 Gráficas y Tablas

### Generar Gráficas
El proyecto incluye scripts en Python para generar gráficas vectoriales de alta calidad.
```bash
python code/generate_figures.py
```
Las gráficas resultantes se guardan en `graphics/`.

### Consejos de Formato
- **IEEE (Doble columna)**: Las imágenes no deben superar `width=0.48\textwidth`.
- **ACM/APA (Una columna)**: Las imágenes pueden ser más grandes, hasta `width=0.7\textwidth`.

## ❓ Solución de Problemas

- **Error "Docker daemon is not running"**: Asegúrate de haber abierto Docker Desktop.
- **Errores de compilación**: Revisa el archivo `build/*.log` para ver detalles. A veces, borrar la carpeta `build` y recompilar soluciona problemas de caché.
- **Bibliografía no aparece**: Asegúrate de haber citado las referencias en el texto usando `\cite{clave}`.

---
*Repositorio generado para el proyecto de investigación Autogestión SENA - 2025.*
