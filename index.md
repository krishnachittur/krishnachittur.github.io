---
---

## About

Hi. I'm Krishna Chittur. At the moment, I'm working at [Duolingo][duolingo] as a software engineer. Before that, I was doing an MS in Computer Science at Carnegie Mellon University.

[Here's][resume] my resume, and [here's][github] my GitHub page. If you'd like to be notified of updates, check out [my RSS feed][rss]!

My email address is [my first name]@chittur.dev. For an alternative email address, see my resume.

## Some Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      <br><em>{{ post.subtitle }}</em>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>

<!--- References -->
[duolingo]: https://www.duolingo.com/
[github]: https://github.com/krishnachittur
[resume]: /resume.pdf
[rss]: /feed.xml
