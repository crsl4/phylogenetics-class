---
layout: default
title: Maximum Likelihood III
nav_order: 14
---

# Maximum Likelihood (Part 3: computer lab)

**Instructions:** Run and compare the results of both ML software (RAxML and IQ-Tree) on the toy dataset of primates. You can use my reproducible script as guideline: [notebook-log.md](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/notebook-log.md).

- RAxML-NG
    - [RAxML-NG tutorial 1](https://github.com/amkozlov/raxml-ng/wiki/Tutorial) (HAL 1.3)
    - [RAxML-NG tutorial 2 (newer)](https://isu-molphyl.github.io/EEOB563/computer_labs/lab4/raxml-ng.html)
- [IQ-Tree](http://www.iqtree.org/workshop/molevol2019)

You can use the primates fasta file that you aligned with ClustalW, MUSCLE or T-Coffee, or you can use the toy data provided in the software tutorial. 

{: .important }
**Bonus points** for paying attention to the importants aspects that affect the performance of the chosen method.

{: .important }
**Double bonus points** for comparing not only the performance of RAxML and IQ-Tree on a given alignment, but comparing how do results differ if we use an alignment from a different method. That is, `primatesAA-aligned-muscle.fasta` are the aligned sequences with MUSCLE. I can run RAxML and IQ-Tree on this file and compare the two trees. I can also run RAxML and IQ-Tree on `primatesAA-aligned.fasta` which was aligned with ClustalW and compare the 4 trees.


# Homework

See the details of the Maximum Likelihood HW in [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-ml.md). 

