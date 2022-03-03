---
title: "Lecture 8"
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

# Lecture 8

### Previous class check-up
- We studied the overview of phylogenetic inference and the main challenges

### Learning objectives

At the end of today's session, you will be able to
- explain both algorithms to reconstruct trees: 1) based on distances and 2) based on parsimony
- assess the strenghts and weaknesses of every approach
- use R for tree estimation based on distances or parsinomy

### Pre-class work

- Install R
- Optional readings: HB Ch 5-6, Baum Ch 7-8

---
class: left, top


# Phylogenetic inference

##### Step 1. Choose the criterion to use: distances, parsimony, likelihood

##### Step 2. Search the space of trees until you find the optimum

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

**Goal:** Fit a tree to a matrix of pairwise genetic distances

#### Computing the distances
- For every two sequences, the distance corresponds to the fraction of positions in which the two sequences differ (p-distance)
- The p-distance underestimates the true genetic distance $d$
- Thus, we do not use the p-distances as the pairwise distances but instead we estimate the number of substitutions that occurred by applying a specific evolutionary model

---
class: left, top

# Distance-based methods


#### Computing the distances


<div style="text-align:center"><img src="../assets/pics/fig5.2hb.png" width="750"/></div>

_Figure 5.2 in HB 5_


---
class: left, top

# Distance-based methods

- We will assume that the genetic distances have been estimated using an appropriate evolutionary model (more on Lectures 9 and 12)
- The main distance-based tree building methods are:
  - cluster analysis
  - minimum evolution
- **Advantage of distance-based methods over parsimony or likelihood:** There are algorithms that produce the optimum tree without having to search the space of trees
  - Pros: You can get the tree in a scalable manner regardless of sample size
  - Cons: 
      - Algorithmic methods tend to be approximations, so they would approximate the optimum tree, but rarely achieve it
      - However, keep in mind that searching the space would not necessarily achieve the optimum either because many times the search is not exhaustive
    

---
class: left, top

## Cluster analysis

- Constructs ultrametric trees (rooted trees in which all the end nodes are equidistant from the root)
- Only possible assuming a **molecular clock**:
  - Zuckerland and Pauling published two fundamental papers on the evolutionary rate of proteins
  - They noticed that the genetic distance of two sequences coding for the same protein on different species seems to increase linearly with divergence time
  - This seems to imply that the rate of evolution for any given protein is constant: existence of a molecular clock
  - This assumption is used for dating the divergences in the tree
  - The molecular clock assumption aligns with the neutral theory of evolution (vs positive selection theory) and implies that deviations from clock-like behavior may reveal adaptive evolution, relaxing functional constraints or changes in effective population size
  - How to test the clock hypothesis? HB 11

---
class: left, top

## Cluster analysis

- Constructs ultrametric trees (rooted trees in which all the end nodes are equidistant from the root)
- Only possible assuming a **molecular clock**:

<div style="text-align:center"><img src="../assets/pics/fig11.1hb.png" width="550"/></div>

_Figure 11.1 in HB11_  

---
class: left, top

## Cluster analysis

- Options: 
  - UPGMA: unweighted-pair group methods with arithmetic means
  - WPGMA: weighted-pair group methods with arithmetic means
- Cluster analysis is extremely sensitive to unequal rates in different lineages


#### UPGMA/WPGMA Algorithm

Input: Matrix of pairwise distances

1) Group together the two taxa with smallest distance (say A, B)

2) Compute the distance from AB to every other taxa

WPGMA: $d_{(AB)k} = \frac{d_{A,k}+d_{B,k}}{2}$ (simple average)

UPGMA: $d_{(AB)k} = \frac{N_A d_{A,k}+N_B d_{B,k}}{N_A + N_B}$ (averaged by number of taxa in the cluster)

3) Repeat until all taxa are clustered


**Note:** We are not searching the space of trees here, this is an algorithm that returns a tree that agrees with the distances provided.

---
class: left, top

## Cluster analysis example

**In-class dynamic:** (_Box 5.1 in HB11_) Find the WPGMA tree for the distance matrix below.

```
   A  B  C  D  E  F 
A
B  2  
C  4  4 
D  6  6  6
E  6  6  6  4
F  8  8  8  8  8
```

