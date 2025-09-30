% Research in personalized education\newline Teaching competitive programming
% Jill-Jênn Vie
% DIX, April 25, 2024
---
handout: true
aspectratio: 169
institute: \includegraphics[height=1cm]{figures/soda.png} \includegraphics[height=1cm]{figures/inria.png}
biblio-style: authoryear
colorlinks: true
header-includes: |
  ```{=tex}
  \usepackage{tikz}
  \usepackage{subfig}
  \usepackage{eurosym}
  \usepackage{graphbox}
  \usepackage{tabularx}
  \usepackage{annotate-equations}
  \usepackage{xcolor}
  \def\hfilll{\hspace{0pt plus 1 filll}}
  \def\D{\mathcal{D}}
  \def\E{\mathbb{E}}
  \def\x{{\bm{x}}}
  \def\W{{\bm{W}}}
  \def\b{{\bm{b}}}
  \def\L{\mathcal{L}}
  \def\R{\mathbf{R}}
  \def\softmax{{\textnormal{softmax}}}
  \renewcommand{\arraystretch}{1.2}
  \newcolumntype{C}{>{\centering\arraybackslash}X}
  \def\correct{\includegraphics{figures/win.pdf}}
  \def\mistake{\includegraphics{figures/fail.pdf}}
  \usepackage{bm}
  \def\uic{\alert{\textnormal{User } i} \textnormal{ solves item } j~\correct}
  ```
biblatexoptions:
  - maxbibnames=99
  - maxcitenames=5
---

## CV highlights

- 2014 Agrégation de mathématiques option informatique
- 2016 *Competitive programming in Python* book with Christoph Dürr
- 2016 PhD in Computer Science at Université Paris-Saclay  
"Adaptive Testing using Cognitive Diagnosis for Large-Scale Learning"  
Yolaine Bourda (LISN), Fabrice Popineau (LISN), Éric Bruillard (ENS Paris-Saclay)
- 2019 Joined Inria Lille, SCOOL team (CRCN)
- 2021 Joined Inria Saclay, SODA team
- 2021 General Chair of Educational Data Mining 2021 conference (400 p.)
- 2022 Secretary of Société informatique de France
- From 2022 Jury of agrégation d'informatique
- From 2023 Scientific committee of French Ministry of Education

Taught at:

- X (INF471S ICPC training, PDV302 Bachelor ICPC training, PSC SWERC)
- ENS, CentraleSupélec, Sorbonne U, U Lille, Polytech'Lille, EPF

# Research project

## Learning human representations over time

<!-- :::::: {.columns}
::: {.column}
![](figures/cf.jpg)
:::
::: {.column}
![](figures/duolingo0.png)
:::
:::::: -->

### Movie recommendations (e.g. Movielens) \medskip

\centering

![](figures/cf.jpg){width=60%}

### Knowledge tracing: predicting student performance (e.g. Duolingo) \medskip

![](figures/duolingo0.png)

## Estimating item difficulty from data, using item response theory

\centering

\resizebox{0.9\linewidth}{!}{$\displaystyle \substack{\normalsize \Pr(\textnormal{"student A solves question B"})\\ \Pr(\textnormal{"player A beats player B"})\\ \Pr(\textnormal{"A is preferred to B"})} = \frac1{1 + \exp(-(score_A - score_B))}$}

\raggedright

Learn \alert{scores} from data by maximum likelihood estimation (or gradient descent)

\begin{figure}
  \captionsetup[subfigure]{labelformat=empty,justification=centering}
  \subfloat[reCAPTCHA\\ (Luis von Ahn, 2008)]{\raisebox{2mm}{\includegraphics[width=0.25\linewidth]{figures/captcha.png}}}
  \subfloat[Elo (1967)\\ TrueSkill (2007)]{\includegraphics[width=0.25\linewidth]{figures/tournament-nyt.png}}
  \subfloat[Adaptive tests\\ (Rasch, 1960)]{\includegraphics[width=0.25\linewidth]{figures/irt.pdf}}
  \subfloat[Preference models\\ (Bradley \& Terry, 1952)]{\raisebox{3mm}{\includegraphics[width=0.25\linewidth]{figures/elo2.jpg}}}
\end{figure}

We provided efficient implementations scaling to millions of rows, using sparse vectors

\vfill \small

\fullcite{KTM2019}

## Application: adaptive tests in dimension 1

After item difficulty has been learned from data

To measure efficiently, we can do a binary search over the level of the student.  
Good for the examiner (reducing questions), not for the examinee (50\% chance \correct)

\centering

![](figures/irt.pdf)

## Example: Fraction dataset

Fraction subtraction data contains $536 \times 20$ attempts of middle schoolers.

