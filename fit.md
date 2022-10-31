% Multilayer Perceptrons:\newline Expressiveness, overfitting, regularization
% Marc Lelarge; Kevin Scaman; Jill-Jênn Vie
% Oct 21, 2022
---
aspectratio: 169
header-includes: |
  ```{=tex}
  \usepackage{bm}
  \usepackage{datetime2}
  \def\E{\mathbb{E}}
  \def\R{\mathbf{R}}
  \def\N{\mathbf{N}}
  \def\C{\mathcal{C}}
  \def\L{\mathcal{L}}
  \def\NN{\mathcal{N}}
  \def\MLP{\textnormal{MLP}}
  \def\x{{\bm{x}}}
  \def\y{{\bm{y}}}
  \def\W{{\bm{W}}}
  \def\b{{\bm{b}}}
  \def\CC{{\bm{C}}}
  \def\boldth{{\bm{\theta}}}
  \def\hf{{g_\boldth}}
  \usepackage[skins,minted]{tcolorbox}
  \definecolor{bgm}{rgb}{0.95,0.95,0.95}
  \newtcblisting{myminted}[3][]{listing engine=minted,listing only,#1,minted language=#3,colback=bgm,minted options={linenos,fontsize=\footnotesize,numbersep=2mm,escapeinside=||,mathescape=true}}
  ```
---
# Multilayer Perceptrons (MLP) {.fragile}

$$\begin{aligned}
\x^{(0)} & = \x \only<2->{\in \R^{d_0}}\\
\x^{(\ell + 1)} & = \sigma(\W^{(\ell)} \x^{(\ell)} + \b^{(\ell)}) \only<2->{\in \R^{d_\ell}} \quad \ell = 0, \ldots, L - 2\\
y = \x^{(L)} & = \W^{(L-1)} \x^{(L-1)} + \b^{(L-1)} \only<2->{\in \R^{d_L}}
\end{aligned}$$

\pause

The $\ell$th layer has $d_\ell$ neurons. Input layer $\ell = 0$, output layer $\ell = L$.  
$\sigma$ is the link function. Usually, $\sigma = \textnormal{ReLU} = \max(\mathbf{0}, \x)$. #params?

\pause

\begin{myminted}{MLP}{python}
from torch import nn

mlp = nn.Sequential(
    nn.Linear(|$d_0$|, |$d_1$|),
    nn.ReLU(),
    nn.Linear(|$d_1$|, |$d_2$|),
    ...
    nn.Linear(|$d_{L - 1}$|, |$d_L$|)
)
\end{myminted}

# Example: logistic regression is a 1-layer perceptron

$y = \sigma(\W \x + b)$ where $\sigma = \textnormal{sigmoid} = 1 / (1 + \exp(-x))$

# 

\centering

![](figures/bengio.png){width=70%}

\pause

\raggedright
A ReLU-based MLP with inputs in $\R^n$, $L$ layers of width $k \geq n$, can compute functions that have $\Omega((k / n)^{n (L - 1)} n^k)$ linear regions.

\fullcite{montufar2014number}

# Expressiveness

The number of activation patterns ($\sim$ regions) of a ReLU-based MLP with $L$ layers of width $k$, inputs in $\R^n$ is upper bounded (tightly) by $O(k^{n L})$ as $L \to \infty$.

![](figures/mlp.png)

\fullcite{raghu2017expressive}

# Universal approximation theorems

## Fixed depth 2 arbitrary width $k$ (Pinkus, 1999) (Cybenko, 1989)

Let $\alert\sigma \in \C(\R)$ a continuous function from $\R$ to $\R$.

Then: $\alert\sigma$ is not polynomial $\iff$

For all $\varepsilon > 0$, $n, m \in \N$, compact $K \subseteq \R^n$, function $f \in \C(K, \R^m)$,   
there exist latent dimension $k$ and weights $\W, \b, \CC$ such that

$$ \sup_{\x \in K} || f(\x) - \textnormal{MLP}(\x) || < \varepsilon \quad \textnormal{MLP}(\x) = \CC \alert\sigma(\W \x + \b). $$

\pause

In other words, 2-layer MLPs are \alert{dense} in $\C(K, \R^m)$.  
They are \alert{universal approximators} of continuous functions.

# Universal approximation theorems

## Arbitrary depth, minimal width (Park, 2020)

For any function $f \in L^p(\R^n, \R^m)$ and any $\varepsilon > 0$  
there exists a MLP with ReLU of width $\max(n + 1, m)$ such that

$$ || f - \MLP ||_p = \left(\int_{\R^n} || f(x) - \MLP(x) ||^p dx\right)^{1 / p} < \varepsilon. $$

\pause

Moreover:

## Arbitrary depth, constrained width (Kidger and Lyons, 2020)

Let $\NN$ be the space of $\textnormal{MLP} : \R^n \to \R^m$ with any layers having $n + m + 2$ neurons.  
Then: $\NN$ is \alert{dense} in $\C(K, \R^m)$ where compact $K \subseteq \R^n$.

# Some other theoretical results

## Infinite-depth limit

- Untrained MLP with random weights (Karakida, Akaho & Amari, 2018)

The Fisher information matrix i.e. $\frac{\partial^2 \L}{\partial \theta^2}$ has eigenvalues having mean $O(1/M)$, variance $O(1)$ and max $O(M)$.

- Neural Tangent Kernels (Jacot, Gabriel & Hongler, 2018)

## Turing-completeness

- RNNs are Turing-complete (Siegelmann & Sontag, 1995)
- LSTMs can perform unbounded counting while GRUs cannot (Weiss, Goldberg & Yahav, 2018)
- Neural Turing Machines with external memory (Graves, Wayne & Danihelka, 2014)

