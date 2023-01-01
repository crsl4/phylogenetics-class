---
layout: default
nav_exclude: true
---

# Summary of the three alignment software

## Progressive alignment: [Thompson, 1994, ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/)

- Pairwise alignment to create distance matrix and then tree based on NJ
- Sequences are down-weighted compared to how closely related they are to other sequences (to avoid a group of similar sequences to dominate the alignment)
- Different weight matrices are used: 1) for closely related sequences where high scores are given to identities and low scores ow; 2) for distantly related sequences where high scores are given to conservative amino acid matches and low score to identities (BLOSUM, PAM matrices)
- The program varies the gap penalties (GP) for sequences and positions
- Most widely used option, but several methods have been shown more accurate and fast
- Downsides
  - The guide tree has a big impact on alignments (and we usually estimate an inaccurate tree). Some ways to overcome this issue are
      - better ways to estimate the tree (maximum likelihood); not very scalable
      - iteration between tree and alignment; not very scalable
  - Errors made early in the process persist since subsequent mergers never change the alignments they are merging together


## Iterative refinement: [Edgar, 2004, MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623)

- Outperforms ClustalW in most settings but it is less scalable
- [MAFFT](https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html) also performs iterative refinement


## Consistency-based scoring: [Notredame, 2000, T-Coffee](https://www.sciencedirect.com/science/article/pii/S0022283600940427)
- Consistency-based scoring: overcomes progressive alignment local-minimum problem
- It uses "weighted sum of pairs" (WSP) objective function; we want to find the MSA that maximizes the score of the alignments (or minimizes the cost)
- Sum-of-pairs alignment
  - the cost of a given multiple sequence alignment is defined by summing the costs of its site of induced pairwise alignments
  - given input set S of sequences and the function for computing the cost of any pairwise alignment, find an alignment A on S such that the sum of the induced pairwise alignments is minimized
- It uses intermediate sequences to improve the quality of the pairwise alignment. For example, we are aligning sequences A and C and get a pairwise alignment A-C. We need incorportate an intermediate sequence B, and pairwise A-B and B-C to then obtain the pairwise alignment (A-C)
- Generally more accurate than Clustalw; but not scalable to large alignments