Watch again in [YouTube video](https://youtu.be/jLQAwlODdCo).

---
class: left, top

## Minimum evolution
- We want to reconstruct a tree with minimum length
- The length of the tree is inferred from the genetic distances
- It does not reconstruct ultrametric trees, but additive trees
- An additive tree is a tree that satisfies the four-point metric condition: $d_{AB}+d_{CD} \leq max(d_{AC}+d_{BD},d_{AD}+d_{BC})$
- Additive trees are always a better fit to distances under non-clock-like behavior
- There is an algorithm to estimate the ME tree: neighbor-joining (NJ) [(Saitou and Nei, 1987)](https://pubmed.ncbi.nlm.nih.gov/3447015/)
- NJ tree is the same as the ME tree only if distances are additive to begin with, but it has been shown that the NJ tree can be very similar to the ME tree most of the times
- NJ is better that UPGMA/WPGMA under unequal rates of evolution

---
class: left, top

### NJ Algorithm

Input: Matrix of pairwise distances

1. Compute the net divergence $r$ (sum of distances) for every end node: $r_j = \sum_i d_{ij}$
2. Create a rate-corrected distance matrix: $M_{ij} = d_{ij} - \frac{r_i+r_j}{N-2}$
3. Define the new node that groups taxa $i$ and $j$ for which $M_{ij}$ is minimal (say A,B)
4. Compute the branch lengths from new node U to A and B: $S_{AU} = \frac{d_{AB}}{2} + \frac{r_A - r_B}{2(N-2)}$
5. Compute new distances from node U to every other end node: $d_{kU} = \frac{d_{Ak}+d_{Bk}-d_{AB}}{2}$
6. Repeat the steps


---
class: left, top

## Minimum evolution example

**Homework:** Find the NJ tree for the distance matrix below.

```
   A  B   C  D  E  F 
A
B  5  
C  4  7 
D  7  10  7
E  6  9   6  5
F  8  11  8  9  8
```

_Box 5.2 in HB11:_ Note that there are many errors in the book.

**Solution:** See this [YouTube video](https://youtu.be/n1BEd05IpEk) with all the steps in the algorithm.


---
class: left, top

# Distance-based methods

### Main conclusions:
- Two steps
  1. genetic distances from a p-distance and a model of evolution
  2. a phylogenetic tree is constructed from the distances
- Distance methods reduce the phylogenetic information to one value per pair of sequences, so many times regarded as inferior compared to character-based methods (less stat power due to the loss of info)
- But unlike parsimony, they rely on an evolution model but the result will depend on which model is chosen (more on Lecture 9 and 12)
- They do not have the model flexibility as likelihood-based models
- Under standard conditions, NJ trees are meant to estimate accurate trees and they are very fast to be estimated
- However, these methods assume the distances are accurate. Noisy distances can affect the estimated tree
- Aside from the ME algorithm that aims to find the tree that minimizes the tree length, there are other ME algorithms that aim to find the tree that minimize the differences between the genetic distances and the tree distances (called OLS=ordinary least squares): $F = \sum_{i,j} (D_{ij}-d_{ij})^2$ where $D_{ij}$ are the tree distances and $d_{ij}$ are the observed genetic distances


---
class: left, top

# Distance-based methods

### Software: R package _ape_

- _ape_ is one of the most widely used phylogenetic software
- It is an R package and it has a huge variety of functions
- In particular, today we will use it for distance-based tree estimation methods
- [Full documentation](http://ape-package.ird.fr/)
- We will follow this [great tutorial](https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf)

#### In-class group dynamic

**Time:** 10 minutes

**Instructions:** 
1. Follow the R commands to obtain a ME tree from the sample data (or your own data!). The commands are listed in the [PDF tutorial]((https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf) that we are using as guideline, in our reproducible script [notebook-log.md](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/notebook-log.md) and on the following slides.
2. After the allotted time, we will compare our work all together.


---
class: left, top

# Distance-based methods

### Software: R package _ape_

1) Installing necessary packages:
```r
install.packages("adegenet", dep=TRUE)
install.packages("phangorn", dep=TRUE)
```

2) Loading the packages
```r
library(ape)
library(adegenet)
library(phangorn)
```

3) Loading the sample data
```r
dna <- fasta2DNAbin(file="http://adegenet.r-forge.r-project.org/files/usflu.fasta")
```

---
class: left, top

# Distance-based methods

### Software: R package _ape_

4) Computing the genetic distances. They choose a Tamura
and Nei 1993 model which allows for different rates of transitions and transversions, heterogeneous base frequencies, and between-site variation of the substitution rate (more on Lecture 9).
```r
D <- dist.dna(dna, model="TN93")
```

5) Get the NJ tree
```r
tre <- nj(D)
```

