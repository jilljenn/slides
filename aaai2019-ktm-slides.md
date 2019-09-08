% Knowledge Tracing Machines:\newline Factorization Machines for Knowledge Tracing
% Jill-Jênn Vie \and Hisashi Kashima
% Hawaii University, January 24, 2019\bigskip\newline \url{https://arxiv.org/abs/1811.03388}
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
    - \DeclareMathOperator\logit{logit}
    - \def\ReLU{\textnormal{ReLU}}
    - \def\xdownarrow{ {\left\downarrow\vbox to 2.9\baselineskip{}\right.\kern-\nulldelimiterspace}}
    - \def\correct{\includegraphics{figures/win.pdf}}
    - \def\mistake{\includegraphics{figures/fail.pdf}}
    - \DeclareMathOperator\probit{probit}
biblatexoptions:
    - maxbibnames=99
    - maxcitenames=5
---

# Introduction

## Knowledge Tracing Machines (Vie & Kashima, 2019)

\vspace{1mm}
\begin{columns}
\begin{column}{0.5\linewidth}
\begin{block}{Predicting student performance}
\vspace{2mm}
\parbox{6mm}{over\\time} $\xdownarrow$ \parbox{4.2cm}{User 1 attempts Item 1 \correct\\
User 1 attempts Item 2 \mistake\\
User 1 attempts Item 2 \correct\\
User 2 attempts Item 1 ???\\
User 2 attempts Item 1 ???\\
User 2 attempts Item 2 ???}
\end{block}
\end{column}
\begin{column}{0.5\linewidth}
\begin{block}{Existing work}
\vspace{-7mm}
$$ \underbrace{\textnormal{PFA}}_\textnormal{LogReg} \! \leq \underbrace{\textnormal{DKT}}_\textnormal{LSTM} \leq \! \underbrace{\textnormal{IRT}}_\textnormal{LogReg} \! \alert{\leq \underbrace{\textnormal{KTM}}_\textnormal{FM}} $$
Using different features
\end{block}
\end{column}
\end{columns}
\vspace{4mm}

### Our method: encoding data into \alert{sparse} features

\includegraphics[width=\linewidth]{figures/archi.pdf}

## A Knowledge Tracing Machines (Vie & Kashima, 2019)

Each \textcolor{blue!80}{user}, \textcolor{orange}{item}, \textcolor{green!50!black}{skill} $k$ is modeled by bias $\alert{w_k}$ and embedding $\alert{\bm{v_k}}$.\vspace{2mm}
\begin{columns}
\begin{column}{0.47\linewidth}
\includegraphics[width=\linewidth]{figures/fm.pdf}
\end{column}
\begin{column}{0.53\linewidth}
\includegraphics[width=\linewidth]{figures/fm2.pdf}
\end{column}
\end{columns}\vspace{-2mm}

\hfill $\probit p(\bm{x}) = \mu + \underbrace{\sum_{k = 1}^N \alert{w_k} x_k}_\textnormal{logistic regression} + \underbrace{\sum_{1 \leq k < l \leq N} x_k x_l \langle \alert{\bm{v_k}}, \alert{\bm{v_l}} \rangle}_\textnormal{pairwise relationships}$

\begin{columns}
\begin{column}{0.4\linewidth}
\vspace{-5mm}
\begin{block}{Results on Assistments}
\scriptsize 347k samples: 4k users, 27k items
\includegraphics[width=\linewidth]{figures/barchart.pdf}
\end{block}
\end{column}
\begin{column}{0.6\linewidth}
\scriptsize
\input{tables/assistments42-full-simple}
\end{column}
\end{columns}

## AI for Social Good

\begin{columns}
\begin{column}{0.5\linewidth}
AI can:
\begin{itemize}
\item recognize images/speech
\item predict the next word
\item generate fakes
\item play go (make decisions)
\end{itemize}
as long as you have enough data.
\end{column}
\begin{column}{0.5\linewidth}
Can it also:
\begin{itemize}
\item \alert{improve education}
\item \alert{predict student performance}
\item generate exercises
\item optimize human learning
\end{itemize}
as long as you have enough data?
\end{column}
\end{columns}

### My research in a nutshell

Apply ML techniques to educational data mining and psychometrics.

## Students try exercises


Math Learning

\centering
\begin{tabular}{cccc} \toprule
Items & 5 -- 5 = ? & \only<2->{17 -- 3 = ?} & \only<3->{13 -- 7 = ?}\\ \midrule
New student & \alert{$\circ$} & \only<2->{\alert{$\circ$}} & \only<3->{\alert{$\mathbf{\times}$}}\\ \bottomrule
\end{tabular}

\raggedright
\only<4->{Language Learning

\includegraphics{figures/duolingo0.png}}

\pause\pause\pause\pause

### Challenges

- Data comes from humans
- People can make mistakes that do not reflect their knowledge

## Predicting student performance: knowledge tracing

### Data

A population of students answering questions

- Events: "Student $i$ answered question $j$ correctly/incorrectly"

Side information

- Skills of each item are assumed known \hfill \emph{e.g., $+$, $\times$}
- Class ID, school ID, etc.

### Goal: classification problem

Predict the performance of new users on existing questions

### Method

Learn parameters of questions from historical data \hfill \emph{e.g., difficulty}  
Measure parameters of new students \hfill \emph{e.g., expertise}  

## Visually: Knowledge Tracing (KT)

\includegraphics[width=\linewidth]{figures/dkt.png}

- Colors: skills
- Disks: outcomes of students on items targeting skills
    - Full disk: correct
    - Hole: incorrect
- We want to generalize knowledge to new skills
    - Blue to green: low to high probability of correctness
- People can try the same exercise multiple times

## Existing work

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
\only<4->{(Wilson et al., 2016) \\ \bottomrule}
\end{tabular}

<!-- \alert{Recurrent neural networks} are powerful because they learn a more complex function that tracks the evolution of the latent state

- DKT cannot handle multiple skills.
- We can combine DKT with side information
- Actually, @wilson2016back even managed to beat DKT with (1-dim!) IRT. -->

## Limitations and contributions

- Several models for KT were developed independently
- Some of them cannot handle multiple skills per item

### In this paper

- Knowledge Tracing Machines unify most existing models
    - Encoding student data to sparse features
    - Then running logistic regression or factorization machines
- KTMs can handle multiple skills
- First use of factorization machines in the context of educational data mining

### Our findings

- It is better to estimate a bias per item, not only per skill
- Side information improves performance more than higher dim.

## Learning outcomes of this presentation

\alert{Encoding existing models} into logistic regression\vspace{-3pt}
\begin{minipage}{0.6\linewidth}
\begin{itemize}
\item Examples on a dummy dataset
\item Results on big data
\end{itemize}\bigskip

\alert{Knowledge Tracing Machines}
\begin{itemize}
\tightlist
\item How to model pairwise interactions?
\item Training using MCMC
\item \alert{Results} on several datasets
\end{itemize}
\end{minipage}
\begin{minipage}{0.35\linewidth}
\includegraphics[width=\linewidth]{figures/ktm.pdf}
\end{minipage}\bigskip

Future Work\vspace{-5pt}
\begin{itemize}
\tightlist
\item Combine KTMs with \alert{recurrent neural networks}
\end{itemize}

# Encoding existing models

## Existing models

\includegraphics{figures/ktm-cite.pdf}

Not in the family: Recurrent Neural Networks

- Deep Knowledge Tracing [@piech2015deep]

\vspace{5mm}

\fullcite{rendle2012factorization}

## Dummy dataset: weak generalization

\begin{block}{Weak generalization}
\alert{Filling the blanks}: some students did not attempt all questions
\end{block}

<!-- DIAGRAM completion -->

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

## Dummy dataset: strong generalization

\begin{block}{Strong generalization}
\alert{Cold-start}: some new students are not in the train set
\end{block}

<!-- DIAGRAM whole rows missing -->

\begin{columns}
\begin{column}{0.6\linewidth}
\begin{itemize}
\item User 1 answered Item 1 correct
\item User 1 answered Item 2 incorrect
\item User 2 answered Item 1 ???
\item User 2 answered Item 1 ???
\item User 2 answered Item 2 ???
\end{itemize}
\end{column}
\begin{column}{0.4\linewidth}
\centering
\input{tables/dummy-ui-strong}\vspace{5mm}

\texttt{dummy.csv}
\end{column}
\end{columns}

## Our approach

- Encode data to sparse features
- Run logistic regression or factorization machines

## Model 1: Item Response Theory

Learn abilities $\alert{\theta_i}$ for each user $i$  
Learn easiness $\alert{e_j}$ for each item $j$ such that:
$$ \begin{aligned}
Pr(\textnormal{User $i$ Item $j$ OK}) & = \sigma(\alert{\theta_i} + \alert{e_j}) \quad \sigma : x \mapsto 1/(1 + \exp(-x))\\
\logit Pr(\textnormal{User $i$ Item $j$ OK}) & = \alert{\theta_i} + \alert{e_j}
\end{aligned}$$

Really popular model, used for the PISA assessment

### Logistic regression

Learn $\alert{\bm{w}}$ such that $\logit Pr(\bm{x}) = \langle \alert{\bm{w}}, \bm{x} \rangle$

Usually with L2 regularization: ${||\bm{w}||}_2^2$ penalty $\leftrightarrow$ Gaussian prior

## Graphically: IRT as logistic regression

Encoding "User $i$ answered Item $j$" with \alert{sparse features}:

\centering

![](figures/lr.pdf)

$$ \langle \bm{w}, \bm{x} \rangle = \theta_i + e_j = \logit Pr(\textnormal{User $i$ Item $j$ OK}) $$

## Encoding into sparse features

\centering

\input{tables/show-ui}

\raggedright
Then logistic regression can be run on the sparse features.

## Oh, there's a problem

\input{tables/pred-ui}

We predict the same thing when there are several attempts.

## Count number of attempts: AFM

Keep a counter of attempts at skill level:

\centering

\input{tables/dummy-uisa}

![](figures/lr-sa.pdf)

## Count successes and failures: PFA

Count separately successes $W_{ik}$ and fails $F_{ik}$ of student $i$ over skill $k$.

\centering

\input{tables/dummy-uiswf}

![](figures/lr-swf.pdf)

## Model 2: Performance Factor Analysis

$W_{ik}$: how many successes of user $i$ over skill $k$ ($F_{ik}$: #failures)

Learn $\alert{\beta_k}$, $\alert{\gamma_k}$, $\alert{\delta_k}$ for each skill $k$ such that:
$$ \logit Pr(\textnormal{User $i$ Item $j$ OK}) = \sum_{\textnormal{Skill } k \textnormal{ of Item } j} \alert{\beta_k} + W_{ik} \alert{\gamma_k} + F_{ik} \alert{\delta_k} $$

\centering
\input{tables/show-swf}

## Better!

\input{tables/pred-swf}

## Test on a large dataset: Assistments 2009

346860 attempts of 4217 students over 26688 items on 123 skills.

\vspace{1cm}

\centering
\input{tables/assistments42-afm-pfa}

# Knowledge Tracing Machines

## Model 3: a new model (but still logistic regression)

\centering
![](figures/lr.pdf)

\input{tables/assistments42-afm-pfa-iswf}

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

![](figures/fm2.pdf)

## Formally: factorization machines

Learn bias \alert{$w_k$} and embedding \alert{$\bm{v_k}$} for each feature $k$ such that:
$$ \logit p(\bm{x}) = \mu + \underbrace{\sum_{k = 1}^N \alert{w_k} x_k}_{\textnormal{logistic regression}} + \underbrace{\sum_{1 \leq k < l \leq N} x_k x_l \langle \alert{\bm{v_k}}, \alert{\bm{v_l}} \rangle}_{\textnormal{pairwise interactions}} $$


Multidimensional item response theory: $\logit p(\bm{x}) = \langle \bm{u_i}, \bm{v_j} \rangle + e_j$  
is a particular case.

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

\fullcite{rendle2012factorization}

# Results

## Datasets

\scriptsize

\input{tables/datasets}

## Results on the Assistments dataset

\includegraphics{figures/assistments-results.pdf}

## Accuracy results on the Assistments dataset

\centering
\input{tables/assistments42-full}

## AUC results on all datasets

\tiny

\input{tables/summary}

<!-- TODO transpose -->

## Bonus: interpreting the learned embeddings

\centering

\includegraphics{figures/viz.pdf}

# Future Work

## Future work

### Optimizing Human Learning

- Dynamically update uncertainty estimates
- Good model for prediction $\rightarrow$ Good adaptive policy for teaching
- Applications to preference elicitation

### Graph applications

- Graph convolutional networks
- Knowledge graph of side information
- Applications to crowdsourcing

# Conclusion

## Take home message

\alert{Factorization machines} are a strong baseline that unifies many existing EDM models

- It is better to estimate a bias at item level, not only at skill level
- Side information improves performance more than higher $d$

\alert{Recurrent neural networks} are powerful because they track the evolution of the latent state

- Most existing models (like DKT) cannot handle multiple skills, but KTM do
- We should combine DKT with side information

## Any suggestions are welcome!

Read our article:

\begin{block}{Knowledge Tracing Machines}
\url{https://arxiv.org/abs/1811.03388}
\end{block}

Try the code:

\centering
\url{https://github.com/jilljenn/ktm}

\raggedright
Feel free to chat:

\centering
vie@jill-jenn.net

\raggedright
Do you have any questions?
