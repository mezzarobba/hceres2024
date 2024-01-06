hceres2024-main.pdf:

pdf := hceres2024-main.pdf \
       unit/hceres2024-unit.pdf \
       example/hceres2024-example.pdf

all := $(pdf) index.html

all: $(all)

%.clean: FORCE
	latexmk -C --jobname=$(basename $@)
	rm index.html

clean: $(pdf:.pdf=.clean)

index.html: Makefile tools/index.py $(pdf)
	> $@ python3 tools/index.py $(pdf)

FORCE:

.SECONDEXPANSION:
$(pdf): %.pdf: Makefile hceres.cls assets/* hceres2024-main.tex \
               $$(shell git ls-files --exclude-standard -co $$(dir $$@))
	@echo Dependencies: $^
	@echo Rebuilding $@ because of changes in $?
	latexmk --lualatex --jobname=$(basename $@) hceres2024-main.tex
	touch $@ # update timestamp in case latexmk found nothing to do

.PHONY: all clean FORCE
