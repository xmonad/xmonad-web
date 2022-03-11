# Prefer Ruby 2.7, github/pages-gem doesn't support 3.0 yet.
# (see https://github.com/xmonad/xmonad-web/issues/37 for details)
BUNDLE := $(firstword $(shell command -v bundle2.7 bundle-2.7) bundle)

export BUNDLE_PATH ?= $(CURDIR)/.bundle/gems

.PHONY: build
build: .bundle/.done
	$(BUNDLE) exec jekyll build --drafts

.PHONY: serve
serve: .bundle/.done
	$(BUNDLE) exec jekyll serve --drafts --livereload

.bundle/.done: Gemfile
	$(BUNDLE) install
	touch $@

.PHONY: clean
clean:
	$(RM) -r Gemfile.lock .bundle _site

_data/sponsors-named.json: _sponsors.sh
	./_sponsors.sh named-sponsors xmonad >$@
