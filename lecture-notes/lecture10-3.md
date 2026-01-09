---
layout: default
title: Maximum Likelihood (IQ-Tree)
nav_order: 14
---

# Maximum Likelihood (IQ-Tree)

### Previous class check-up
- We studied the algorithms for maximum likelihood and focused on the main contributors to good or poor performance

### Learning objectives

At the end of today's session, you will be able to
- explain in details the IQ-Tree inference methods
- use IQ-Tree software

{: .important-title}
> Pre-class work
>
> Read the papers :
>  - [IQ-Tree1](https://academic.oup.com/mbe/article/32/1/268/2925592?login=true)
>  - [IQ-Tree2](https://academic.oup.com/mbe/article/37/5/1530/5721363?login=true)


# In-class discussion

## Individual work (15 minutes)

**Instructions:** Based on the IQ-Tree papers you read, write down (somewhere) the following questions:

1. Starting tree
- How does IQ-TREE generate or accept starting trees?
- Any novel methods (e.g., random vs parsimony starting trees)?

2. Model of evolution
- What automatic model selection options exist?
- How does IQ-TREE differ from RAxML in model selection and assumption reporting?

3. Data quality
- How does IQ-TREE handle missing data or poorly aligned regions?
- Any quality control features?

4. Convergence
- How does IQ-TREE optimize the likelihood?
- How does IQ-TREE detect if optimization is complete?

5. Optional extra credit:
- Find one recommendation from the paper about speed vs accuracy trade-offs.

## Whole class work (15 minutes)

Let's discuss the questions together!

{: .important }
**Take-home message:** always read carefully the paper and the documentation of any phylogenetic method you use

{: .note }
Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).

# Software

We are following the tutorial in [here](http://www.iqtree.org/workshop/molevol2019).

Download for mac [here](http://www.iqtree.org/#download). Downloaded a zipped folder `iqtree-1.6.12-MacOSX` and placed in `software`.

I will copy this executable into `/usr/local/bin` so that I can call it from wherever in my machine, but you can also use the whole path.

```
cd software/iqtree-1.6.12-MacOSX/bin ## you need to modify to your own path
ls ## check the iqtree executable is there
cp iqtree /usr/local/bin
```

We will use the `primatesAA` data again. For now, we will use the alignment from MUSCLE, but it would be interesting to compare to other alignments.

```shell
iqtree -s primatesAA-aligned-muscle.fasta
```

{: .highlight}
Which is the best model according to IQ-Tree? Compare to the model we arbitrarily chose for RAxML.

Read carefully the output file as it provides information on starting tree and parameters used. No information found on convergence criteria, but they do provide information on how long it took to converge.

IQ-Tree produces the following output files:
```
Analysis results written to: 
  IQ-TREE report:                primatesAA-aligned-muscle.fasta.iqtree
  Maximum-likelihood tree:       primatesAA-aligned-muscle.fasta.treefile
  Likelihood distances:          primatesAA-aligned-muscle.fasta.mldist
  Screen log file:               primatesAA-aligned-muscle.fasta.log
```

We can do a quick and dirty plot in R:

```r
library(ape)
tre = read.tree(file="primatesAA-aligned-muscle.fasta.treefile")
plot(tre)
```

Note how we need to root the tree again:
```
plot(tre)
nodelabels()

rtre = root(tre, node=31, resolve.root=TRUE)
plot(rtre)
```


{: .important }
> **Check at home:**
> 
> How does this tree compare to the one estimated by RAxML?
>
> **Double bonus points** for comparing not only the performance of RAxML and IQ-Tree on a given alignment, but comparing how do results differ if we use an alignment from a different method.

Finally, we also want to quantify support for the estimated tree. Note that we don't do model selection anymore to reduce computational time. We choose the best model by IQ-Tree. Also, we only do 10 bootstrap replicates. Last, we need to add a prefix because it again does not let us overwrite original files produced.

```
iqtree -s primatesAA-aligned-muscle.fasta -m HIVb+G4 -b 10 -pre primatesAA-aligned-muscle.fasta-iqtree-bootstrap
```

We can plot again the tree with bootstrap support in R:

```r
library(ape)
tre = read.tree(file="primatesAA-aligned-muscle.fasta-iqtree-bootstrap.treefile")
plot(tre)
nodelabels()

rtre = root(tre, node=31, resolve.root=TRUE)
plot(rtre)
nodelabels(rtre$node.label)
```

# Homework

See the details of the Maximum Likelihood HW in [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-ml.md). 

