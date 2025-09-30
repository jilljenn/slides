% Efficiency and environmental impact of LLMs
% [Jill-Jênn Vie](https://jjv.ie)
% March 26, 2025
---
aspectratio: 169
institute: \includegraphics[height=1cm]{figures/soda.png} \includegraphics[height=1cm]{figures/inria.png}
colorlinks: true
biblio-style: authoryear
biblatexoptions:
    - maxbibnames=99
    - maxcitenames=5
header-includes:
  - \def\CO2{CO\textsubscript{2}}
---

# In-context learning

Traditional ML: fit(train), predict(test)

Transfer learning: pretrain, finetune(train), predict(test) \hfill (e.g. word embeddings)

In-context learning: pretrain (LLM), predict(test, train)

\vfill

\small

\fullcite{brown2020language}

\fullcite{ouyang2022training}

\fullcite{hollmann2025}

# 

\centering

![](figures/tabpfn-nature.png)

# TabPFN is pretrained on 1 million synthetic datasets

- Pretrain a foundation model to "train and test" (very meta)
- Better than training from scratch (4 hours $\to$ 2.8 seconds)
- Directly estimate $p(y_{test} \mid x_{test}, D_{train})$ using in-context learning $\to$ strong baseline
- Limitations: up to 10000 samples, does not handle missing data very well

\pause

\centering

:::::: {.columns}
::: {.column width=72%}
![](figures/tabicl.png)
:::
::: {.column width=28%}
\vspace{5mm}
\fullcite{qu2025tabicl}
:::
::::::

# Open weights models: download & run them on your computer / phone

\centering

![](figures/deepseek-r1.png){width=80%}

# Speech recognition: Whisper

The smallest model is 75 MB (!) and takes 8 seconds to transcribe 30 seconds of video:

\footnotesize

```
time ./main -m models/ggml-tiny.bin -l fr -f sample-show.wav

[00.000 --> 02.500]   - Ça va, merci. - C'est pas trois que je parle.
[02.500 --> 04.800]   Regarde ce que tu as fait, c'est de pourfouter de chose.
[04.800 --> 06.100]   Est-ce qu'il ne respire?
[06.100 --> 08.100]   - Euh, bah je crois. - Oui, je crois.
[08.100 --> 11.000]   - Ne restes pas planté là, tu vois bien qu'il a besoin d'un médecin.
[11.000 --> 13.000]   Il y a un centre Pokémon, non loin d'ici.
[13.000 --> 15.200]   Il faut que tu y ailles le plus vite possible.
[15.200 --> 16.700]   - C'est vrai et un centre.
[16.700 --> 20.600]   - Oui, pour Pokémon. - Est-ce que tu peux m'indiquer la direction?
[20.600 --> 21.700]   - Par là.
[21.700 --> 25.700]   - Oh non, ils arrivent!
[25.700 --> 28.900]   - Humé! Qu'est-ce que tu fais?
[28.900 --> 30.900]   Je comprends pas mis.
```

\small

insanely-fast-whisper is (pretrained on 5M hours of data) optimized for GPU  
and transcribes 150 minutes (2.5 hours) of audio in 98 seconds on a Nvidia A100 80 GB.  
A compressed version (166M parameters) fits within 1.5 GB RAM.

# Trade-offs between compression and performance

\href{https://allenai.org/blog/olmo2-32B}{OLMo 2 32B}: First fully open model to outperform GPT-3.5 and GPT-4o mini

\centering

![](figures/olmo2.png){width=80%}

# Distillation and other cutting-costs tricks

Before: humans were annotating data $\to$ Cost: a lot

Later: GPT-4 is annotating data $\to$ Cost: still a lot :)

Now: smaller models are trained on GPT-4 answers

3 dimensions for improvement:

- Parallelize the search of an answer: sample many responses and score them
- Giving more time to compute an answer (o1): score partial promising answers  
\hfill ($\to$ not what DeepSeek is doing)
- Improve the base model (bigger)

DeepSeek had (and shared) many other tricks for reducing costs (45x improvement)

- Caching frequent requests
- 671B parameters but only 37B active in the VRAM
- Multi-head latent attention (MLA) reducing key-value cache
- Multi-token prediction

# 

\centering

:::::: {.columns}
::: {.column width=40%}
![](figures/netflix.png)

\tiny

\qquad Maps \alert{ChatGPT} Fortnite Zoom Spotify Netflix YouTube
:::
::: {.column width=60%}
## Let's now talk about \CO2

"It's okay\footnote{\scriptsize\url{https://andymasley.substack.com/p/individual-ai-use-is-not-bad-for}}" $\to$ "No it's not"\bigskip

\alert{What does it replace?}

If getting the answer from an LLM prevents me from watching a YouTube video: cool\bigskip

Or instead of browsing many pages with trackers  
($\sim$ 50--70\% of carbon emissions\footnote{\scriptsize\url{https://marmelab.com/blog/2021/12/20/mesurons-lempreinte-carbone-des-plus-gros-sites-medias.html}}): cool\bigskip

<!-- Sources: \url{https://andymasley.substack.com/p/individual-ai-use-is-not-bad-for}, \url{https://marmelab.com/blog/2021/12/20/mesurons-lempreinte-carbone-des-plus-gros-sites-medias.html} -->

"500 billion\footnote{\scriptsize\url{https://theconversation.com/que-sait-on-des-impacts-environnementaux-de-la-video-en-ligne-lexemple-de-netflix-229955}} logged events per day on Netflix in 2016"

<!-- Source: \url{https://theconversation.com/que-sait-on-des-impacts-environnementaux-de-la-video-en-ligne-lexemple-de-netflix-229955} -->
:::
::::::

#

## Pretraining

- \alert{552 metric tons} eq. \CO2  
(5x the lifetime emissions of an American car, 550 roundtrip flights NYC--SF)

## Finetuning

- Gemma-2B-it took 1/7 emissions of GPT-3 to finetune
- QLoRA directly finetunes the 4-bit 65B quantized model  
(24 h on a single 48 GB GPU $\to$ reached \alert{99.3\%} performance of GPT-4)

## Inference

- Despite lower per-query energy use, \alert{inference dominates total emissions} due to scale
- Google in 2022 reported \alert{60\%} of ML energy use stems from inference
- ChatGPT had 1.7B visits in October 2023: within weeks or months, inference would surpass training costs\medskip

\tiny

\fullcite{patterson2022carbon}

\fullcite{luccioni2024power}

\fullcite{dettmers2023qlora}

# Comparison to human labor

Digitalization and OCR (being improved by multimodal LLMs) helped reduce heavy transport environmental costs

<!-- Better than human workers $\to$ OK -->

Environmental impact for workers in the US:

- 53x less emissions for typical LLM (LLaMa-3-70B)
- 4400x less emissions for lightweight LLM (Gemma-2B-it)

For workers in India:

- 13x less emissions for typical LLM (LLaMa-3-70B)
- 1100x less emissions for lightweight LLM (Gemma-2B-it)

\vfill

\fullcite{ren2024reconciling}

# 

"An algorithm that optimizes flight costs makes people fly more which is 'bad'"

To me:

- It is yet to be proven that such an algorithm actually changes human behavior  
(so-called rebound effect is hard to estimate)
- It's the pricing that is 'bad', not the algorithm.  
So probably we should: enforce carbon tax everywhere, $cost = price + \lambda \CO2$

Paradox: if a LLM or AI helps reduce carbon emissions of a company, then it's worth using it

# Estimating the carbon emissions of a LLM before training it (ICLR 2024)

\centering

![](figures/llmcarbon.png){width=65%}  
\raggedright \footnotesize \fullcite{faizllmcarbon}

# 

\small

Troll : "L'IA frugale n'existe pas, l'IA c'est de l'optimisation, donc ça dépend ce qu'on optimise"  
En fait :

\centering

:::::: {.columns}
::: {.column width=80%}
![](figures/frugal.png)
:::
::: {.column width=20%}
\vspace{1cm}
\fullcite{afnor2314}
:::
::::::

# Take-home message

It's all about \alert{trade-offs} computation / performance / memory / time / carbon / energy  
Still, datacenters represent \alert{1--2\%} of global carbon emissions  
Need for \alert{transparency} (cf. \href{https://x.com/SashaMTL/status/1891253847500169501}{Altman vs. Luccioni})

Avoid doing the same thing multiple times  
(cache, use pretrained instead of train from scratch, reproducibility, sovereignty paradox)

<!-- Perhaps get inspiration from "amortized complexity" (potentials, etc.) to understand marginal (per query) vs. average costs (including pretraining) -->

Avoid: usage peaks (everyone at the same time), mad race for incremental benefits (everyone wants their own model, cf. many lines built from different companies \href{https://simonwillison.net/2024/Dec/31/llms-in-2024/}{serving the exact same routes} in the 1800s)

<!-- Sharing your screen with an LLM instead of Twitch does not put you in contact with humans -->

Je n'aime pas trop "IA frugale" je suggère plutôt "optimisation optimisée"

*Cela est bien dit, répondit Candide, mais il faut cultiver notre jardin*  
$\to$ \alert{continuer à avoir notre impact} de chercheur ou ingénieur en informatique

\small \hfill Merci à Benjamin Ninassi, Antoine Pietri, Michel Blockelet, Damien Sileo pour les discussions

\footnotesize\fullcite{varoquaux2024hype}