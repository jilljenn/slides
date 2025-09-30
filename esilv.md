% Risques et opportunités de l'IA en éducation
% Jill-Jênn Vie
% 10 avril 2025
---
institute: \includegraphics[height=1cm]{figures/inria.png}
lang: fr
babel-otherlangs: english
csquotes: true
aspectratio: 169
biblio-style: authoryear
navigation: frame
colorlinks: true
header-includes: |
  ```{=tex}
  \usepackage{subfig}
  \usepackage{icomma}
  \usepackage{bm}
  \usepackage{multicol,booktabs}
  \def\correct{\includegraphics{figures/win.pdf}}
  \def\uic{\textnormal{User } i \textnormal{ Item } j~\correct}
  \AtEndPreamble{\DefineBibliographyExtras{french}{\restorecommand\mkbibnamefamily}}
  \newcommand\mycite[3]{\textcolor{blue}{#1} "#2".~#3.}

  \setbeamertemplate{navigation symbols}{}
  \setbeamertemplate{footline}{%
    \leavevmode%
    \hbox{%
    \begin{beamercolorbox}[wd=\paperwidth,ht=2.25ex,dp=1ex,right]{date in head/foot}%
      \usebeamerfont{date in head/foot}\insertframenumber\hspace*{2ex}
    \end{beamercolorbox}}%
    \vskip0pt%
  }
  ```
biblatexoptions:
  - maxbibnames=99
  - maxcitenames=5
  - babel=other
---

# L'IA en éducation

![](figures/ih2ef.png)

# Application : sous-titres automatiques dans la même langue

\centering

![](figures/india-bloom.jpg){height=3cm} ![](figures/india-bloom2.png){height=3cm}

\raggedright

Étude sur 13000 écoliers entre 2002 et 2007.\bigskip

> Purely from schooling, without any exposure to [same-language subtitling, SLS], we found that \alert{24\%} children became good readers after 5 years of schooling. But in the group of school children that was exposed to SLS regularly, at most 30 min a week over five years, \alert{56\%} became good readers.

\small

\fullcite{kothari2008let}

# Un récent outil : AxTongue.com \only<2>{basé sur un prompt ChatGPT}

\centering

![](figures/graffiti.png){width=80%}

# Les LLM[^1] ont démocratisé la numérisation / la reconnaissance de la parole

(Bouleversement du marché des OCR)

Le plus petit modèle Whisper fait 75 Mo et met 8 secondes pour transcrire 30 secondes

Le plus optimisé insanely-fast-whisper transcrit 2,5 h d'audio en 1 min 30 sur un A100 avec 80 GB de RAM.

Une version compressée (166M) tient dans 1,5 GB de RAM.

Simon Willison raconte qu'en utilisant les API payantes il peut générer des légendes pour les 70 000 photos sur son ordinateur pour 2 dollars.

Cf. llama.cpp et Ollama (wrapper en Go vers llama.cpp, plus facile à installer)

 [^1]: Grands modèles de langue (*large language models*) comme Mistral, LLaMa, ChatGPT, Gemini

# Où l'IA (générative) peut-elle être utilisée en éducation ?

:::::: {.columns}
::: {.column width=80%}
- Correction automatique
- Génération automatique d'exercices
- Prédire la performance d'apprenants pour adapter l'instruction
- Personnaliser l'évaluation (ma recherche)
- Proposer un retour personnalisé (*feedback*, explications) aux apprenants\medskip

Cf. le rapport anglais de janvier 2024 (536 répondants)
:::
::: {.column width=15%}
$\fbox{\includegraphics{figures/genai-uk.png}}$
:::
::::::

## Opportunités

- libérer du temps d'enseignant passé aux tâches administratives pour se concentrer sur l'enseignement
- un soutien pédagogique supplémentaire (par ex. élèves en situation de handicap)

## Risques

- Informations biaisées ou peu fiables
- Dépendance excessive aux outils d'IA

# Correction automatique : GradeScope (Singh et al. 2017, Berkeley)

![](figures/gradescope.jpg)