6) Before plotting, we can use the [`ladderize` function](https://rdrr.io/cran/ape/man/ladderize.html) which reorganizes the internal structure of the tree to get the ladderized effect when plotted
```r
tre <- ladderize(tre)
```

---
class: left, top

# Distance-based methods

### Software: R package _ape_

7) We can plot the tree
```r
plot(tre, cex=.6)
title("A simple NJ tree")
```

<div style="text-align:center"><img src="../assets/pics/nj-tree.png" width="350"/></div>

---
class: left, top

# Distance-based methods

### Software: R package _ape_

Main distance functions:
- `nj` (`ape` package): the classical Neighbor-Joining algorithm.
- [`bionj`](https://www.rdocumentation.org/packages/ape/versions/5.4-1/topics/BIONJ) (`ape`): an improved version of Neighbor-Joining: [Gascuel 1997](https://pubmed.ncbi.nlm.nih.gov/9254330/). It uses information on variances of evolutionary distances
- [`fastme.bal` and `fastme.ols`](https://www.rdocumentation.org/packages/ape/versions/5.4-1/topics/FastME) (`ape`): minimum evolution algorithms: [Desper and Gascuel, 2002](https://pubmed.ncbi.nlm.nih.gov/12487758/)
- `hclust` (`stats`): classical hierarchical clustering algorithms including single
linkage, complete linkage, UPGMA, and others.


#### Further learning

Continue the distance-based steps in the [PDF tutorial](https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf) on the same sample data.


---
class: left, top

# Parsimony-based methods

- Character-based data: 4 nucleotides ACGT or 20 aminoacids => matrix of aligned characters
- It does not rely on models of evolution
- One seeks the tree that minimizes the amount of evolutionary change required to explain the data
- Justification: 
  - Ockham's razor: when two hypothesis provide equally valid explanations for a phenomenon, the simpler one should always be preferred
  - More character-state changes imply a more complex hypothesis because homoplasy (sharing identical character states that cannot be explained by inheritance from a common ancestor) is an _ad hoc_ hypothesis
- Parsimony represents a useful fall back method when model-based methods cannot be used due to computational limitations

---
class: left, top

# Parsimony-based methods

### Assumptions
- Parsimony methods are most effective when rate of evolution is slow, but this is not a necessary assumption
- Parsimony methods can perform well under high rates of evolution as long as there are no pathological inequalities (long-branch attraction: Felsenstein zone)
- The only real assumption of parsimony is independence among characters

---
class: left, top

# Parsimony-based methods

### Methodology

1. Determine the amount of character change required to explain the data by a given tree
2. Search over all possible tree topologies

- We need to be able to calculate the length of a proposed tree which is defined as the amount of character change implied by a most parsimonious reconstruction of internal nodes
- Just as in MSA, we need to have costs for substitutions (equal costs or unequal costs)

**Example:** Evaluate the length of the `((W,Y),(X,Z));` tree given the site:
```
W:G
X:C
Y:A
Z:C
```

- **Full solution:** see this [YouTube video](https://youtu.be/lJaFPek3eAc)
- Note that this is only one site! We need to repeat this process for every site and add up the lengths
- More on Newick (parenthetical) format [here](https://en.wikipedia.org/wiki/Newick_format)

---
class: left, top

# Parsimony-based methods

### Methodology

Just as in MSA, we cannot do this by hand and there are dynamic programming algorithms that help us (what was dynamic programming?): 
- Fitch algorithm (HB Box 8.2) for equal costs
- Sankoff algorithm (HB Box 8.1) for unequal costs

---
class: left, top

# Parsimony-based methods

### Methodology

#### Fitch algorithm
1) Root the tree in a random place (parsimony score is not affected by the root)

2) Calculate the state-set $X_i$ for each internal node $i$ corresponding the set of states that can be assigned to each node so that the minimum possible length of the subtree can be achieved. Let $L(i)$ and $R(i)$ be the left and right child descendant nodes of $i$ respectively.

  2.1) Form the intersection of the two child state sets: $X_{L(i)} \cap X_{R(i)}$

  2.2) If the intersection is non-empty, set $X_i$ equal to this intersection and the accumulated length for this node as the sum of the accumulated lengths for the two child nodes: $s_i=s_{L(i)}+s_{R(i)}$

  2.3) If the intersection is empty, let $X_i$ be equal to the union of the two child sets: $X_{L(i)} \cup X_{R(i)}$ and set the accumulated length for this node as the sum of the accumulated lengths for the two child nodes _plus one_: $s_i=s_{L(i)}+s_{R(i)}+1$
  
