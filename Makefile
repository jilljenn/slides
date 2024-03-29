all: aimangaki-light.pdf animeexpo.pdf balse.pdf dauphine.pdf dauphine-recent.pdf ens.pdf genma-bsi.pdf \
	 hnkansai.pdf hnkansai2018.pdf intro.pdf ktm-slides.pdf \
	 iswag.pdf manpu.pdf mcjp.pdf meetup.pdf mfglabs.pdf ml4anime.pdf picopicocafe.pdf \
	 recsysfr.pdf recsysfr2-hnkansai.pdf thiers.pdf student-demo-cup.pdf vfm-handout.pdf vfm.pdf

%.html: %.md
	pandoc -s --mathjax --bibliography=biblio.bib $< -o $@

shanghai.pdf: shanghai.md
	time pandoc -s --bibliography=biblio.bib --biblatex $< -t beamer -o shanghai.tex
	xelatex shanghai
	biber shanghai
	xelatex shanghai
	xelatex shanghai
	open $@

parcours.tex: parcours.md
	time pandoc -s --filter pandoc-minted.py $< -t beamer -o $@
	lualatex -shell-escape $@

icce2023.tex: icce2023.md
	time pandoc -s --filter pandoc-minted.py --bibliography=biblio.bib --biblatex $< -t beamer -o $@
	pdflatex -shell-escape $@
	biber ${@:.tex=}
	pdflatex -shell-escape $@

deeprec.md: deeprec-master.md
	# ./prepare.py $< --handout > $@
	./prepare.py $< > $@

%.pdf: %.md
	# time pandoc --bibliography=biblio.bib --biblatex $< -t beamer -o $@
	time pandoc $< -t beamer -o $@
	# --bibliography=biblio.bib --biblatex

%.tex: %.md
	time pandoc -s --bibliography=biblio.bib --biblatex --verbose $< -t beamer -o $@
	#  
	#  --filter pandoc-minted.py
	# time pandoc -s --filter pandoc-minted.py --verbose $< -t beamer -o $@
	pdflatex -shell-escape $@ 
	biber ${@:.tex=}
	pdflatex -shell-escape $@
	# evince ${@:.tex=.pdf}

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
