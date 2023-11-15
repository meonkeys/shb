# Dear Reviewer

**THANK YOU**! ❤️🧡💛💚💙💜

I need and appreciate your open, honest feedback. With your help this book will be better.

The review deadline is Nov 24, 2023. I'd like to publish by December 20.

Please send me feedback in any form: email, text, PRs... whatever is most convenient. Every bit of your feedback helps, even a single sentence. I've got a thick skin so just let me have it as if you're reviewing a book from a complete stranger.

I made a list of issues below to capture stuff I'm already aware of and working on. As for what kinds of feedback I'm seeing, please see [Feedback ideas](#feedback-ideas), below.

I'd like to wait to release everything publicly once it is ready, so please help me keep it secret for now.

## Directory structure

| path     | description                           |
|----------|---------------------------------------|
| `build/` | build outputs appear here             |
| `src/`   | sources for the book                  |
| `mario/` | sources for _mario_ provisioning tool |

## Book formats

I use [Pandoc](https://pandoc.org) to produce multiple typeset versions of the book from a single source file: `src/book.md`.

[Download EPUB, PDF, and HTML versions here](https://github.com/meonkeys/shb-review/releases/).

The book source is Pandoc-specific Markdown. GitHub will try to render the Markdown in a web browser and fail in most respects.

The `Makefile` in `src/` generates an EPUB, a HTML file, and printable and screen-friendly PDFs.

If you want to generate your own typeset outputs, run `./typeset.sh`. See "Prerequisites to build the book" in `src/book.md`.

## Feedback ideas

By _feedback_ I mean, well, anything you're willing and able to help with!

Here are some ideas:

* What are your first impressions? Cover, table of contents, font, style, page size, book length, etc.
* Any/all factual, spelling, grammatical, and structural errors.
* Overall manuscript critique, comprehensive or line edits, copy-editing, proofreading.
* Inscrutable thrust of a section. Does it make sense what I'm trying to convey and how?
* Inconsistencies in voice, level of detail, narrative flow.
* Anywhere a diagram or photo would significantly help to illustrate a point.
* Any sections that should be rewritten, rethought, or removed.
* Is there a relevant and useful technology that isn't mentioned and should be?
* Test out _mario_ on your own hardware/VM. Does it work for you as advertised?
* Is this something you'd actually read?
* Is this something you'd recommend to others?
* What would you expect to pay for a print copy?
* What would you expect to pay for a digital copy?
* Any feedback on the [book website](https://selfhostbook.com)?

## Issues

Here's a quick summary of the stuff I'm aware of and working on. IDs start with `am` to avoid conflicts with IDs that might be generated by some other issue tracker, should I choose one. I (Adam) am the assignee for all of these.

| ID   | Description | Status |
|------|-------------|--------|
| am1  | table formatting broken for PDF outputs in "Prerequisites to build the book" section | OPEN |
| am2  | [code snippets in PDF outputs are not wrapped](https://stackoverflow.com/questions/20788464/pandoc-doesnt-text-wrap-code-blocks-when-converting-to-pdf) - e.g. docker logs output for traefik in "start reverse proxy" section | OPEN |
| am3  | improve footnote formatting in HTML output (use hover text or group by chapter) | OPEN |
| am4  | missing contributor info | OPEN |
| am5  | missing translator info | OPEN |
| am7  | no color emoji in PDF outputs | OPEN |
| am8  | incomplete _Resources_ section | OPEN |
| am9  | incomplete _Contact info_ section | OPEN |
| am10 | incomplete _Contributions section_ | OPEN |
| am11 | incomplete _Translations section_ | OPEN |
| am12 | incomplete _Support future awesome books_ section | OPEN |
| am13 | remove _Cover art_ section | RESOLVED |
| am14 | missing _Periodic maintenance_ section (example schedules) | OPEN |
| am15 | missing style guide | OPEN |
| am16 | confirm adherence to style guide | OPEN |
| am17 | add more photos and illustrations | OPEN |
| am18 | change _mario_ to use [Duck DNS](https://hub.docker.com/r/linuxserver/duckdns) | OPEN |
| am19 | PDF and HTML outputs lack cover art | OPEN |
| am20 | define "attack surface" | RESOLVED |
| am21 | differentiate style for image captions | OPEN |
| am22 | add illustration: loaf of bread server | OPEN |
| am23 | add illustration: squeaky clean chickens | OPEN |
| am24 | conform voice of _Criminal chickens_ section | RESOLVED |
| am25 | tie in 4th-wall-breaking "caveman speak" near "5 Ws" or just leave it out | RESOLVED |
| am26 | be less apologetic, limit to perhaps 3 or so apologies | OPEN |
| am27 | correct "knows as" typo to "known as" | RESOLVED |
| am28 | add photo: bird on server | OPEN |

## Copyright and license

This pre-publication secret manuscript of _Steadfast Self-Hosting: Rapid-Rise Personal Cloud_ is copyright &copy;2023 Adam Monsen. All rights reserved.

## Editing stages reference

From <https://www.ingramspark.com/how-to-self-publish-a-book>...

### Manuscript Critique

This is a high-level examination of your manuscript. It looks at things like narrative voice, plot, and character development. With this type of critique, editors give feedback on items that will help improve your overall story.

### Comprehensive Edit / Line Edit

A comprehensive edit addresses structural issues (similar to a manuscript critique), but it also involves a line edit, which looks closely at writing style and language. With a line edit, an editor focuses on the use of language to communicate your story to a reader.

### Copyedit

A copyedit is often confused with a line edit, but they're very different steps in the editing process. A copyedit reviews technical flaws--issues with spelling, grammar, and punctuation--and looks for internal inconsistencies throughout the text.

### Proofread

This is the final step in the editing process. A proofreader examines the final copy of the manuscript (usually after typesetting) for any awkward page breaks, and he or she might perform some light copyediting.
