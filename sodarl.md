% From causal inference to reinforcement learning
% Jill-Jênn Vie
% July 4, 2023
---
aspectratio: 169
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

\small

\textcolor{gray}{Yamane, Yger, Atif \& Sugiyama (NeurIPS 2018). Uplift Modeling from Separate Labels.}

\textcolor{gray}{Hsieh, Kasiviswanathan \& Kveton (NeurIPS 2022). Uplifting bandits.}

\normalsize

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

# On-policy vs. off-policy

Problem: old episodes were collected from an older policy, so does it makes sense?

- off-policy: can improve the policy with old samples
- on-policy: each time the policy changes, we need to generate new samples

![](figures/on-off-policy.png)

# $Q$-learning is an off-policy algorithm

- For each episode:
	- For each step of episode:
		- Choose action $a$ given $s$ according to $Q$, observe $r, s'$
		- $Q(s, a) \gets Q(s, a) + \alpha(r + \gamma \max_{a'} Q(s', a') - Q(s, a))$

## Variants

- $\E[\max(X_1, X_2)] \geq \max(\E X_1, \E X_2)$ $\to$ double $Q$-learning: alleviate the positive bias from overestimation by having one network for selecting action, one network for evaluating value (average reward)

\small

\textcolor{gray}{Hasselt (NeurIPS 2010). Double $Q$-Learning.}\bigskip

\normalsize

- Conservative $Q$-learning: lower bound on the $Q$-function

\small

\textcolor{gray}{Kumar, Zhou, Tucker \& Levine (NeurIPS 2020). Conservative $Q$-Learning for Offline Reinforcement Learning.}

# Dynamic programming (1952)

:::::: {.columns}
::: {.column width=40%}
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

# Crowdsourcing

Learning from human (noisy) labels (e.g. reCAPTCHA, Duolingo) based on graphical models.

\vfill \small

\textcolor{gray}{Raykar, Yu, Zhao, Valadez, Florin, Bogoni, \& Moy (JMLR 2010).  
Learning from crowds.}

Ex. \textcolor{gray}{Bachrach, Graepel, Minka \& Guiver (ICML 2012). How to grade a test without knowing the answers---A Bayesian graphical model for adaptive crowdsourcing and aptitude testing.}

# Reinforcement Learning from Human Feedback

1. Collect demonstration data, and train a supervised policy $\pi_0(y|x)$ (based on GPT-3)
2. Collect comparison data, train a reward model  
(Elo rating, or BPR; "only" 50k annotations)

$$ \textnormal{loss}(\alert\theta) = -\E_{(x, y_w, y_\ell) \sim D} \log \underbrace{\sigma(r_{\alert\theta}(x, y_k) - r_{\alert\theta}(x, y_\ell))}_{\Pr(\textnormal{output } y_w \textnormal{ is preferred to } y_\ell)} $$

3. Optimize a policy against the reward model using PPO.

$$ \textnormal{objective}(\alert\phi) = \E_{(x, y) \sim \pi_{\alert\phi}} r_\theta(x, y) - \beta \textnormal{KL}(\pi_{\alert\phi}, \pi_0) $$

\small

\textcolor{gray}{Ouyang, Wu, Jiang, Almeida, Wainwright, Mishkin, … \& Lowe (NeurIPS 2022). Training language models to follow instructions with human feedback.}

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
