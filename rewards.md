% Reward functions in (adaptive) recommender systems
% Jill-Jênn Vie
% Inria Bordeaux, September 3, 2024
---
aspectratio: 169
institute: \includegraphics[height=1cm]{figures/inria.png}
biblio-style: authoryear
colorlinks: true
header-includes: |
  ```{=tex}
  \usepackage{bm}
  \usepackage{algorithm,algpseudocode}
  %\floatname{algorithm}{Algorithm}
  \renewcommand{\thealgorithm}{}
  \def\x{\bm{x}}
  ```
biblatexoptions:
  - maxbibnames=99
  - maxcitenames=5
---

# Who's this? / Akinator (20Q systems, 1988)

:::::: {.columns}
::: {.column}
![](figures/whoisit.jpg)
:::
::: {.column}
![](figures/akinator.jpg)
:::
::::::

# Top 250 IMDb / MyAnimeList

:::::: {.columns}
::: {.column width=20%}
![](figures/imdb.png)
:::
::: {.column width=20%}
![](figures/mal.png)
:::
::: {.column width=60%}
\pause

Why are there so many sequels?\bigskip

\pause

It's because of \alert{survivor bias} in the data.

People who rated Season 2 survived to Season 1.

$\Rightarrow$ Average rating is a biased estimator. \bigskip

(In education, success rate is also biased, because it depends on who answered and their ability at the time of answering.)\bigskip

Item response theory: computing a Elo score between students and questions
:::
::::::

# $k$ nearest neighbors {.fragile}

\begin{algorithm}[H]
\caption{$k$ nearest neighbors}
\begin{algorithmic}
\For{each user in database}
\State compute distance between Alice and this user
\EndFor
\State identify the $k$ nearest neighbors of Alice
\State compute the average of their movie ratings
\end{algorithmic}
\end{algorithm}

How to choose $k$? \pause If $k = 1$, it is just Alice; if $k = |everyone|$, what is it?

\begin{center}
\includegraphics[height=3cm]{figures/knn.png}\includegraphics[height=3cm]{figures/knn2.png}
\end{center}

<!-- Au programme dès la première -->

# Learning a representation in latent space

\centering

\only<1>{\includegraphics[width=0.9\linewidth]{figures/embed0.pdf}}\only<2>{\includegraphics[width=0.9\linewidth]{figures/embed1.pdf}}\only<3>{\includegraphics[width=0.9\linewidth]{figures/embed2.pdf}}\only<4>{\includegraphics[width=0.9\linewidth]{figures/embed3.pdf}}\only<5>{\includegraphics[width=0.9\linewidth]{figures/embed4.pdf}}\only<6>{\includegraphics[width=0.9\linewidth]{figures/embed5.pdf}}\only<7>{\includegraphics[width=0.9\linewidth]{figures/embed6.pdf}}\only<8>{\includegraphics[width=0.9\linewidth]{figures/embed7.pdf}}\only<9>{\includegraphics[width=0.9\linewidth]{figures/embed8.pdf}}\only<10>{\includegraphics[width=0.9\linewidth]{figures/embed9.pdf}}\only<11>{\includegraphics[width=0.9\linewidth]{figures/embed10.pdf}}\only<12>{\includegraphics[width=0.9\linewidth]{figures/embed11.pdf}}\only<13>{\includegraphics[width=0.9\linewidth]{figures/embed12.pdf}}\only<14>{\includegraphics[width=0.9\linewidth]{figures/embed13.pdf}}\only<15>{\includegraphics[width=0.9\linewidth]{figures/embed14.pdf}}\only<16>{\includegraphics[width=0.9\linewidth]{figures/embed15.pdf}}\only<17>{\includegraphics[width=0.9\linewidth]{figures/embed16.pdf}}\only<18>{\includegraphics[width=0.9\linewidth]{figures/embed17.pdf}}\only<19>{\includegraphics[width=0.9\linewidth]{figures/embed18.pdf}}\only<20>{\includegraphics[width=0.9\linewidth]{figures/embed19.pdf}}\only<21>{\includegraphics[width=0.9\linewidth]{figures/embed20.pdf}}\only<22>{\includegraphics[width=0.9\linewidth]{figures/embed21.pdf}}\only<23>{\includegraphics[width=0.9\linewidth]{figures/embed22.pdf}}\only<24>{\includegraphics[width=0.9\linewidth]{figures/embed23.pdf}}\only<25>{\includegraphics[width=0.9\linewidth]{figures/embed24.pdf}}\only<26>{\includegraphics[width=0.9\linewidth]{figures/embed25.pdf}}\only<27>{\includegraphics[width=0.9\linewidth]{figures/embed26.pdf}}\only<28>{\includegraphics[width=0.9\linewidth]{figures/embed27.pdf}}\only<29>{\includegraphics[width=0.9\linewidth]{figures/embed28.pdf}}\only<30>{\includegraphics[width=0.9\linewidth]{figures/embed29.pdf}}\only<31>{\includegraphics[width=0.9\linewidth]{figures/embed30.pdf}}\only<32>{\includegraphics[width=0.9\linewidth]{figures/embed31.pdf}}\only<33>{\includegraphics[width=0.9\linewidth]{figures/embed32.pdf}}\only<34>{\includegraphics[width=0.9\linewidth]{figures/embed33.pdf}}\only<35>{\includegraphics[width=0.9\linewidth]{figures/embed34.pdf}}\only<36>{\includegraphics[width=0.9\linewidth]{figures/embed35.pdf}}\only<37>{\includegraphics[width=0.9\linewidth]{figures/embed36.pdf}}\only<38>{\includegraphics[width=0.9\linewidth]{figures/embed37.pdf}}\only<39>{\includegraphics[width=0.9\linewidth]{figures/embed38.pdf}}

