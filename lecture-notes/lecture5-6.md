---
title: "Lecture 5-6"
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

# Lecture 5-6 (draft)

At the end of today's session, you
- will be able to explain the most widely used algorithms for multiple sequence alignment
- will be able to assess the strengths and weaknesses of each type of algorithm
- will learn to use software xxxx

## Pre-class work

- Read HAL 2.2
- Optional reading: HB 3 and [Computational phylogenetics](https://www.amazon.com/Computational-Phylogenetics-Introduction-Designing-Estimation/dp/1107184711) (Warnow) Sections 9.1-9.5, 9.11, 9.12, 9.13

---
class: left, top

# What is multiple sequence alignment (MSA)?

- homology is inferred from an input of sequences that are assumed to have an evolutionary relationship: descended from a common ancestor
- Intuitively, an MSA method inserts gap characters `-` inside input sequences to produce a set of longer sequences that are all of the same length, such that residues at the same position in different sequences (aligned residues) share some common properties (homology)
- a crucial step since phylogenetic inference methods assume that residue homology relationships are correctly reflected by the input sequences


![](../assets/pics/fig9.1.png)
_Figure 9.1 in Warnow_

---
class: left, top

# What is multiple sequence alignment (MSA)?

- the true MSA reflects the historical substitution, insertion and deletion evolutionary events

![](../assets/pics/fig9.2.png)
_Figure 9.2 in Warnow_

---
class: left, top

# Why is it one of the most computationally intensive tasks?

- Alignment can be not identifiable or unique
- **Example 9.1** Suppose that we knew the _true_ evolutionary events from sequence `ACAT` to `AGAT`. Suppose that we knew that it was not a substitution, but a deletion of `C` (thus creating `AAT`) followed by an insersion of `G`. Even in this scenario (when we know the truth), there are two ways to represent the alignment:
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

**Table 9.1** (Warnow). What would be the alignment of the two sequences: `S=ACATTA` which evolves into `S'=TACA` if we knew the _true_ evolutionary events?
- deletion of the first two nucleotides `AC`
- deletion of the second `T`
- substitution of `T` into `C`
- insersion of `T` at the front

---
class: left, top

## In-class activity

**Table 9.2** (Warnow). Without knowing the _true_ evolutionary events from `S` to `S'`, what would you think is a good alignment?

---
class: left, top

## In-class activity

**Table 9.2** (Warnow). Without knowing the _true_ evolutionary events from `S` to `S'`, what would you think is a good alignment?

**Solution:** You probably choose an alignment where none (or few) of the _true_ homology relationships are correct.
- The true alignment has 4 events: 2 deletions, 1 insersion, 1 substitution
- The estimated alignment we created now also has 4 events: 3 deletions and 1 insersion
- The algorithm will ultimately choose an alignment based on how we penalize each of the events

---
class: left, top

### First key insight for MSA: we are guiding the algorithms by selecting the penalties for evolutionary events: substitutions, deletions, insersions

---
class: left, top

# MSA algorithm

Input: unaligned sequences (different lengths)

Output: aligned sequences (same length) where each site is an assertion of homology


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

**Table 9.3** (Warnow). You want to get the sequence alignment between sequences `S=AACT` and `S'=CTGG` when:
- cost of gap: 1
- cost of substitution: 3


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

![](..assets/pics/blosum62.png)

- We will continue to use cost for simplicity

---
class: left, top

# MSA algorithm
## 2. Pairwise sequence alignment

- Pairwise alignment of short toy sequences (like in the examples) can be done by hand
- Pairwise alignment of real sequences would be too difficult to do by hand, so we need smart algorithms: **Needleman-Wunsch algorithm**
- Needleman-Wunsch is a dynamic programming algorithm
- Dynamic programming: optimization algorithm that simplifies a complicated problem by breaking it down into simpler sub-problems in a recursive manner
- Before we study the Needleman-Wunsch algorithm, let's focus on the big picture

---
class: left, top

# MSA algorithm
## 3. Multiple sequence alignment

- The Needleman-Wunsch is the magic box that allow us to align two sequences
- We want to expand the pairwise sequence alignment to multiple sequence alignment
- Progressive alignment: the most widely used algorithm (e.g. clustal)
- Consistency-based scoring: improvement over progressive alignment by using a more strict score function (e.g. t-coffee)
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

![](..assets/pics/fig9.9.png)
_Figure 9.9 in Warnow_

What are the steps that we need to know?

---
class: left, top

# Progressive alignment

1. Align all pairs of sequences using the Needleman-Wunsch magic black box
2. For every pairwise alignment, we calculate its cost based on the cost of gap (e.g. unit cost) and the cost of substitution (e.g. unit cost)
3. We estimate the tree from distances: we will learn this in Lecture 8
4. We build the alignments on the tree from the leaves to the root (bottom-up)  
  - For the leaves, we build the pairwise alignments for (a,b) and for (d,e) using the Needleman-Wunsch magic black box
  - For internal nodes, we need to know how to align alignments

#### What are the ingredients that we need to know how to do in order to perform MSA via progressive alignment?
- Perform pairwise sequence alignment via Needleman-Wunsch
- Calculate the cost of a pairwise sequence alignment
- Calculate a tree from distances
- Perform alignment of alignments


**What we still need to learn:**

- Needleman-Wunsch algorithm
- How to align alignments

---
class: left, top

# Needleman-Wunsch algorithm

- **Ingredients:** 
  - Two sequences: $A=a_1 a_2 ...a_m$ and $B=b_1 b_2 ...b_n$
  - Denote $F(i,j)$ the minimum cost to align $A_i$ and $B_j$ based on 1) cost of gap and 2) cost of substitution
