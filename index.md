## About

Hi. I'm Krishna. [Here's](/resume.pdf "resume") my resume. [Here's](https://github.com/krishnachittur "github") my GitHub page. And [here's](/id_rsa.pub "pubkey") my pubkey.

My email address is [first name first initial][last name][at]utexas.edu.

## Some Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>

_(More coming soon.)_