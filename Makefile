# Makefile
TEXFILES = $(wildcard *.tex)
PDFFILES = $(TEXFILES:.tex=.pdf)

all: pdflatex 

pdf: $(PDFFILES)

%.pdf: %.tex
	@rubber --pdf $<
	@if [ -d publish ];then mv *.pdf publish; else mkdir publish; mv *.pdf publish/;fi

pdflatex: $(TEXFILES)
	$(foreach x,$(TEXFILES:.tex=),pdflatex $(x);)
	$(foreach x,$(TEXFILES:.tex=),bibtex $(x);)
	$(foreach x,$(TEXFILES:.tex=),pdflatex $(x);)
	$(foreach x,$(TEXFILES:.tex=),pdflatex $(x);)
	@if [ -d publish ];then mv *.pdf publish; else mkdir publish; mv *.pdf publish/;fi

clean:
	@rm -rf *.aux *.log *.blg *.bbl

distclean: clean
	@rm -rf publish
	@rm -f $(PDFFILES)

x:
	@open publish/$(PDFFILES) &> /dev/null &
