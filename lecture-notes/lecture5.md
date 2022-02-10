---
title: "Lecture 5"
author: "Botany 563"
subtitle: "Multiple sequence alignment"
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

# Lecture 5

### Previous class check-up
- We understand sequencing technologies
- We learned a bit about `phyluce` as a pipeline for phylogenomics on UCEs and about `FastQC` for QC of raw reads
- We start thinking about data for the class project and start working on QC -> beginning of work from home in your data!
  - Remember to add me as collaborator to your repo (instructions in slack)

### Learning objectives

At the end of today's session, you
- will be able to explain the most widely used algorithms for multiple sequence alignment
- will be able to assess the strengths and weaknesses of each type of algorithm
- will learn to use different software options: ClustalW, T-Coffee and MUSCLE

### No pre-class work!


---
class: left, top

# What is multiple sequence alignment (MSA)?

- Homology is inferred from an input of sequences that are assumed to have an evolutionary relationship: descended from a common ancestor
- Intuitively, an MSA method inserts gap characters (`-`) inside input sequences to produce a set of longer sequences that are all of the same length, such that residues at the same position in different sequences (aligned residues) share some common properties (homology)
- MSA is a crucial step since phylogenetic inference methods assume that residue homology relationships are correctly reflected by the input sequences

---
class: left, top

# What is multiple sequence alignment (MSA)?

<div style="text-align:center"><img src="../assets/pics/fig9.1.png" width="750"/></div>

_Figure 9.1 in Warnow_

---
class: left, top

# What is multiple sequence alignment (MSA)?

The true MSA reflects the historical substitution, insertion and deletion evolutionary events:

<div style="text-align:center"><img src="../assets/pics/fig9.2.png" width="750"/></div>

_Figure 9.2 in Warnow_

---
class: left, top

# Why is it one of the most computationally intensive tasks?

- Alignment can be not identifiable or unique

#### Example 9.1
Suppose that we knew the _true_ evolutionary events from sequence `ACAT` to `AGAT`. Suppose that we knew that it was not a substitution, but a deletion of `C` (thus creating `AAT`) followed by an insersion of `G`. Even in this scenario (when we know the truth), there are two ways to represent the alignment:
```
AC-AT
A-GAT
```
and
```
A-CAT
AG-AT
```


---
class: left, top

## In-class activity

**Table 9.1** (Warnow). What would be the alignment of the sequence `S=ACATTA` which evolves into `S'=TACA` if we knew the _true_ evolutionary events?
- deletion of the first two nucleotides `AC`
- deletion of the second `T`
- substitution of `T` into `C`
- insersion of `T` at the front

---
class: left, top

## In-class activity

**Table 9.2** (Warnow). Without knowing the _true_ evolutionary events from `S=ACATTA` to `S'=TACA`, what would you think is a good alignment?

---
class: left, top

## In-class activity

**Table 9.2** (Warnow). Without knowing the _true_ evolutionary events from `S=ACATTA` to `S'=TACA`, what would you think is a good alignment?

**Solution:** You probably choose an alignment where none (or few) of the _true_ homology relationships are correct.
- The true alignment has 4 events: 2 deletions, 1 insersion, 1 substitution
- The estimated alignment we created now also has 4 events: 3 deletions and 1 insersion
- The algorithm will ultimately choose an alignment based on how we penalize each of the events

---
class: left, top

## First key insight for MSA

We are guiding the algorithms by selecting the penalties for evolutionary events: substitutions, deletions, insersions. It has nothing to do with _true_ evolutionary events or _true_ homology.

---
class: left, top

# MSA algorithm

**Input:** unaligned sequences (different lengths)

**Output:** aligned sequences (same length) where each site is an assertion of homology


Steps in MSA:
1. Define cost of each event: deletion, insertion, substitution
2. Learn to obtain the optimal pairwise alignment with the minimum cost ("edit distance")
3. Learn to obtain the optimal multiple sequence alignment: we need to be able to align alignments

---
class: left, top

# MSA algorithm
## 1. Cost of evolutionary events

