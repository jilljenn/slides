% Données de santé, aberrantes, manquantes, synthétiques
% JJ Vie
% CRCN SCOOL, Inria
---
theme: metropolis
handout: true
header-includes:
  - \usepackage{hyperref}
  - \usepackage{bm}
---

# Données de santé

## Accès aux données SNDS

- Vous devez décrire le périmètre de l'étude et le protocole scientifique
- Faire votre propre demande auprès du HDH et de la CNIL
- Dès que c'est OK le HDH vous donne accès à une instance avec GPU que vous devez payer, avec les données brutes à l'intérieur

## EGB : Échantillon général de bénéficiaires

- Échantillon qui est 1/97 de la population : 660k bénéficiaires
- Accord en 15 jours (accès simplifié depuis 2018)
- Accès renouvelable 24 mois max
- Pas besoin d'avoir l'accord de la CNIL

\footnotesize

\url{https://documentation-snds.health-data-hub.fr/introduction/03-acces-snds.html\#les-acces-sur-projet}

\url{https://www.cnil.fr/fr/la-cnil-met-jour-le-referentiel-sur-les-conditions-de-mise-disposition-de-lechantillon-generaliste}

## Inria-Covid : Entrepôt de données de santé (EDS) de l'AP-HP

### Objectif

Générer automatiquement un dashboard quotidien à destination des cellules de crise[^1]

 [^1]: À partir d'outils open source : JupyterLab, scikit-learn, pandoc, GitLab

Intense : appels 2x/j dont WE, puis 1x/j sauf WE, pendant 3 mois

- Données de tabagisme
- Prédiction de l'aggravation à partir de symptômes Covidom
- Données physiologiques (IMC)
- Mortalité et complications pulmonaires à 30 jours après chirurgie sous COVID-19

## Données aberrantes

### Objectif

Calculer l'IMC de tout le monde

\pause

Réalité :

- Chaque personne a plusieurs données de poids \only<3->{$\in [2, 8000]$}
- Plusieurs données de taille

\pause

Nettoyer les valeurs aberrantes : puis prendre les plus récentes ?

Sinon prendre la médiane des $k$ dernières.

## Données manquantes de chirurgie

![](figures/nb_pcr.pdf)

## Cohorte

- 16200 patients $\geq$ 16 ans pris en charge à l'AP-HP
- Ayant une intervention chirurgicale entre 01/02 et 19/05/2020
- Ayant au moins une PCR SARS-CoV-2

\pause

![](figures/timeline.png)

## Aggravation des patients COVID-19 après chirurgie

![](figures/timeline.png)

![](figures/or0.png){width=50%}![](figures/or1.png){width=50%}

\tiny

R H Khonsari, M Bernaux, J-J Vie, A Diallo, N Paris, L B Luong, J Assouad, C Paugam, T Simon, E Vicaut, R Nizard, E Vibert, on behalf of the AP-HP/Universities/INSERM COVID-19 research collaboration, AP-HP COVID Clinical Data Warehouse initiative, Risks of early mortality and pulmonary complications following surgery in patients with COVID-19, British Journal of Surgery, 2021;, znab007, \url{https://doi.org/10.1093/bjs/znab007}

# Données manquantes

## Modèles graphiques

![](figures/altitude_temperature.png)

\pause

Est-ce l'altitude qui fait diminuer la température ? Ou l'inverse ?

## Un exemple de modèle graphique

âge, comorbidités, etc. $\bm{x} \to_{OR} y$ aggravation

## Modèle graphique de données manquantes

Ex. MCAR, MAR, MNAR

![](figures/missing_obesity.png)

\footnotesize

Mohan and Pearl (2019). Graphical Models for Processing Missing Data https://arxiv.org/pdf/1801.03583.pdf

## EM (Dempster, Laird & Rubin, 1977)

latent $\bm{z} \to_\theta \bm{X}$ observé

Objectif : trouver les paramètres $\theta$ les plus vraisemblables

À tour de rôle :

- calculer le score moyen pour toutes les imputations de variables latentes possibles
- trouver les paramètres qui maximisent ce score

## IP (Tanner & Wong, 1987) ~ Gibbs sampling

À tour de rôle :

- Imputer les variables manquantes
- Mettre à jour les paramètres sachant les données complètes

\footnotesize

Zhang, Zhihua, Dit-Yan Yeung, and James T. Kwok (ICML 2004). Bayesian inference for transductive learning of kernel matrix using the Tanner-Wong data augmentation algorithm. \url{https://www.cse.ust.hk/~jamesk/papers/icml04b.pdf}

Schafer, Joseph L. (1997). Analysis of incomplete multivariate data. CRC press. \url{https://ii.uni.wroc.pl/~bitro/wojtki/e_book/Analisis/4061ch05.pdf}

## Et pourquoi on ne ferait pas comme ça ?

Imputation multiple ~ analyse de sensibilité

Alterner entre imputation / apprentissage / imputation etc.

$\bm{z} \to_\theta \bm{x} \to_{OR} y$

## Complétion de matrice

On vous donne des notes d'utilisateurs sur des films, vous devez prédire de nouvelles paires (utilisateur, film).

99 % de données manquantes

SVD : $R \simeq U \Sigma V^T$ où $U$, $V$ ortho et $\Sigma$ diag

Factorisation binaire (IRT) : $R \simeq \sigma(U V^T)$

KNN : imputer la moyenne des voisins

Dictionary learning : $R \simeq DA$ où $D$ de norme $\leq 1$ et $A$ creuse.

## La complétion de matrice à l'échelle (12 Mpx)

![](figures/dictionary_learning.png)

## Retour au contexte des données manquantes

Méthode | Données continues | Données mixtes (+ catégorielles)
--- | --- | ---
SVD | OK | NOK
KNN | OK | OK

Imputation multiple (Amelia)

## Un exemple : fraudes sur la consommation de gaz

50 % de données manquantes

![](figures/results_gas.png)

\footnotesize

\url{https://www.math.univ-toulouse.fr/~besse/Wikistat/pdf/st-m-app-idm.pdf}

## Plus récemment

![](figures/missing_edge_prediction.png)

\footnotesize

You et al. (NeurIPS 2020). Handling Missing Data with Graph Representation Learning \url{https://arxiv.org/abs/2010.16418}

## Résultats

![](figures/missing_graph_results.png)

## D'autres variantes

Seulement des exemples positives (implicit feedback)  
$\to$ méthodes de ranking

Certains points non étiquetés : Positive Unlabeled (PU) learning

![](figures/pu_learning.png)

# Données synthétiques

## Asian Bayesian network

![](figures/asia-bayesian.png)

Générer un jeu de données synthétique pour préserver la confidentialité des patients (PrivBayes, Synthetic Data Vault \url{sdv.dev})

## Compétition NeurIPS Hide-and-Seek

![](figures/hide_and_seek.png)

## En bref

- KNN et SVD me semblent de bonnes baselines pour imputer
- J'espère que le SNDS servira à imputer les données manquantes
- (et pas juste à réidentifier les gens)

Deux communautés de recherche différentes :

- validation croisée vs. valeurs $p$
- inférence bayésienne vs. imputations multiples

Second ACM Conference on Health, Inference, and Learning

April 8--9, 2021

30 USD

\url{https://www.chilconference.org/}
