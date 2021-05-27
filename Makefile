export BUNDLE_PATH ?= $(CURDIR)/.bundle/gems

.PHONY: build
build: .bundle/.done
	bundle exec jekyll build

.PHONY: serve
serve: .bundle/.done
	bundle exec jekyll serve --livereload

.bundle/.done: Gemfile
	bundle install
	touch $@

.PHONY: clean
clean:
	$(RM) -r Gemfile.lock .bundle _site
