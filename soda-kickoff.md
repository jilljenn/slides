% Diversified recommendations of cultural activities with personalized determinantal point processes
% Carole Ibrahim; Hiba Bederina; Daniel Cuesta;\newline Laurent Montier; Cyrille Delabre; Jill-Jênn Vie
% Soda kick-off seminar, June 3, 2025
---
aspectratio: 169
colorlinks: true
institute: \includegraphics[height=1.2cm]{figures/passculture.jpg} \quad \includegraphics[height=1.2cm]{figures/inria.png}
header-includes: |
  ```{=tex}
  \def\E{\mathbb{E}}
  \usepackage{booktabs}
  \def\hfilll{\hspace{0pt plus 1 filll}}
  ```
---

# Pass Culture

Since 2019, the French government awards a fixed credit to 3 million young individuals (aged 15-20) to spend on $\sim$ 1 million possible activities (books, cinema, opera, etc.).

We want to:

- increase youth participation in cultural activities
- broaden their cultural horizons: make them discover new things

How to model it? (1.5 year project)

# Industrial recommender systems are vector databases

Among the million of offers, only 1500 are selected for ranking

Vector database: approximate nearest neighbor according to a query vector

![](figures/culture-post.png)

- One model for retrieval (two-tower model $\sim$ neural collaborative filtering)
- Another one for top $K$ ranking (LightGBM; I also tried skrub)

# Reward metrics (key performance indicators) of Pass Culture

Relevance: click-through rate (booking rate)

Diversification points obtained for each new category / genre / location (increase in cultural diversity); those scores are not visible to the user, but for stakeholders

![](figures/culture-div.png)

It somehow has limitations

# 

![](figures/pass1.png)

# 

![](figures/pass2.png)

# 

![](figures/pass3.png)

# Geometric modeling of diversity

\centering
![](figures/vol.png){width=80%}

- Determinant = square of volume of parallelotope of vectors
- Vectors that are not correlated increase the volume
- We want to sample items proportionally to diversity

# 

\centering

![](figures/sartre2.png)

# Quality-diversity decomposition for recommendation

- $q_i > 0$ is a possibly personalized measure of \alert{quality} of item $i$ for the current user
- $\phi_i$ is a unit semantic embedding of item $i$, $||\phi_i|| = 1$, used for \alert{diversity} sampling

Similarity matrix $K = X X^T$ and $K_{ij} = x_i^T x_j$ can be decomposed as $q_i \phi_i^T \phi_j q_j$

## Metrics of a set $S$ for a user

:::::: {.columns}
::: {.column width=50%}
1. Relevance, i.e. click-through rate

$$ \frac1{|S|} \sum_{i \in S} q_i$$

2. Volume formed by set $S$

$$Vol(S)$$

3. Diversification is the increase in diversity

$$\Delta \simeq Vol(H \cup S) - Vol(H)$$

where $H$ is history of items for a given user.
:::
::: {.column width=50%}
## Our sampling objective

Sampling a set $S$ proportional to $\det K_S$

$$\log \det K_S = \underbrace{\sum_{i \in S} \log q_i}_{\textnormal{quality}} + 2 \underbrace{\log Vol(S)}_{\textnormal{diversity}}$$

:::
::::::

# DPP

If we sample among $n$ items  
$K : n \times n$ \alert{similarity matrix} on items (positive semi-definite)

$P$ is a \alert{determinantal point process} if sample $Y$ verifies:
$$ \forall A \subset \{1, \ldots, n\}, \quad P(A \subseteq Y) \propto det(K_A) = Vol(\{x_i\}_{i \in A})^2 $$
where $K_A$ has subset $A$ of rows and columns.

There is a $O(nk^3)$ algorithm for sampling $k$ items among $n$, at the cost of knowing its eigenvalues in $O(n^3)$, or $O(nd^2)$ for the linear kernel.

## Example for sampling 3 points among 4