# We wanted to use similar models for educational assessment

\centering

![](figures/embedding1.png){width=50%}

#

Question: "Recommender systems work for thousands of users and thousands of items. Can we use similar models for educational assessment?" \only<2>{\alert{Yes!} (MIRT)}

\centering

![](figures/cfirt.png){width=50%}

\raggedright

\small

\fullcite{Bergner2022}

# Goal: asking questions in order to optimize some reward

\centering

![](figures/asking4.pdf)

\raggedright

How to design the reward function? (e.g. clickthrough rate in recommender systems)

# Prior: where the student ability may be

\centering

![](figures/gauss.pdf){width=70%}

# Posterior given one correct answer

\centering

![](figures/gauss2.pdf){width=70%}

\raggedright

Reducing uncertainty is the actual objective function \hfill \only<2>{($\downarrow$ Shadoks, 1970)}

"When you don't know where you're going, you have to get there as fast as you can"

# Compromise between measuring well and asking few questions

\centering

![](figures/irt.pdf){width=80%}

\raggedright

Asking questions that have high uncertainty $\Rightarrow$ Students fail with 50% chance $\Rightarrow$ bad

# Other examples of rewards

Reward is 1 if student answers correctly, 0 otherwise \pause $\Rightarrow$ asking too easy questions

\pause

Difference between success rate after and before (\cite{clement2015multi,shabana2022curriculumtutor}[^1]): but should depend on which questions were asked

 [^1]: Best Paper Award AIED 2022

What is my reward?

- collect the most knowledge, i.e. maximize the number of acquired knowledge components? \parencite{Yessad2022}
- maximize my expected score on the next exam ("cramming")? \parencite{Lan2016ACB}
- given a learning objective, plan the actions to reach it?  
(ALEKS, knowledge space theory, \cite{Falmagne2006})?
- identify a knowledge gap as soon as possible \parencite{Seznec2020}

# Flow

Giving higher reward to solving a harder question, 0 otherwise

\centering

![](figures/zpdflow.png){width=50%}

\raggedright

We identify the flow directly from data (ongoing work, to be submitted)

# Using a structured graph of prerequisites

\centering

![](figures/prerequisite.png){width=80%}

# Application to certification of digital skills (Pix, 6M users)

\centering

:::::: {.columns}
::: {.column width=30%}
![](figures/prerequisite.png)
:::
::: {.column width=70%}
Asking questions that validate/invalidate the highest expected number of nodes\bigskip

\footnotesize

\fullcite{Vie2017PIX}
:::
::::::

![](figures/example.pdf){width=90%}

# Extra challenge: learning student, evolving knowledge

\centering

![](figures/zpd2.png){width=70%}

\textcolor{gray}{Figure from \cite{shabana2022curriculumtutor}.}

\raggedright

Reward is 1 if concept is within the frontier of knowledge, 0 otherwise.

\small

\fullcite{Vassoyan2023}

# Ongoing work on diversity in recommender systems (Pass Culture, 3M users)

![](figures/culture-div.png)

We want to make kids discover new cultural goods

Encouraging diversity: $p(B = 1) \Delta$ where $B$ is booking and $\Delta$ is a measure of diversity

Challenging because of the uncertainty over $B$ is supposed to be high reward
