#!/usr/bin/make -f

MAINSRC = main

all:	
	rubber -I . -I style -I figures -f --pdf $(MAINSRC).tex

clean:	
	rm -f *.aux *.bbl *.blg *.log *.lof *.log *.lot *.out *.synctex.gz *.toc *~ $(MAINSRC).dvi $(MAINSRC).ps $(MAINSRC).pdf

tarball: clean
	tar czvf ../$(MAINSRC).tgz --exclude-vcs --exclude-backups --exclude=$(MAINSRC).tgz .

gitignore:
	@echo "*.aux\n*.bbl\n*.blg\n*.log\n*.lof\n*.log\n*.lot\n*.out\n*.synctex.gz\n*.toc\n*~\n$(MAINSRC).dvi\n$(MAINSRC).ps\n$(MAINSRC).pdf" >> .gitignore

svnignore:
	echo "*.aux\n*.bbl\n*.blg\n*.log\n*.lof\n*.log\n*.lot\n*.out\n**.synctex.gz\n.toc\n*~\n$(MAINSRC).dvi\n$(MAINSRC).ps\n$(MAINSRC).pdf" | svn propset svn:ignore . -RF -

print:
	pdfposter -m160x247mm -pA0 $(MAINSRC).pdf print_poster/temp.pdf
	cd print_poster && pdflatex printer