\begin{columns}
\begin{column}{0.5\textwidth}
\[ K = \left(\begin{array}{cccc}
1 & 2 & 3 & 4\\
2 & 5 & 6 & 7\\
3 & 6 & 8 & 9\\
4 & 7 & 9 & 1
\end{array}\right) \]
\end{column}
\begin{column}{0.5\textwidth}
$A = \{1, 2, 4\}$ will be included with probability proportional to
\[ K_A = det\left(\begin{array}{ccc}
1 & 2 & 4\\
2 & 5 & 7\\
4 & 7 & 1
\end{array}\right) \]
\end{column}
\end{columns}

# Compromise quality-diversity

:::::: {.columns}
::: {.column width=50%}
## SVD naive top $K$

![](figures/pass-svd.png)

Several Star Wars movies in the set
:::
::: {.column width=50%}
## $k$-DPP

![](figures/pass-dpp.png)
:::
::::::  

# Evaluation

We conducted offline and online experiments (A/B/C test) on 400k users during 10 days.

- Version A (baseline): recommender system
- Version B: DPP filter using personalized quality scores $q_i$
- Version C: DPP filter using $q_i = 1$

DPPs are implemented in DPPy by former colleague Guillaume Gautier at Inria Lille

\vfill

\small

\fullcite{Gautier2019}

# Stochastic or deterministic?

We sample $k$-DPP proportionally to $\det K_S$

YouTube [@wilhelm2018practical] computes instead the greedy max of $\displaystyle \mathop{\textnormal{argmax}}_{S, |S| = k} \det K_S$

They happily reported "+0.5%" of increased user engagement (significant? \raisebox{-2pt}{\includegraphics{figures/shrug.pdf}})

We hypothesize that a deterministic approach does not cover the catalogue well

\vfill

\small

\fullcite{wilhelm2018practical}

# Results

\begin{table}
\begin{tabular}{ccrc} \toprule
& Relevance & Volume ratio & Diversification \\ \midrule
Model A & \textbf{0.525} & 1 & 2.759 \\
Model B & 0.399 & $\times$24.7 & \textbf{3.404} \\ 
Model C & 0.381 & $\times$\textbf{28.8} & \textbf{3.482} \\ \bottomrule
\end{tabular}
\caption{Offline results comparing baseline (A) vs DPP-based recommenders (B and C).}
\label{tab:offline_results}
\end{table} 

\begin{table}
\begin{tabular}{ccrc} \toprule
& Click rate & Volume ratio & Diversification\\ \midrule
Group A & \textbf{0.54\%} & 1  & 3.132 \\
Group B & 0.34\%* & $\times$12 & \textbf{3.512*} \\ 
Group C & 0.29\%* & $\times$\textbf{15.8}  & \textbf{3.590*} \\ \bottomrule
\end{tabular}
\caption{Online A/B/C test results. Values with * denote statistical significance ($p<0.001$).}
\label{tab:online_results}
\end{table}

# Conditional DPP for directly optimizing diversification

\only<1>{\includegraphics{figures/dpp-cond1.png}}
\only<2>{\includegraphics{figures/dpp-cond2.png}}

# Limitations and future work

:::::: {.columns}
::: {.column width=70%}
- Only 10 days of A/B test; did it change cultural practice over the long term?
- On Pass Culture, 90\% of spendings come from search; young users do not look so much at personalized recommendations
- We got better results with personalized recommendations than constant quality $q_i = 1$ and we can tune a hyperparameter:
$$\log \det K_S = \alert\lambda \underbrace{\sum_{i \in S} \log q_i}_{\textnormal{quality}} + 2 \underbrace{\log Vol(S)}_{\textnormal{diversity}}$$
:::
::: {.column width=30%}
![](figures/pareto.png)

\centering

Higher volume $\to$

\textcolor{gray}{\texttt{arxiv.org/pdf/2108.03888}}
:::
::::::

# Thank you for your attention!

![](figures/fresque.png)

\vfill

My webpage: `jjv.ie` \hfill `jill-jenn.vie@inria.fr`  
(includes source of those slides \url{https://jjv.ie/slides/soda2025.pdf})
