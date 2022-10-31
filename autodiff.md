% Automatic differentiation
% JJV
% Oct 7, 2022
---
header-includes: |
  ```{=tex}
  \usepackage{tikz}
  \usepackage{bm}
  \usepackage{booktabs}
  \def\bolda{{\bm{a}}}
  \def\boldth{{\bm{\theta}}}
  \def\x{{\bm{x}}}
  \def\W{{\bm{W}}}
  \def\b{{\bm{b}}}
  \def\L{\mathcal{L}}
  \def\R{\mathbf{R}}
  \def\diag{{\textnormal{diag}}}
  \def\softmax{{\textnormal{softmax}}}
  \def\softplus{{\textnormal{softplus}}}
  \def\sigmoid{{\textnormal{sigmoid}}}
  \def\logsumexp{{\textnormal{logsumexp}}}
  \usepackage[skins,minted]{tcolorbox}
  \definecolor{bgm}{rgb}{0.95,0.95,0.95}
  \newtcblisting{myminted}[3][]{listing engine=minted,listing only,#1,minted language=#3,colback=bgm,minted options={linenos,fontsize=\footnotesize,numbersep=2mm,escapeinside=||,mathescape=true}}
  ```
---

# Optimization

Find "the best" parameters to reach a goal

Usually, minimize a differentiable \alert{loss function}

Find the zeroes of another function (its derivative)

How to find the zeroes of a function?

# Newton's method: find $x$ such that $f(x) = 0$ {.fragile}

![](figures/newton.png)

$f: \R \to \R$ differentiable, $\not\exists x, f'(x) = 0$

