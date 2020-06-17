# 🗂 cdalvaro's dotfiles

Deployment is made by SaltStack formulas.

You'll find some files with values shown as `{{ VARIABLE }}`, which are replaced by the Jinja2 templating engine.

```yml
dotfiles files present:
  file.recurse:
    - name: {{ home_dir }}/
    - source: salt://data/cdalvaro/dotfiles/
    - user: {{ grains.main_user }}
    - group: {{ grains.main_group }}
    - dir_mode: 755
    - template: jinja
    - exclude_pat: E@(README.md|settings/|pillar/)
```

Also, other files may begins with `{% raw %}` and ends with `{% endraw %}`.

Thouse [escape sequences](https://jinja.palletsprojects.com/en/master/templates/#escaping) are interpreted by the Jinja engine in order to avoid replacing content between these two markers. (That is the case for `.p10k.zsh` file)
