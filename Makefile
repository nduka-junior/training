# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    = 
SPHINXBUILD     = $(realpath bin/sphinx-build)
SPHINXAUTOBUILD = $(realpath bin/sphinx-autobuild)
PAPER         =
DOCS_DIR      = ./docs/
BUILDDIR      = ../_build/

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .


# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean build directory
	cd $(DOCS_DIR) && rm -rf $(BUILDDIR)/*

.PHONY: distclean
distclean:  ## Clean docs build directory and Python virtual environment
	cd $(DOCS_DIR) && rm -rf $(BUILDDIR)/
	rm -rf ./bin/ ./lib/ ./lib64 ./include ./pyvenv.cfg

bin/python:  ## Set up training: Install requirements
	python3 -m venv . || virtualenv --clear --python=python3 .
	bin/python -m pip install --upgrade pip
	bin/pip install -r requirements.txt
	@echo
	@echo "Installation of requirements completed."

.PHONY: html
html: bin/python  ## Build html
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

.PHONY: livehtml
livehtml: bin/python  ## Rebuild Sphinx documentation on changes, with live-reload in the browser
	cd "$(DOCS_DIR)" && $(SPHINXAUTOBUILD) \
		--ignore "*.swp" \
		-b html . "$(BUILDDIR)/html" $(SPHINXOPTS) $(O)

.PHONY: manual
manual: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b html -t manual . manual

.PHONY: presentation
presentation: bin/python  ## Build html for presentation
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b html -t presentation . $(BUILDDIR)/presentation

.PHONY: livepresentation
livepresentation: bin/python  ## Rebuild Sphinx documentation on changes, with live-reload in the browser
	cd "$(DOCS_DIR)" && $(SPHINXAUTOBUILD) \
		--ignore "*.swp" \
		-b html -t presentation . "$(BUILDDIR)/presentation" $(SPHINXOPTS) $(O)

.PHONY: dirhtml
dirhtml: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

.PHONY: singlehtml
singlehtml: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml."

.PHONY: pickle
pickle: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

.PHONY: json
json: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json
	@echo
	@echo "Build finished; now you can process the JSON files."

.PHONY: htmlhelp
htmlhelp: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $(BUILDDIR)/htmlhelp
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp."

.PHONY: qthelp
qthelp: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b qthelp $(ALLSPHINXOPTS) $(BUILDDIR)/qthelp
	@echo
	@echo "Build finished; now you can run "qcollectiongenerator" with the" \
	      ".qhcp project file in $(BUILDDIR)/qthelp, like this:"
	@echo "# qcollectiongenerator $(BUILDDIR)/qthelp/MasteringPlone.qhcp"
	@echo "To view the help file:"
	@echo "# assistant -collectionFile $(BUILDDIR)/qthelp/MasteringPlone.qhc"

.PHONY: devhelp
devhelp: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b devhelp $(ALLSPHINXOPTS) $(BUILDDIR)/devhelp
	@echo
	@echo "Build finished."
	@echo "To view the help file:"
	@echo "# mkdir -p $$HOME/.local/share/devhelp/MasteringPlone"
	@echo "# ln -s $(BUILDDIR)/devhelp $$HOME/.local/share/devhelp/MasteringPlone"
	@echo "# devhelp"

.PHONY: epub
epub: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."

.PHONY: latex
latex: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex."
	@echo "Run \`make' in that directory to run these through (pdf)latex" \
	      "(use \`make latexpdf' here to do that automatically)."

.PHONY: latexpdf
latexpdf: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "Running LaTeX files through pdflatex..."
	$(MAKE) -C $(BUILDDIR)/latex all-pdf
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex."

.PHONY: text
text: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text."

.PHONY: man
man: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man
	@echo
	@echo "Build finished. The manual pages are in $(BUILDDIR)/man."

.PHONY: texinfo
texinfo: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo
	@echo "Build finished. The Texinfo files are in $(BUILDDIR)/texinfo."
	@echo "Run \`make' in that directory to run these through makeinfo" \
	      "(use \`make info' here to do that automatically)."

.PHONY: info
info: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo "Running Texinfo files through makeinfo..."
	make -C $(BUILDDIR)/texinfo info
	@echo "makeinfo finished; the Info files are in $(BUILDDIR)/texinfo."

.PHONY: changes
changes: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

.PHONY: linkcheck
linkcheck: bin/python  ## Run linkcheck
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
		"or in $(BUILDDIR)/linkcheck/ ."

.PHONY: linkcheckbroken
linkcheckbroken: bin/python  ## Run linkcheck and show only broken links
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck | GREP_COLORS='0;31' grep -wi "broken\|redirect" --color=auto || test $$? = 1
	@echo
	@echo "Link check complete; look for any errors in the above output " \
		"or in $(BUILDDIR)/linkcheck/ ."

.PHONY: spellcheck
spellcheck: bin/python  ## Run spellcheck
	cd $(DOCS_DIR) && LANGUAGE=$* $(SPHINXBUILD) -b spelling -j 4 $(ALLSPHINXOPTS) $(BUILDDIR)/spellcheck/$*
	@echo
	@echo "Spellcheck is finished; look for any errors in the above output " \
		" or in $(BUILDDIR)/spellcheck/ ."

.PHONY: html_meta
html_meta:
	python ./docs/addMetaData.py

.PHONY: doctest
doctest: bin/python
	cd $(DOCS_DIR) && $(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."

.PHONY: test
test: clean linkcheckbroken spellcheck  ## Run linkcheckbroken, spellcheck

.PHONY: deploy
deploy: clean html

.PHONY: netlify
netlify:
	pip install -r requirements.txt
	cd $(DOCS_DIR) && sphinx-build -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html

.PHONY: all
all: clean spellcheck linkcheck html ## Run checks and build html
