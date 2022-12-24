---
layout: default
title: The coalescent II
nav_order: 18
---

### Previous class check-up
- We studied the coalescent model on a species tree

### Learning objectives

At the end of today's session, you will be able to
- explain in details the ASTRAL and BUCKy inference methods
- use ASTRAL and BUCKy software


### Pre-class work

- Read the papers corresponding to your group (in canvas):
  - [ASTRAL](https://arxiv.org/abs/1904.03826)
  - [BUCKy](https://academic.oup.com/mbe/article/24/2/412/1146040?login=true)


---
class: left, top

## In-class discussion

**Objective:** Understand the main algorithms, assumptions and limitations of two widely used coalescent-based methods.

**Instructions:**

1. Separate group discussions (20 minutes): Students will discuss with their respective groups and prepare a 10-minute presentation for the whole class. Use the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) as guideline for your discussion and presentation. Use these google slides:
  - [ASTRAL](https://docs.google.com/presentation/d/1xj62t2EDm7EBEsHNQ20fQdrw5urPkdLCEQM96yFYcB0/edit?usp=sharing)
  - [BUCKy](https://docs.google.com/presentation/d/1hvjBw6S_tJgPZ5HE4RbtVwmvvp5uYDTbV3zxwgYv8eA/edit?usp=sharing)
2. Group presentations (20 minutes total; 10 minutes per group): Each group will summarize their discussion in a 10-minute presentation to the class.


---
class: left, top

## In-class exercise

**Instructions:** Run both coalescent software (ASTRAL and BUCKy). 

- [ASTRAL](https://github.com/smirarab/ASTRAL/blob/master/astral-tutorial.md)
- [BUCKy](https://pages.stat.wisc.edu/~larget/AustinWorkshop/tutorial.pdf)

We need multiple estimated gene trees (or estimated posterior distributions of gene trees from MrBayes) to run these methods.
Both software provide toy data that we will use.

**Note** I still have not added these steps to the reproducible script: [notebook-log.md](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/notebook-log.md).

---
class: left, top

## Homework

**Instructions:**

1. Choose a coalescent method that you like the best on your project dataset. If your dataset does not contain multiple genes/markers, you can do this example with the toy dataset provided by the software. 
  - Don't forget to include in your reproducible script a short description of the chosen algorithm, its assumptions and limitations (see the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md))
2. Make sure to keep notes in your reproducible script and keep the most updated version on github (it is important to push your work to github since this allows me to check what you are doing and offer suggestions)
3. Submit the link to your github commit in canvas

**Deadline:** April 29th, 2022

**Note:** You do not need to have the output of the ML method to submit the HW, only need the commands you used.

---
class: left, top

## Take-home message: always read carefully the paper and the documentation of any phylogenetic method you use

Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).
