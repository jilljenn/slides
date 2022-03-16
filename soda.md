% Regression with sparse features\newline and side information
% Jill-Jênn Vie
% March 16, 2022
---
institute: \includegraphics{figures/soda.png}
colorlinks: true
header-includes:
    - \usepackage{bm}
    - \usepackage{minted}
    - \DeclareMathOperator\logit{logit}
    - \def\Dt{D_\theta}
    - \def\E{\mathbb{E}}
    - \def\logDt{\log \Dt(x)}
    - \def\logNotDt{\log(1 - \Dt(x))}
---

# Problem

Observe data of users with different trajectories

Ex. user $i$ liked items $j_1, j_2$ disliked $j'_1, j'_2$

We may assume (or train) side information, e.g. item embeddings.

How to infer new pairs (user $i$, item $j$)?

\vspace{1cm}

## Outline

<!-- When dealing with sparse or tabular data, it is common to encounter cold-start problems; and hard to define a similarity metric on sparsely-activated objects that seem very different. In this presentation, we will show how we can get some inspiration from the recommender system literature. The keywords are: factorization machines, positive-unlabeled learning, a bit of optimal transport and most of this work is in progress :) -->

- Matrix factorisation: values in $\mathbb{R}, \{0, 1\}, \{1\}$
- Nearest neighbors, but for what similarity metric?

# Collaborative filtering in recommender systems

Ex. $r_{ij}$ is the rating of user $i$ on item $j$ (usually 99% data missing)

$R \simeq UV \qquad \hat{r}_{ij} = \langle \bm{u}_i, \bm{v}_j \rangle$

\vspace{1cm}

Minimize $\mathcal{L} = \sum_{i, j} ||\hat{r}_{ij} - r_{ij}||^2 + \lambda ||u_i||^2 + \lambda ||v_j||^2$

