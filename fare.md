% FARE: Provably Fair Representation Learning with Practical Certificates
% Jill-Jênn Vie
% MILLE CILS 2023
---
aspectratio: 169
institute: \includegraphics[height=1cm]{figures/inria.png} \includegraphics[height=1cm]{figures/soda.png}
header-includes:
  - \def\R{\mathbf{R}}
  - \def\E{\mathbb{E}}
---

# Context

Learning fair representations such that \alert{any} classifier using these representations cannot discriminate even if they are trying to.

We need \alert{practical} certificates

## Requirements

1. High-probability: Bound the fairness metric with high probability
1. Finite sample bound and not asymptotic i.e. $n \to \infty$
1. Distribution-free bound
1. Model-free: Should hold for any model trained on representations
1. Non-vacuous bound (i.e. $< 1$)

(Bounds should be explicitly computable on real datasets)

## Strong points

- Related work is impressive
- First "practical" certificates (e.g. difference in proba bounds not above 1)

# Background

- Triplets $(x, s, y) \in \R^d \times \{0, 1\} \times \{0, 1\}$
- Data producers \alert{encode} $x \mapsto z$ (of size $d' < d$) using some $f$
- Data consumers should classify $z$ into $y$ using some downstream classifier $g \in \mathcal{G}$

## Metrics

- Demographic parity $\Delta(g) = |\E_{p(z|s = 0)} g(z) - \E_{p(z|s = 1)} g(z)|$
- Adversary $h$ may be trying to predict $s$ from $z$.  
Its balanced accuracy $BA(h) = \frac12 (\E_{p(z|s = 0)} [1 - h(z)] + \E_{p(z|s = 1)} h(z))$
- Both quantities are related: $\Delta(g) = |2BA(g) - 1| \leq |2BA(h^*) - 1|$  
So the balanced accuracy of optimal $h^*$ is a fairness certificate

\pause

\begin{definition}
Given small $\varepsilon$, finite dataset $D$, encoder $f : x \mapsto z$ creating representations, a \alert{practical DP distance certificate} is a value $T^*(n, D) \in \R$ such that
$$\sup_{g \in \mathcal{G}} \Delta(g) \leq T^*(n, D)$$
holds with probability $1 - \varepsilon$.
\end{definition}

# Trick

Representations should have finite support  
i.e. $f : \R^d \to \{z_1, \ldots, z_k\}$ one of $k$ possible values (whaaat?)

\pause

But actually this includes decision trees (each leaf has same encoding)

## Examples of criteria

- Gini impurity: making outcome $y$ in each leaf highly unbalanced $\rightarrow$ unfair
- Compromise with: making the distribution of attribute $s$ in each leaf as close to uniform as possible (making it hard to infer $s$ from $z_i$) $\rightarrow$ FARE

# Results

\centering

![](figures/fare-results.png)

# Personal thoughts

- How come such a simple classifier has slightly lower accuracy?!
- If it's simple, it can be done in practice

![](figures/fare-times.png)

Nikola Jovanović, Mislav Balunovic, Dimitar Iliev Dimitrov, Martin Vechev. \alert{FARE: Provably Fair Representation Learning with Practical Certificates.} Proceedings of the 40th International Conference on Machine Learning, PMLR 202:15401-15420, 2023. \url{https://arxiv.org/abs/2210.07213}

Thanks! jill-jenn.vie@inria.fr
