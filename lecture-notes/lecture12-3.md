---
layout: default
title: Bayesian Inference III
nav_order: 17
---

# Bayesian Inference (Part 3: computer lab)

**Instructions:** Run MrBayes on the toy dataset described below. You can use my reproducible script as guideline: [notebook-log.md](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/notebook-log.md).

[MrBayes tutorial](http://hydrodictyon.eeb.uconn.edu/eebedia/index.php/Phylogenetics:_MrBayes_Lab)

New toy dataset: Download the data (`algaemb.nex`)
```
curl -O http://hydrodictyon.eeb.uconn.edu/people/plewis/courses/phylogenetics/data/algaemb.nex
```

You can also use the primates fasta file that you aligned with ClustalW, MUSCLE or T-Coffee. 

{: .important }
Make sure to read the [MrBayes tutorial](http://hydrodictyon.eeb.uconn.edu/eebedia/index.php/Phylogenetics:_MrBayes_Lab) carefully to determine the appropriate MrBayes block for your data.

{: .important }
**Bonus points** for paying attention to the importants aspects that affect the performance of the chosen method.

{: .important }
**Double bonus points** for comparing how do results differ if we use an alignment from a different method. That is, `primatesAA-aligned-muscle.fasta` are the aligned sequences with MUSCLE. I can run MrBayes on this file and on `primatesAA-aligned.fasta` which was aligned with ClustalW and compare with the estimated trees.



# Homework

See the details of the Bayesian Inference HW in [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-bayesian.md). 

