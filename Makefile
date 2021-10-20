export BUNDLE_PATH ?= $(CURDIR)/.bundle/gems

.PHONY: build
build: .bundle/.done
	bundle exec jekyll build --drafts

.PHONY: serve
serve: .bundle/.done
	bundle exec jekyll serve --drafts --livereload

.bundle/.done: Gemfile
	bundle install
	touch $@

.PHONY: clean
clean:
	$(RM) -r Gemfile.lock .bundle _site

_data/sponsors-named.json: _sponsors.sh
	./_sponsors.sh named-sponsors xmonad >$@
