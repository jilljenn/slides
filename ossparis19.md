---

# Deep Learning for Anime & Manga
## JJ Vie

---

# 2014 {.big}

Mangaki in Paris

---

# Mangaki, recommendations of anime/manga

Rate anime/manga and receive recommendations

![](https://jiji.cat/tmp/slides/figures/blackdecks.jpg)

---

# Build a profile

![](https://jiji.cat/tmp/slides/figures/blackprofile2.png)

---

# Mangaki prioritizes your watchlist

![](https://jiji.cat/tmp/slides/figures/blackreco2.png)

---

# Mangaki.fr

Discover precious pearls suited to your taste

- 371,000 ratings by 2,500 users on 15,000 anime & manga
- 5 languages

Nonprofit

- Everything is open source AGPLv3 or MIT: github.com/mangaki
- Python (Django), Vue.js

Awards: Microsoft Prize (2014) Japan Foundation (2016)

---

# Recommendation: user2vec, item2vec

Algorithm ALS: Alternating Least Squares (Zhou, 2008)

- Until convergence:
    - Fix users learn works in order to minimize the error of predictions
    - Fix works learn users

---

# Training our recommender system

![](https://jiji.cat/tmp/slides/figures/embed/embed.gif)

---

# All of Mangaki.fr is free software

Platform is under AGPLv3 license

github.com/mangaki/mangaki

Core algorithms are under MIT license

github.com/mangaki/zero

You can run them on any data (fit, predict)

---

# 2017 {.big}

Postdoc in RIKEN AIP, Tokyo

---

# RIKEN, Japan

- Public research institute founded in 1917 (> 100 years!)
- RIKEN ~ CNRS
- RIKEN AIP (Tokyo) is a 10-year project dedicated to AI ~ Inria team-project

---

# Mangaki Data Challenge

25 participants from 11 countries

1. Ronnie Wang (Microsoft Suzhou, China)
2. Kento Nozawa (The University of Tokyo, Japan)
3. Jo Takano (Kobe University, Japan)

If you want the anonymized dataset, please contact us

---

# Danbooru 2017 & 2018 datasets by Gwern

- 3,330,000 manga illustrations (2.5TB)
- 365,000 unique description tags (~28 per image)

What do we want to do?

- Take a pretrained model on ImageNet
- Retrain it on this dataset

---

# Illustration2Vec (Saito and Matsui, 2015)

![](https://jiji.cat/tmp/slides/figures/fate2.png)
![](https://jiji.cat/tmp/slides/figures/i2v-rv.png)

---

# Our algorithm: BALSE (Vie et al., 2017)

![](https://jiji.cat/tmp/slides/figures/balse.jpg)

---

# Meeting Yanghua Jin

![](https://jiji.cat/tmp/slides/figures/farewell.jpg)

---

# Using GAN to generate anime characters

![](https://jiji.cat/tmp/slides/figures/mgm.png)

---

# Make.Girls.Moe (Jin et al., NeurIPS workshop 2017)

![](https://jiji.cat/tmp/slides/figures/mgm2.png)

---

# Comic Market (200k attendees × 4 days)

![](https://jiji.cat/tmp/slides/figures/comicmarket.jpg)

---

# Make.Girls.Moe

- July 19: Make.Girls.Moe gets live
- August 11: Research article sold at Comiket
- 1 million visits in 1 month

How to keep the server up with such an amount of visitors?

---

# How to keep your deep learning server up?

All deep learning code was executed client-side,
on the browser of the visitors!

(The compressed model was only 12 MB.)

Using WebDNN by The University of Tokyo.
Many alternatives exist today.

---

# 2018 {.big}

Keynote in Los Angeles

---

# Keynote at Anime Expo

- Anime/Manga Recommendation

- Anime Face Generation

- Manga Sketch Colorization

- Manga Style Transfer

---

# Crypko.ai, a cryptocollectible game

- Yanghua Jin
- Minjun Li
- Yingtao Tian
- Jiakai Zhang
- Huachun Zhu

![](https://jiji.cat/tmp/slides/videos/female.gif)

---

# Also generating boy faces!

Crypko was acquired by Preferred Networks (PFN) in August 2018

![](https://jiji.cat/tmp/slides/videos/male.gif)

---

# PaintsChainer by Taizan Yonetsuji (PFN)

![](https://jiji.cat/tmp/slides/figures/paintschainer.jpg)

---

# style2paints by LvMin Zhang (Soochow U.)

![](https://jiji.cat/tmp/slides/videos/s2p.gif)

---

# Manga Style Transfer

![](https://jiji.cat/tmp/slides/figures/styletransfer.jpg)

---

# TwinGAN by Jerry Li (now at DeepMind)

github.com/jerryli27/TwinGAN under Apache License 2.0

![](https://jiji.cat/tmp/slides/figures/twingan.png)

---

# 2019 {.big}

Back to France

---

# StyleGAN by Nvidia (Karras, Laine, Aila, 2018)

![](https://jiji.cat/tmp/slides/figures/stylegan.png)

---

# This Waifu Does Not Exist .net by Gwern

![](https://jiji.cat/tmp/slides/figures/stylegan-twdne.jpg)

---

# Waifu Labs by Sizigi Studios (5 USD)

![](https://jiji.cat/tmp/slides/figures/waifulabs.jpg)

---

# Wait… Is this legal?

- Nvidia StyleGAN source code & models are CC-BY-NC 4.0
  - "You can use, redistribute, and adapt the material for non-commercial purposes, as long as you give appropriate credit by citing our paper and indicating any changes you've made."

- Some people share their weights (pretrained models) under simplified BSD licenses ("use at your own risk")

- What about samples? "To qualify as a work of authorship, a work must be created by a human being." (Burrow-Giles Lithographic Co., 111 U.S. at 58)

Source: gwern.net

---

# Training models on copyrighted data?

- Only [non-profit] research institutions will have the unlimited right to mine copyrighted content

- While other actors still must respect the opt-out choice of the rightsholder.

- A copyright exception allows “temporary acts of reproduction”
(Article 5(1), Information Society Directive)

- This concept can also apply to copies made for the purpose of Machine Learning training data, provided they’re deleted as soon as the training process is completed.

Source: https://blog.valohai.com/copyright-laws-and-machine-learning, Copyright in the Digital Single Market, European Parliament, 20 February 2019

---

# A

![](https://jiji.cat/tmp/slides/videos/deepanime.gif){.background}

---

# Virtual YouTuber (without a GAN!)

![](https://jiji.cat/tmp/slides/figures/vtuber-rv.png)

---

# Virtual YouTuber by Pramook Khungurn

@[youtube](FioRJ6x_RbI)

---

# Download these slides on: https://research.mangaki.fr

- Mangaki.fr is free software, please enjoy
- Everyone needs more control on the latent space
  - So that recommendations are less boring
- Let's generate a whole new anime series!

(By the way, we're currently looking for postdocs!)

vie@jill-jenn.net

@jjvie on Twitter
