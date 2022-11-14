---
layout: post
title:  "Negation and notation"
category: math
tags: [math, musings]
mathjax: true
text-expand: true
---

This one's going to be pretty quick. Here's a puzzle. Suppose you have functions $f$ and $g$, and you want to make it clear that $f(a) = g(b)$ and $f(-a) = g(-b)$ in a single terse line of notation. How do you do it? Note that we haven't defined any other operations on $a$ and $b$ besides negation.

&#8203;  

@expand@ Small hint

If you were to write $f(\pm a) = g(\pm b)$, that would actually say four things:

1. $f(a) = g(b)$
2. $f(a) = g(-b)$
3. $f(-a) = g(b)$
4. $f(-a) = g(-b)$

Of these four things, you only want to express #1 and #4.

@/expand@

&#8203;  

@expand@ Bigger hint

If you were to write $f(\pm a) = g(\mp b)$, that would only give you #2 and #3 as written above. Almost, but not quite!

@/expand@

&#8203;  

@expand@ Solution

There may be better ways to do this, but here's how I'd write it:

$$f(\pm a) = g(\mp (-b))$$

Is it kind of ugly? Yes, but that's the point. The notation is humorously inconsistent, and we can take advantage of that.

@/expand@