- **Main principle:** When we want to compute $F(i,j)$, we assume that we have already computed all smaller sequences (sub-problems): $F(i-1,j-1), F(i,j-1), F(i-1,j)$.

The final site of the alignment must take one of the following forms:

1. $a_i$ and $b_j$ are aligned together in the final site. Then the other sites deinfe a pairwise alignment of $A_{i-1}$ and $B_{j-1}$
2. $a_i$ is aligned with a gap in the final site. Then $A_{i-1}$ and $B_{j}$ defined a pairwise alignment
3. $b_j$ is aligned with a gap in the final site. Then $A_{i}$ and $B_{j-1}$ defined a pairwise alignment

---
class: left, top

# Needleman-Wunsch algorithm: Example of notation

Let $A=a_1 a_2 a_3 a_4 a_5 a_6$ and $B=b_1 b_2 b_3 b_4 b_5$, and suppose you want to align sites $a_5$ ($i=5$) and $b_3$ ($j=3$)

1. $a_5$ and $b_3$ are aligned together in the final site. Then the other sites deinfe a pairwise alignment of $A_4=a_1 a_2 a_3 a_4$ and $B_2=b_1 b_2$ (we do not know how at this point)
2. $a_5$ is aligned with a gap in the final site. Then $A_4=a_1 a_2 a_3 a_4$ and $B_3=b_1 b_2 b_3$ defined a pairwise alignment
3. $b_3$ is aligned with a gap in the final site. Then $A_5=a_1 a_2 a_3 a_4 a_5$ and $B_2=b_1 b_2$ defined a pairwise alignment

---
class: left, top

# Needleman-Wunsch algorithm: Costs

1. $a_i$ and $b_j$ are aligned together in the final site. So, the cost is 0 if $a_i=b_j$ and 1 (or whatever cost of substitution defined) if they are different. Hence, the total cost is $F(i,j) = F(i-1,j-1)+cost(a_i,b_j)$
Then the other sites deinfe a pairwise alignment of $A_{i-1}$ and $B_{j-1}$
2. $a_i$ is aligned with a gap in the final site so that cost is 1 (or whatever the cost of gap is). Hence, the the total cost is $F(i,j) = F(i-1,j)+1$
3. $b_j$ is aligned with a gap in the final site so that cost is 1 (or whatever the cost of gap is). Hence, the the total cost is $F(i,j) = F(i,j-1)+1$

Finally, $F(i,j)=min (F(i-1,j-1)+cost(a_i,b_j), F(i-1,j)+1, F(i,j-1)+1 )$.

---
class: left, top

# Needleman-Wunsch algorithm

Steps:
1. Compute $F(i,j)$ for every $i,j$ and put in a matrix (sometimes denoted dynamic programming (DP) matrix). First column/row correspond to gap and F(0,0)=0
2. As you fill the matrix, keep track of which of the three entries gave you the minimum with an arrow
3. Trace back the arrows to construct the alignment (diagonal arrow=nucleotide, vertical/horizontal arrow=gap replacing the nucleotide the arrow is pointing)

![](../assets/pics/fig9.3.png)
_Figure 9.3 from Warnow_

---
class: left, top

# Needleman-Wunsch algorithm: Example

We want to align $S_1=ATCG$ and $S_2=TCA$ for a cost of substitution of 1 and cost of gap of 1.


---
class: left, top

# Homework: Needleman-Wunsch algorithm

**Instructions:** Redo the same example with a cost of gap of 1 and a cost of substitions of 3.


---
class: left, top

# How to align alignments

We need a concept called "profile".

![](..assets/pics/table9.7.png)
![](..assets/pics/table9.8.png)

---
class: left, top

# How to align alignments

1. Construct profiles
2. We want to minimize the expected edit distance between profiles
3. Treat $a_i$ in $P_1$ and $b_j$ in $P_2$ as generative models: $P(x|a_i)$ is the probability of observing $x$ in position $i$ on $P_1$
4. Define the cost of putting $a_i, b_j$ together
5. Use Needleman-Wunsch to align $P_1$ and $P_2$