- cost of deletion/insersion (cost of gap): 1
- cost of substitution: 1


**Note:** Some software/books will actually use "weights" instead of costs:
- weight for match: 5
- weight for gap: -1
- weight for mismatch (substitution): -1

I prefer to use costs because the idea of negative weights is not intuitive.


---
class: left, top

# MSA algorithm
## 1. Cost of evolutionary events
### In-class activity

**Table 9.3** (Warnow). How would you align the sequences `S=AACT` and `S'=CTGG` when:
- cost of gap: 1
- cost of substitution: 3
?


---
class: left, top

# MSA algorithm
## 1. Cost of evolutionary events
### In-class activity

**Table 9.3** (Warnow). How would you change the alignment between sequences `S=AACT` and `S'=CTGG` if the costs were: 
- cost of gap: 4
- cost of substitution: 1


---
class: left, top

# MSA algorithm
## 1. Cost of evolutionary events

There are other ways to measure cost/penalty:
- sequence identity: number of identical sites in an alignment divided by the total number of aligned positions
- biochemical similarity when assigning costs of substitutions (Figure 3.4 HB 3): PAM weight matrices and BLOSUM62 weight matrices

<div style="text-align:center"><img src="../assets/pics/blosum62.png" width="350"/></div>


- We will continue to use cost for simplicity

---
class: left, top

# MSA algorithm
## 2. Pairwise sequence alignment

- Pairwise alignment of short toy sequences (like in the examples) can be done by hand
- Pairwise alignment of real sequences would be too difficult to do by hand, so we need smart algorithms: **Needleman-Wunsch algorithm**
- Needleman-Wunsch is a dynamic programming algorithm
- Dynamic programming: optimization algorithm that simplifies a complicated problem by breaking it down into simpler sub-problems in a recursive manner


---
class: left, top

# Needleman-Wunsch algorithm

- **Ingredients:** 
  - Two sequences: $A=a_1 a_2 ...a_m$ and $B=b_1 b_2 ...b_n$
  - 1) cost of gap and 2) cost of substitution
- Denote $F(i,j)$ the minimum cost to align sub-sequences $A_i$ and $B_j$ based on the costs
- **Main principle:** When we want to compute $F(i,j)$, we assume that we have already computed all smaller sequences (sub-problems): $F(i-1,j-1), F(i,j-1), F(i-1,j)$.

The final site of the alignment must take one of the following forms:

1. $a_i$ and $b_j$ are aligned together in the final site. Then the other sites define a pairwise alignment of $A_{i-1}$ and $B_{j-1}$
2. $a_i$ is aligned with a gap in the final site. Then $A_{i-1}$ and $B_{j}$ defined a pairwise alignment
3. $b_j$ is aligned with a gap in the final site. Then $A_{i}$ and $B_{j-1}$ defined a pairwise alignment

---
class: left, top

# Needleman-Wunsch algorithm

### Example of notation

Let $A=a_1 a_2 a_3 a_4 a_5 a_6$ and $B=b_1 b_2 b_3 b_4 b_5$, and suppose you want to align sites $a_5$ ( $i=5$ ) and $b_3$ ( $j=3$ )

1. $a_5$ and $b_3$ are aligned together in the final site. Then the other sites define a pairwise alignment of $A_4=a_1 a_2 a_3 a_4$ and $B_2=b_1 b_2$ (we do not know how at this point)
2. $a_5$ is aligned with a gap in the final site. Then $A_4=a_1 a_2 a_3 a_4$ and $B_3=b_1 b_2 b_3$ define a pairwise alignment
3. $b_3$ is aligned with a gap in the final site. Then $A_5=a_1 a_2 a_3 a_4 a_5$ and $B_2=b_1 b_2$ define a pairwise alignment

---
class: left, top

# Needleman-Wunsch algorithm: Costs

