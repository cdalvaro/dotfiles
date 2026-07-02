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

## Claude

Currently, my CLAUDE.md is just a copy of [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills).
