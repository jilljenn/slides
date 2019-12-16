all: aimangaki-light.pdf animeexpo.pdf balse.pdf dauphine.pdf dauphine-recent.pdf ens.pdf genma-bsi.pdf \
	 hnkansai.pdf hnkansai2018.pdf intro.pdf ktm-slides.pdf \
	 iswag.pdf manpu.pdf mcjp.pdf meetup.pdf mfglabs.pdf ml4anime.pdf picopicocafe.pdf \
	 recsysfr.pdf recsysfr2-hnkansai.pdf thiers.pdf student-demo-cup.pdf vfm-handout.pdf vfm.pdf

pages/%.html: %.md
	pandoc --bibliography=biblio.bib $< -o $@

shanghai.pdf: shanghai.md
	time pandoc -s --bibliography=biblio.bib --biblatex $< -t beamer -o shanghai.tex
	xelatex shanghai
	biber shanghai
	xelatex shanghai
	xelatex shanghai
	open $@

deeprec.md: deeprec-master.md
	./prepare.py $< --handout > $@

%.pdf: %.md
	time pandoc --bibliography=biblio.bib --biblatex $< -t beamer -o $@
	# --bibliography=biblio.bib --biblatex

%.tex: %.md
	time pandoc -s --bibliography=biblio.bib --biblatex --verbose $< -t beamer -o $@
	pdflatex $@
	biber ${@:.tex=}
	pdflatex $@
	evince ${@:.tex=.pdf}

%.pdf: %.tex
	xelatex $<
	open $@

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.log *.nav *.out *.run.xml *.snm *.synctex \
		  *.synctex.gz *.toc *.vrb
	rm -f */*.log */*.aux

fullclean:
	rm '#'*'#' *~

check:
	grep --color includegraphics */*.tex