1. If $a_i$ and $b_j$ are aligned together in the final site, then the cost is 0 if $a_i=b_j$ and 1 (or whatever cost of substitution defined) if they are different. Hence, the total cost is $F(i,j) = F(i-1,j-1)+cost(a_i,b_j)$
2. If $a_i$ is aligned with a gap in the final site, then the cost is 1 (or whatever the cost of gap is). Hence, the the total cost is $F(i,j) = F(i-1,j)+1$
3. If $b_j$ is aligned with a gap in the final site, then the cost is 1 (or whatever the cost of gap is). Hence, the the total cost is $F(i,j) = F(i,j-1)+1$

How to know which of the three options to do? We choose the one with minimum cost!

$F(i,j)=min {F(i-1,j-1)+cost(a_i,b_j), F(i-1,j)+1, F(i,j-1)+1 }$.

---
class: left, top

# Needleman-Wunsch algorithm

Steps:
1. Compute $F(i,j)$ for every $i,j$ and put in a matrix (sometimes denoted dynamic programming (DP) matrix). First column/row correspond to gap and F(0,0)=0
2. As you fill the matrix, keep track of which of the three entries gave you the minimum with an arrow
3. Trace back the arrows to construct the alignment (diagonal arrow=nucleotide, vertical/horizontal arrow=gap replacing the nucleotide the arrow is pointing)

<div style="text-align:center"><img src="../assets/pics/fig9.3.png" width="450"/></div>

_Figure 9.3 from Warnow_

---
class: left, top

# Needleman-Wunsch algorithm

### Example

We want to align $S_1=ATCG$ and $S_2=TCA$ for a cost of substitution of 1 and cost of gap of 2.

---
class: left, top

# Needleman-Wunsch algorithm

### Example

We want to align $S_1=ATCG$ and $S_2=TCA$ for a cost of substitution of 1 and cost of gap of 2.

**Homework:** Complete at home the F matrix (details in next slide).

**How do we get the alignment after building the F matrix?** We trace back the arrows from the bottom right corner:
```
ATCG
-TCA
```

<div style="text-align:center"><img src="../assets/pics/nw-ex.png" width="300"/></div>



---
class: left, top

# Homework: Needleman-Wunsch algorithm

**Instructions:** Watch the class video on canvas with the rest of the steps of the Needleman-Wunsch algorithm and finish the alignment. Optional: redo the same example with a cost of gap of 1 and a cost of substitions of 3 to compare the final alignment in both cases. 


**Important take-home message:** The final alignment depends on the costs of gaps and substitutions.


---
class: left, top

# MSA algorithm
## 3. Multiple sequence alignment

- The Needleman-Wunsch is the magic algorithm that allows us to align two sequences
- We want to expand the pairwise sequence alignment to multiple sequence alignment
- Progressive alignment: the most widely used algorithm (e.g. ClustalW)
- Consistency-based scoring: improvement over progressive alignment by using a more strict score function (e.g. T-Coffee)
- Iterative refinement algorithm: improvement over progressive alignment by doing sequential alignments until convergence of score (e.g. mafft, muscle)


### Progressive alignment

Steps:
1. Compute rooted binary tree (guide tree) from pairwise distances
2. Build MSA from the bottom (leaves) up (root)


---
class: left, top

# Wait a minute, what is a rooted binary tree?


---
class: left, top

# Progressive alignment

What are the steps that we need to know?

<div style="text-align:center"><img src="../assets/pics/fig9.9.png" width="550"/></div>

_Figure 9.9 in Warnow_



---
class: left, top

# Progressive alignment

1. Align all pairs of sequences using the Needleman-Wunsch algorithm
2. For every pairwise alignment, we calculate its cost based on the cost of gap (e.g. unit cost) and the cost of substitution (e.g. unit cost)
3. We estimate the tree from distances: we will learn this in Lecture 8. Let's pretend we already have the tree
4. We build the alignments on the tree from the leaves to the root (bottom-up)  
  - For the leaves, we build the pairwise alignments for (a,b) and for (d,e) using the Needleman-Wunsch algorithm
  - For internal nodes, we need to know how to align alignments

#### What are the ingredients that we need to know to perform MSA via progressive alignment?
- Perform pairwise sequence alignment via Needleman-Wunsch (check!)
- Calculate the cost of a pairwise sequence alignment (check!)
- Calculate a tree from distances (Lecture 8)
- Perform alignment of alignments (missing)


