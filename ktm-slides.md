% (Deep?) Factorization Machines\newline for Optimizing Human Learning
% Jill-Jênn Vie\newline RIKEN Center for Advanced Intelligence Project
% April 16, 2018
---
header-includes:
    - \usepackage{booktabs}
    - \usepackage{multirow}
    - \usepackage{biblatex}
    - \addbibresource{biblio.bib}
    - \usepackage{bm,bbm}
    - \def\R{\mathbf{R}}
biblio-style: authoryear
handout: true
suppress-bibliography: true
nocite: |
    @Vie2018
---

# Tokyo lights by night (Shibuya)

\includegraphics[width=\linewidth]{figures/shibuya.jpg}

# Tokyo cherry blossoms by day (Shinjuku Gyoen)

\includegraphics[width=\linewidth]{figures/hanami.jpg}

#

\includegraphics[width=\linewidth]{figures/aip.jpg}

## Teams (Tokyo, Nihonbashi)

- Variational Inference, Discrete Optimization, Continuous Optimization
- Reinforcement Learning, Deep Learning, etc. (50 teams)

> - 500 GPU
> - 8 papers at NIPS
> - \alert{62.5} GPU per NIPS paper!

# Research interests

## Modeling data that comes from humans

- Rating data of users over movies
- Correct or incorrect attempts of students over questions
- Crowdsourcing: the true label is unknown

Terminology:

- \alert{user}: consumer, examinee, student
- \alert{item}: movie, question, exercise

# Context: Educational Data Mining

How to use logs to optimize the sequences of exercises?  
*(user $i$ attempted item $j$ and got it correct/incorrect)*

- Ask highly informative questions to reduce the length of tests
    - Item Response Theory (Hambleton et al. 1991)
    - SPARFA [@vats2013test]
- Measure knowledge over attempts
    - Knowledge Tracing [@corbett1994knowledge]
    - Performance Factor Analysis (Pavlik et al. 2009)
- Optimize progress of learner
    - Multi-Armed Bandits [@clement2013multi]

\pause
This talk [@Vie2018]:

- but they're all \alert{factorization machines} (except the latter)
- is data important?
- is dimension important?

# Collaborative filtering

\includegraphics[width=\linewidth]{figures/cf.jpg}

## Sparse data

- Users rate 1% of items
- $(i, j, r_{ij})$ where $r_{ij} \in \mathbf{R}$ is the rating of user $i$ over item $j$.

# Feature extraction

\includegraphics[width=\linewidth]{figures/svd.png}

# Feature extraction

\includegraphics[width=\linewidth]{figures/svd2.png}

# What about educational data?

\centering
\includegraphics[width=0.5\linewidth]{figures/mirt-here.png}

# Interpreting the components

\centering
\includegraphics[width=\linewidth]{figures/inter1.jpg}

# Interpreting the components

\centering
\includegraphics[width=\linewidth]{figures/inter2.jpg}

Useful for providing \alert{feedback} to the user

# A first simple, yet reliable model: Item Response Theory

- $R_{ij} \in \{0, 1\}$ outcome of user $i$ over item $j$ (right/wrong)
- $\alert{\theta_i}$ ability of user $i$
- $\alert{d_j}$ difficulty of item $j$
- Sigmoid $\sigma : x \mapsto 1 / (1 + \exp(-x))$

$$ \Pr(R_{ij} = 1) = \sigma(\alert{\theta_i} - \alert{d_j}). $$

## Training

- Learn $\alert{\theta_i}$ and $\alert{d_j}$ for historical data (maximizing log-likelihood)
- For a new examinee $i$: keep $d_j$ learn $\alert{\theta_i}$
    - Initialize $\hat\theta^{(0)} = 0$
    - For each time $t = 0, \ldots, T - 1$:
        - Ask question of difficulty $d_j$ closest to student ability $\hat\theta^{(t)}$  
        (proba closest to 1/2)
        - Refine student ability $\hat\theta^{(t + 1)}$ (maximum likelihood estimate)  

# How to add side information?

Usually, collaborative filtering:

$$ r_{ij} = \mu + \mu_{ui} + \mu_{vj} + \bm{u_i}^T \bm{v_j} $$

How to model that the movie was seen on TV, or at the cinema?

\pause

$$ r_{ij} = \mu + \mu_{ui} + \mu_{vj} + \mu_{TV} + \bm{u_i}^T \bm{v_j} + \bm{u_i}^T \bm{w_{TV}} + \bm{v_j}^T \bm{w_{TV}} $$

# Factorization machines [@rendle2012factorization]

- Encode each instance into sparse features ${(x_k)}_k$ over $N$ entities
- Learn a bias $\alert{w_k}$ and an embedding $\alert{\bm{v_k}}$ (dim $d$) for each entity $k$

$$ y_{FM}(\bm{x}) = \mu + \sum_{k = 1}^N \alert{w_k} x_k + \sum_{1 \leq k, l \leq N} x_k x_l \alert{\bm{v_k}^T} \alert{\bm{v_l}} $$

## Special case: collaborative filtering

If $\bm{x} = (\mathbf{1}_i^n, \mathbf{1}_j^m)$ where $\mathbf{1}_i^n$ is a one-hot $n$-dim vector with $i$-th at 1:

