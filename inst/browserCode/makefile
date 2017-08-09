build: webpack assemble buildPackage installPackage

assemble:
	(cd ./dist; m4 -P template.html-template > template.html)
	ls -l ./dist/template.html

buildPackage:
	(cd ../../..; R CMD build --no-build-vignettes BrowserVizTemplate)

installPackage:
	(cd ../../..; R CMD INSTALL `ls -at BrowserVizTemplate_* | head -1`)

webpack:
	npm update
	webpack

test:
	(cd ./dist; pwd)

all: clean install run

clean:
	- rm -rf dist/
	- rm -rf node_modules

install:
	npm install
