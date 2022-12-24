---
layout: default
title: Bayesian Inference II
nav_order: 15
---

### Previous class check-up
- We studied Bayesian inference and focused on the main contributors to good or poor performance: priors, convergence and burnin.

### Learning objectives

At the end of today's session, you will be able to
- explain in details the MrBayes inference methods
- use MrBayes software


### Pre-class work

- Read the papers corresponding to your group (in canvas):
  - [MrBayes1](https://academic.oup.com/bioinformatics/article/17/8/754/235132) and [MrBayes2](https://academic.oup.com/bioinformatics/article/19/12/1572/257621)
  - [Larget and Simon, 1999](https://academic.oup.com/mbe/article/16/6/750/2925469)


---
class: left, top

## In-class discussion

**Objective:** Understand the method, assumptions and limitations of MrBayes software and Bayesian phylogenetics.

**Instructions:**

1. Separate group discussions (20 minutes): Students will discuss with their respective groups and prepare a 10-minute presentation for the whole class. Use the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) as guideline for your discussion and presentation. Use these google slides:
  - [MrBayes](https://docs.google.com/presentation/d/1gMTR0x5VNnTvX24NFsolTYv6cOP7krRoS6GW5Vk1In0/edit?usp=sharing)
  - [Larget Simon (1999)](https://docs.google.com/presentation/d/1czi3HqFwPJ3iQ-wsZ8hwmd1how6AfyZeBx0P2fMF6Gw/edit?usp=sharing)
2. Group presentations (20 minutes total; 10 minutes per group): Each group will summarize their discussion in a 10-minute presentation to the class.


---
class: left, top

## In-class exercise

**Instructions:** Run MrBayes on the toy dataset described below. You can use my reproducible script as guideline: [notebook-log.md](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/notebook-log.md).

[MrBayes tutorial](http://hydrodictyon.eeb.uconn.edu/eebedia/index.php/Phylogenetics:_MrBayes_Lab)

New toy dataset: Download the data (`algaemb.nex`)
```
curl -O http://hydrodictyon.eeb.uconn.edu/people/plewis/courses/phylogenetics/data/algaemb.nex
```

You can also use the primates fasta file that you aligned with ClustalW, MUSCLE or T-Coffee. 

**Bonus points** for paying attention to the importants aspectes that affect the performance of the chosen method.

**Double bonus points** for comparing how do results differ if we use an alignment from a different method. That is, `primatesAA-aligned-muscle.fasta` are the aligned sequences with MUSCLE. I can run RAxML and IQ-Tree on this file and compare the two trees. I can also run MrBayes on `primatesAA-aligned.fasta` which was aligned with ClustalW and compare with the trees we obtained with maximum likelihood.


---
class: left, top

## Homework

**Instructions:**

1. Run MrBayes on your project data. You can always choose another bayesian implementation, but make sure to read the paper and tutorial carefully.
  - Don't forget to include in your reproducible script a short description of the chosen algorithm, its assumptions and limitations (see the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md))
2. Make sure to keep notes in your reproducible script and keep the most updated version on github (it is important to push your work to github since this allows me to check what you are doing and offer suggestions)
3. Submit the link to your github commit in canvas

**Deadline:** April 20th, 2022

**Note:** You do not need to have the output of the method to submit the HW, only need the commands you used.

---
class: left, top

## Take-home message: always read carefully the paper and the documentation of any phylogenetic method you use

Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).