---
class: left, top

# Parsimony-based methods

### Methodology
  
**Example:** Evaluate the length of the `((W,Y),(X,Z));` tree given the site:
```
W:G
X:C
Y:A
Z:C
```
using the Fitch algorithm.

- **Full solution:** see this [YouTube video](https://youtu.be/bZdEkYyq2hQ)
- **Homework:** Redo the algorithm with different root positions to verify that you get the same length


---
class: left, top


# Phylogenetic inference: Maximum Parsimony (MP) tree

##### Step 1. Evaluate the parsimony score of a given tree (length) with Fitch algorithm

##### Step 2. Search the space of trees until you find the optimum

##### Some downsides

- Parsimony methods have been shown to produce inconsistent trees
- Read more in [Felsenstein 1978](https://academic.oup.com/sysbio/article/27/4/401/1734959?login=true)

---
class: left, top

# Parsimony method

### Software: R package _phangorn_

- _phangorn_ is another widely used phylogenetic software
- It is an R package and it has a huge variety of functions
- In particular, today we will use it for parsimony-based tree estimation methods
- [Full documentation](https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.pdf)
- We will follow this [great tutorial](https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf)

#### In-class group dynamic

**Time:** 10 minutes

**Instructions:** 
1. Follow the R commands to obtain a MP tree from the sample data (or your own data!). The commands are listed in the [PDF tutorial]((https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf)) that we are using as guideline or in our reproducible script [notebook-log.md](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/notebook-log.md) or on the following slides.
2. After the allotted time, we will compare our work all together.


---
class: left, top

# Parsimony method

### Software: R package _phangorn_

1) Installing necessary packages (if you have not installed them for the distance section above)
```r
install.packages("adegenet", dep=TRUE)
install.packages("phangorn", dep=TRUE)
```

2) Loading
```r
library(ape)
library(adegenet)
library(phangorn)
```

3) Loading the sample data and convert to phangorn object:
```r
dna <- fasta2DNAbin(file="http://adegenet.r-forge.r-project.org/files/usflu.fasta")
dna2 <- as.phyDat(dna)
```

---
class: left, top

# Parsimony method

### Software: R package _phangorn_

4) We need a starting tree for the search on tree space and compute the parsimony score of this tree (422)
```r
tre.ini <- nj(dist.dna(dna,model="raw"))
parsimony(tre.ini, dna2)
```

5) Search for the tree with maximum parsimony:
```r
> tre.pars <- optim.parsimony(tre.ini, dna2)
Final p-score 420 after  2 nni operations
```

6) Plot tree:
```r
plot(tre.pars, cex=0.6)
```

**Further learning:** Continue the parsimony steps in the [PDF tutorial](https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf) on the same sample data.

---
class: left, top

# Homework

**Instructions:**

1. Estimate a distance-based tree and a parsimony-based tree for your data using the `ape` and `phangorn` R packages.
  - Don't forget to include in your reproducible script a short description of the chosen algorithm, its assumptions and limitations (see the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md))
2. Make sure to keep notes in your reproducible script and keep the most updated version on github (it is important to push your work to github since this allows me to check what you are doing and offer suggestions)
3. Submit the link to your github commit in canvas

**Deadline:** March 23rd, 2022
