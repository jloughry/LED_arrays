target = LED_arrays_paper

latex_cmd = pdflatex

build_counter = build_counter.txt
sources = $(target).tex title.tex abstract.tex

all:: $(target).pdf

$(target).pdf: $(sources) Makefile
	@echo $$(($$(cat $(build_counter)) + 1)) > $(build_counter)
	$(latex_cmd) $<
	bibtex $(target)
	@while grep "Rerun to get" $(target).log ; do \
		$(latex_cmd) $(target) ; \
	done
	@echo "Build `cat $(build_counter)`"

clean:
	rm -fv $(target).aux $(target).log $(target).out $(target).blg

allclean: clean
	rm -fv $(target).pdf

vi:
	vi $(target).tex

