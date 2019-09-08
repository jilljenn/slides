% Knowledge Tracing:\newline Predicting \& Optimizing Human Learning
% Jill-Jênn Vie \and Hisashi Kashima
% AIP-IITH workshop, March 15, 2019
---
theme: Frankfurt
handout: true
institute: \includegraphics[height=9mm]{figures/aip-logo.png} \quad \includegraphics[height=1cm]{figures/kyoto.png}
section-titles: false
biblio-style: authoryear
header-includes:
    - \usepackage{booktabs}
    - \usepackage{multicol,multirow}
    - \usepackage{algorithm,algpseudocode}
    - \usepackage{bm}
    - \usepackage{bbm}
    - \usepackage{tikz}
    - \def\ReLU{\textnormal{ReLU}}
    - \def\xdownarrow{{\left\downarrow\vbox to 2.9\baselineskip{}\right.\kern-\nulldelimiterspace}}
    - \def\correct{\includegraphics{figures/win.pdf}}
    - \def\mistake{\includegraphics{figures/fail.pdf}}
    - \newcommand\logit{\mathop{\mathrm{logit}}}
biblatexoptions:
    - maxbibnames=99
    - maxcitenames=5
---

# Knowledge Tracing

## Topics

- Modeling learning over time

- Combining representations (users & items)
    - Dimension 1 \only<2>{\alert{user2bias}}
    - Dimension $n$ \only<2>{\alert{user2vec}} \hfill \raisebox{-1.5cm}{\only<2>{\includegraphics[width=3cm]{figures/surprised.jpg}}}

- Adaptive strategies for testing & optimizing human learning
    - If we can understand how human learns
    - We can learn a policy to teach better

## Related applications

### Crowdsourcing

Data: worker $i$ labels item $j$ with class $k$  
What is the true label of all items?

### Mixture of experts, ensemble methods

Modeling which algorithm suits which features

### Machine teaching

Feed the best sequence of samples to train a known algorithm

## Practical intro

When exercises are too easy (or difficult),  
students get bored (or discouraged).  

To personalize assessment,  
$\rightarrow$ need a \alert{model} of how people respond to exercises.

\centering
\includegraphics{figures/adaptive.pdf}

## Learning low-rank representations of users and items

\centering
\includegraphics[width=0.6\linewidth]{figures/map.png}

## Students try exercises

Math Learning

\centering
\begin{tabular}{cccc} \toprule
Items & 5 -- 5 = ? & \uncover<2->{17 -- 3 = ?} & \uncover<3->{13 -- 7 = ?}\\ \midrule
New student & \alert{$\mathbf{\circ}$} & \only<2->{\alert{$\mathbf{\circ}$}} & \only<3->{\alert{$\bm{\times}$}}\\ \bottomrule
\end{tabular}

\raggedright
\only<4->{Language Learning

\includegraphics{figures/duolingo0.png}}

\pause\pause\pause\pause

### Challenges

- Users can attempt a same item multiple times
- Users learn over time
- People can make mistakes that do not reflect their knowledge

## Predicting student performance: knowledge tracing

### Data

A population of users answering items

- Events: "User $i$ answered item $j$ correctly/incorrectly"

Side information

- If we know the skills required to solve each item \hfill \emph{e.g., $+$, $\times$}
- Device used by the student, etc.

### Goal: classification problem

Predict the performance of new users on existing items  
Metric: AUC

### Method

Learn parameters of questions from historical data \hfill \emph{e.g., difficulty}  
Measure parameters of new students \hfill \emph{e.g., expertise}  

# user2bias

## Our small dataset

\begin{columns}
\begin{column}{0.6\linewidth}
\begin{itemize}
\item User 1 answered Item 1 correct
\item User 1 answered Item 2 incorrect
\item User 2 answered Item 1 incorrect
\item User 2 answered Item 1 correct
\item User 2 answered Item 2 ???
\end{itemize}
\end{column}
\begin{column}{0.4\linewidth}
\centering
\input{tables/dummy-ui-weak}\vspace{5mm}

\texttt{dummy.csv}
\end{column}
\end{columns}

## Our approach

- Encode data to sparse features

\includegraphics[width=\linewidth]{figures/archi.pdf}

- Run logistic regression or factorization machines  
$\Rightarrow$ recover existing models or better models

