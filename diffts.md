% \only<1>{Constrained Decision Transformer\newline for Offline Safe Reinforcement Learning} \only<2>{Thompson Sampling with Diffusion Generative Prior}
% Jill-Jênn Vie
% MILLE CILS 2023
---
title-meta: Thompson Sampling with Diffusion Generative Prior
aspectratio: 169
institute: \includegraphics[height=1cm]{figures/inria.png} \includegraphics[height=1cm]{figures/soda.png}
header-includes:
  - \def\R{\mathbf{R}}
  - \def\E{\mathbb{E}}
---
I changed the paper at test time

:::::: {.columns}
::: {.column width=80%}
- Decision Transformer: Reinforcement Learning via Sequence
Modeling (NeurIPS 2021).
- Constrained Decision Transformer for Offline Safe Reinforcement Learning (ICML 2023).

*We make the assumption that the dataset is both \alert{clean} and
\alert{reproducible}, meaning that any trajectory in the dataset can
be reliably reproduced by a policy*

\vspace{5mm}

- Thompson Sampling with Diffusion Generative Prior (ICML 2023)

*To capture realistic bandit scenarios, we propose a novel diffusion model training procedure that trains from \alert{incomplete} and \alert{noisy} data, which could be of independent interest.*
:::
::: {.column width=20%}
\vspace{1cm}

![](figures/drake.jpg)
:::
::::::

# Context

It is boring to learn from scratch in bandits, it is important to have a good prior

How to learn\only<2>{ \alert{a diffusion model}} from noisy and partial information?

\centering

![](figures/mab.png){width=80%}

\small (stolen from 2205.10113)

# Setting

- Pull arm $a_t \in [K]$ receive reward $r_t \in \R$
- Gaussian reward with \alert{known} variance $\sigma^2$

Thompson sampling:

- Given prior over rewards
- Based on history $(a_s, r_s)_{s \in [t - 1]}$
- Guess mean reward vector $\tilde\mu_t$ at round $t$
- Pull arm $a_t \in \arg \max_{a \in A} \tilde\mu^a_t$
- (Update posterior based on observation)

The idea is to use a diffusion model to learn the prior over rewards, in a meta-training scheme where either:

- Meta-training set are exact $\mu_B$
- Meta-training set contains incomplete and noisy data

# Meta-Challenge

*For a vector $x$, $x^a$ represents its $a$-th coordinate, $x^2$ represents its coordinate-wise square*

\pause

\centering

\scalebox{4}{$\huge x_{i,\ell}^a$}

\raggedright

- $i$ position in the training set, round of bandit
- $\ell \in [L]$ step in diffusion
- $a$ component, i.e. observed action

# Challenge I: partial information

At round $t$ we only observe component $a_t$ still we want to update the posterior of the diffusion model.

Sample from $q(X_0|y) \propto q(y|X_0) q(X_0)$ where $y$ contains partial noisy observations of $X_0$

\centering

![](figures/diffTS-small.pdf){width=70%}

\raggedright

# About diffusion

The forward process is Markovian $q(x_{1:L}|x_0) = \prod_{\ell = 0}^{L - 1} q(x_{\ell + 1}|x_\ell)$

A denoising diffusion model is an approximation of the reverse process $q(x_{0:L - 1} | x_L) = \prod_{\ell = 0}^{L - 1} q(x_\ell | x_{\ell + 1})$

- Forward $q\left(x_\ell | x_{\ell - 1}\right)$ is defined Gaussian $\mathcal{N}\left(x_\ell; \sqrt{1 - \beta_\ell}x_{\ell - 1}, \beta_\ell I\right)$
- Reverse $q(X_\ell | x_{\ell + 1})$ is not Gaussian
- $q(X_\ell | x_{\ell + 1}, x_0)$ is Gaussian but $x_0$ is unknown, it is what we want

Therefore, we estimate $x_0$:

- $\widehat{x_0} = h_\theta(x_{\ell + 1}, \ell + 1)$ where $\theta$ are parameters of a neural network
- $p(X_\ell | x_{\ell + 1}) = q(X_\ell | x_{\ell + 1}, X_0 = \widehat{x_0})$ is a Gaussian that depends on $h_\theta$ and $\beta_{1:\ell + 1}$ only

$$ \textnormal{ minimize $ELBO$} \Leftrightarrow \textnormal{minimize } \sum_{\ell = 1}^L \E_{x_0 \sim Q_0, x_\ell \sim X_\ell|x_0} || x_0 - h_\theta(x_\ell, \ell) ||^2 $$

# Challenge II: partial and noisy information

Cannot observe $x_0$ but a noisy version of it $\to$ Stochastic EM-like procedure

\centering

![](figures/diffusion-training-EM.pdf){width=50%}

\raggedright

What loss $\mathcal{L}$?

- If log-likelihood of samples: low-quality samples at early stage of training
- If denoising loss $\sum_{x_{0:L} \in D} \sum_{\ell = 1}^L || x_0 - h_\theta(x_\ell, \ell) ||^2$: same problem

Instead they choose (Metzler et al. 2018; Zhussip et al. 2019)

\centering

![](figures/diffts-em-loss.png){width=65%}

\raggedright

where $\lambda = 0$ encourages exploration.

# Results

Recommender system \hfill Bidding on auctions \hfill Getting out from a maze

![](figures/diffts-results.png)

Up: real means, down: perturbed means

# Thanks

Yu-Guan Hsieh, Shiva Kasiviswanathan, Branislav Kveton, Patrick Blöbaum.  
\alert{Thompson Sampling with Diffusion Generative Prior.} Proceedings of the 40th International Conference on Machine Learning, PMLR 202:13434-13468, 2023. \url{https://arxiv.org/abs/2301.05182}

\vspace{1cm}

jill-jenn.vie@inria.fr / jjv.ie
