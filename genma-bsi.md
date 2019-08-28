% Adaptive Testing using a General Diagnostic Model
% JJV
% \today

# Context

How to predict the performance of students while asking as few questions as possible to them?

(AKA: I have a bunch of log files, can I use them to improve my online course?)

# A first simple, yet reliable model

- $R_{ij} \in \{0, 1\}$ outcome of examinee $i$ over item $j$ (right/wrong)
- $\theta_i$ ability of examinee $i$
- $d_j$ difficulty of item $j$

$$ Pr(R_{ij} = 1) = \Phi(\theta_i - d_j). $$

## Algorithm

- Learn $d_j$ (and $\theta_i$) for historic data (maximizing log-likelihood)
- When a new examinee arrives: initialize $\theta^{(0)} = 0$
- For each time $t = 0, \ldots, T - 1$:
    - Ask question of difficulty $d_j$ closest to student ability $\theta^{(t)}$  
    (proba closest to 1/2)
    - Refine student ability $\theta^{(t + 1)}$ (maximum likelihood estimate)

<-- # Visual interpretation -->

# DINA model

- $K$ possible skills
- $S = \{0, 1\}^K$ potential latent states (subsets of mastered skills)
- Each question requires $x_j \in S$ skills.
- $\pi$: distribution of a new examinee over latent states

$$ Pr(R_{ij} = 1) = \begin{cases}
1 - s_j & \textnormal{if student $i$ masters all skills required $x_j$}\\
g_j & \textnormal{otherwise}.
\end{cases} $$

# Algorithm

- Nothing to learn from historic data
- When a new examinee arrives: initialize $\pi^{(0)}$ to $Uniform(S)$
- For each time $t = 0, \ldots, T - 1$:
    - Ask question that minimizes the expected entropy over $\pi^{(t + 1)}$ according to the answer (using Bayes' rule)
    - Refine $\pi^{(t + 1)}$ accordingly

# Other models

## Performance factor analysis

$$ Pr(R_{ij} = 1) = \Phi\left(\theta_i + \sum_k q_{jk} \beta_k + \sum_k q_{jk} \gamma_k N_{ik}\right) $$

- $\theta_i$
- 

## Bandit

Ask questions so as to maximize the \alert{learning progress} of the student: how well he performed recently to how well he performed before.