Déjà en 2014 : Divide and Correct ; en France : CorrectExam (Rennes)

# Quels superpouvoirs souhaitent avoir les profs ?

Trop d'EdTech ne se soucient pas des réels besoins des professeurs

\small

## Superpouvoirs : avoir un baromètre de si la classe a compris ou pas

- Voir les processus de pensée des apprenants (ceux dans la mauvaise direction)
- Voir qui est vraiment bloqué / qui y est presque / qui a juste besoin de motivation
- Se cloner / avoir des yeux dans le dos (patrouiller)
- Détecter les mauvaises conceptions des apprenants (qui risquent de persister)

Doléances :

- Aidez-moi à intervenir là, quand, et ce pour quoi on a le plus besoin de moi
- La technologie ne \alert{doit pas attirer mon attention} hors de mes étudiants
- Comment savoir si ce que je fais a un réel impact ?
- Je ne suis qu'une personne ; déchargez-moi
- Que pouvez-vous me dire sur mes étudiants que je ne sais pas déjà ?
- Laissez-moi \alert{contrôler et personnaliser la technologie} pour mes propres besoins

\fullcite{holstein2019co}

# Personnalisation de l'évaluation : tests adaptatifs

Comment mesurer 800 composantes de connaissances efficacement ?  
Avec la théorie de la réponse à l'item

:::::: {.columns}
::: {.column}
![](figures/adaptive.pdf)
:::
::: {.column}
\vspace{1cm}

- On pose une question de niveau 5
- L'apprenant \alert{réussit}
- On pose une question de niveau 12
- L'apprenant \alert{échoue}
- On pose une question de niveau 4
- etc.
:::
::::::

\small

\fullcite{Vie2017adaptive}

\normalsize

Sommatif : classer les gens \hfill Formatif : identifier points forts et faibles

# Modèle sommatif : théorie de la réponse à l'item

\centering

\resizebox{0.9\linewidth}{!}{$\displaystyle \substack{\normalsize \Pr(\textnormal{"étudiant A résout question B"})\\ \Pr(\textnormal{"joueur A bat joueur B"})\\ \Pr(\textnormal{"A est préféré à B"})} = \frac1{1 + \exp(-(score_A - score_B))}$}

\raggedright

Mesurer la compétence latente (la position sur la gaussienne) à partir de tests

\begin{figure}
  \captionsetup[subfigure]{labelformat=empty,justification=centering}
  \subfloat[reCAPTCHA\\ (Luis von Ahn, 2008)]{\raisebox{2mm}{\includegraphics[width=0.25\linewidth]{figures/captcha.png}}}
  \subfloat[Elo (1967)\\ TrueSkill (2007)]{\includegraphics[width=0.25\linewidth]{figures/tournament-nyt.png}}
  \subfloat[Tests adaptatifs\\ (Rasch, 1960)]{\includegraphics[width=0.25\linewidth]{figures/irt.pdf}}
  \subfloat[Modèles de préférences\\ (Bradley \& Terry, 1952)]{\raisebox{3mm}{\includegraphics[width=0.25\linewidth]{figures/elo2.jpg}}}
\end{figure}

\vfill \small

\fullcite{rasch1960studies}

# Modèle formatif : recommandation de documents dans la ZPD

Zone proximale de développement, cf. @shabana2022curriculumtutor

\centering

![](figures/zpd2.png){width=70%}

\small \raggedright

\fullcite{Vassoyan2023}

Travaux acceptés à NeurIPS 2024 workshop on Large Foundation Models for Educational Assessment

# Compromis entre bien mesurer et poser peu de questions

\centering

![](figures/irt-fr.pdf){width=70%}

\raggedright

\alert{Maximiser l'information} $\rightarrow$ poser des questions à la frontière de la connaissance $\rightarrow$ les apprenants échouent 50 % du temps (bien pour l'évaluateur, pas pour les apprenants)


# Choisir la bonne fonction à optimiser

\centering

![](figures/asking4.pdf)

\raggedright

