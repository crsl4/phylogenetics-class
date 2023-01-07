---
layout: default
title: Distance and Parsimony II
nav_order: 9
---

# Distance and Parsimony methods (Part 2)

# Parsimony-based methods

- Character-based data: 4 nucleotides ACGT or 20 aminoacids => matrix of aligned characters
- It does not rely on models of evolution
- One seeks the tree that minimizes the amount of evolutionary change required to explain the data
- Justification: 
  - Ockham's razor: when two hypothesis provide equally valid explanations for a phenomenon, the simpler one should always be preferred
  - More character-state changes imply a more complex hypothesis because homoplasy (sharing identical character states that cannot be explained by inheritance from a common ancestor) is an _ad hoc_ hypothesis
- Parsimony represents a useful fall back method when model-based methods cannot be used due to computational limitations


## Assumptions
- Parsimony methods are most effective when rate of evolution is slow, but this is not a necessary assumption
- Parsimony methods can perform well under high rates of evolution as long as there are no pathological inequalities (long-branch attraction: Felsenstein zone)
- The only real assumption of parsimony is independence among characters


## Methodology

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


Just as in MSA, we cannot do this by hand and there are dynamic programming algorithms that help us (what was dynamic programming?): 
- Fitch algorithm (HB Box 8.2) for equal costs
- Sankoff algorithm (HB Box 8.1) for unequal costs


### Fitch algorithm
1) Root the tree in a random place (parsimony score is not affected by the root)

2) Calculate the state-set $X_i$ for each internal node $i$ corresponding the set of states that can be assigned to each node so that the minimum possible length of the subtree can be achieved. Let $L(i)$ and $R(i)$ be the left and right child descendant nodes of $i$ respectively.

2.1) Form the intersection of the two child state sets: $X_{L(i)} \cap X_{R(i)}$

2.2) If the intersection is non-empty, set $X_i$ equal to this intersection and the accumulated length for this node as the sum of the accumulated lengths for the two child nodes: $s_i=s_{L(i)}+s_{R(i)}$

2.3) If the intersection is empty, let $X_i$ be equal to the union of the two child sets: $X_{L(i)} \cup X_{R(i)}$ and set the accumulated length for this node as the sum of the accumulated lengths for the two child nodes _plus one_: $s_i=s_{L(i)}+s_{R(i)}+1$
  
  
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

{: .highlight }
**Phylogenetic inference: Maximum Parsimony (MP) tree:** Step 1) Evaluate the parsimony score of a given tree (length) with Fitch algorithm. Step 2) Search the space of trees until you find the optimum.

## Some downsides

- Parsimony methods have been shown to produce inconsistent trees
- Read more in [Felsenstein 1978](https://academic.oup.com/sysbio/article/27/4/401/1734959?login=true)

 