$$ x_{t + 1} = x_t - \frac{f(x_t)}{f'(x_t)} \qquad \parbox{0.45\textwidth}{\centering Quadratic convergence\\$\exists C > 0, |x_{t + 1} - \ell| \leq C |x_t - \ell|^2$}$$

# In higher dimension

Let $g : \R^n \to \R$ twice differentiable, with $n >> 1$

\pause

What is the size of $g'(\bm{x})$? Usually noted $\frac{\partial g}{\partial \bm{x}}$ or $\nabla_{\bm{x}} g$.

\pause

$$\x_{t + 1} = \x_t - \underbrace{g''(\x_t)^{-1}}_{\in \mathbf{R}^{n \times n},~O(n^3)} \underbrace{g'(\x_t)}_{\in \mathbf{R}^n}$$

# Gradient descent {.fragile}

\centering

![](figures/sgd.jpg){width=70%}

$\x_{t + 1} = \x_t - \gamma \nabla_{\x} \L(\x_t)$

\begin{myminted}{SGD}{python}
for each epoch:
    for |$\x$|, |$y$| in dataset:
        compute gradients |$\frac{\partial \L}{\partial \boldth}(f_\boldth(\x), y)$|  # also noted $\nabla_\boldth \L$
        |$\boldth \gets \boldth - \gamma \nabla_\boldth \L$|  # $\gamma$ is the learning rate
\end{myminted}

# SGD in PyTorch {.fragile}

\begin{myminted}{PyTorch SGD}{python}
import torch

# define model, n_epochs, trainloader
criterion = torch.nn.CrossEntropyLoss()
optimizer = torch.optim.SGD(model.parameters(), lr=0.001)

for _ in range(n_epochs):
    for batch_inputs, batch_labels in trainloader:
        outputs = model(batch_inputs)
        loss = criterion(outputs, batch_labels)

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
\end{myminted}

# How to compute gradients automatically?

\centering\tiny
```python
>>> from autograd import elementwise_grad as egrad  # for functions that vectorize over inputs
>>> import matplotlib.pyplot as plt
>>> x = np.linspace(-7, 7, 200)
>>> plt.plot(x, tanh(x),
...          x, egrad(tanh)(x),                                     # first  derivative
...          x, egrad(egrad(tanh))(x),                              # second derivative
...          x, egrad(egrad(egrad(tanh)))(x),                       # third  derivative
...          x, egrad(egrad(egrad(egrad(tanh))))(x),                # fourth derivative
...          x, egrad(egrad(egrad(egrad(egrad(tanh)))))(x),         # fifth  derivative
...          x, egrad(egrad(egrad(egrad(egrad(egrad(tanh))))))(x))  # sixth  derivative
>>> plt.show()
```
\begin{center}\includegraphics[width=0.6\linewidth]{figures/tanh.png}\end{center}

# Existing methods and their limitations

## Numerical differentiation

$$\frac{f(x + h) - f(x)}h$$

Round-off errors

\pause

## Symbolic differentiation

Have to keep symbolic expressions at each step of the process

\pause

## Automatic differentiation

# Chain rule

$$ (f \circ g)' = g' \cdot (f' \circ g) $$

## Generalized chain rule

$$ \frac{df_1}{dx} = \frac{df_1}{df_2} \frac{df_2}{df_3} \cdots \frac{df_n}{dx} $$

# Reminder: Jacobians

Consider differentiable $f : \R^n \to \R^m$, its Jacobian contains its first-order partial derivatives $(J_f)_{ij} = \frac{\partial f_i}{\partial x_j}$:

$$J_f ={\begin{bmatrix}{\dfrac {\partial f }{\partial x_{1}}}&\cdots &{\dfrac {\partial f }{\partial x_{n}}}\end{bmatrix}}={\begin{bmatrix}\nabla ^{\mathrm {T} }f_{1}\\\vdots \\\nabla ^{\mathrm {T} }f_{m}\end{bmatrix}}={\begin{bmatrix}{\dfrac {\partial f_{1}}{\partial x_{1}}}&\cdots &{\dfrac {\partial f_{1}}{\partial x_{n}}}\\\vdots &\ddots &\vdots \\{\dfrac {\partial f_{m}}{\partial x_{1}}}&\cdots &{\dfrac {\partial f_{m}}{\partial x_{n}}}\end{bmatrix}}$$

\pause

## Example: linear layer

$W$ is a $m \times n$ matrix

If $f(\x) = W \x$

$f_i = W_i \x = \sum_j W_{ij} x_j$ where $W_i$ is $i$th row of $W$

$(J_f)_{ij} = \frac{\partial f_i}{\partial x_j} = W_{ij}$ so $J_f = W$

# Generalized multivariate chain rule

Consider differentiable $f : \R^m \to \R^k, g : \R^n \to \R^m$ and $\bolda \in \R^n$.

$$D_\bolda (f \circ g) = D_{g(\bolda)} f \circ D_\bolda g$$

So the Jacobians verify:

$$ J_{f \circ g} = (J_f \circ g) J_g$$

# Computation graph

\centering
\begin{tikzpicture}[var/.style={draw,rounded corners=2pt}, every edge/.style={draw,->,>=stealth},xscale=2.5,yscale=2]
\node (x) [var] {$\x$};
\node (y) at (2.5,-1) [var] {$y$};
\node (W) at (0.5,-1) [var] {$\W$};
\node (b) at (1.5,-1) [var] {$\b$};
\node (z) at (1,0) [var] {$z$};
\node (f) at (2,0) [var] {$\softmax$};
\node[var] (loss) at (3,0) {$\L$};
\node (end) at (4,0) {};
\draw (x) edge (z);
\draw (W) edge (z);
\draw (b) edge (z);
\draw (z) edge node[above] {$z(\x)$} (f);
\draw (f) edge node[above] {$f(\x)$} (loss);
\draw (y) edge (loss);
\draw (loss) edge node[above] {$\L(f(\x), y)$} (end);
\end{tikzpicture}

$$\begin{aligned}
\frac{d\L}{db_1} & = \frac{d\L}{df} \frac{df}{db_1} = \frac{d\L}{df} \left( \frac{df}{dz} \frac{dz}{db_1} \right) \textnormal{ (forward)}\\
& = \frac{d\L}{dz} \frac{dz}{db_1} = \left( \frac{d\L}{df} \frac{df}{dz} \right) \frac{dz}{db_1} \textnormal{ (backward)}
\end{aligned}$$

Properly written: $J_{\L \circ \softmax \circ z} = (J_\L \circ f) (J_\softmax \circ z) J_z$

Given that $\x \in \R^d, z(\x), f(\x) \in \R^{d_2}, \L(f(\x), y) \in \R$,  
which order is better?

# Reverse accumulation (in $\R$)

Let us note the adjoint $\bar{f} \triangleq \frac{d\L}{df}$.

\centering
\begin{tikzpicture}[var/.style={draw,circle}, every node/.style={minimum size=7mm}, every edge/.style={draw,->,>=stealth},xscale=2.5,yscale=2]
\node (f) [var] {$f$};
\node (end) at (1,0) {};
\node (u) at (-1,1) {};
\node (v) at (-1,-1) {};
\draw (u) edge[bend right,draw=none] coordinate[at start](u-b) coordinate[at end](f-b) (f)
          edge[bend left,draw=none] coordinate[at start](u-t) coordinate[at end](f-t) (f)
          (u-b) edge node[below] {$u$} (f-b);
\only<2>{\draw[red] (f-t) edge node[above right] {$\bar{f} \frac{df}{du}$} (u-t);}
\draw (v) edge[bend right,draw=none] coordinate[at start](v-b) coordinate[at end](f-bv) (f)
          edge[bend left,draw=none] coordinate[at start](v-t) coordinate[at end](f-tv) (f)
          (v-t) edge node[above] {$v$} (f-tv);
\only<2>{\draw[red] (f-bv) edge node[below right] {$\bar{f} \frac{df}{dv}$} (v-b);}
\draw (f) edge node[above] {$f(u,v)$} (end);
\only<2>{\draw[red] ([yshift=-2pt] end.west) edge node[below] {$\bar{f}$} ([yshift=-2pt] f.east);}
\end{tikzpicture}

# A complete example (Wikipedia)

![](figures/reverse-ad.png)

# Please compute gradients

![](figures/autodiff.png)

# Examples of link functions (Ollion & Grisel)

![](figures/activation_functions.png)

# More interesting link functions

\footnotesize
\begin{tabular}{ccc} \toprule
& Binary & Multiclass\\ \midrule
$f$ & $\softplus : x \mapsto \log (1 + \exp(x))$ & $\logsumexp^+ : \x \mapsto \log(1 + \sum_c \exp(x_c))$\\
$f'$ & $\sigmoid : x \mapsto 1 / (1 + \exp(-x))$ & $\softmax : \x \mapsto \exp(\x) / \sum_c \exp(x_c)$\\
$f''$ & $x \mapsto \sigmoid(x) (1 - \sigmoid(x))$ & \only<1>{?}\only<2>{\alert{$\x \mapsto \diag(s(\x)) - s(\x) s(\x)^T$}}\\ \bottomrule
\end{tabular}

# Computation graph: classifier

\centering
\begin{tikzpicture}[var/.style={draw,rounded corners=2pt}, every edge/.style={draw,->,>=stealth},xscale=2.5,yscale=2]
\node (x) [var] {$\x$};
\node (y) at (2.5,-1) [var] {$y$};
\node (W) at (0.5,-1) [var] {$\W$};
\node (b) at (1.5,-1) [var] {$\b$};
\node (z) at (1,0) [var] {$z$};
\node (f) at (2,0) [var] {$\softmax$};
\node[var] (loss) at (3,0) {$\L$};
\node (end) at (4,0) {};
\draw (x) edge (z);
\draw (W) edge (z);
\draw (b) edge (z);
\draw (z) edge node[above] {$z(\x)$} (f);
\draw (f) edge node[above] {$f(\x)$} (loss);
\draw (y) edge (loss);
\draw (loss) edge node[above] {$\L(f(\x), y)$} (end);
\end{tikzpicture}

Here we define $\L$ as cross-entropy:
$$ \L(f(\x), y) = - \sum_{c = 1}^K \mathbf{1}_{y = c} \log {f(\x)}_c = - \log {f(\x)}_y $$
Compute $\frac{d\L}{dz_c}$
