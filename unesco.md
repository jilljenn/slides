% AI4T: AI for and by teachers\newline Pix: assessing digital skills in a changing world
% Jill-Jênn Vie\newline\newline\includegraphics[height=1cm]{figures/pix.png}\qquad\inria
% April 22, 2024
---
section-titles: false
aspectratio: 169
biblio-style: authoryear
header-includes:
    - \usepackage{booktabs}
    - \usepackage{multicol}
    - \usepackage{bm}
    - \usepackage{multirow}
    - \DeclareMathOperator\logit{logit}
    - \def\ReLU{\textnormal{ReLU}}
    - \def\inria{\includegraphics[height=1cm]{figures/inria.png}}
    - \newcommand\mycite[3]{\textcolor{blue}{#1} "#2".~#3.}
---
# Introduction

## Where AI can be used in education?

:::::: {.columns}
::: {.column width=80%}
- Automatic grading
- Automatic generation of exercises using AI
- Predicting student performance to adapt instruction
- \alert{Personalization of assessment}
- Providing personalized feedback to students
- Personalized explanations\medskip

Check UK report (536 respondants): *Generative AI in education*, UK Department for Education, January 2024 $\to$
:::
::: {.column width=20%}
$\fbox{\includegraphics{figures/genai-uk.png}}$
:::
::::::

### Opportunities

- freeing up teacher time with administrative tasks to focus on teaching
- additional educational support, notably for students with special needs

### Risks

- Unreliable or biased information
- Overreliance on AI tools

## Learning digital skills by doing, with the Pix platform

:::::: {.columns}
::: {.column}
### EU's DIGCOMP 2.0 framework

![](figures/digcomp.png)
:::
::: {.column}
![](figures/pix.png){width=2cm}

Initiated as a "state startup" at the French Ministry of Education

### Example Pix challenge

> In the village of Montrésor,  
what is the name of the street that crosses Perrières street?

Required skill: "Looking for information online".
:::
::::::

- Pix now part of French law (Code of Education)
- Pix is used by 6M active users (10\% of French population)
- Also a version Pix+ Édu for teachers
- All code is open source on GitHub
- France's solution to massive training of French citizens to digital skills

## Personalization of assessment: adaptive tests

How to assess 800 skills efficiently? Using item response theory

:::::: {.columns}
::: {.column}
![](figures/adaptive.pdf)
:::
::: {.column}
\vspace{1cm}

- We ask a question of level 5
- The examinee \alert{succeeds}
- We ask a question of level 12
- The examinee \alert{fails}
- We ask a question of level 4
- etc.
:::
::::::

\fullcite{Vie2017PIX}

## Another example of simulated challenge

![](figures/pix-filesystem.png)

## Thanks for your attention!

### Know more about Pix, digital competencies

https://pix.org/en/

### Know more about AI4Teachers

https://ai4t.eu

### Contact me:

\bigskip

Jill-Jênn Vie  
X : \@jjvie  
`vie@jill-jenn.net`