\begin{align*}
y_{FM}(x) & = \mu + w_i + w_{n + j} + \bm{v_i}^T \bm{v_{n + j}}\\
r_{ij} & = \mu + \mu_{ui} + \mu_{vj} + \bm{u_i}^T \bm{v_j}
\end{align*}

# Example of FM with educational data

\centering
\includegraphics[width=\linewidth]{figures/fm-poster.jpg}

Rows are instances $\bm{x}$, columns are entities $k$  
Roses are red, violets are blue

# Item Response Theory is a FM

$$ y_{FM}(\bm{x}) = \mu + \sum_{k = 1}^N \alert{w_k} x_k + \sum_{1 \leq k, l \leq N} x_k x_l \alert{\bm{v_k}^T} \alert{\bm{v_l}} $$

If $d = 0$ and $x = (\mathbf{1}_i^n, \mathbf{1}_j^m)$ for $n$ users, $m$ items:

$$ \sigma(y_{FM}(\bm{x})) = \sigma(w_i + w_{n + j}) = \sigma(\theta_i - d_j) $$

where $\bm{w} = (\bm{\theta}, -\bm{d})$ (concatenation).

We made similar observations for other educational data mining models.

<!-- # Performance Factor Analysis

Successful attempts -->

# Training of FMs

$$ y_{FM}(\bm{x}) = \mu + \sum_{k = 1}^N \alert{w_k} x_k + \sum_{1 \leq k, l \leq N} x_k x_l \alert{\bm{v_k}^T} \alert{\bm{v_l}} $$

- Encoding each triplet $(i, j, r_{ij})$ into instance $\bm{x}_{ij}$ and truth $r_{ij}$
- Maximize the log-likelihood of prediction $\Phi(y_{FM}(\bm{x}_{ij}))$ and $r_{ij}$  
with the following priors: \vspace{-1cm}

\begin{align*}
w_k, v_{kf} \sim \mathcal{N}(\mu, 1/\lambda)\\
\mu \sim \mathcal{N}(0, 1)\\
\lambda \sim \Gamma(1, 1).
\end{align*}

$\Phi = \textnormal{probit}$[^1] so Gibbs sampling can be used  
[@freudenthaler2011bayesian].

 [^1]: Cumulative distribution function of the standard normal distribution.

<!-- # Interesting findings

Intrinsic difficulty is important to explain results

We do not know why historically MIRT did not consider an item bias  
Maybe easier to explain? -->

# Experiments

- 5-fold cross-validation over triplets $(i, j, r_{ij})$
    - 80% train, 20% test
- Maximize log-likelihood
- Compute ACC and AUC on the test set

## Datasets

\small
\input{tables/datasets}

Berkeley has 2 attempts per user over item, in average.

# Entries

- user_id
- item_id
- skill_id (one-to-many)
- counting attempts at skill level
- counting wins at skill level
- counting fails at skill level
- counting attempts at item level
- counting wins at item level
- counting fails at item level

# Better models found

FMs match or outperform other models

\tiny
\input{tables/summary-poster}

\normalsize

- IRT == user + item, $d = 0$
- MIRTb10 == user + item, $d = 10$
- AFM == user + skill + attempts, $d = 0$
- PFA == user + skill + wins + fails, $d = 0$
- uia0 == user + item + attempts, $d = 0$
- uis0 == user + item + skill, $d = 0$
- uis10 == user + item + skill, $d = 10$
- uiswfWF1 == user + item + skill + wins (skill) + fails (skill) + Wins (item) + Fails (item), $d = 1$

# Results Berkeley

\vspace{1cm}
\small
\includegraphics[width=\linewidth]{figures/berkeley0-poster.pdf}

# Results Assistments

\vspace{1cm}
\includegraphics[width=\linewidth]{figures/assistments0-poster.pdf}

# Results Berkeley

\input{tables/berkeley0-table-poster}

# DeepFM? [@guo2017deepfm]

Combine output of FM with DNN:

$$ \hat{y} = \sigma(y_{FM} + y_{DNN}) $$

Inspired by Wide and Deep Learning [@cheng2016wide].

# FM component

\includegraphics[width=\linewidth]{figures/fm.jpg}

# Deep component

\includegraphics[width=\linewidth]{figures/deep.jpg}

# DeepFM

\includegraphics[width=\linewidth]{figures/monster.jpg}

# Discussion

- Item bias improves a lot the predictions
- Bigger dimension does not improve much
- Incorporating temporal side information helps measure learning
- FMs are a nice baseline for large-scale data

# Next steps

- Replace Gibbs sampling with variational inference to speed up computation
- Once features have been extracted, one can detect the skills that students have
- Attention mechanism to interpret failures?
- Adaptive testing models?

## Take away message

- It is possible to run deep learning models on sparse data
- Deep Knowledge Tracing aka LSTMs [@piech2015deep]  
have been beaten by  
the simplest Item Response Theory model [@wilson2016back]  
$\rightarrow$ simpler may be better & an item bias is important.

# Thanks for your attention!

Please come to our workshop in Montréal on June 12:  
\alert{Optimizing Human Learning}  
`https://humanlearn.io`

\footnotesize
\begin{thebibliography}{9}
\bibitem{Vie2018} \fullcite{Vie2018}
\bibitem{rendle2012factorization} \fullcite{rendle2012factorization}
\end{thebibliography}