---
class: left, top

# How to align alignments

We need a new concept called "profile".

<div class="image123">
    <img src="../assets/pics/table9.7.png" height="400"  style="float:left">
    <img class="middle-img" src="../assets/pics/table9.8.png" height="400">
</div>


---
class: left, top

# How to align alignments

1. Construct profiles
2. Define the cost of putting $a_i, b_j$ together. We want to minimize the expected cost between profiles
3. Use Needleman-Wunsch to align $P_1$ and $P_2$ based on the costs


---
class: left, top

# How to align alignments: defining the costs

- Treat $a_i$ in $P_1$ and $b_j$ in $P_2$ as probability models: $P(x|a_i)$ is the probability of observing nucleotide $x$ in position $i$ on $P_1$ (Example: What is $P(A|a_1)$?)

<div class="image123">
    <img src="../assets/pics/table9.7.png" height="200"  style="float:left">
    <img class="middle-img" src="../assets/pics/table9.8.png" height="200">
</div>

- Define the cost as

<div style="text-align:center"><img src="../assets/pics/cost-progressive.png" width="200"/></div>

- **In-class exercise:** What is the $cost(a_3,b_2)$?

---
class: left, top

# Homework

**Instructions:** Build the cost matrix for the two following profiles. This means that you want to calculate $cost(a_i,b_j)$ for all $i$ and $j$.

<div class="image123">
    <img src="../assets/pics/table9.7.png" height="300"  style="float:left">
    <img class="middle-img" src="../assets/pics/table9.8.png" height="300">
</div>

---
class: left, top

# Aligning the alignments

Assume we got the following cost matrix

```  
     a1   a2  a3  a4   a5
b1 [ 1/3  1  1/4  1   8/15 ]  
b2 [  1   1  1/4  2/3  1   ]  
b3 [  1   0  3/4  1/3  1   ]
b4 [  1   1  1/4  2/3  1   ]
b5 [  1   0  3/4  1/3  1   ]
b6 [ 1/3  1  9/12 7/9 11/15]
```

and we will use it to align the two profiles $P_1 = a_1 a_2 a_3 a_4 a_5$ and $P_2 = b_1 b_2 b_3 b_4 b_5 b_6$ with Needleman-Wunsch. The cost matrix above provides the costs of substitutions and we assume a cost of gap of 1.

**In-class activity:** Let's recall Needleman-Wunsch: we need the $F(i,j)$ matrix and then trace back the alignment. Let's do here together some of the entries of the $F(i,j)$ matrix.

---
class: left, top

# Homework

**Instructions:** Finish Needleman-Wunsch on the two profiles.

1. Build the F matrix
2. Trace back the alignment from the bottom right corner

---
class: left, top

# Homework solution:

You should get the following alignment which we can translate back to the original sequences.

<div class="image123">
    <img src="../assets/pics/table9.9.png" height="100"  style="float:left">
    <img class="middle-img" src="../assets/pics/table9.10.png" height="300">
</div>

---
class: left, top

# MSA key insights
- Needleman-Wunsch lies at the core of MSA:
  - if we have two sequences, we align them with Needleman-Wunsch
  - if we have two alignments, we first convert them to profiles, and then align the profiles with Needleman-Wunsch
- The final alignment will depend on the assumptions on the cost of substitutions and costs of gaps

---
class: left, top

# Homework recap

**Part 1:** Practice Needleman-Wunsch algorithm:

1. Finish the F matrix for the Needleman-Wunsch algorithm to align two sequences
2. Finish the cost matrix of substitutions for the alignment of alignments
3. With the cost matrix of substitutions, finish the Needleman-Wunsch algorithm to align two alignments
4. Complete the canvas quiz

**Deadline:** February 23rd, 2022

**Part 2:** Pre-class work for next class:

- Students are divided in three groups: ClustalW, T-Coffee, MUSCLE
- Read the corresponding paper for your group for class discussion next time

**Deadline:** February 16th, 2022 2:30pm CT