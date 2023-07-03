% From causal inference to reinforcement learning
% Jill-Jênn Vie
% July 4, 2023
---
institute: \includegraphics[height=1cm]{figures/soda.png}
header-includes: |
  ```{=tex}
  \usepackage{tikz}
  \usepackage{tabularx}
  \def\E{\mathbb{E}}
  \renewcommand{\arraystretch}{1.2}
  \newcolumntype{C}{>{\centering\arraybackslash}X}
  ```
---

# 

\centering

![](figures/rct.png){width=95%}

\raggedright

\footnotesize

\textcolor{gray}{Source: https://quantifyinghealth.com/cohort-vs-randomized-controlled-trials/}

# Randomized controlled trials vs. cohort study

\centering

\begin{tikzpicture}[var/.style={draw,rounded corners=2pt,align=center}, every edge/.style={draw,->,>=stealth,very thick},xscale=2.5,yscale=2]
\node (x) [var] {covariates\\ $X$};
\node (t) at (-0.5,-1) [var] {treatment\\ $T$};
\node (y) at (0.5,-1) [var] {outcome\\ $Y$};
\draw (x) edge (t);
\draw (t) edge (y);
\draw (x) edge (y);
\end{tikzpicture}

\raggedright

## Randomized controlled trial (A/B testing)

We could \alert{control} treatment, therefore treated/non-treated distributions are the same: $P(X|T = 0) = P(X|T = 1)$

## Cohort study (observational data)

Could not control, have to remove bias from estimates  
(e.g. inverse probability weighting)\bigskip

Randomized \alert{controlled} trials $\to$ How about optimal \alert{control} theory?

# Here come bandits

Instead of having to wait for sufficient sample size and high statistical significance (A/B test)  

![](figures/ab-testing-bandits.png)

How about: dynamically allocating traffic to actions that are performing well  
(while allocating less and less traffic to underperforming actions)

\textcolor{gray}{Source: blog post on dynamicyield.com}

# Quantities of interest -- causal inference

## Average treatment effect

$$ATE = \E [Y^1 - Y^0]$$

## Individual or heterogeneous treatment effect

Uplift: the incremental profit brought by treatment conditioned on features of each individual

$$u(x) = \E [Y^1|X = x] - \E [Y^0|X = x] $$

\textcolor{gray}{Yamane, I., Yger, F., Atif, J., \& Sugiyama, M. Uplift Modeling from Separate Labels. NeurIPS 2018.}

\textcolor{gray}{Hsieh, Y. G., Kasiviswanathan, S., \& Kveton, B. Uplifting bandits. NeurIPS 2022.}

Deciding whether treatment or not given $x_i$: \alert{policy}  
(seen in dynamic treatment regime)

# Contextual bandits

![](figures/contextual-bandits.png)

Optimize average reward

Or regret: how do we perform compared to the best possible action at each time?

Or best arm identification: which action/treatment is the best?

# Quantities of interest -- stochastic bandits

- $\theta$ context (observed, e.g. user history, day of the week…)
- $a$ actions
- $\pi(a|\theta)$ policy
	- $\pi_0$ original (*behavior policy*)
	- $\pi^*$ optimal
- reward $r \sim p(r|\theta,a)$
- value $V(\pi) = \E_{\theta,a,r} r = \int_s \int_a \int_r r\, p(r|\theta,a)\, \pi(a|\theta)\, p(\theta)\, d\theta\, da\, dr$

Objective

- Find $\pi$ that optimizes $V$ (or regret, or best arm)

# Off-policy estimation

![](figures/ipw.png)

# From bandits to reinforcement learning

\scriptsize

\begin{tabularx}{\columnwidth}{l*{4}{C}}
\rule{0pt}{4.2ex} & Actions don't change state & Actions change state & Cannot control\\[3ex] \cline{2-4}
\rule{0pt}{5.2ex} Observable & \multicolumn{1}{|c|}{Contextual bandits} & Markov Decision Process & \multicolumn{1}{|c|}{Markov Chain}\\[3ex] \cline{2-4}
\rule{0pt}{4.2ex} Hidden & \multicolumn{1}{|c|}{Multi-armed bandits} & Partially observable MDP & \multicolumn{1}{|c|}{Hidden Markov Model}\\[3ex] \cline{2-4}
\rule{0pt}{4.2ex} & Bandits & Reinforcement Learning & Graphical Models
\end{tabularx}

\pause

\normalsize

Episode: $S_0 \to^\pi A_0 \to R_0 \to S_1 \to^\pi A_1 \to R_1 \to S_2 \to^\pi \cdots \to R_T$

$G_t = R_{t + 1} + \gamma R_{t + 2} + \cdots = \sum_{k = t + 1}^T \gamma^{k - t - 1} R_k$

Find $\pi(a|s)$ that optimizes $\E_\pi [G_t | S_t = s]$

Bandits are the equivalent for episodes of length 1

# Dynamic programming (1952)

:::::: {.columns}
::: {.column}
![](figures/bellman.jpg)

\centering

Richard Bellman (1920--1984)
:::
::: {.column}
Invented dynamic programming before programming was invented (Autocode, 1953)

## Principle of Optimality

An optimal policy has the property that whatever the initial state and initial decision are, the remaining decisions must constitute an optimal policy with regard to the state resulting from the first decision.
:::
::::::

# Applications

## Health

*Clémence Réda, Marie Skłodowska-Curie postdoc*  
Drug repurposing: given a disease, find a drug

## Culture

*Tomas Rigaux, engineer*  
Recommendation of cultural content with diversity  
(Pass Culture, 15--18 years old)

## Education

*Samuel Girard, intern*  
Off-policy estimation of new policies for asking exercises  
Compromise between short-term reward (learner solves hard problems) and long-term reward (they progress a lot)
