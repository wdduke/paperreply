@echo off
setlocal
cd /d "%~dp0"

if not exist build mkdir build

set XELATEX=xelatex -interaction=nonstopmode -halt-on-error

echo Building main.tex...
%XELATEX% -output-directory=build main.tex || exit /b 1
%XELATEX% -output-directory=build main.tex || exit /b 1

echo Building examples/legacy-referee1-response.tex...
pushd examples
%XELATEX% "-output-directory=../build" legacy-referee1-response.tex || (popd & exit /b 1)
%XELATEX% "-output-directory=../build" legacy-referee1-response.tex || (popd & exit /b 1)
popd

echo Building examples/minimal.tex...
pushd examples
%XELATEX% "-output-directory=../build" minimal.tex || (popd & exit /b 1)
%XELATEX% "-output-directory=../build" minimal.tex || (popd & exit /b 1)
popd

echo Building examples/blank-template.tex...
pushd examples
%XELATEX% "-output-directory=../build" blank-template.tex || (popd & exit /b 1)
%XELATEX% "-output-directory=../build" blank-template.tex || (popd & exit /b 1)
popd

echo Building tests/math-response-test.tex...
pushd tests
%XELATEX% "-output-directory=../build" math-response-test.tex || (popd & exit /b 1)
%XELATEX% "-output-directory=../build" math-response-test.tex || (popd & exit /b 1)
popd

echo Build finished.
