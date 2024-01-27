% Implicit Layers
% JJ Vie
% 11/12/21
---
theme: metropolis
header-includes:
  - \usepackage{icomma}
  - \def\R{\mathbf{R}}
  - \def\V{\mathcal{V}}
  - \def\zstar{z^*}
---
## Implicit Layers

You can now backpropagate in any DAG.

But can you differentiate any layer?

\pause

Some layers may call solvers that take several \alert{iterations}  
(e.g., root finding, fixed point, ODE solver, numerical integration)

### Example of root finding layer

\vspace{2mm}

Find $z \in \R^n$ such that $f(a, z) = 0$ ($a \in \R^p$ are parameters)

## When do we need it?

- Modeling physical systems
- Differentiable (constrained) optimization
- Hyper-parameter optimization
- Continuous counterparts of discrete, iterative architectures e.g. ResNet
- Interpolation between probability distributions

## Example: ODE layers (Chen et al. 2018)

\centering

![](figures/ode2.png){width=7cm}

\vspace{-5mm}

$$ \begin{array}{ccc}
& h_{t + 1} = h_t + f(h_t, \theta_t) & \frac{d h(t)}{dt} = f(h(t), t, \theta)\\
\textnormal{Input:} & x = h_0 & x = h(0)\\
\textnormal{Output:} & y = h_T & y = h(T)
\end{array} $$

## Implicit function theorem

Let $f : \R^p \times \R^n \to \R^n$ and $a_0 \in \R^p, z_0 \in \R^n$ s.t.

- $f(a_0, z_0) = 0$
- $f$ is continuously differentiable with invertible Jacobian $\partial_z f(a_0, z_0) \in \R^{n \times n}$.

Then there exists open sets $V_a \in \V(a_0)$ and $V_z \in \V(z_0)$ and a $\alert{unique}$ continuous function $\alert{z^*} : V_a \to V_z$ ("solution mapping") s.t.

- $z_0 = z^*(a_0)$
- $f(a, \alert{\zstar(a)}) = 0 \quad \forall a \in V_a$
- and $\zstar$ is \alert{differentiable} on $V_a$

## Why is it convenient?

$$f(a, \alert{z^*}(a)) = 0 \quad \forall a \in V_a$$

Differentiate w.r.t. $a$ and evaluate at $(a_0, z_0)$

\begin{align*}
\partial_a f(a_0, z_0) + \partial_z f(a_0, z_0) \alert{\partial z^*}(a_0) = 0\\
\alert{\partial z^*}(a_0) = - \partial_z f(a_0, z_0)^{-1} \partial_a f(a_0, z_0)
\end{align*}

**Main result:** Computing the gradient of unknown function $z^*$ only depends on derivatives of $f$

## Example: Brachistochrone problem

\centering

![](figures/brachistochrone2.png){width=50%}

\raggedright

What is the shape of the path that minimizes the time for a marble to slip without friction (accelerated by gravity)?

- In 1696, Johann Bernoulli (Euler's PhD advisor) challenged his colleagues with this problem
- Answered by Newton, Jakob Bernoulli, Leibniz, von Tschirnhaus, and de l'Hôpital
- Led to the calculus of variations by Euler in 1766

## Putting into equation

Input: $P = (P_X, P_Y) \in \R^2$

Find path that minimizes $$T = \int_0^P \frac{ds}v $$

$ds = \sqrt{dx^2 + dy^2}$, $\frac12 mv^2 = mgy$, $y = y(x)$

Find path that minimizes
$$T = \int_0^{P_x} \underbrace{\sqrt{\frac{1 + y'^2}{2gy}}}_{L(x, y, y')} dx \qquad \underbrace{\partial_y L = \frac{d}{dx} \partial_{y'} L}_{\textnormal{Euler-Lagrange}}$$

$\Rightarrow y(1 + y'^2) = 2 R$ for some parameter $R$ \qquad $y'^2 = \frac{2R}y - 1$

## Putting into code

Find parameter $R$

that minimizes loss $|| y_R(P_X) - P_Y ||^2$

such that $y_R$ is a solution of $y(1 + y'^2) = 2R$

### JAX is Autograd and XLA[^1]

```python
from jax import grad
parameters -= GAMMA * grad(loss)(parameters)
```

 [^1]: (xccelerated linear algebra)

## References

Kolter, Duvenaud and Johnson, **Deep Implicit Layers**, Tutorial NeurIPS 2020, \url{https://implicit-layers-tutorial.org}

Blondel et al., **Efficient and Modular Implicit Differentiation**, \url{https://jaxopt.github.io}

Chen et al., **Neural Ordinary Differential Equations**, Best Paper NeurIPS 2018, \url{https://arxiv.org/abs/1806.07366}

### Unrelated good reads

\vspace{2mm}

Wibisono, Wilson and Jordan, **A Variational Perspective on Accelerated Methods in Optimization**, 2016

Even et al., **A Continuized View on Nesterov Acceleration for Stochastic Gradient Descent and Randomized Gossip**, NeurIPS 2021, \url{https://arxiv.org/abs/2106.07644}
