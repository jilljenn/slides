---
header-includes:
    - \DeclareMathOperator\probit{probit}
    - \usepackage{bm}
    - \usepackage{booktabs}
    - \def\xdownarrow{{\left\downarrow\vbox to 2.9\baselineskip{}\right.\kern-\nulldelimiterspace}}
    - \def\correct{\includegraphics{figures/win.pdf}}
    - \def\mistake{\includegraphics{figures/fail.pdf}}
---
# Knowledge Tracing Machines (Vie & Kashima, 2019)

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

## Our method: encoding data into \alert{sparse} features

\includegraphics[width=\linewidth]{figures/ktm-archi.pdf}

# Knowledge Tracing Machines (Vie & Kashima, 2019)

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
