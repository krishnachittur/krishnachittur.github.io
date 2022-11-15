alias u := update
alias s := serve
alias c := clean
alias pr := preview
alias un := unpreview

# Dummy date for previewing drafts. Jekyll doesn't show
# anything with a date past the current date.
export DUMMY_DATE := `date --iso-8601`

# Update system-wide packages and local dependencies.
update:
    gem update
    bundle update

# Serve the site on localhost:4000.
serve:
    bundle exec jekyll serve

# Preview drafts on the blog.
preview:
    for draft in `ls _drafts`; do \
        echo $draft; \
        ln -f _drafts/$draft _posts/$DUMMY_DATE-$draft; \
    done

# Get rid of the previewed drafts. Will fail if it gets
# run on a different day from `preview`.
unpreview:
    for post in `ls _posts/$DUMMY_DATE-*`; do \
        echo $post; \
        rm $post; \
    done

# Get rid of the generated site, cached metadata, etc.
clean: unpreview
    rm -rf _site
    rm -f .jekyll-cache .jekyll-metadata