## Simplest baseline: Item Response Theory (Rasch, 1960)

Learn abilities $\alert{\theta_i}$ for each user $i$  
Learn easiness $\alert{e_j}$ for each item $j$ such that:
$$ \begin{aligned}
Pr(\textnormal{User $i$ Item $j$ OK}) & = \sigma(\alert{\theta_i} + \alert{e_j}) \quad \sigma : x \mapsto 1/(1 + \exp(-x))\\
\logit Pr(\textnormal{User $i$ Item $j$ OK}) & = \alert{\theta_i} + \alert{e_j}
\end{aligned}$$

Really popular model, used for the PISA assessment

### Can be encoded as logistic regression

Learn $\alert{\bm{w}}$ such that $\logit Pr(\bm{x}) = \langle \alert{\bm{w}}, \bm{x} \rangle + b$

## Graphically: IRT as logistic regression

Encoding "User $i$ answered Item $j$" with \alert{sparse features}:

\centering

![](figures/lr.pdf)

$$ \langle \bm{w}, \bm{x} \rangle = \theta_i + e_j = \logit Pr(\textnormal{User $i$ Item $j$ OK}) $$

## Oh, there's a problem

\input{tables/pred-ui}

We predict the same thing when there are several attempts.

## Performance Factor Analysis (Pavlik et al., 2009)

Keep counters over time:  
$W_{ik}$ ($F_{ik}$): how many successes (failures) of user $i$ over skill $k$
\begin{columns}
\begin{column}{0.5\linewidth}
\includegraphics[width=\linewidth]{figures/lr-swf.pdf}
\end{column}
\begin{column}{0.5\linewidth}
$$\begin{aligned}
\logit Pr(\textnormal{User $i$ Item $j$ OK})\\
= \sum_{\textnormal{Skill } k \textnormal{ of Item } j} \alert{\beta_k} + W_{ik} \alert{\gamma_k} + F_{ik} \alert{\delta_k}
\end{aligned}$$
\end{column}
\end{columns}

\small
\input{tables/pred-swf}

## Model 3: a new model (but still logistic regression)

346860 attempts of 4217 students over 26688 items on 123 skills.

\centering
\input{tables/assistments42-afm-pfa-iswf}

# user2vec

## Here comes a new challenger

How to model \alert{pairwise interactions} with \alert{side information}?

### Logistic Regression

Learn a 1-dim \alert{bias} for each feature (each user, item, etc.)

### Factorization Machines

Learn a 1-dim \alert{bias} and a $k$-dim \alert{embedding} for each feature

## How to model pairwise interactions with side information?

If you know user $i$ attempted item $j$ on \alert{mobile} (not desktop)  
How to model it?

$y$: score of event "user $i$ solves correctly item $j$"

### IRT

$$ y = \theta_i + e_j $$

### Multidimensional IRT (similar to collaborative filtering)

$$ y = \theta_i + e_j + \langle \bm{v_\textnormal{user $i$}}, \bm{v_\textnormal{item $j$}} \rangle $$

\pause

### With side information

\small \vspace{-3mm}
$$ y = \theta_i + e_j + \alert{w_\textnormal{mobile}} + \langle \bm{v_\textnormal{user $i$}}, \bm{v_\textnormal{item $j$}} \rangle + \langle \bm{v_\textnormal{user $i$}}, \alert{\bm{v_\textnormal{mobile}}} \rangle + \langle \bm{v_\textnormal{item $j$}}, \alert{\bm{v_\textnormal{mobile}}} \rangle $$

## Graphically: logistic regression

\centering

![](figures/lr.pdf)

## Graphically: factorization machines

\centering

![](figures/fm.pdf)

## Formally: factorization machines

Each \textcolor{blue!80}{user}, \textcolor{orange}{item}, \textcolor{green!50!black}{skill} $k$ is modeled by bias $\alert{w_k}$ and embedding $\alert{\bm{v_k}}$.\vspace{2mm}
\begin{columns}
\begin{column}{0.47\linewidth}
\includegraphics[width=\linewidth]{figures/fm.pdf}
\end{column}
\begin{column}{0.53\linewidth}
\includegraphics[width=\linewidth]{figures/fm2.pdf}
\end{column}
\end{columns}\vspace{-2mm}

