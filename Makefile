

preview: start build_cv
	quarto preview

start:
	echo "currentyear: "`date +%Y` > _variables.yml

build_cv: ../cv/content.tex ../cv/content_industry.tex ../bib/me.bib
	cd ../cv; make 
	cp ../cv/crawford_cv_academic.pdf resume
	cp ../cv/crawford_resume.pdf resume
	pybtex-convert ../bib/me.bib bibliography/me.yaml

deploy: start build_cv
	quarto render
	aws s3 cp _site s3://www.crawfordlab.io --recursive 

clean: 
	rm -fR _site