![](figures/decarlo.png)

## 2-dimensional item response theory (similar to PCA)

$$\Pr(\uic) = \sigma(\langle \alert{\bm{\theta}_{i}}, \bm{a}_{j} \rangle + b_j)$$

\centering

![](figures/embedding1.png){width=40%}

## Interpreting the components

\centering

![](figures/embedding2.png){width=80%}

## Interpreting the components

\centering

![](figures/embedding3.png){width=80%}

## Modeling trajectories of students

Models of learning and forgetting for spaced repetition

\centering

![](figures/memory.png){width=50%}

\raggedright

\small

\fullcite{Choffin2019}

## Reinforcement learning (RL) on human feedback

RL is popular in simulated environments such as games.

Challenges:

- How to be sample efficient when doing RL on human interaction data?
- How to generalize a trained agent on new courses?

\centering

![](figures/asking3.pdf)

\small \raggedright

\fullcite{Vassoyan2023}

## Contextual bandits

Observe student context $s$ (user ability, user history, day of the week, etc.)  
$\to$ select activity $a$ $\to$ observe reward $r$

Find the policy $\pi(a \mid s)$ that maximizes average reward:\bigskip

\begin{equation*}
  V(\pi) = \E r = \int_s \int_a \int_r
    \eqnmarkbox[NavyBlue]{s}{p(s)}\,
    \eqnmarkbox[OliveGreen]{a}{\pi(a \mid s)}\,
    \eqnmarkbox[WildStrawberry]{r}{p(r \mid s, a) r}\,
    ds\, da\, dr
\end{equation*}

\annotate[yshift=1em]{above,left}{s}{observe student context $s$}
\annotate[yshift=1em]{above}{a}{select activity $a$ using policy}
\annotate[yshift=-0.5em]{below}{r}{observe reward $r$}

\raggedright Given a dataset $\D_0 = (s_i, a_i, r_i)_i$ collected with policy $\pi_0(a \mid s)$:

- How to parameterize a model $p(r \mid s, a)$ on existing data $\D_0$? (EAAI 2022)
- How to generate a new synthetic dataset $\mathcal{D}'$ that follows a similar distribution than $\D_0$ while ensuring the privacy of participants? (EC-TEL 2022)
- Given data $\mathcal{D}_0$ collected with policy $\pi_0$ how to evaluate a different policy $\pi_e$ for asking questions? (counterfactual learning, preprint)

These questions go beyond the application to education.

## Applications to (public) State Startups

:::::: {.columns}
::: {.column width=75%}
### Pix

Certifying 800 digital skills of French citizens using $\sim$ 20 questions  
6M active users (10\% of French population)  
Paris Region PhD funding (Samuel Girard)

### Pass Culture  

Recommending items with diversity to 3M students  
with Kyoto U: RED (Recommendations Encouraging Diversity)  
Funding a research engineer

### MonProjetSup

Recommender system of jobs and disciplines  
AEx Orion (optimization of professional orientation)  
Funding Marie Generali's PhD
:::
::: {.column width=25%}
\centering

![](figures/pix.png){width=70%}

\vspace{1cm}

![](figures/passculture.jpg)

\vspace{1cm}

![](figures/monprojetsup.png)
:::
::::::

# Teaching project

## Algorithms \& complexity, e.g. shortest paths

\centering

![](figures/shortest-paths.png){width=90%}

## Practical lessons on real data: Paris's graph (11k vertices, 18k edges)

\centering

![Paris](figures/paris0.png){width=90%}

## Shortest path in Paris (Gare de Lyon $\to$ Porte d'Italie)

![](figures/paris-shortest-path.png)

## Algorithmic problem solving: International Collegiate Programming Contest

:::::: {.columns}
::: {.column width=60%}
![](figures/longest-path-dag.png)
:::
::: {.column width=40%}
\centering
![](figures/icpc.png){width=40%}
![](figures/swerc1-crop.jpg)
![](figures/swerc2.jpg)
:::
::::::

## Loading testcases in Codium (offline judge)

\centering

![](figures/longest-path-dag-vscode.png)

## Results

:::::: {.columns}
::: {.column width=33%}
### XCPC local contest

1.  \alert{Luca PV} \hfill 6 cnXtv
2.  \alert{Quang} \hfill   6 eXotic
3.  \alert{Cristian} \hfill 5 cnXtv
4.  \alert{Luca M}  \hfill  4 cnXtv
5.  \alert{Sirawit}  \hfill 4 eXotic
6.  Gabriel  \hfill 4 eXotic
7.  Aymane   \hfill 4
8.  \alert{Tudor}  \hfill   4
9.  \alert{Duc}   \hfill    3
10. \alert{Pu}   \hfill     3
11. Zhicheng \hfill 2
12. Mostafa  \hfill 1\medskip

