SHELL=/bin/bash
pdfopts=--table-of-contents --toc-depth=2 --fail-if-warnings --pdf-engine=xelatex --metadata-file metadata.yaml

all: SteadfastSelfHosting-PRINT.pdf SteadfastSelfHosting-SCREEN.pdf SteadfastSelfHosting.html SteadfastSelfHosting.epub

# Optimized for printing, I guess. Uses left and right-hand pages, and ends up
# more total pages. Otherwise this is pretty much the same as the "SCREEN" PDF.
# I'm not convinced we need both.
SteadfastSelfHosting-PRINT.pdf: no-emoji.md metadata.yaml Makefile
	pandoc $(pdfopts) -V documentclass:book $< -o $@

SteadfastSelfHosting-SCREEN.pdf: no-emoji.md metadata.yaml Makefile
	pandoc $(pdfopts) -V documentclass:report $< -o $@

# Strip emoji before generating PDF.
# - The PDF engine can't handle emoji. No worries, they aren't necessary.
# - See what was stripped with `git diff filtered.md no-emoji.md` (`diff -u` works fine too, just with less awesome colors).
no-emoji.md: filtered.md strip-non-ascii.py Makefile
	python3 strip-non-ascii.py < $< > $@

# Replace a few strings to automate capturing some build-time information.
filtered.md: book.md filter.py Makefile
	python3 filter.py < $< > $@

# Use latest pandoc binary for HTML generation, via Docker. Better-looking
# output than the pandoc that comes with my operating system. Specifically:
# - cleaner table of contents (no bullets)
# - wider left and right margins
# Note that images are not inlined in HTML.
SteadfastSelfHosting.html: filtered.md style.inc metadata.yaml Makefile img/*
	docker run --rm --volume "$(shell pwd):/data" --user $(shell id -u):$(shell id -g) pandoc/core --table-of-contents --toc-depth 2 --standalone --number-sections -t html5 --metadata-file metadata.yaml --highlight-style=tango --include-in-header="style.inc" --embed-resources $< -o $@

# laptop version (unless/until I set up docker):
#pandoc --table-of-contents --standalone -t html5 --metadata-file metadata.yaml --highlight-style=tango --include-in-header="style.inc" $< -o $@

SteadfastSelfHosting.epub: filtered.md metadata.yaml Makefile img/*
	pandoc --table-of-contents --number-sections --toc-depth=2 --highlight-style=tango --metadata-file metadata.yaml --include-in-header="style.inc" $< -o $@

# not used often, yet: handy
SteadfastSelfHosting.odt: filtered.md metadata.yaml Makefile img/*
	pandoc --table-of-contents --metadata-file metadata.yaml $< -o $@

clean:
	$(RM) SteadfastSelfHosting* filtered.md no-emoji.md