---
class: left, top

# In-class activity

**Instructions:** Align the two alignments below.

![](..assets/pics/table9.7.png)


---
class: left, top

# Homework

**Instructions:** Continue with the example by calculating the cost for every pair of $a_i$ and $b_j$ and calculate the cost of the alignment below. Can you find another alignment with lower cost using the Needleman-Wunsch algorithm?

![](..assets/pics/table9.9.png)


---
class: left, top

# How to align alignments

If the alignment of profiles is the optimal, then we can translate back to the original sequences:

![](..assets/pics/table9.10.png)

---
class: left, top

# Needleman-Wunsch algorithm

#### Conclusion: 
Needleman-Wunsch lies at the core of MSA:
- if we have two sequences, we align them with Needleman-Wunsch
- if we have two alignments, we first convert them to profiles, and then align the profiles with Needleman-Wunsch

---
class: left, top

# Progressive alignment

### Steps

1. Compute rooted binary tree (guide tree) from pairwise distances
2. Build MSA from the bottom (leaves) up (root)

![](..assets/pics/fig9.9.png)
_Figure 9.9 in Warnow_

### Downsides

- The guide tree has a big impact on alignments (and we usually estimate an inaccurate tree). Some ways to overcome this issue are
    - better ways to estimate the tree (maximum likelihood); not very scalable
    - iteration between tree and alignment; not very scalable
- Errors made early in the process persist since subsequent mergers never change the alignments they are merging together. Some ways to overcome this issue are 
    - "polishing": breaks a set of sequences into subsets and re-aligns the induced sub-alignments
    - consistency (more later)

---
class: left, top

# Progressive alignment

### Software: ClustalW

- input sequences -> progressive alignment
- pairwise alignment to create distance matrix and then tree based on NJ
- sequences are down-weighted compared to how closely related they are to other sequences (to avoid a group of similar sequences to dominate the alignment)
- different weight matrices are used: 1) for closely related sequences where high scores are given to identities and low scores ow; 2) for distantly related sequences where high scores are given to conservative amino acid matches and low score to identities (BLOSUM, PAM matrices)
- the program varies the gap penalties (GP) for sequences and positions
- most widely used option, but several methods have been shown more accurate and fast

[Thompson, 1994, ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/)

---
class: left, top

# Iterative refinement

![](..assets/pics/muscle.png)

[Edgar, 2004, MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623)

---
class: left, top

# Iterative refinement

### Software: MUSCLE
- outperforms ClustalW in most settings but it is less scalable
- [MAFFT](https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html) also performs iterative refinement

---
class: left, top

# Consistency-based scoring
- consistency-based scoring: overcomes progressive alignment local-minimum problem
- uses "weighted sum of pairs" (WSP) objective function; we want to find the MSA that maximizes the score of the alignments (or minimizes the cost)
- Sum-of-pairs alignment
  - the cost of a given multiple sequence alignment is defined by summing the costs of its site of induced pairwise alignments
  - given input set S of sequences and the function for computing the cost of any pairwise alignment, find an alignment A on S such that the sum of the induced pairwise alignments is minimized

---
class: left, top

# Consistency-based scoring

### Software: T-coffee
- uses intermediate sequences to improve the quality of the pairwise alignment. For example, we are aligning sequences A and C and get a pairwise alignment A-C. We need incorportate an intermediate sequence B, and pairwise A-B and B-C to then obtain the pairwise alignment (A-C)^*
- generally more accurate than Clustalw; but not scalable to large alignments

---
class: left, top

# Other algorithms

### Genetic algorithm
- SAGA uses the WSP objective function but uses genetic algorithms instead of dynamic programming (individual=alignment)
- very accurate
- more scalable than t-coffee, but still not super scalable

### Hidden markov model
- [UPP](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0688-z)
- [pasta](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4424971/)

### Simultaneous estimation tree/alignment
- [sate](https://phylo.bio.ku.edu/software/sate/sate.html)


---
class: left, top

# Which program to choose?
- not a clear answer
- scalability vs accuracy
- journal club discussion: [Alignathon](https://genome.cshlp.org/content/24/12/2077)
- filtering is more important than the specific program used (more on filtering later)

# Other considerations

## Nucleotide vs amino acid sequence
- when there is choice (protein-coding genes), amino acid alignments are easier to carry out and less ambiguous; also nucleotide alignments do not recognizoe codon as a unit and can break up the reading frame; typically, you align the amino acids and then generate the corresponding nucleotide sequence alignment
- when sequences are not protein coding, only choice is to align nucleotides

## Manual editing and visualizing alignments
- manual editing is scary because it is not reproducible
- but many times it is necessary because automatic alignment methods are not as accurate as they should be

---
class: left, top

(aqui voy): example software

---
class: left, top

### Filtering alignments

topics

software

