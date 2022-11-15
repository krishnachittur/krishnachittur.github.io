alias u := update
alias s := serve
alias c := clean

update:
    gem update
    bundle update

serve:
    bundle exec jekyll serve

clean:
    rm -rf _site
    rm -f .jekyll-cache .jekyll-metadata
