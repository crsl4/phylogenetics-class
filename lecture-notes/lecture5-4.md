---
layout: default
title: Alignment (MUSCLE, MAFFT)
nav_order: 6
---

# Alignment methods (MUSCLE, MAFFT)

### Learning objectives

At the end of today's session, you
- will learn to use different software options: MAFFT and MUSCLE

{: .note }
Pre-class work: Read the paper corresponding to your canvas group: [MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623), [MAFFT](https://academic.oup.com/nar/article/30/14/3059/2904316)


{: .highlight }
First, let's take a look at data from last year's projects [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/data-examples.md).

## Iterative refinement: MUSCLE and MAFFT

<div style="text-align:center"><img src="../assets/pics/muscle.png" width="600"/></div>

[Edgar, 2004, MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623)

[Katoh et al, 2002, MAFFT](https://academic.oup.com/nar/article/30/14/3059/2904316)

Note that you can easily install the two software with [BioConda](https://bioconda.github.io/) again:

```
conda install -c bioconda muscle
conda install -c bioconda mafft
```

# In-class activity: MUSCLE and MAFFT

## In-groups time: 30 minutes

Google slides:

- [MAFFT](https://docs.google.com/presentation/d/1mul9d-rTo1-gk3NJlWQwT5MVV9toHgHIuMRR1Tlgfos/edit?usp=sharing)
- [MUSCLE](https://docs.google.com/presentation/d/1EoDrQhpS8u7DzfiDeButf-NZrC5PE6W00v5p9r7zhbE/edit?usp=sharing)

**Instructions:** Work individually or in teams (people that read the same paper as you).
In the slides:
1. Write down one claim that the authors make about their method (e.g. accuracy, speed, robustness, scalability)
2. Run the software on the `primatesAA.fasta` data and write down the command you ran in the slides
  - [MUSCLE docs](https://www.drive5.com/muscle/manual/basic_alignment.html)
  - [MAFFT docs](https://mafft.cbrc.jp/alignment/software/manual/manual.html)
3. Write a paragraph suitable for a paper Methods section that:
  a. Describes what you did
  b. Expliclty connects your choices to the claims described in the paper
  c. Makes clear what assumptions you are relying on
  d. Note that you may not say 'default parameters' without explaining what that implies in terms of the method

## Whole group activity: 20 minutes

One person per method will present their work to the class.

# Comparing all three software

Let's open all three in [AlignmentViewer](https://alignmentviewer.org/):
```
primatesAA-aligned.fasta        ## clustalw
primatesAA-aligned-muscle.fasta ## muscle
primatesAA-aligned-mafft.fasta  ## mafft
```

Looking at all three alignments, think of:
- One region where all three agree
- One region where at least two disagree
- One region you would be uncomfortable using for phylogenetic inference
- Which method tends to introduce: More gaps? Longer indels? Better conservation?


{: .highlight }
**Homework:** Check out the alignment HW [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-alignment.md).



# Final MSA insights

- No perfect method
- No automatic method
  - All methods require manual work of comparing results from different alignment parameters and from different sofware
- Take notes of the choices you made and keep track of all comparisons to justify final choice
- We probably don't spend as much time as we should on the alignment step of the phylogenomic pipeline
  - We want a blackbox that does not exist yet!

## Other algorithms

### Genetic algorithm
- SAGA uses the WSP objective function but uses genetic algorithms instead of dynamic programming (individual=alignment)
- very accurate
- not scalable

### Hidden markov model
- [UPP](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0688-z)
- [pasta](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4424971/)

### Simultaneous estimation tree/alignment
- [sate](https://phylo.bio.ku.edu/software/sate/sate.html)


## Which program to choose?
- Not a clear answer
- Scalability vs accuracy
- HW reading: [Alignathon](https://genome.cshlp.org/content/24/12/2077)
- **Strategy:**
  - Run multiple programs and parameter choices
  - Filtering is more important than the specific program used (more on filtering later)
  - Read program papers and documentation carefully
  - Take good note of choices and keep track of all comparisons to justify final choice


# Learn more!

- Read Chapter 3 of the Phylogenetic Handbook (HB)
- Read Sections 9.1-9.5, 9.11, 9.12, 9.13 of [Computational phylogenetics](https://www.amazon.com/Computational-Phylogenetics-Introduction-Designing-Estimation/dp/1107184711) (Warnow) 
- Read HAL 2.3 on a new alignment method `MACSE`