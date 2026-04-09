---
layout: default
title: The coalescent (ASTRAL)
nav_order: 19
---

# The coalescent (ASTRAL)

### Previous class check-up
- We studied the coalescent model on a species tree

### Learning objectives

At the end of today's session, you will be able to
- use ASTRAL software


{: .important-title}
> Pre-class work
>
> Read the paper: [ASTRAL](https://arxiv.org/abs/1904.03826)

# Software: In-class exercise

**Instructions:** Up until now, you have followed the commands I provide for the computer lab. This time work individually or in teams to run ASTRAL on the toy data `song_mammals.424.gene.tre` in the [ASTRAL github](https://github.com/smirarab/ASTRAL). 

You can follow the instructions to install and run ASTRAL in the [documentation](https://github.com/smirarab/ASTRAL/blob/master/astral-tutorial.md).

Keep good notes of all the steps you are running for ASTRAL in a md file (as we have done so far in class) and write down an accompanying paragraph for a Methods section in the paper describing your ASTRAL analysis.

You can read the estimated species tree in R. Note that the name of the file could be different depending on what you chose.
```r
library(ape)
tre = read.tree(file="song-astral.tre")
plot(tre)
```
Note that ASTRAL has their own support values (not bootstrap) which are done by default. More info in [this paper](https://academic.oup.com/mbe/article/33/7/1654/2579300?guestAccessKey=).

{: .important }
**Take-home message:** always read carefully the paper and the documentation of any phylogenetic method you use

{: .note }
Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).

## Homework

See the details of the Coalescent HW in [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-coalescent.md). 