\hfill $$\begin{aligned}
\logit p(\bm{x}) & = \mu + \underbrace{\sum_{k = 1}^N \alert{w_k} x_k}_\textnormal{logistic regression} + \underbrace{\sum_{1 \leq k < l \leq N} x_k x_l \langle \alert{\bm{v_k}}, \alert{\bm{v_l}} \rangle}_\textnormal{pairwise relationships}\\
& = \mu + \langle \bm{w}, \bm{x} \rangle + \frac12 \left({||V \bm{x}||}^2 - \mathbbm{1}^T (V \circ V) (\bm{x} \circ \bm{x}) \right)
\end{aligned}
$$

<!-- Multidimensional item response theory: $\logit p(\bm{x}) = \langle \bm{u_i}, \bm{v_j} \rangle + e_j$  
is a particular case. -->

\small
\fullcite{rendle2012factorization}

## Training using MCMC

Priors: $w_k \sim \mathcal{N}(\mu_0, 1/\lambda_0) \quad \bm{v_k} \sim \mathcal{N}(\bm{\mu}, \bm{\Lambda}^{-1})$  
Hyperpriors: $\mu_0, \ldots, \mu_n \sim \mathcal{N}(0, 1), \lambda_0, \ldots, \lambda_n \sim \Gamma(1, 1) = U(0, 1)$

<!-- DIAGRAM Graphical model -->

\begin{algorithm}[H]
\begin{algorithmic}
\For {each iteration}
    \State Sample hyperp. $(\lambda_i, \mu_i)_i$ from posterior using Gibbs sampling
    \State Sample weights $\bm{w}$
    \State Sample vectors $\bm{V}$
    \State Sample predictions $\bm{y}$
\EndFor
\end{algorithmic}
\caption{MCMC implementation of FMs}
\label{mcmc-fm}
\end{algorithm}

Implementation in C++ (libFM) with Python wrapper (pyWFM).

\small
\fullcite{rendle2012factorization}

## Datasets

### Fraction

500 middle-school students, 20 fraction subtraction questions,  
8 skills (full matrix)

### Assistments

346860 attempts of 4217 students over 26688 math items  
on 123 skills (sparsity 0.997)

### Berkeley

On a MOOC of Computer Science, 562201 attempts  
of 1730 students over 234 items of 29 categories

## Existing work on Assistments

\footnotesize
\begin{tabular}{cccc} \toprule
\multirow{2}{*}{Model} & \multirow{2}{*}{Basically} & Original & \only<3->{Fixed}\\
& & AUC & \only<3->{AUC}\\ \midrule
Bayesian Knowledge Tracing & \multirow{2}{*}{Hidden Markov Model} & \multirow{2}{*}{0.67} & \only<3->{\multirow{2}{*}{0.63}}\\
(\cite{corbett1994knowledge})\\ \midrule
\only<2->{Deep Knowledge Tracing & \multirow{2}{*}{Recurrent Neural Network} & \multirow{2}{*}{0.86} & \only<3->{\multirow{2}{*}{0.75}}\\}
\only<2->{(\cite{piech2015deep})\\ \midrule}
\only<4->{Item Response Theory & \multirow{3}{*}{Online Logistic Regression} & \multirow{3}{*}{} & \multirow{3}{*}{0.76}\\}
\only<4->{(\cite{rasch1960studies})\\}
\only<4->{(Wilson et al., 2016) \\ \midrule}
\only<5->{Knowledge Tracing Machines & Factorization Machines & & 0.82\\ \bottomrule}
\end{tabular}

\small
\only<5->{\fullcite{KTM2019}}

<!-- \alert{Recurrent neural networks} are powerful because they learn a more complex function that tracks the evolution of the latent state

- DKT cannot handle multiple skills.
- We can combine DKT with side information
- Actually, @wilson2016back even managed to beat DKT with (1-dim!) IRT. -->

## AUC results on the Assistments dataset

\centering
\includegraphics[width=0.6\linewidth]{figures/barchart.pdf}

\scriptsize
\input{tables/assistments42-full}

## Bonus: interpreting the learned embeddings

\centering

\includegraphics{figures/viz.pdf}

# ???

## What 'bout recurrent neural networks?

Deep Knowledge Tracing: knowledge tracing as sequence prediction

