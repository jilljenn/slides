% AEx Orion : optimisation de l'orientation
% 
% 2 mai 2024
---
institute: \includegraphics[height=1cm]{figures/inria.png}
lang: fr
csquotes: true
aspectratio: 169
header-includes:
  - \def\E{\mathbb{E}}
  - \AtEndPreamble{\DefineBibliographyExtras{french}{\restorecommand\mkbibnamefamily}}
biblatexoptions:
  - maxbibnames=99
  - maxcitenames=5
---
# Contexte

Observer et recommander des parcours de formation  
(behavior policy)  (policy optimization)

En 2021, 75 \% des lycéens/étudiants satisfaits de leurs choix d'orientation, 86 % inquiets pour leur avenir, 63 % ont manqué de visibilité pour faire leurs choix d'orientation

Onisep voulait bosser avec nous mais on n'a pas réussi à trouver un angle de collaboration  
Ils ont surtout de la documentation (plaquettes)

Du coup j'ai demandé une AEx à Inria qui a été acceptée $\to$ financement de thèse

Entre-temps, MonProjetSup : startup d'État CNRS/Onisep (portée par Hugo Gimbert co-créateur de l'algo de Parcoursup)  
Recommander des métiers et formations à partir :

- des vœux "J'aime prendre soin des gens / J'aime voyager"  
- spécialités
- moyenne générale en terminale

# Objectifs

- $A$ attribut sensible (genre, niveau socioéconomique)
- $X$ contexte (notes, spécialités en première)
- $T$ traitement (formation)
- $Y$ outcome (réussite ?)

Idéalement on aimerait bien sortir du cadre $A$ binaire et plutôt mesurer un effet de traitement (uplift)

$$CATE(X, A) = \E[Y \mid do(T = 1), X, A] - \E[Y \mid do(T = 0), X, A]$$

# Pistes

Voir la diversité des contextes selon le genre (ex. DEPP "Les filles choisissent plus d'options" : quel est l'effet sur les parcours ?)

Mesurer la sélectivité d'une formation en fonction des spécialités de lycée $X$

Et la sélectivité (ou fairness) sur plusieurs étapes (multistage fairness ? [@emelianov2019price])

Pour deux formations $T_1$ et $T_2$ qui mènent de $A$ à $B$, peut-on quantifier la plus facile ?

Biais possibles dans les embeddings si l'on applique des méthodes naïvement ?

\hfill

\small

\fullcite{emelianov2019price}

# Challenges

Recommander la même formation $T$ à tout le monde crée de la congestion

Régularisation entropique sur les recommandations faites pour diversifier [@mashayekhi2023recon]

Quel outcome ? Durée des études, absence de redoublement, etc.

\hfill

\small

\fullcite{mashayekhi2023recon}
