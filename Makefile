VERSION=v`cat STABLE`

generated_files1 = $(shell find doc -type f -name \*.md | grep -v blog | xargs)
generated_files = $(addprefix out/,$(patsubst %.md,%.html,$(generated_files1)))

website_dirs = \
	out/doc \
	out/doc/video \
	out/doc/download \
	out/doc/logos \
	out/doc/images

doc_images = $(addprefix out/,$(wildcard doc/images/* doc/*.jpg doc/*.png))
website_assets = $(addprefix out/,$(wildcard doc/*.css doc/*.js))

blog_dirs = $(patsubst out/doc/%,out/blog/%,$(website_dirs))
blog_assets = $(patsubst out/doc/%,out/blog/%,$(website_assets))
blog_images = $(patsubst out/doc/%,out/blog/%,$(doc_images))

website_files = \
	out/doc/index.html    \
	out/doc/v0.4_announcement.html   \
	out/doc/sh_main.js    \
	out/doc/sh_javascript.min.js \
	out/doc/sh_vim-dark.css \
	out/doc/sh.css \
	out/doc/favicon.ico   \
	out/doc/pipe.css \
	out/doc/video/index.html \
	out/doc/download/index.html \
	$(generated_files) \
	$(doc_images) \
	$(website_assets)

blog_files = \
	$(blog_assets) \
	$(blog_images)

doc: website blog

blogclean:
	rm -rf out/blog

blog: doc/blog tools/blog $(blog_dirs) $(blog_files)
	node tools/blog/generate.js doc/blog/ out/blog/ doc/blog.html doc/rss.xml

website: $(website_dirs) $(website_files)

out/doc/%.html: doc/%.md
	mkdir -p $(shell dirname $@)
	node tools/doc/generate.js --format=html --template=doc/website.html $< > $@

$(website_dirs):
	mkdir -p $@

$(blog_dirs):
	mkdir -p $@

out/doc/%.html: doc/%.html
	cat $< | sed -e 's|__VERSION__|'$(VERSION)'|g' > $@

out/doc/%: doc/%
	cp -r $< $@

out/blog/%: doc/%
	cp -r $< $@

blog-upload: blog
	rsync -r out/blog/ node@nodejs.org:~/web/nodejs.org/blog/

website-upload: doc
	rsync -r out/doc/ node@nodejs.org:~/web/nodejs.org/

release: website-upload blog-upload
	rsync -r out/doc/ node@nodejs.org:~/web/nodejs.org/dist/$(VERSION)/docs/

docopen: out/doc/api/all.html
	-google-chrome out/doc/api/all.html

docclean:
	-rm -rf out/doc

clean: docclean

.PHONY: clean docopen docclean doc all website-upload blog blogclean
