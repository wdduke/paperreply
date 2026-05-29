@echo off
setlocal
cd /d "%~dp0"

for /r %%F in (*.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.out *.run.xml *.synctex.gz *.toc *.xdv *.lof *.lot *.nav *.snm) do (
  del /f /q "%%F" >nul 2>nul
)

if exist build (
  for /r build %%F in (*.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.out *.run.xml *.synctex.gz *.toc *.xdv *.lof *.lot *.nav *.snm) do (
    del /f /q "%%F" >nul 2>nul
  )
)

echo LaTeX intermediate files removed.
