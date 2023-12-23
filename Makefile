hceres2024-main.pdf:

all = hceres2024-main.pdf \
      unit/hceres2024-unit.pdf \
      example/hceres2024-example.pdf

all: $(all)

$(all): %.pdf: Makefile hceres.cls assets/* hceres2024-main.tex \
               $(shell find -not -name 'hceres2024-*.pdf' $(dir $@))
	latexmk --lualatex --jobname=$(basename $@) hceres2024-main.tex

.PHONY: all
