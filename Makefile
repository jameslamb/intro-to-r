SHELL = bash

.PHONY: clean
clean:
	git clean -d -f -X

.PHONY: install
install:
	Rscript ./.ci/install-deps.R

.PHONY: assignments
assignments:
	find \
		./assignments \
		-name '*.Rmd' \
		-exec Rscript -e "rmarkdown::render(commandArgs(trailingOnly=TRUE)[[1]])" {} \;

.PHONY: code-samples
code-samples: clean
	find \
		./code \
		-name '*.Rmd' \
		-exec Rscript -e "rmarkdown::render(commandArgs(trailingOnly=TRUE)[[1]])" {} \;

vendored/github-markdown.css:
	curl -L https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css -o vendored/github-markdown.css

# '-f gfm' = "GitHub-flavored markdown"
.PHONY: readme
readme: vendored/github-markdown.css
	pandoc \
		-f gfm \
		-s \
		--metadata title="Intro to R" \
		--css=vendored/github-markdown.css \
		-o ./index.html \
		./README.md

.PHONY: slides
slides:
	find \
		./slides \
		-name '*.Rmd' \
		-exec Rscript -e "slidify::slidify(commandArgs(trailingOnly=TRUE)[[1]])" {} \;

.PHONY: syllabus
syllabus:
	Rscript -e 'rmarkdown::render("./syllabus.Rmd", output_format = c("pdf_document", "html_document"))'

.PHONY: course
course: clean install assignments code-samples readme slides syllabus
	@echo "made course"