\alert{Maximiser le taux de succès} $\rightarrow$ on pose artificiellement des questions trop faciles

\alert{Acquérir le plus de connaissances} \parencite{Yessad2022}

\alert{Maximiser son score sur l'examen suivant ?}  
Réviser ce qui a le plus de chances de tomber \parencite{Lan2016ACB}

\alert{Maximiser la croissance du taux de succès} Travaux zone proximale de développement à Inria Bordeaux \parencite{clement2015multi}

\alert{Identifier une lacune de l'apprenant le plus vite possible} \parencite{Seznec2020}

Étant donné un objectif d'apprentissage, planifier les activités pour y parvenir ?

# Algorithme conçu pour Pix

\alert{Maximiser le nombre moyen d'acquis validés ou invalidés}

Le code source de l'algorithme adaptatif est \alert{ouvert}  
(pix.fr, code sur GitHub sous licence AGPLv3)  
Déjà 350 000 comptes créés, 50 000 certifications délivrées

\centering
\includegraphics[width=\linewidth]{figures/example.pdf}

\raggedright

\small

\fullcite{Vie2017PIX}

# Flow

Récompense plus haute si l'étudiant a résolu une question plus difficile, 0 si l'étudiant n'arrive pas à répondre

\centering

![](figures/zpdflow.png){width=50%}

\raggedright

On identifie le *flow* directement à partir des données (soumission en cours)

# Challenges supplémentaires : évolution des connaissances (oubli)

Travaux sur la mémoire et la répétition espacée

\centering

![](figures/memory.png){width=45%}

\raggedright \small

\fullcite{Choffin2019}

# 

\centering

![](figures/polytechnique.png)



# Risque I -- Discrimination, exclusion et toxicité : stéréotypes

GPT-3 : analogies entre musulmans et terroristes dans 23 % des tests

Le fait que ça fonctionne moins bien dans d'autres langues que l'anglais

Suggestion de prendre un médicament ou de pousser au suicide

D'où l'importance de la modération des contenus

\vfill

\small

\fullcite{weidinger2022taxonomy}

# 

![](figures/kunashir.png)

# Mais ce biais est une vertu : multiplier les points de vue (ex. PhiloGPT)

\centering

![](figures/sartre.png)

\url{https://philogpt.vmirebeau.fr}

# Risque II -- Risques liés à l'information

Le fait que ChatGPT mémorise et régurgite des informations confidentielles présentes dans les données d'entraînements ou bien les infère correctement (Weidinger et al. 2021)

![](figures/information-leak.png)


# Risque III -- Dommages causés par la désinformation

Disséminer des informations fausses  
\pause \alert{Et pourtant} ça permet aux conspirationnistes de revenir sur leurs idées (effets durables)

![](figures/conspiracy.jpg)

\small

\fullcite{costello2024durably}

# Risque IV -- Utilisations malveillantes

Plus facile de fabriquer de la désinformation à moindre coût (fermes de bots)

Arnaques, fraude (phishing) en imitant la voix

Génération de faux reçus, fausses ordonnances

Créer des nouveaux virus difficiles à détecter

# Risque V -- Dommages causés par l'interaction homme-machine

Risque que ChatGPT s'exprime tellement bien qu'on vienne à en oublier qu'il s'agit d'un robot ; que les jeunes s'ouvrent à lui car ils sont moins jugés que s'ils s'exprimaient avec un professeur ou un humain.

(Les humains qui interagissent avec un robot qui a l'air humain révèlent plus d'informations que s'ils partagent avec un robot qui a l'air machine.)

# Risque VI -- Automatisation, accès et dommages environnementaux

## Pré-entraînement : \alert{552 tonnes} équivalent CO2  

(5 fois les émissions à vie d'une voiture américaine, 550 allers-retours NYC--SF)

## Fine-tuning

- Gemma-2B-it a coûté 1/7 des émissions de GPT-3 pour le fine-tuning
- QLoRA fine-tune directement le modèle quantized 65B sur 4 bits  
(24 h sur un seul GPU de 48 GB $\to$ atteint \alert{99,3\%} de la performance de GPT-4)

## Inférence : \alert{domine les émissions totales} à cause de l'échelle

(malgré une consommation par requête plus faible ; Google disait en 2022 : 60 % de l'énergie pour l'inférence ; ChatGPT a eu 1,7 milliard de visites en octobre 2023 : en quelques semaines ou mois, l'inférence dépasserait les coûts d'entraînement)\medskip

\scriptsize

\fullcite{patterson2022carbon}

\fullcite{luccioni2024power}

\fullcite{dettmers2023qlora}

Cf. une autre présentation à ce sujet : \url{https://jjv.ie/slides/foresight2025.pdf}

# Risque VI -- Automatisation, accès et dommages environnementaux

Risque de déplacement des emplois (et non suppression). Il est possible qu'on ait moins besoin de développement de la technologie et plus besoin d'embaucher des gens pour la modération à moindre coût. Risque d'une dégradation de la qualité des emplois, si les gens doivent juste valider ce que la machine fait, avec moins d'autonomie, et moins de contact humain au travail.\bigskip

Bainbridge's *Ironies of Automation* (1983)

\small

> a key irony of automation is that by mechanising routine tasks and leaving exception-handling to the human user, you deprive the user of the
routine opportunities to practice their judgement and strengthen their cognitive musculature, leaving them atrophied and unprepared when the exceptions do arise.

\normalsize

Les compétences ont glissé (Lee et al. CHI 2025) :

- Pour la compréhension, on est passé de la recherche d'info à la vérification de l'info
- Pour l'application, on est passé de la résolution de pb à l'intégration de réponses IA
- Pour l'analyse, synthèse et évaluation : exécution à gestion des tâches

\small

\fullcite{weidinger2022taxonomy}

# LLM sur questions SAT (1200 participants Amazon Mechanical Turk)

Lors d'un test basé sur des QCM de mathématiques, comment le type de feedback reçu (bonne réponse seulement vs. réponse avec explication générée par LLM) affecte-t-il la performance sur les QCM ultérieurs ?

Les explications LLM ont un impact positif sur l'apprentissage (par rapport à juste donner la bonne réponse), que les participants les aient consultées avant ou après avoir tenté de résoudre les QCM.

L'exposition aux explications LLM a augmenté le sentiment d'apprentissage des participants et a diminué la difficulté perçue des problèmes de test.

\vfill

\small

\fullcite{kumar2023math}

# ``What comes after the homework apocalypse?"

:::::: {.columns}
::: {.column width=40%}
\centering

![](figures/negative-affect.jpg)\bigskip

\raggedright\small

Sources : Ethan Mollick, Vassena & Bijleveld (2024)
:::
::: {.column width=60%}
On a tendance à ne pas aimer faire des efforts

Par ex, les cours préférés par les élèves ne sont pas ceux qui ont un impact sur les apprentissages

Les devoirs ne servent à rien si c'est l'IA qui les fait ; importance de "*productive struggle*"

## Astuces

- Génération de quiz automatiques, ou d'une interrogation à partir d'un poly
- Critique ma lettre de recommandation, préparer un entretien
- Aide pour le style dans la rédaction de dissertation : générer un document par itérations et interaction (``*Always easier to edit a shitty draft than a blank page*")
:::
::::::

# Impact de notre recherche en IA pour l'éducation

## Question piège du gouvernement français {.subtitle}

\medskip

> Avec l'IA en l'éducation, avons-nous besoin de plus de professeurs d'informatique ou de moins de professeurs d'informatique ?

Réponse simple : même avec Google Translate, nous avons encore besoin de professeurs d'anglais (vraiment ?) ; il est possible d'avoir les deux.

Réponse : la mesure automatisée (score à l'examen) est un altimètre (elle mesure le potentiel). Le professeur (humain) doit encore élever les élèves.

Réponse LLM : « C'est une question complexe sans réponse facile ! »\bigskip

> Mais de fait, si la recherche en parcours d'apprentissage personnalisés progresse, avons-nous encore besoin de professeurs ?

Réponse : il est possible que l'on soit plus motivé si l'on visualise son progrès, reçoit des encouragements d'un humain, ou apprend en groupe (entre pairs), et pas seulement chacun derrière son écran  
(Duolingo est certes addictif, mais les gens apprennent-ils vraiment la langue ?)

# Qu'en est-il de la quantité de profs d'informatique ?

Je continue à être persuadé que l'on a besoin de davantage de professeurs d'informatique : chaque modélisation (physique, biologie) implique du calcul, tout est numérique. Mais certaines personnes pensent qu'on a besoin de moins de programmeurs

\small

(Pourtant, si l'on réduit le besoin en programmeurs, ou qu'il y en a davantage, peut-être que leur coût réduira, et que davantage de personnes pourront accéder à ces profils : paradoxe de Jevons.)

:::::: {.columns}
::: {.column width=70%}
## Autres risques LLM vs. professeurs humains

\normalsize

Le risque d'augmenter les inégalités (les gens qui ont déjà les connaissances accélèrent avec la programmation / les LLM)\bigskip

Mais grâce aux LLM, les inégalités liées à la langue sont réduites (ex. des gens non natifs peuvent traduire ce que le professeur dit dans leur langue)\bigskip

Peut-être que le COVID nous aura prouvé qu'on a besoin de professeurs humains $\to$
:::
::: {.column width=30%}
![](figures/kz-covid.png)

![](figures/pisa2022-france.png)
:::
::::::

# Paradoxe : PISA vs. LLMs

## Un peu fatigué par les comparaisons entre pays avec des tests traditionnels {.subtitle}

:::::: {.columns}
::: {.column}
PISA mesure 3 nombres par pays

![](figures/pisa2022-world.png)

Le risque d'overfit à un examen donné (tests standardisés)

On a besoin de davantage d'itérations
:::
::: {.column}
Tandis que ChatGPT mesure 1536 nombres par token (portion de mot)

Une évaluation formative serait plus utile

\centering

![](figures/verhelst-profiles.png)

\raggedright

\scriptsize \fullcite{verhelst2017balance}

:::
::::::

# Take-home message

Démocratisation impressionnante de la connaissance (et des hallucinations) :  
même nos grands-parents en ont entendu parler

## Importance de la transparence et de l'open source

Trop de gens ne connaissent que ChatGPT comme LLM

Les LLM hors ligne représentent une opportunité pour des applications décentralisées et privées
(maintenir les données dans la salle de classe, modèles quantized pour réduire l'impact environnemental) avec les risques habituels d'hallucination, mauvaise utilisation non supervisée

## Encourager et non pas remplacer le fait de penser par soi-même

Encourager l'évaluation \alert{formative} plutôt que sommative, les explications personnalisées, aider les tuteurs à valider du feedback automatique personnalisé

Il n'est plus pertinent d'évaluer uniquement le \alert{résultat} (car nous ne savons pas qui l'a fait ;
si un enseignant donne une dissertation, ce n'est pas pour le produit final mais pour l'exercice de réflexion)  
Devrions-nous évaluer le \alert{raisonnement} des élèves ? En utilisant des données de réflexion à voix haute et des LLM hors ligne ?

# Merci pour votre attention

Ces slides sont sur \url{https://jjv.ie/slides/esilv.pdf}

\hfill \texttt{jill-jenn.vie@inria.fr}

# Bonus : Tordre le cou aux bulles de filtre

Je ne dis pas que ça n'existe pas (cf. polarisation sur les réseaux sociaux, élections, etc.)

Mais avant les systèmes de recommandation, on était dans nos bulles de filtre physiques.

Un moteur de recherche ou un LLM a lu beaucoup plus de choses que nous (polydisciplinaires) :

- peut nous amener vers des choses où on ne serait pas naturellement allé  
Ex. le système de recommandation est le reflet de la multitude de notes
- LLM capables de repérer qu'un même concept a des noms différents dans différentes disciplines, différentes langues
- multiplier les points de vue (jeu de rôle) et différences culturelles