## Training MLP with random labels?! (Maennel et al., 2020)

# Overfitting

:::::: {.columns}
::: {.column}
## Fitting
Polynomial degree 1 $Y = wX + b$
![](figures/interpol-lr.png)
Linear regression  
`scipy.stats.linreg`
:::
::: {.column}
## Overfitting
Polynomial degree 6 $Y = \sum_{k = 0}^6 w_k X^k$
![](figures/interpol-lagrange.png)
Lagrange interpolation
`scipy.interpolation.lagrange`
:::
::::::

# Bias-variance decomposition

Samples $x_i, y_i \in \R$. We train a model $\hf$.  
Let us assume that $y_i = f(x_i) + \varepsilon_i$ where $\varepsilon_i \in \NN(0, \sigma^2)$.  
Then: the generalization error for the squared loss verifies
$$\begin{aligned}
\E[(Y - \hf(X))^2] & = \alert{\textnormal{Bias}(\hf)^2} + \textcolor{blue}{\textnormal{Var}(\hf)} + \sigma^2\\
& = \alert{\E[\hf - f]^2} + \textcolor{blue}{\E[(\hf - \E \hf)^2]} + \sigma^2.
\end{aligned}$$

\only<1>{\centering\includegraphics[width=0.6\linewidth]{figures/bias-var.png}}
\only<2>{Proof. $$ \E f = f \quad \E Y = f \quad \textnormal{Var}(Y) = \sigma^2 $$
As $\varepsilon$ and $\hf$ are independent: \small
$$ {\displaystyle {\begin{aligned}\E\left[(Y-{\hf})^{2}\right]&=\E\left[Y^{2}+{\hf}^{2}-2Y{\hf}\right]\\&=\E\left[Y^{2}\right]+\E \left[{\hf}^{2}\right]-\E [2Y{\hf}]\\&=\textnormal {Var}(Y)+\E [Y]^{2}+\textnormal {Var}({\hf})+\E [{\hf}]^{2}-2f\E [{\hf}]\\&=\textnormal {Var}(Y)+\textnormal {Var}({\hf})+(f-\E [{\hf}])^{2}\\&=\textnormal {Var}(Y)+\textnormal {Var}({\hf})+\E [f-{\hf}]^{2}\\&=\sigma ^{2}+\textnormal {Var}({\hf})+\textnormal {Bias}({\hf})^{2}.\end{aligned}}}$$}

# How to detect overfitting?

:::::: {.columns}
::: {.column}
![](figures/early.png)
:::
::: {.column}
\pause
By keeping a validation set

![](figures/crossval.png)
:::
::::::

# Hyperparameter selection by cross-validation {.fragile}

\centering

![](figures/crossval.png){width=40%}

\begin{myminted}{CV}{python}
trainval, test = split data into 80:20
train, valid = split trainval into 80:20

for each hyperparameter |$\lambda$|:
    minimize error on train using |$\lambda$|
    |$\texttt{valid\_score}_\lambda \gets$| evaluate metric on valid
|$\lambda^* \gets \lambda$| achieving best |$\texttt{valid\_score}_\lambda$|
minimize error on trainval using |$\lambda^*$| (= refit)
\end{myminted}

# Early stopping {.fragile}

\centering

![](figures/early.png){width=40%}

\raggedright
\begin{myminted}{CV}{python}
def training_loop(train, valid):
    for each epoch:
        for |$\x$|, |$y$| in train:
            do one step of gradient
            valid_score |$\gets$| evaluate metric on valid
            if valid_score is worse than before:
                return
\end{myminted}

# Example

Let us consider logistic regression i.e. 1-layer MLP:

$f(\x_i) = \sigma(\W \x_i + b)$

Logistic loss: $\L = \sum_i -(1 - y_i) \log (1 - f(\x_i)) - y_i \log f(\x_i)$

If all samples have same target $y_i = 1$ (or if there's only 1 sample), what will happen?

\pause

MLP believes everything is a cat.

- Minimize $-\log \sigma(\W \x_1 + b)$
- $\sigma(\W \x_1 + b) \to 1$
- $\W \x_1 + b \to +\infty$
- Parameters $|\W|$ and $b$ diverge to $+\infty$

Add penalty to loss $||\W||_2^2 + ||b||_2^2$ (= assuming a Gaussian prior centered in $\bm{0}$), called $L_2$ regularization


# Regularize to generalize

\begin{columns}
\begin{column}{0.6\linewidth}
Minimizing loss:\\
May fall in local minima or diverge to $\infty$\\\vspace{2cm}
Minimizing loss + regularization:\\
Easier to optimize
\end{column}
\begin{column}{0.4\linewidth}
\hfill \includegraphics[width=\linewidth]{figures/nonreg.pdf}\\
\hfill \includegraphics[width=\linewidth]{figures/reg.pdf}
\end{column}
\end{columns}

We will see an example next week.

# Take home message

## Expressiveness

- 2-layer MLPs are universal approximators of continuous functions
- Try to overfit a single batch; otherwise your model cannot express the data.

## Bias-variance trade-off

There is incompressible error due to inherent noise

## Overfitting

- Don't look at test data it's forbidden
- Implement early stopping
- And $L_2$ regularization

# Today's practical: datasets

## Digits

\centering

![](figures/digits.png){width=20%}

\raggedright
$1797 \times 8 \times 8$ images representing numbers between 0 and 9.

## Red Wine Quality[^1] (Cortez et al., 2009)

1599 wines $\times$ 11 features[^2], have to predict quality which is an integer between 0 and 10 (in practice between 3 and 8).

 [^1]: \url{https://kaggle.com/datasets/uciml/red-wine-quality-cortez-et-al-2009}
 [^2]: fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates, alcohol

## Also: Faces, Cats and dogs
