---
layout: post
title:  "Setting up a GitHub Pages blog for local dev on WSL"
category: CS
tags: [guide, software]
---

It is perhaps an ancient meme that anytime someone sets up a blog, the [first][static-blog-1] [thing][static-blog-2] [they][static-blog-3] [do][static-blog-4] is write about the blog they just made. Far be it from me to play into stereotypes, but given that I'm pretty fond of my current setup, I figured I might as well give into the inevitable. And honestly, I felt like there weren't any good resources out there for what I did, so hopefully someone will find this post useful.

## Overview

The long and short of it is that my blog runs on [GitHub Pages][gh-pages]. There are lots of nice things about this arrangement:

* It's free
* Blog posts are just plain markdown files
* Creating a new post is as simple as `git commit` and `git push`
* It's free
* If you already have a GitHub account, you don't need to sign up for anything new
* Lots of nice templates for simple static sites, perfect for blogging
* It's free

Under the hood, GitHub Pages use [Jekyll][jekyll], a flexible static site generator written in Ruby. Jekyll is really the star of the show here: it has enough batteries included that setup is relatively painless, but it's powerful enough to support plenty of customization. Over time, I've tweaked plenty of things with the site — updating the layout, adding support for things like buttons and mathematical formulas, etc. — but at no point did I feel overwhelmed despite having exactly zilch experience with making websites.

That said, when I started out, it frustrated me that the only way I could preview blog posts was by pushing them to GitHub and waiting — this was inelegant and exposed my entire git commit history to the world, which was less than fun. That's what the meat of this guide is about - taking that last step to be able to preview your blog comfortably on your own device.

![Image of sequence of embarrassing commit messages.](/assets/images/posts/local-jekyll-1.PNG){:style="display:block; margin-left:auto; margin-right:auto" width="600" }
*Pictured: why I don't like sharing my commit history with everyone.*

But first, the basics! Skip to the [local dev](#previewing-your-blog-locally) section if you already have a GitHub Pages blog up and just want to know how to preview it on your device.

## Getting started

I do most of my work in the [Windows Subsystem for Linux][wsl], which lets me pretend my mediocre Windows laptop is a significantly less mediocre Linux laptop while still playing video games in my spare time[^1]. That said, pretty much everything in this guide should apply just as well to a vanilla install of Ubuntu 22.04.

Nowadays you can set up WSL just by opening up PowerShell and typing

```
wsl --install
```

and boom, you're good to go! Goes great with [Windows Terminal][wt] too, though that's optional.

After that, it's just a matter of setting up a GitHub account if you don't already have one - guide for that [here][gh-setup]. `git` is already preinstalled on Ubuntu but you'll want to know how to run basic `git` commands like `clone`, `commit`, and `push`.

Then you can just follow the [quickstart guide][gh-pages-quickstart] for GitHub Pages and your shiny new blog should be ready to go!

## Bonus points: get a custom domain

Personally I found `krishnachittur.github.io` to be a a bit of an eyesore, so I used got myself a better domain from [Namecheap][namecheap] and followed [the guide][gh-pages-custom-domain] to set up a custom domain. Namecheap has been an excellent domain registrar so far, so I highly recommend them. They gave me free email forwarding as well so I could get a nice-looking email address.

I also wanted to set up Cloudflare on the domain but Cloudflare STILL doesn't support .dev domains so I guess that's not happening any time soon. (╯°□°）╯︵ ┻━┻

## Previewing your blog locally

Now for the fun part.

# TODO

- Setting up Jekyll (copy from Discord thread)
- upgrading the Ubuntu version - shenanigans
	sudo apt install ruby ruby-dev
	gem install bundler
	bundle update --bundler
	bundle update
	gem update jekyll
	gem update
	bundle exec jekyll serve
	bundle add webrick

--------------------------------------------

### Footnotes

[^1]: Remember when this used to be called Bash on Ubuntu on Windows and required toggling Developer Mode and an obscure Windows feature? Or later when you needed some obscure PowerShell command to enable some virtualization changes? Yeah, me neither.

<!--- References -->
[gh-pages]: https://pages.github.com/
[gh-pages-custom-domain]: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site
[gh-pages-quickstart]: https://docs.github.com/en/pages/quickstart
[gh-setup]: https://docs.github.com/en/get-started/quickstart/set-up-git
[jekyll]: https://jekyllrb.com/
[namecheap]: https://www.namecheap.com/
[static-blog-1]: https://yakkomajuri.com/blog/teeny
[static-blog-2]: https://inoads.com/articles/2021-01-09-Next-Gen-Static-Blogging
[static-blog-3]: https://erjjones.github.io/blog/How-I-built-my-blog-in-one-day
[static-blog-4]: https://www.jonashietala.se/blog/2022/08/29/rewriting_my_blog_in_rust_for_fun_and_profit/
[wsl]: https://learn.microsoft.com/en-us/windows/wsl/about
[wt]: https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701