#!/usr/bin/make -f

FEEDBACK_PDFS = delta.feedback.pdf enigmail.feedback.pdf L-10.feedback.pdf

feedback.pdf: $(FEEDBACK_PDFS)
	pdftk $(FEEDBACK_PDFS) cat output $@

%.feedback.pdf: %.feedback.svg
	inkscape --export-pdf-version=1.5 --export-pdf=$@ $<

clean:
	rm -f $(FEEDBACK_PDFS) feedback.pdf

.PHONY: clean
