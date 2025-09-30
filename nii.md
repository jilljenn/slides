% Modeling learner knowledge over time
% Wenbin Gan; Yuan Sun; Jill-Jênn Vie
% Oct 31, 2022
---
aspectratio: 169
handout: true
institute: \includegraphics[height=1cm]{figures/inria.png} \quad \includegraphics[height=1cm]{figures/nii.png} 
section-titles: false
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
---

# Introduction

## Predicting future performance of learners \cite{KTM2019,Minn2018,Choffin2019,gan2022knowledge}

\includegraphics[width=\linewidth]{figures/dkt.png}
\vspace{-5mm}
\begin{columns}
\begin{column}{0.5\linewidth}
\parbox{6mm}{over\\time} $\xdownarrow$ \parbox{4.2cm}{User 1 attempts Item 1 \correct\\
User 1 attempts Item 2 \mistake\\
User 1 attempts Item 2 \correct\\
User 2 attempts Item 1 ???\\
User 2 attempts Item 1 ???\\
User 2 attempts Item 2 ???}
\end{column}
\begin{column}{0.5\linewidth}
\centering
Providing feedback to learner and teacher\\
\includegraphics[height=4cm]{figures/embedding1.png}
\end{column}
\end{columns}

## Future work \hfill yuan@nii.ac.jp \hfill jill-jenn.vie@inria.fr

### Optimizing Human Learning using Causal Inference

- Estimate the learning gains $\to$ Learn an adaptive policy for teaching
- Zone of proximal development: not too hard, not too easy
- Good model for prediction $\to$ Model-based reinforcement learning
- Dynamically update the uncertainty estimates using variational methods

### Millions of data traces, e.g. Duolingo dataset
\vspace{5mm}
\includegraphics[width=\linewidth]{figures/duolingo0.png}
