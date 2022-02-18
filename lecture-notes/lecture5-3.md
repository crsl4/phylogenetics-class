---
title: "Lecture 5"
author: "Botany 563"
subtitle: "Multiple Sequence Alignment"
output:
  xaringan::moon_reader:
    lib_dir: libs
    nature:
      ratio: '16:9'
      highlightStyle: github
      highlightLines: yes
      countIncrementalSlides: no
  html_document:
    df_print: paged
---
class: left, top

### Previous class check-up
- We studied the algorithms for multiple sequence alignment: Needleman-Wunsch, progresive alignment and improvements
- We learned about three software for MSA: muscle, t-coffee, clustalw

### Learning objectives

At the end of today's session, you will be able to
- highlight the main differences among MSA filtering methods


### Pre-class work

- Read the paper corresponding to your group (in canvas):
  - [ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/)
  - [MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623)
  - [T-Coffee](https://www.sciencedirect.com/science/article/pii/S0022283600940427)

---
class: left, top

### Project checklist: heavy HW on your data starting now

- Until now:
  - Created your project github repo
  - Added the link to the `class-repos.md` via pull request
  - Added me as collaborator on your github repo (slack msg)
  - Data chosen and added 1 slide about it to the [shared google slides](https://docs.google.com/presentation/d/1UW6P5wVKcDLwVLoshnJ2ilTbrsUEPFoH1MTXppQcpAc/edit#slide=id.g10fe071e574_0_0)
      - Don't wait on your data: you can use public data because you will be creating scripts to use later on the "real" data
  - Added a description about your data in your `notebook-log.md` (or similar reproducible script) in your github repo and pushed
  - QC on your data: not perfect/complete, but at least a plan pushed to your github repo
- Next item: 
  - Alignment work pushed to your github repo by March 2nd, 2022

### Expectations as we move forward to heavy HW on your data
- You will be working on your data alone:
  - Troubleshooting with different data formats
  - Troubleshooting with software installation for your operating system
- Actively ask questions!
  - Slack
  - Office hours


---
class: left, top

# In-class discussion

**Objective:** Understand the main algorithms, assumptions and limitations of three widely used MSA software.

**Instructions:**

1. Separate group discussions (15 minutes): Students will discuss with their respective groups and prepare a 10-minute presentation for the whole class. Use these google slides:
  - [ClustalW](https://docs.google.com/presentation/d/1vtegUr8V5Q3Cf-L9Q_RQKyeml1AVPejaHnNhIi5cNOA/edit?usp=sharing)
  - [MUSCLE](https://docs.google.com/presentation/d/1u9JyRZ-xwta4iCY0Dk4ZiyYzjOU02xMHqoON7HYP4Lg/edit?usp=sharing)
  - [T-Coffee](https://docs.google.com/presentation/d/1tFc-VL_lH3FEBXHdR8RQ7OB5imfiWIx-oyBWPS4Aaf0/edit?usp=sharing)

2. Group presentations (30 minutes total; 10 minutes per group): Each group will summarize their discussion in a 10-minute presentation to the class.


---
class: left, top

# Summary of the three software

### Progressive alignment: [Thompson, 1994, ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/)

- pairwise alignment to create distance matrix and then tree based on NJ
- sequences are down-weighted compared to how closely related they are to other sequences (to avoid a group of similar sequences to dominate the alignment)
- different weight matrices are used: 1) for closely related sequences where high scores are given to identities and low scores ow; 2) for distantly related sequences where high scores are given to conservative amino acid matches and low score to identities (BLOSUM, PAM matrices)
- the program varies the gap penalties (GP) for sequences and positions
- most widely used option, but several methods have been shown more accurate and fast
- Downsides
  - The guide tree has a big impact on alignments (and we usually estimate an inaccurate tree). Some ways to overcome this issue are
      - better ways to estimate the tree (maximum likelihood); not very scalable
      - iteration between tree and alignment; not very scalable
  - Errors made early in the process persist since subsequent mergers never change the alignments they are merging together


---
class: left, top

### Iterative refinement: [Edgar, 2004, MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623)

- outperforms ClustalW in most settings but it is less scalable
- [MAFFT](https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html) also performs iterative refinement


### Consistency-based scoring: [Notredame, 2000, T-Coffee](https://www.sciencedirect.com/science/article/pii/S0022283600940427)
- consistency-based scoring: overcomes progressive alignment local-minimum problem
- uses "weighted sum of pairs" (WSP) objective function; we want to find the MSA that maximizes the score of the alignments (or minimizes the cost)
- Sum-of-pairs alignment
  - the cost of a given multiple sequence alignment is defined by summing the costs of its site of induced pairwise alignments
  - given input set S of sequences and the function for computing the cost of any pairwise alignment, find an alignment A on S such that the sum of the induced pairwise alignments is minimized
- uses intermediate sequences to improve the quality of the pairwise alignment. For example, we are aligning sequences A and C and get a pairwise alignment A-C. We need incorportate an intermediate sequence B, and pairwise A-B and B-C to then obtain the pairwise alignment (A-C)
- generally more accurate than Clustalw; but not scalable to large alignments
