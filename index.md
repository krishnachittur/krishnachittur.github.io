---
mathjax: true
---

## About

Hi. I'm Krishna Chittur. At the moment, I'm doing an MS in Computer Science at Carnegie Mellon University. [Here's](/resume.pdf "resume") my resume. [Here's](https://github.com/krishnachittur "github") my GitHub page. And [here's](/id_rsa.pub "pubkey") my pubkey.

My email address is [my first name]@chittur.dev. For an alternative email address, see my resume.

## Some Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