Ex. if $\lambda = 0$, singular value decomposition SVD : $R = (U' \Sigma) V$

# Binary case

Ex. $r_{ij}$ is 1 if user $i$ answered item $j$ correctly (knowledge tracing)

$R \simeq \sigma(UV) \qquad p_{ij} = Pr(R_{ij} = 1) = \sigma(\langle \bm{u}_i, \bm{v}_j \rangle)$

\vspace{1cm}

Either a MCMC method: sample $U$, train $V$ (Cai, 2010) but slow

\vspace{1cm}

Or train directly: minimize $\mathcal{L} = \sum_{i, j} (1 - r_{ij}) \log (1 - p_{ij}) + r_{ij} \log p_{ij}$ on minibatches of data

\pause

If \mintinline{python}{class_weight="balanced"}, minimize $\mathcal{L} = \E_{pos} \log p_{ij} + \E_{neg} \log (1 - p_{ij})$

# Neural collaborative filtering

Input: concatenation of $\bm{u_i}$ and $\bm{v_j}$

Model: multilayer perceptron

Output: $\hat{r}_{ij}$

\vspace{1cm}

\pause

Please, do not do this.

\small \fullcite{Dacrema2019}

# Logistic regression with sparse features

Let us encode the event (user $i$, item $j$) as a two-hot vector $\bm{x}$:

\centering

![](figures/lr.pdf)


$p_{ij} = \sigma(\langle \alert{\bm{w}}, \bm{x} \rangle) = \sigma(\sum_k \alert{w_k} x_k) = \sigma(\alert{\theta_i} + \alert{e_j})$

# Introducing: factorization machines

Learn bias \alert{$w_k$} and embedding $\alert{\bm{v_k}}$ for each feature $k$ such that:

$$ \logit p(\bm{x}) = \mu + \underbrace{\sum_{k = 1}^N \alert{w_k} x_k}_{\textnormal{logistic regression}} + \underbrace{\sum_{1 \leq k < l \leq N} x_k x_l \langle \alert{\bm{v_k}}, \alert{\bm{v_l}} \rangle}_{\textnormal{pairwise interactions}} $$


If $\bm{x}$ is again two-hot: $\logit p(\bm{x}) = \langle \bm{u_i}, \bm{v_j} \rangle + w'_i + w_j$
we recover binary matrix factorization

\small \fullcite{rendle2012factorization}

# Graphically: factorization machines

\centering

![](figures/fm.pdf)

![](figures/fm2.pdf)

# Trivia: the Blondel Trilogy

Generalizing to $P(\langle \bm{x}, \bm{v}_i \rangle)$ for a polynomial $P$

- Polynomial networks and FMs (ICML 2016)
- Multi-output polynomial networks and FMs (NIPS 2017)
- Higher-order FMs (NIPS 2016)

\vspace{1cm}

\small \fullcite{blondel2016polynomial}

# With biased entries?

Ex. usually we try medications that may work; mainly observe positive outcomes

i.e. $r_{ij} = 1$ for almost all non-missing $(i, j)$

\vspace{1cm}

Ongoing work with Clémence Réda (Inserm $\times$ Inria Scool) in drug repurposing

# Positive-Unlabeled (PU) learning

- Some $\bm{x}_i$ have positive class $y_i = 1$
- Others $\bm{x}_i$ are known but unlabeled: $y_i$ is unknown

Traditional \hfill This setting

![](figures/pu-learning.png)

\hfill (Jaskie & Spanias 2019)

\small \fullcite{du2014analysis}

# Formally: PU learning

- $pos(x)$ represents the density of positive class.
- $\alert{neg}(x)$ (unknown) represents the density of negative class
- $unlab(x) = \pi pos(x) + (1 - \pi) \alert{neg}(x)$ represents the density of unlabeled points
- $\Dt$ is the classifier, i.e. $\Dt(x) = \Pr(y = 1|x)$

Ideally we would like to optimize:

$\mathcal{L}(\theta) = -\E_{pos}[\log \underbrace{\Dt(x)}_{\textrm{should be close to } 1}] - 
    \E_{\alert{neg}}[\log (1 - \underbrace{\Dt(x)}_{\textrm{should be close to } 0})]$

But we can't.

# Density ratio trick

- $unlab(x) = \pi pos(x) + (1 - \pi) \alert{neg}(x)$ represents the density of unlabeled points
- $\Dt$ is the classifier, i.e. $\Dt(x) = \Pr(y = 1|x)$

Ideally we would like to optimize:

$\mathcal{L}(\theta) = -\E_{pos}[\log \underbrace{\Dt(x)}_{\textrm{should be close to } 1}] - 
    \E_{\alert{neg}}[\log (1 - \underbrace{\Dt(x)}_{\textrm{should be close to } 0})]$

But we can't. Fortunately $\alert{neg}(x) = \frac1{1 - \pi} unlab(x) - \frac\pi{1 - \pi} pos(x)$ so:

$\begin{aligned}
\mathcal{L}(\theta) & = & -\E_{pos}[\logDt] - \frac1{1 - \pi} \E_{unlab}[\logNotDt]\\
& & + \frac\pi{1 - \pi} \E_{pos}[\logNotDt]\\
& = & \E_{pos}\left[-\logDt + \frac\pi{1 - \pi} \logNotDt\right]\\
& & - \E_{unlab}\left[\frac1{1 - \pi} \logNotDt\right]
\end{aligned}$

<!--

# Simplifying even more

which, using magic sigmoid tricks $\logNotDt = \logDt - logit(x)$ and $\log(\sigma(u)) = u - \log(e^u + 1)$ can be rewritten as:

$\mathcal{L}(\theta) = \E_{pos}\left[\frac{2\pi - 1}{\pi - 1} \log(\exp(logit(x) + 1) - logit(x)\right]
+ \E_{unlab}\left[\frac1{1 - \pi} \log(\exp(logit(x) + 1)\right]$

So if $L$ is a vector of logits, to compute the loss we need to compute $T = \log(\exp(L) + 1)$ also called $T = softplus(L)$ and the batch we are interested in is:

$\left(\underbrace{\frac1{1 - \pi} T}_{\textrm{if unlabeled}},
       \underbrace{\frac{2\pi - 1}{\pi - 1} T - L}_{\textrm{if positive}}\right)$

-->

# Toy example

Left Gaussian is positive, right Gaussian is negative

Blue is correct, \alert{red} is incorrect

![](figures/pu-example.png)

Trained only on neg \hfill Trained on some pos \hfill PU learning

# Dynamic time warping: metric on time series

$c_{ij}$: cost between $x_i$ and $y_j$ e.g. $c_{ij} = dist(x_i, y_j) = |x_i - y_j|$

$DTW(\bm{x}, \bm{y}) = DTW(n, m)$ where $DTW(0, \cdot) = DTW(\cdot, 0) = 0$ and \vspace{-1cm}

$$ DTW(i, j) = c_{ij} + min \left\{\begin{array}{l}
DTW(i - 1, j)\\
DTW(i, j - 1)\\
DTW(i - 1, j - 1)
\end{array}\right. \quad \begin{array}{l}
\bm{x} = x_1 \cdots x_n\\
\bm{y} = y_1 \cdots y_m
\end{array} $$

\centering

![](figures/dtw.png){width=50%}

# Optimal transport

Find $P : m \times n$ that minimizes $\langle C, P \rangle$ s.t. $P 1_n = \bm{x}$ and $1_m P = \bm{y}$

The minimum value is $W(\bm{x}, \bm{y})$

\centering

![](figures/ot-matrix.png){width=30%}

\raggedright

\small \fullcite{Peyre2019}

# The problem with naive interpolation ($L_2$ is average)

![](figures/ot-bary.png)

# The problem with naive interpolation, 3D

Barycenter for $L_2$ i.e. average \hfill Barycenter for $W$

![](figures/ot-bary2.png)

`pip install POT`

\small \fullcite{Flamary2021}

# Anime posters

![](figures/mangaki-posters.jpg)

![](figures/ratingsim.png){width=48%} ![](figures/visualsim.png){width=48%}

# Poster neighbors

![](figures/mangaki-neighbors.jpg)

# Take home message

- Factorization machines take context into account
    - May be useful to refine crude categories
- Density ratio trick of using unlabeled data for training a classifier
- Optimal transport for metric and possibly generation

\vspace{1cm}

\pause

Thanks! Questions? \hfill These slides on \href{https://jjv.ie/slides/soda.pdf}{jjv.ie/slides/soda.pdf}
