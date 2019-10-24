% IA, éducation et formation\vspace{1pt}
% Jill-Jênn Vie\newline\newline\includegraphics[height=0.7cm]{figures/aip-logo.png}\qquad\inria\newline aip.riken.jp \qquad \qquad inria.fr
% 25 octobre 2019
---
theme: Frankfurt
section-titles: false
biblio-style: authoryear
header-includes:
    - \usepackage{booktabs}
    - \usepackage{multicol}
    - \usepackage{bm}
    - \usepackage{multirow}
    - \DeclareMathOperator\logit{logit}
    - \def\ReLU{\textnormal{ReLU}}
    - \def\inria{\includegraphics[height=1cm]{figures/inria.jpg}}
    - \newcommand\mycite[3]{\textcolor{blue}{#1} "#2".~#3.}
biblatexoptions:
    - maxbibnames=99
    - maxcitenames=5
---
# Introduction

## Optimisation de l'apprentissage humain

On observe des données d'apprentissage sur une plateforme  
(évaluation, cours en ligne)

Comment utiliser ces données pour profiter aux autres apprenants ?

### Challenges

- Ne pas poser trop de questions aux apprenants
- Les apprenants évoluent au cours du temps
- Quelles données utiliser ?
- Quelle fonction objectif choisir ?

## Tests adaptatifs

\centering
![](figures/adaptive.pdf)


# Tests de positionnement

## Référentiel de compétences numériques DIGCOMP 2.0

\centering
\includegraphics[width=0.5\linewidth]{figures/digcomp.png}

- Informations et données
  - Ex. rechercher de l'information sur Internet
- Communication collaboration
- Création de contenu
- Protection et sécurité
- Résolution de problèmes

## Certification des compétences numériques

Avant : B2i.

Maintenant :

![](figures/pix.png){width=2cm}

La certification Pix remplace le B2i pour les lycéens  
(JO du 1\textsuperscript{er} septembre 2019)

- 1 intrapreneur au ministère de l'Éducation
- 3 chercheurs concepteurs d'épreuves
- 2 développeurs
- +1 concepteur de l'algorithme adaptatif

## Un exemple de problème Pix

\centering \Large
Dans le village de Montrésor,  
sur quelle rue débouche la rue des Perrières ?

\vspace{1cm} \pause

\normalsize
$\rightarrow$ permet de valider l'acquis \@rechercheInfo3

## Types de tests

### Tests de positionnement

Évaluer son niveau en peu de questions  
Faible enjeu ; basé sur une cartographie des connaissances

### Tests de certification

Fort enjeu : l'apprenant peut le valoriser

### Tests de progression

"Quoi apprendre ensuite ?"  
Optimiser l'apprentissage humain


## Théorie de la réponse à l'item

\centering
![](figures/rasch-curve.pdf)

Utilisé par les certifications PISA, GMAT, etc.

## Exemple de test adaptatif :

- On pose une question de niveau 2
- L'apprenant \alert{réussit}
- On lui pose une question de niveau 6
- L'apprenant \alert{échoue}
- On lui pose une question de niveau 4
- L'apprenant \alert{réussit}
- Il est de niveau 5

## Choisir la bonne fonction à optimiser

\alert{Maximiser l'information} $\rightarrow$ les apprenants échouent 50 % du temps (bien pour l'évaluateur, pas pour les apprenants)

\pause

\alert{Maximiser le taux de succès} $\rightarrow$ on pose artificiellement des questions trop faciles

\pause

\alert{Maximiser la croissance du taux de succès}  
Travaux d'une équipe Inria à Bordeaux (Clement et al. 2015)

\pause

\alert{Identifier une lacune de l'apprenant le plus vite possible}  
(Seznec et al. 2019)

## Algorithme conçu pour Pix

Maximiser le nombre moyen d'acquis validés ou invalidés

Le code source de l'algorithme adaptatif est \alert{ouvert}  
(pix.fr, code sur GitHub sous licence AGPLv3)  
Déjà 350 000 comptes créés, 50 000 certifications délivrées

\centering
\includegraphics[width=\linewidth]{figures/example.pdf}

**Article**

:   \scriptsize\mycite{Jill-Jênn Vie, Fabrice Popineau, Françoise Tort, Benjamin Marteau, and Nathalie Denos (2017)}{A Heuristic Method for Large-Scale Cognitive-Diagnostic Computerized Adaptive Testing}{ACM Conference on Learning at Scale}

## Le but de cette étape ?

\centering

![](figures/embedding1.png){width=60%}

## Identifier les points forts

![](figures/embedding2.png)

## Et les lacunes

![](figures/embedding3.png)

## Le niveau évolue au cours du temps

\centering

![](figures/dkt.png)

Si l'on peut simuler l'apprentissage,  
alors on peut optimiser l'apprentissage

# Systèmes de recommandation

## Systèmes de recommandation

### Exemple

\begin{tabular}{ccccc}
& \includegraphics[height=2.5cm]{figures/1.jpg} & \includegraphics[height=2.5cm]{figures/2.jpg} & \includegraphics[height=2.5cm]{figures/3.jpg} & \includegraphics[height=2.5cm]{figures/4.jpg}\\
Sacha & \only<1>{?}\only<2>{\alert{3}} & 5 & 2 & \only<1>{?}\only<2>{\alert{2}}\\
Ondine & 4 & 1 & \only<1>{?}\only<2>{\alert{4}} & 5\\
Pierre & 3 & 3 & 1 & 4\\
Joëlle & 5 & \only<1>{?}\only<2>{\alert{2}} & 2 & \only<1>{?}\only<2>{\alert{5}}
\end{tabular}

## Cartographie des goûts

![](figures/svd2.png)

## Comment faire si on n'a pas, ou trop peu, de notes ?

Quelles autres données sont à notre disposition ?  
(texte, image, vidéo)

## Pour les films : nous avons des posters !

![](figures/posters.png)

## Illustration2Vec (Saito and Matsui, 2015)

\centering

![](figures/fate2.png){height=70%}\ 
![](figures/i2v.png){height=70%}\ 

- Réseau de neurones entraîné sur des millions de photos
- Puis réentraîné sur 1,5M illustrations de manga, avec tags
- Renvoie les tags les plus probables parmi 502 possibles

## Autres types de données

Signaux explicites : notes des utilisateurs

Signaux implicites : à quel point un item les intéresse, etc.

\vspace{1cm}

Pour en savoir plus : `https://github.com/mangaki/zero`

# Mémoire

## Duolingo

\centering
\includegraphics[width=0.42\linewidth]{figures/reverse_tap.png}

## Données de Duolingo (data challenge)

![](figures/duolingo.png)

![](figures/duolingo2.png)

## Systèmes à répétition espacée (Leitner, 1970s)

\includegraphics[width=0.5\linewidth]{figures/anki.png}\includegraphics[width=0.5\linewidth]{figures/leitner.png}

## Modélisation de la mémoire

Optimiser la planification de cartes

Notre solution :

- compter le nombre d'essais (heure, jour, semaine, mois, $\infty$)
- compter le nombre de succès dans ces mêmes temps

Apprendre par machine learning :

- la difficulté des exercices
- celle des acquis
- le progrès par essai et par succès

**Article**

:   \scriptsize
\mycite{Benoît Choffin, Fabrice Popineau, Yolaine Bourda, and Jill-Jênn Vie (2019)}{DAS3H: Modeling Student Learning and Forgetting for Optimally Scheduling Distributed Practice of Skills}{\alert{Best Paper Award at EDM 2019}}

## Mémoriser le nombre d'essais

\centering
![](figures/time-windows.pdf)

# Conclusion

## Points à retenir

\alert{Tests de positionnement} Importance d'adapter l'évaluation,  
et de bien choisir la fonction à optimiser (évaluation, progression)

\alert{Systèmes de recommandation} Plus proches voisins  
Des données de tout type peuvent améliorer la précision,  
mais attention encore aux biais

\alert{Mémoire} En simulant l'humain au plus près,  
on peut optimiser l'enseignement

## Merci pour votre attention !

\centering
Jill-Jênn Vie  
Twitter : \@jjvie  
`vie@jill-jenn.net`

Questions ?
