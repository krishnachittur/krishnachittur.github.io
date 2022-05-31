---
mathjax: true
---

## About

Hi. I'm Krishna Chittur. At the moment, I'm working at [Duolingo][duolingo] as a software engineer. Before that, I was doing an MS in Computer Science at Carnegie Mellon University.

[Here's][resume] my resume. [Here's][github] my GitHub page. And [here's][pubkey] my pubkey.

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

<!--- References -->
[duolingo]: https://www.duolingo.com/
[github]: https://github.com/krishnachittur
[pubkey]: /id_rsa.pub
[resume]: /resume.pdf
