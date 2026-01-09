---
layout: default
title: Maximum Likelihood (RAxML)
nav_order: 13
---

# Maximum Likelihood (RAxML)

### Previous class check-up
- We studied the algorithms for maximum likelihood and focused on the main contributors to good or poor performance

### Learning objectives

At the end of today's session, you will be able to
- explain in details the RAxML inference methods
- use RAxML software

{: .important-title}
> Pre-class work
>
> Read the papers :
>  - [RAxML1](https://academic.oup.com/bioinformatics/article/30/9/1312/238053?login=true)
>  - [RAxML2](https://academic.oup.com/bioinformatics/article/35/21/4453/5487384?login=true)


# In-class discussion

## Individual work (15 minutes)

**Instructions:** Based on the RAxML papers you read, write down (somewhere) the following questions:

1. Starting tree
- How does RAxML generate or accept a starting tree?
- Why does starting tree choice matter for ML search?

2. Model of evolution
- Which models are implemented in RAxML?
- How are models chosen in practice?
- What are assumptions or limitations of these models?

3. Data quality
- What does RAxML assume about the input alignment?
- Are there warnings or guidance about poorly aligned or incomplete data?

4. Convergence
- How does RAxML search tree space?
- How does it decide when it has found the ML tree?
- What steps ensure that results are reliable (e.g., multiple searches, bootstrap)?

5. Optional extra credit:
- Identify one tip or recommendation from the paper for improving runtime or accuracy.

## Whole class work (15 minutes)

Let's discuss the questions together!

{: .important }
**Take-home message:** always read carefully the paper and the documentation of any phylogenetic method you use

{: .note }
Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).

# Software

The repository for RAxML has installation instructions [here](https://github.com/amkozlov/raxml-ng).

I click on `Download OSX/macOS binary (x86 and ARM)` and I download `raxml-ng_v1.2.2_macos.zip`. I put this folder in my computer (I have a folder `software`), and inside it is the executable `raxml-ng`.

I will copy this executable into `/usr/local/bin` so that I can call it from wherever in my machine, but you can also use the whole path.

```
cd software/raxml-ng_v1.2.2_macos/ ## you need to modify to your own path
ls ## check the raxml-ng executable is there
cp raxml-ng /usr/local/bin
```

We will use the `primatesAA` data again. For now, we will use the alignment from MUSCLE, but it would be interesting to compare to other alignments.

First, we will check the alignment:
```
raxml-ng --check --msa primatesAA-aligned-muscle.fasta --model LG+G8+F
```

And then we find the ML tree:
```
raxml-ng --msa primatesAA-aligned-muscle.fasta --model LG+G8+F
```

{: .note}
Version 2.0 or higher has now automatic model selection (see [here](https://github.com/amkozlov/raxml-ng/wiki/Input-data#evolutionary-model)).

RAxML produces the following output files:
```
Best ML tree saved to: primatesAA-aligned-muscle.fasta.raxml.bestTree
All ML trees saved to: primatesAA-aligned-muscle.fasta.raxml.mlTrees
Optimized model saved to: primatesAA-aligned-muscle.fasta.raxml.bestModel
Execution log saved to: primatesAA-aligned-muscle.fasta.raxml.log
```

We can do a quick and dirty plot in R:

```r
library(ape)
tre = read.tree(file="primatesAA-aligned-muscle.fasta.raxml.bestTree")
plot(tre)
```

It is not enough to estimate the ML tree, we also want to do non-parametric bootstrapping.
We call this non-parametric bootstrapping because we resample our alignment columns with replacement and rebuild trees many times to see which clades are consistently recovered.

We use the flag `--all` to run both ML and bootstrap:
```
raxml-ng --all --msa primatesAA-aligned-muscle.fasta --model LG+G8+F --bs-trees 10 --prefix primatesAA-aligned-muscle-raxml-boostrap
```
We are only doing 10 bootstrap replicates for the sake of time, but we should always try to do at least 100. We need to choose a new prefix because it doesn't let us overwrite the previous raxml output files.

The output file we are interested in is:
```
Best ML tree with Felsenstein bootstrap (FBP) support values saved to: primatesAA-aligned-muscle-raxml-boostrap.raxml.support
```

We can do a quick and dirty plot in R:

```r
library(ape)
tre = read.tree(file="primatesAA-aligned-muscle-raxml-boostrap.raxml.support")
plot(tre)
nodelabels(tre$node.label)
```

First, we note that the tree does not seem to be rooted correctly.

{: .important-title}
> very important
>
> Maximum likelihood methods are uncapable of inferring the place of the root. We always have to root the estimated tree afterwards with an outgroup.

```r
library(ape)
tre = read.tree(file="primatesAA-aligned-muscle-raxml-boostrap.raxml.support")
plot(tre)
nodelabels()

rtre = root(tre, node=33, resolve.root=TRUE)
plot(rtre)
nodelabels(rtre$node.label)
```

{: .highlight}
How do we interpret those numbers?

{: .warning}
Common mistake in final project: forget to root the estimated trees!