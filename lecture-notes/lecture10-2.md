---
layout: default
title: Maximum Likelihood II
nav_order: 12
---

### Previous class check-up
- We studied the algorithms for maximum likelihood and focused on the main contributors to good or poor performance

### Learning objectives

At the end of today's session, you will be able to
- explain in details the RAxML and IQ-Tree inference methods
- use RAxML and IQ-Tree software


### Pre-class work

- Read the papers corresponding to your group (in canvas):
  - [RAxML1](https://academic.oup.com/bioinformatics/article/30/9/1312/238053?login=true)
  - [RAxML2](https://academic.oup.com/bioinformatics/article/35/21/4453/5487384?login=true)
  - [IQ-Tree1](https://academic.oup.com/mbe/article/32/1/268/2925592?login=true)
  - [IQ-Tree2](https://academic.oup.com/mbe/article/37/5/1530/5721363?login=true)


---
class: left, top

## In-class discussion

**Objective:** Understand the main algorithms, assumptions and limitations of two widely used maximum likelihood software.

**Instructions:**

1. Separate group discussions (20 minutes): Students will discuss with their respective groups and prepare a 10-minute presentation for the whole class. Use the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) as guideline for your discussion and presentation. Use these google slides:
  - [RAxML](https://docs.google.com/presentation/d/1KFnDiC3K2BoLmpJIvzQcS0VTCac38y7KJ_XpPwvIwF4/edit?usp=sharing)
  - [IQ-Tree](https://docs.google.com/presentation/d/1H7WsOl0s45nbhJha2XbCCNnDj6k-5xdcZJ3ZWZ0t3gw/edit?usp=sharing)
2. Group presentations (20 minutes total; 10 minutes per group): Each group will summarize their discussion in a 10-minute presentation to the class.


---
class: left, top

## In-class exercise

**Instructions:** Run and compare the results of both ML software (RAxML and IQ-Tree) on the toy dataset of primates. You can use my reproducible script as guideline: [notebook-log.md](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/notebook-log.md).

- [RAxML-NG](https://github.com/amkozlov/raxml-ng) (HAL 1.3)
- [IQ-Tree](http://www.iqtree.org/workshop/molevol2019)

You can use the primates fasta file that you aligned with ClustalW, MUSCLE or T-Coffee, or you can use the toy data provided in the software tutorial. 

**Bonus points** for paying attention to the importants aspectes that affect the performance of the chosen method.

**Double bonus points** for comparing not only the performance of RAxML and IQ-Tree on a given alignment, but comparing how do results differ if we use an alignment from a different method. That is, `primatesAA-aligned-muscle.fasta` are the aligned sequences with MUSCLE. I can run RAxML and IQ-Tree on this file and compare the two trees. I can also run RAxML and IQ-Tree on `primatesAA-aligned.fasta` which was aligned with ClustalW and compare the 4 trees.


---
class: left, top

## Homework

**Instructions:**

1. Choose a maximum likelihood method that you like the best on your project dataset (it does not have to be RAxML or IQ-Tree, but you should read the paper and tutorial of whichever method you choose)
  - Don't forget to include in your reproducible script a short description of the chosen algorithm, its assumptions and limitations (see the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md))
2. Make sure to keep notes in your reproducible script and keep the most updated version on github (it is important to push your work to github since this allows me to check what you are doing and offer suggestions)
3. Submit the link to your github commit in canvas

**Deadline:** April 8th, 2022

**Note:** You do not need to have the output of the ML method to submit the HW, only need the commands you used.

---
class: left, top

## Take-home message: always read carefully the paper and the documentation of any phylogenetic method you use

Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).
