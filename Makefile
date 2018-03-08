#!/usr/bin/make -f

FEEDBACK = iff2018-autocrypt-feedback.pdf

burner-credentials.pdf: burner-credentials.svg accounts.txt accounts2handouts.py allcreds2pdf
	./accounts2handouts.py
	./allcreds2pdf $@

FEEDBACK_PDFS = delta.feedback.pdf enigmail.feedback.pdf L-10.feedback.pdf

all: $(FEEDBACK) burner-credentials.pdf

$(FEEDBACK): $(FEEDBACK_PDFS)
	pdftk $(FEEDBACK_PDFS) cat output $@

%.feedback.pdf: %.feedback.svg
	inkscape --export-pdf-version=1.5 --export-pdf=$@ $<

eff_short_wordlist_1.txt:
	wget -O $@ https://www.eff.org/files/2016/09/08/eff_short_wordlist_1.txt

accounts.txt: make-accounts eff_short_wordlist_1.txt
	./make-accounts < eff_short_wordlist_1.txt > $@

clean:
	rm -f $(FEEDBACK_PDFS) $(FEEDBACK) \
	      burner-credentials_out*.svg burner-credentials_out*.pdf \
	      burner-credentials.pdf

.PHONY: clean all
