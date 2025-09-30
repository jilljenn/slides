% Environnement de l'oral
% Marc Jeanmougin; JJ Vie
% 28 mars 2023
---
header-includes:
  - \def\OS{\textsf{OS}}
---

# 

\centering
\fontsize{48}{1}\selectfont NonOS

\normalsize

*Ce n'est pas un OS, c'est un environnement de concours.*

\vspace{1cm}

- Une machine virtuelle `.ova` à lancer avec VirtualBox
- Une image `.iso` à graver sur une clé USB
- Beaucoup de paquets tiers inclus

# Contenu

:::::: {.columns}
::: {.column}
## Langages supportés

- Python 3.10.06
    - mypy
    - pandas matplotlib
    - numpy scipy scikit-learn
    - Pillow imageio
    - jupyterlab
- OCaml 4.13.1
    - utop
    - ocaml-lsp-server
- g++ 11.3
    - gdb
    - valgrind
- PHP, SQLite 3
:::
::: {.column}
## Environnements de développement

- Codium
- JupyterLab
- Pycharm Pyzo
- emacs (Tuareg) vim gedit

## Documentation hors ligne

- Zeal
- devdocs

## Outils

- flex ml-yacc ragel menhir
- svn git
:::
::::::

# diff

## Remplacements

Bureau : GNOME $\to$ Xfce

## Suppressions

- MySQL, phpMyAdmin, Java, R, Node
- LaTeX (on peut en discuter, 76 Mo $\to$ 50 Go), pandoc
- Packages Python : sympy jax jinja
- Chromium
- qgis

## Ajouts

- Autres claviers, ex. Bépo
- Plus de man pages
- Package Python : mypy\bigskip

\alert{Décision :} garder un LaTeX minimal.
