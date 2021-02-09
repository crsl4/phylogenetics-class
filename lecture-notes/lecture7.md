---
title: "Lecture 7"
author: "Botany 563"
subtitle: "Distance/parsimony methods to estimate phylogenetic trees"
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

# Lecture 6 (draft)

### Previous class check-up
- We studied the algorithms for orthology detection: MCL graph clustering ideas in OrthoFinder
- We learned about OrthoFinder as one option for software

### Learning objectives

At the end of today's session, you will be able to
- explain both algorithms to reconstruct trees: 1) based on distances and 2) based on parsimony
- assess the strenghts and weaknesses of every approach
- use Phylip or PAUP for tree estimation

### Pre-class work

- Optional readings: HB Ch 5-6, Baum Ch 7-8

---
class: left, top


# Phylogenetic methods

|  | Character-based methods | Non-character-based methods | 
| :---:   | :---: | :---:       | 
| Based on an explicit model of evolution | Likelihood methods | Distance methods |
| Not based on an explicit model of evolution | Parsimony methods | |

---
class: left, top

# Distance-based methods

- Fit a tree to a matrix of pairwise genetic distances
- For every two sequences, the distance corresponds to the fraction of positions in which the two sequences differ (p-distance)
- The p-distance underestimates the true genetic distance $d$
- Thus, we do not use the p-distances as the pairwise distances but instead we estimate the number of substitutions that occurred by applying a specific evolutionary model



<div style="text-align:center"><img src="../assets/pics/fig5.2hb.png" width="650"/></div>

_Figure 5.2 in HB 5_


---
class: left, top

# Distance-based methods

- We will assume that the genetic distances have been estimated using an appropriate evolutionary model (more on Lectures 8 and 10)
- The main distance-ased tree building methods are:
  - cluster analysis
  - minimum evolution