- Each student on skill $q_t$ has performance $a_t$
- How to predict outcomes $\bm{y}$ on every skill $k$?
- Spoiler: by measuring the evolution of a latent state $\alert{\bm{h_t}}$

\small
\fullcite{piech2015deep}
\normalsize

### Our approach: encoder-decoder

\def\xin{\bm{x^{in}_t}}
\def\xout{\bm{x^{out}_t}}
$$\left\{\begin{array}{ll}
\bm{h_t} = Encoder(\bm{h_{t - 1}}, \xin)\\
p_t = Decoder(\bm{h_t}, \xout)\\
\end{array}\right. t = 1, \ldots, T$$

## Graphically: deep knowledge tracing

\centering

![](figures/dkt1.pdf)

## Deep knowledge tracing with dynamic student classification

\centering

![](figures/dkt3.pdf)

\raggedright\small
\fullcite{Minn2018}

## DKT seen as encoder-decoder

\centering

![](figures/dkt2.pdf)

## Results on Fraction dataset

500 middle-school students, 20 Fraction subtraction questions,  
8 skills (full matrix)

\begin{table}
\centering
\begin{tabular}{cccccc} \toprule
Model & Encoder & Decoder & $\xout$ & ACC & AUC\\ \midrule
\textbf{Ours} & GRU $d = 2$  & bias & iswf & \textbf{0.880} & \textbf{0.944}\\
KTM & counter & bias & iswf & 0.853 & 0.918\\
PFA & counter & bias & swf & 0.854 & 0.917\\
Ours & $\varnothing$  & bias & iswf & 0.849 & 0.917\\
Ours & GRU $d = 50$  & $\varnothing$ & & 0.814 & 0.880\\
DKT & GRU $d = 2$  & $d = 2$ & s & 0.772 & 0.844\\
Ours & GRU $d = 2$  & $\varnothing$ & & 0.751 & 0.800\\ \bottomrule
\end{tabular}
\label{results-fraction}
\end{table}

## Results on Berkeley dataset

562201 attempts of 1730 students over 234 CS-related items of 29 categories. 

\begin{table}
\centering
\begin{tabular}{cccccc} \toprule
Model & Encoder & Decoder & $\xout$ & ACC & AUC\\ \midrule
\textbf{Ours} & GRU $d = 50$ & bias & iswf & \textbf{0.707} & \textbf{0.778}\\
\textbf{KTM} & counter & bias & iswf & \textbf{0.704} & \textbf{0.775}\\
Ours & $\varnothing$ & bias & iswf & 0.700 & 0.770\\
DKT & GRU $d = 50$  & $d = 50$ & s & 0.684 & 0.751\\
Ours & GRU $d = 100$  & $\varnothing$ & & 0.682 & 0.750\\
PFA & counter & bias & swf & 0.630 & 0.683\\
DKT & GRU $d = 2$  & $d = 2$ & s & 0.637 & 0.656\\ \bottomrule
\end{tabular}
\label{results-assistments}
\end{table}

\raggedright \small
\fullcite{Vie2019encode}

# Conclusion

## Take home message

\alert{Factorization machines} unify many existing EDM models

- Side information improves performance more than higher $d$
- We can visualize learning (and provide feedback to learners)

They can be combined with \alert{deep neural networks}

- Unidimensional decoders perform better
- But simple counters are good enough encoders

Then we can \alert{optimize learning}

- Increase success rate of the student  
\hfill (Clement et al., JEDM 2015)
- Identify something that the student does not know  
\hfill (Teng et al., ICDM 2018, Seznec et al., AISTATS 2019)
- See more on https://humanlearn.io

## Merci ! Do you have any questions?

\centering
\url{https://jilljenn.github.io}

\raggedright
I'm interested in:

- predicting student performance
- optimizing human learning using reinforcement learning
- (manga) recommender systems

\vspace{7mm}
\begin{columns}
\begin{column}{0.2\linewidth}
\includegraphics[width=\linewidth]{figures/workshop.png}
\end{column}
\begin{column}{0.8\linewidth}
We are organizing a workshop on June 3--4, 2019\\
\alert{Optimizing Human Learning} (Kingston, Jamaica)\\
colocated with Intelligent Tutoring Systems, ITS 2019\\
\alert{CFP open} until April 16, 2019: https://humanlearn.io
\end{column}
\end{columns}

\centering
vie@jill-jenn.net
