% Using Ratings & Posters\newline for Anime & Manga Recommendations
% Jill-Jênn Vie
% RIKEN Center for Advanced Intelligence Project (Tokyo)\newline Mangaki (Paris)
---
header-includes:
    - \usepackage{tikz}
    - \usepackage{array}
    - \usepackage{icomma}
    - \usepackage{multicol,booktabs}
    - \def\R{\mathcal{R}}
---

# RIKEN Center for Advanced Intelligence Project

![](figures/aip.png)\ 

- RIKEN is the biggest public research institution in Japan
- New AI lab near Tokyo Station (opened in 2016)
- 3 interns from Master Vision Apprentissage in ENS Paris-Saclay
- 8 accepted papers at NIPS 2017

# Recommendation System

## Problem

- Every user rates few items (1 %)
- How to infer missing ratings?

![](figures/cf.jpg)\ 

# Every supervised machine learning algorithm

## fit($X$, $y$)

\centering
\begin{tabular}{ccc} \toprule
\multicolumn{2}{c}{$X$} & $y$\\ \cmidrule{1-2}
\texttt{user\_id} & \texttt{work\_id} & \texttt{rating}\\ \midrule
24 & 823 & like\\
12 & 823 & dislike\\
12 & 25 & favorite\\
\ldots & \ldots & \ldots\\ \bottomrule
\end{tabular}

\pause

## $\hat{y}$ = predict($X$)

\centering
\begin{tabular}{ccc} \toprule
\multicolumn{2}{c}{$X$} & $\hat{y}$\\ \cmidrule{1-2}
\texttt{user\_id} & \texttt{work\_id} & \texttt{rating}\\ \midrule
24 & 25 & \only<2>{?}\only<3>{\alert{disliked}}\\
12 & 42 & \only<2>{?}\only<3>{\alert{liked}}\\ \bottomrule
\end{tabular}

# Evaluation: Root Mean Squared Error (RMSE)

If I predict $\hat{y_i}$ for each user-work pair to test among $n$,  
while truth is $y^*_i$:

$$ RMSE(\hat{y}, y^*) = \sqrt{\frac1n \sum_i (\hat{y}_i - y^*_i)^2}. $$

# Dataset: Mangaki

![](figures/ratings.jpg)\ 

- 2300 users
- 15000 works \textcolor{gray}{\hfill {\em \small anime / manga / OST}}
- 340000 ratings \textcolor{gray}{\hfill {\em \small fav / like / dislike / neutral / willsee / wontsee}}
- User can rate anime or manga
- And receive recommendations
- And reorder their watchlist

\pause

- Code is 100% on GitHub  
- Awards from Microsoft and Japanese Foundation
- Ongoing \alert{data challenge} on `research.mangaki.fr`

# Visualizing movies: movie2vec

\alert{Closer} points mean similar taste

![](figures/svd.png)\ 

# Find your taste

You will \alert{like} movies that are \alert{close to you}

![](figures/svd2.png)\ 

# Variants of Matrix Factorization for Recommendation

$R$ ratings, $C$ coefficients, $P$ profiles ($F$ features).

$R = CP = CF^T \Rightarrow r_{ij} \simeq \hat{r}_{ij} \triangleq C_i \cdot F_j$.

## Objective functions (reconstruction error) to minimize

SVD : $\sum_{i, j}~(r_{ij} - C_i \cdot F_j)^2$ (deterministic)

\pause

ALS : $\sum_{i, j \textnormal{\alert{ known}}}~(r_{ij} - C_i \cdot F_j)^2$

\pause

\alert<6>{ALS-WR} : $\sum_{i, j \textnormal{\alert{ known}}}~(r_{ij} - C_i \cdot F_j)^2 + \lambda (\sum_i \alert<6>{N_i} ||C_i||^2 + \sum_j \alert<6>{M_j} ||F_j||^2)$

\pause

WALS by Tensorflow™ : $$\sum_{i, j} w_{ij} \cdot (r_{ij} - C_i \cdot F_j)^2 + \lambda (\sum_i ||C_i||^2 + \sum_j ||F_j||^2)$$

\pause

## Who do you think wins?

# ALS for feature extraction

$R = CP$

## Issue: Item Cold-Start

- If no ratings are available for an anime  
$\Rightarrow$ no feature will be trained
- If anime features at put to 0  
$\Rightarrow$ prediction of ALS will be constant for every unrated anime.

\pause

## But we have posters!

- On Mangaki, almost all works have a poster
- How to extract information?

# Illustration2Vec (Saito and Matsui, 2015)

\centering

![](figures/fate.png){width=40%}\ 
![](figures/i2v.png){width=40%}\ 

- CNN (VGG-16) pretrained on ImageNet, trained on Danbooru  
(1.5M illustrations with tags)
- 502 most frequent tags kept, outputs \alert{tag weights}

# LASSO for explanation of user preferences

$T$ matrix of 15000 works $\times$ 502 tags

- Each user is described by its preferences $P$  
$\rightarrow$ a \alert{sparse} row of weights over tags.
- Estimate user preferences $P$ such that $r_{ij} \simeq PT^T$.

## Interpretation and explanation

- *You seem to like \alert{\emph{magical girls}} but not \alert{\emph{blonde hair}}  
$\Rightarrow$ Look! All of them are \alert{\emph{brown hair}}! Buy now!*

## Least Absolute Shrinkage and Selection Operator (LASSO)

$$ \frac1{2 N_i} {\lVert \R_i - P_i T^T \rVert}_2^2 + \alpha \alert{ {\lVert P_i \rVert}_1}. $$

\noindent
where $N_i$ is the number of items rated by user $i$.

# Blending

We would like to do:

$$ \hat{r}_{ij}^{BALSE} = \begin{cases}
\hat{r}_{ij}^{ALS} & \text{if item $j$ was rated at least $\gamma$ times}\\
\hat{r}_{ij}^{LASSO} & \text{otherwise}
\end{cases} $$

But we can't. Why?

\pause

$$ \hat{r}_{ij}^{BALSE} = \alert{\sigma(\beta(R_j - \gamma))} \hat{r}_{ij}^{ALS} + \left(1 - \alert{\sigma(\beta(R_j - \gamma))}\right) \hat{r}_{ij}^{LASSO} $$

\noindent
where $R_j$ denotes the number of ratings of item $j$  
$\beta$ and $\gamma$ are learned by stochastic gradient descent.

\pause

\centering

We call this gate the \alert{Steins;Gate}.

# Blended Alternate Least Squares with Explanation

\centering

![](figures/archi.pdf)\ 

\pause

We call this model \alert{BALSE}.

# Results

\centering

![](tables/results.pdf)\ 

# Follow us on Twitter: \alert{@MangakiFR}!

\centering
![](figures/mangaki.png){width=50%}\ 

\raggedright

## Read this article (front page of Hacker News!)

Using Posters to Recommend Anime and Mangas in a Cold-Start Scenario

`https://github.com/mangaki/balse` (PDF is on arXiv)

## Compete to Mangaki Data Challenge: \alert{research.mangaki.fr}

- Who will win? Japan? France? US? Korea? China? You?