(over 22 students)
:::
::: {.column width=33%}
### Southwestern Europe

\begin{enumerate}
\item ETH Zürich \hfill (11 pbs)
\item Univ. Porto \hfill (11 pbs)
\item \alert{cnXtv} \hfill (11 pbs)
\item \alert{eXotic} \hfill (10 pbs) 
\item[10.] ENS Ulm 1 \hfill (9 pbs)
\end{enumerate} \medskip

(over 107 teams of 3)
:::
::: {.column width=33%}
### European Championship

\begin{enumerate}
\item Univ. Warsaw \hfill (9 pbs)
\item  Univ. Zagreb \hfill (8 pbs)
\item Univ. Kyiv \hfill (8 pbs)  
\item[6.] ENS Ulm 1 \hfill (8 pbs)  
\item[9.] Univ. Porto \hfill (8 pbs)  
\item[11.] ETH Zurich  \hfill (7 pbs)  
\item[21.] \alert{cnXtv}  \hfill (7 pbs)
\end{enumerate} \medskip

(over 52 teams of 3) 
:::
::::::

\alert{cnXtv} qualified for ICPC World Finals in September 2024 in Astana, Kazakhstan

## Deep Learning: Do It Yourself at École normale supérieure de Paris

![](figures/deeplearning.png)

with Kevin Scaman, Marc Lelarge

## Automatic differentiation

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

Matrix multiplication (Jacobians): $J_{\L \circ \softmax \circ z} = (J_\L \circ f) (J_\softmax \circ z) J_z$

## Backpropagation as (gradient) message passing on a graph

![](figures/reverse-ad.png)

## Suggestions

We already have a couple of graders at École polytechnique  
How about having yet another one? (DOMjudge, works with any language)

![](figures/kattis.png)

With our tryalgo library we already have 128+ algorithms implemented with testcases.

If we want students to have better programming skills  
Should we have a practical CS entrance examination[^1] at X?

 [^1]: Like concours ENS MP, concours Télécom Paris MPI, agrégation d'informatique, etc.

## Thanks for your attention!

My research project: personalizing education

### Wanna do: competitive programming

- INF471S ICPC training
- PDV302 Bachelor ICPC training
- INF473A Competitive programming in C++ (if needed)

### Can join: algorithms

- INF411 Bases programmation & algorithmique
- INF421 Conception et analyse d'algorithmes

### Can join: machine learning

- INF442 Analyse de données en C++
- INF554 Apprentissage automatique et profond
- INF581A Apprentissage profond avancé
- INF473V Deep Learning in Computer Vision (a bit less)

### Cannot do: Java

## Reinforcement Learning from Human Feedback: InstructGPT, ChatGPT

1. Predict the next word $\pi(y|x)$ (GPT)
1. Collect demonstration data, and train a supervised policy $\pi_0(y|x)$ (based on GPT)
1. Collect comparison data ("only" 50k preferences), train a reward model using Elo

\centering

$\displaystyle \textnormal{loss}(\alert\theta) = -\E_{(x, y_k, y_\ell) \sim D} \log \underbrace{\sigma(r_{\alert\theta}(x, y_k) - r_{\alert\theta}(x, y_\ell))}_{\Pr("\textnormal{answer } y_k \textnormal{ is preferred to } y_\ell")}$

4. Optimize a policy against the reward model using PPO ("without going too far").

$\displaystyle \textnormal{objective}(\alert\phi) = \E_{(x, y) \sim \pi_{\alert\phi}} r_\theta(x, y) - \beta \textnormal{KL}(\pi_{\alert\phi}, \pi_0)$

\raggedright \small

\fullcite{ouyang2022training}

Part 2: A teacher should be better than the main population (if 50\% of population believes something wrong, we do not want the LLM to imitate this behavior).  
Part 3--4: We can remove the reward model, according to the following paper.

\fullcite{rafailov2024direct}

## From bandits to reinforcement learning

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

Bandits are the equivalent for episodes of length 1: $S \to A \to R$

## Google Hash Code 2014

How to explore a maximum of meters of Paris within 15 hours?

### Hint: Eulerian graphs

\centering
![Euler](figures/euler.pdf)\ 

\vspace{1cm}

\raggedright
iff 0 or 2 nodes having an \alert{odd} number of neighbors.

## Add edges to make Paris graph Eulerian by coupling nodes with shortest paths

\centering
![Eulérianiser Paris](figures/euler-paris.pdf)\ 

\vspace{1cm}

\raggedright
Some nodes have an \alert{excess} number of incoming edges, others are \alert{lacking} edges.

Maximum matching of minimal weight
