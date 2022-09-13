% Privacy-Preserving Synthetic Educational Data Generation
% Jill-Jênn Vie; \alert{Tomas Rigaux}; Sein Minn
% September 15, 2022
---
institute: \includegraphics[width=2cm]{figures/soda.png}
colorlinks: true
biblio-style: authoryear
biblatexoptions: natbib
header-includes:
    - \usepackage{bm}
    - \usepackage{tikz}
    - \usepackage{booktabs}
    - \usepackage{colortbl}
    - \DeclareMathOperator\logit{logit}
    - \def\Dt{D_\theta}
    - \def\E{\mathbb{E}}
    - \def\logDt{\log \Dt(x)}
    - \def\logNotDt{\log(1 - \Dt(x))}
---

# Intro

- It is hard to get access to sensitive data
- A dataset posted online may be archived forever
- How about having instead access to:
    - statistics
    - conditional probabilities
    - a fake dataset? (ex. for reproducibility)

# Outline

- Privacy
- Metrics: utility and re-identification
- Attack models
    - Membership inference
    - Heuristic attacker

# Striking facts

## People pseudonymize, but it's not enough
@narayanan2008robust managed to de-anonymize a Netflix pseudonymized dataset of seen movies with IMDb

## People $k$-anonymize, but high-dimensional data (e.g. mobility) is rarely $k$-anonymizable

- 4 timestamp-location points are needed to uniquely identify 95\% of individual trajectories in a dataset of 1.5M rows \citep{de2013unique}
- 15 demographic points are enough to re-identify 99.96\% of Americans \citep{rocher2019estimating}

<!---
# Differentially private graphical models

## $\varepsilon$-differential privacy

$$ \left|\log \frac{Pr(A(D_1) \in S)}{Pr(A(D_2) \in S)}\right| \leqslant \varepsilon $$

for all datasets $D_1$ and $D_2$ that differ on a single element  
for all possible subsets $S$ (of $\textnormal{Im } A$)

## PrivBayes \citep{zhang2017privbayes}

![](figures/privbayes.png){width=50%}

However, we need a dynamic model
-->

# Intuition

Knowledge embeddings are safe to be shared

User embeddings however should be drawn from distribution

\centering

![User embeddings for Assistments 2009](figures/gaussian.png){width=50%}

# Example data

\begin{table}[h]
%\caption{Example of minimal tabular dataset.}
\label{example-dataset}
\centering
\resizebox{\textwidth}{!}{%
\begin{tabular}{ccc} \toprule
user ID & action ID & outcome \\ \midrule
2487 & 384 & 1 \\
2487 & 242 & 0 \\
2487 & 39 & 1 \\
2487 & 65 & 1 \\ \bottomrule
\end{tabular}
\arrayrulecolor{white}
\begin{tabular}{l} \toprule
description \\ \midrule
user 2487 got token ``I'' correct \\
user 2487 got token ``ate'' incorrect \\
user 2487 got token ``an'' correct \\
user 2487 got token ``apple'' correct \\ \bottomrule
\end{tabular}
}
\arrayrulecolor{black}
\end{table}

So in our case there are two models:

- Sequence generation: Predicting the next action ID (Markov chain, RNN)
- Response pattern generation: Predicting  the outcome given user ID and action ID (IRT, Bayesian networks)

# Item response theory for response pattern generation

Ex. $r_{ij}$ is 1 if user $i$ got a positive outcome on action (item) $j$

$$p_{ij} = \Pr(R_{ij} = 1) = \sigma(\theta_i - d_j)$$

\noindent
where $\theta_i$ is ability of user $i$ and $d_j$ is difficulty of action $j$

\vspace{1cm}

Trained using Newton's method: minimize log-loss $\mathcal{L} = \sum_{i, j} (1 - r_{ij}) \log (1 - p_{ij}) + r_{ij} \log p_{ij}$

# Logistic regression with sparse features

Let us encode the event (user $i$, item $j$) as a two-hot vector $\bm{x}$:

\centering

![](figures/lr-diff.pdf)


$p_{ij} = \sigma(\langle \alert{\textbf{w}}, \textbf{x} \rangle) = \sigma(\sum_k \alert{w_k} x_k) = \sigma(\alert{\theta_i} - \alert{d_j})$


# Utility

\centering
Practictioners who conduct study on the real and fake dataset should have \alert{similar} findings

$\downarrow$

Trained model on original dataset should have parameters that are \alert{not too far} in RMSE

\raggedright

We also consider weighted RMSE:

$$ wRMSE = \sqrt{\sum_{j = 1}^N w_j (d_j - \widehat{d_j})^2} $$

where $w_j \in [0, 1]$ is the frequency of action $j$ in the training set, and $d_j, \widehat{d_j}$ are the original and generated inferred difficulties.

# Membership inference: Reidentification task

\centering
It should not be easy to re-identify people / the fake dataset should not leak too much information about participants

$\downarrow$

An attacker has to guess, from a broader population, who was in the training set (predict 1 if in training, 0 otherwise)

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

# Exaample scenarios of membership inference

Membership inference seems innocuous, but could lead to privacy issues.

For instance, if we want to publish a dataset of test results for students with special needs using an anonymizing method, it shouldn't be possible to guess who was selected to generate the published dataset.

Should the system be able to adapt to people with special needs, without guessing the condition?

More generally, any leak of information is potentially bad

# Reidentification

We use a heuristic based on Longest Common Subsequence (LCS) to reidentify

\begin{figure}
\centering
\begin{tikzpicture}[scale=0.5]
\node at (0, 0) {384};
\node at (2, 0) [draw=blue] {39};
\node at (4, 0) [draw=blue] {39};
\node at (6, 0) {65};
\node at (8, 0) [draw=blue] {17};
\draw (-2, 1) -- (10, 1);
\node at (-1, 2) {65};
\node at (1, 2) {39};
\node at (3, 2) [draw=blue] {39};
\node at (5, 2) [draw=blue] {39};
\node at (7, 2) [draw=blue] {17};
\node at (9, 2) {242};
\end{tikzpicture}

LCS: $39 - 39 - 17$ with length 3
\end{figure}

For each user in the original dataset, this heuristic gives a \alert{matching score}, and we compute the Area under the ROC curve (AUC) associated with those scores for the training dataset classification task

Users with too few actions (in the information entropy sense) are excluded

# Histogram of actions ($y$-axis: frequency)

\centering

![](figures/hist-assist-markov.pdf)

Actions

# Quantitative results

![](figures/auc-wrmse-assist.pdf){width=49%}
![](figures/auc-wrmse-duolingo.pdf){width=49%}

$\downarrow$ low distance between real and fake parameters, lower is better (high utility)

$\leftarrow$ low reidentification score, lower is better (hard to identify)

<!---
# Slided bag of events for SNDS

![](figures/slided_boe_corr.png)

# A bad example

![](figures/aegan.png)

# A good example

![](figures/aeplot2.png){width=100%}
-->

# Take home message

- Let's share the data of people who do not exist

\vspace{1cm}

\pause

Thanks! Questions? \hfill These slides on \href{https://jjv.ie/slides/ectel2022.pdf}{jjv.ie/slides/ectel2022.pdf} and the code on \href{https://github.com/Akulen/PrivGen}{github.com/Akulen/PrivGen}
