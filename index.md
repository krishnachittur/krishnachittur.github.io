## About

Hi. I'm Krishna. [Here](/resume.pdf "resume") is a link to my resume. [Here's](https://github.com/krishnachittur "github") my GitHub page.

My email address is [first name first initial][last name][at]utexas.edu.

## Some Posts

<!-- [A guide to the GRE.]({% post_url 2019-11-15-gre-guide %}) -->

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>

_(More coming soon.)_