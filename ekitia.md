% Génération de données synthétiques, opportunités et risques
% Jill-Jênn Vie; Antoine Boutet
% Ekitia, 23 novembre 2023
---
institute: \includegraphics[height=1cm]{figures/inria.png} \includegraphics[height=1cm]{figures/soda.png}
aspectratio: 169
biblio-style: authoryear
biblatexoptions: natbib
header-includes:
  - \usepackage{tikz}
---
# Outline

- Données images
- Données tabulaires (1 ligne par humain)
- Traces (plusieurs lignes par humain)
- Règles CNIL : pseudonymisation / anonymisation
- Confidentialité (differential privacy)

# GANs then latent diffusion 

![](figures/chest.png)

\fullcite{weber2023cascaded}

# Mobility data

## People pseudonymize, but it's not enough
@narayanan2008robust managed to de-anonymize a Netflix pseudonymized dataset of seen movies with IMDb

## People $k$-anonymize, but high-dimensional data (e.g. mobility) is rarely $k$-anonymizable

- 4 timestamp-location points are needed to uniquely identify 95\% of individual trajectories in a dataset of 1.5M rows \citep{de2013unique}
- 15 demographic points are enough to re-identify 99.96\% of Americans \citep{rocher2019estimating}

# Tabular data

Mixed continuous and categorical variables

![](figures/tabddpm.png)

# Bad results

![](figures/gen-baseline.png)

# Better results

![](figures/gen-ours.png)

# Results

![](figures/tabddpm-corr.png){width=95%}

Akim Kotelnikov, Dmitry Baranchuk, Ivan Rubachev, Artem Babenko.  
\alert{TabDDPM: Modelling Tabular Data with Diffusion Models.} Proceedings of the 40th International Conference on Machine Learning, PMLR 202:17564-17579, 2023. https://arxiv.org/abs/2209.15421

# Hide and seek NeurIPS challenge

An attacker has to guess, from a broader population, who was in the training set

\centering
\begin{tikzpicture}[
    xscale=3,
    yscale=2,
    data/.style={draw},
    >=stealth
]
\node[data] (original) at (0,0) {Original};
\node[data] (training) at (1,0) {Training set};
\node[data] (fake) at (1,-1) {Fake set};
\node[data,text width=1.6cm,text centered] (real-irt) at (2,0) {Real item params $d$};
\node[data,text width=1.6cm,text centered] (fake-irt) at (2,-1) {Fake item params $\hat{d}$};
\draw[->] (original) edge node[above=3mm] {sampling half users} (training);
\draw[->] (training) edge node[right] {generator} (fake);
\draw[<->] (real-irt) edge node[right] {RMSE} (fake-irt);
\draw[->,dashed,bend right] (original) edge (training);
\draw[->,dashed,bend left=60,text width=2cm,text centered] (fake) edge node[below left] {reidentify\\AUC} (training);
\draw[->] (training) edge node[above] {IRT} (real-irt);
\draw[->] (fake) edge node[above] {IRT} (fake-irt);
\end{tikzpicture}

(framework inspired by NeurIPS "Hide and Seek" challenge in healthcare by \cite{jordon2020hide})

# Problem with pseudonymized data

This is even more possible with mobility data

# According to CNIL

"should not be able to infer new info"

# Risque pour l'intégrité scientifique

Si on peut générer un dataset, on peut aussi générer des choses dont les conclusions

# Attention

- On peut être diff private et inutile (prédicteur constant)
- On peut ne pas être diff private et inutile et sûr quand même (ex. prendre la colonne des user ID)
- On peut être diff private mais avoir des symptômes qui sont corrélés avec un attribut sensible (ex. symptômes du cancer)

# Grâce à des outils open source

- sdv.dev / DataSynthesizer
- Stable Diffusion
- LLaMa pour les LLM

# Diff privacy

![](figures/curves.png)
