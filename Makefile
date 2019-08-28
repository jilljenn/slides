all: aimangaki-light.pdf animeexpo.pdf balse.pdf dauphine.pdf dauphine-recent.pdf ens.pdf genma-bsi.pdf \
	 hnkansai.pdf hnkansai2018.pdf intro.pdf ktm-slides.pdf \
	 iswag.pdf manpu.pdf mcjp.pdf meetup.pdf mfglabs.pdf ml4anime.pdf picopicocafe.pdf \
	 recsysfr.pdf recsysfr2-hnkansai.pdf thiers.pdf student-demo-cup.pdf vfm-handout.pdf vfm.pdf

pages/%.html: %.md
	pandoc --bibliography=biblio.bib $< -o $@

%.pdf: %.md
	time pandoc --bibliography=biblio.bib --biblatex $< -t beamer -o $@
	open $@

%.tex: %.md
	time pandoc -s --bibliography=biblio.bib --verbose $< -o $@

%.pdf: %.tex
	xelatex $<
	open $@

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.log *.nav *.out *.run.xml *.snm *.synctex \
		  *.synctex.gz *.toc *.vrb
	rm -f */*.log */*.aux

check:
	grep --color includegraphics */*.tex
