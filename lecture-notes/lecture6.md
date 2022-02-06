---
title: "Lecture 6"
author: "Botany 563"
subtitle: "Orthology inference"
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

# Lecture 6

### Previous class check-up
- We studied the algorithms for multiple sequence alignment: Needleman-Wunsch, progresive alignment and improvements
- We learned about three software for MSA: muscle, t-coffee, clustalw

### Learning objectives

At the end of today's session, you will be able to
- compare the difference methods for orthology inference
- describe the steps in the OrthoFinder algorithm
- run OrthoFinder in your computer

### Pre-class work

- Read HAL 2.4
- Read [OrthoFinder paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0721-2)

---
class: left, top

# Filtering alignments
(HAL 2.2)

- MSA is messy and error-prone, so many times we need to filter out poorly aligned regions
- We need to make sure that we do not remove signal along with the noise
- The balance depends on the planned downstream analysis: 
  - Example: misaligned regions impacting a single seauence at one time will have little impact on the phylogeny inference apart from terminal branch length estimations, but they will induce many false positives when searching for loci under positive selection
- We want automatic MSA cleaning methods, not manual for reproducibility reasons, but there are no options yet
- Two types of filtering methods:
    - (take it or leave it) TILI-filtering methods: remove whole sites or whole sequences
    - masking residues: replace by gap or a symbol representing ambiguity ?,N,X

---
class: left, top

### What are the problematic regions of an aligment?

<div style="text-align:center"><img src="../assets/pics/fig8hal.png" width="400"/></div>

---
class: left, top

### What are the problematic regions of an aligment?

1. poorly informative
  - patchy: too many gaps (Fig 8a HAL)
  - regions in the vicinity of patchy regions (Fig 8b HAL)

2. wrongly aligned
  - misaligned regions (Fig 8c HAL)
  - low complexity regions with repeated characteristics (Fig 8d HAL)

---
class: left, top

### What causes problematic MSA regions?
- Highly divergent or non-homologous sequence fragments
    - Note that even when sequences are too divergent, or not even homologous, MSA software will still produce an alignment
    - Somewhere along the gradient from highly similar sequences to highly divergent sequences,
there is a critical point beyond which to align sequences is not possible, or biologically
meaningful: too many substitutions or indels have occurred

- High-throughput sequencing or annotation errors 
    - Sequencing errors -> small indels in nucleotide alignments -> errors in translation
    - Errors in homology annotation can lead to the inclusion of sequences that are not homologous
    - This more tricky case occurs
when all considered sequences are homologous but some are erroneously considered as being
orthologous (derived from ancestral copy by speciation) while actually being paralogous
(derived from ancestral copy by duplication)

---
class: left, top

### Principles underlying filtering methods

- Gaps indicate hard to align and possibly saturated regions 
    - From a biological viewpoint, it is often assumed that in proteins insertions and deletions are less frequent than point substitutions

- Few/similar residues are expected per site
- Reliable regions are likely more robust to MSA method variations

- Homologous (fragment of) sequences are expected to be similar (pre-filtering)
    - For most pipelines, sequence similarity is an initial criterion used to identify homologous sequences

- Orthologous sequences are supposed to be congruent over loci
(post-filtering)

---
class: left, top

### TILI-filtering methods vs masking residues methods

![](../assets/pics/fig9hal.png)

- they are fated to remove signals along with noise
- TILI-filtering methods could still do a great job regarding phylogeny inference if they are able to correctly identify and remove sequences and sites containing more noise than signal
- In general, masking residues methods are better

---
class: left, top

## Comparison of filtering methods

<div style="text-align:center"><img src="../assets/pics/fig12hal.png" width="700"/></div>

---
class: left, top

## Comparison of filtering methods

<div style="text-align:center"><img src="../assets/pics/table1hal.png" width="500"/></div>

- [OMM_MACSE pipeline](https://github.com/ranwez/MACSE_V2_PIPELINES) and [HmmCleaner](https://metacpan.org/pod/distribution/Bio-MUST-Apps-HmmCleaner/bin/HmmCleaner.pl) among the best filtering methods, but careful since not simulated data


---
class: left, top

# Homology subtypes

- All life on earth shares a common origin
- Homologous genes: share ancestry
- We want to distinguish more precisely how homologous genes are related, giving rise to different homology subtypes
  - orthologs: speciation
  - paralogs: duplication
  - ohnologs: whole genome duplication
  - homoelogs: hybridization
  - xenologs: lateral gene transfer
- We mostly focus on orthologs due to their importance in phylogenomics
- Orthology can be a one-to-one relationship, a one-to-many, or many-to-one relationship
- Orthology and paralogy relationships are not transitive (see next figure)


---
class: left, top

# Orthologous groups

<div style="text-align:center"><img src="../assets/pics/fig1hal2.4.png" width="750"/></div>

_Figure 1 in HAL 2.4_


---
class: left, top

# Orthologous groups: Figure summary

- Orthology can be a one-to-one, a one-to-many, a many-to-one, or many-to-many relationship
  - Example: a mammal gene in the human lineage and duplicated in the rodent lineage. Both rodent paralogous copies are orthologous to the human gene
- Orthology and paralogy relationships are not transitive
  - Example: mouse has two insulin genes Ins1 and Ins2, which duplicated within the rodent lineage. Human has one copy, INS. Therefore, Ins1 is orthologous to INS, INS is orthologous to Ins2, but Ins1 is not orthologous but paralogous to Ins2
- There are different types of orthologous groups: strict ortholog groups (transitive) and hierarchical orthologs groups
- Hierarchical orthogroups are obtained by the speciation nodes on the reconciled gene trees
  - "Reconciled gene trees": internal nodes labelled as speciation or duplication (HAL 3.2)
- Here, we will not worry on the reconciliation step and will focus on identifying and using orthologs

---
class: left, top

# Orthology inference methods

- Bidirectional Best Hit (BBH)
- Reciprocal Smallest Distance (RSD)
- Tree-based methods
- Graph-based methods

**Important reading:** From journal club, _The Impact of Gene Duplication, Insertion, Deletion, Lateral Gene Transfer and Sequencing Error on Orthology Inference: A Simulation Study_ [Dalquen et al 2013](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0056925)

---
class: left, top

# Orthology inference methods

### Bidirectional Best Hit (BBH)
- Also found as "reciprocal best hit"
- Call as orthologs all pairs of genes between two species that are more similar (i.e., with highest alignment score) to one another than to any other gene in the other species
- In BLAST: gene _i_ in genome _I_ is BBH of gene _j_ in genome _J_ if query of genome _I_ with gene _j_ hits gene _i_ and viceversa
- Original paper: [Overbeek et al 1999](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC15866/)
- Bidirectional Best Hits miss many orthologs in duplication-rich clades such as plants and animals [Dalquen & Dessimoz, 2013](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3814191/)


---
class: left, top

# Orthology inference methods

### Reciprocal Smallest Distance (RSD)

- It relies on global sequence alignment and maximum likelihood estimation of evolutionary distances to detect orthologs between two genomes
- Original paper [Wall et al, 2003](https://academic.oup.com/bioinformatics/article/19/13/1710/224944)
- Steps:
  1. You have gene _i_ from genome _I_ and target genome _J_
  2. With BLAST, identify a set of hits _H_ above a predefined significance threshold
  3. Use ClustalW to pairwise align every sequence in _H_ with gene _i_
  4. If the alignment score is greater than a threshold, the sequence _h_ is kept (call this set of hits _H2_)
  5. Using PAML, you calculate the maximum likelihood evolutionary distance between every sequence in _H2_ and gene _i_ based on a given model of evolution
  6. The sequence with the minimim evolutionary distance to gene _i_ is identified as the ortholog
  
  
- Weaknesses of BBH and RSD:
  - BBH and RSD do not deal well with many-to-many orthology relationships,
resulting in missing pairs
  - BBH and RSD can fail in case of differential gene loss: a situation where
the corresponding ortholog is simply missing in both species, resulting in paralogs being wrongly identified as orthologs
  - BBH and RSD do not obviously generalise to groupwise orthology (COGs: clusters of orthologous groups)

---
class: left, top

# Orthology inference methods

### Tree-based methods
- Tree-based orthology inference methods
reconstruct a gene tree for a group of homologous sequences to then infer the type of
evolutionary event represented by each internal node of the tree
- To label the trees, there are two options:
  - gene tree/species tree reconciliation (HAL 3.2)
  - species overlap: duplication nodes have the same species represented in child subtrees
- Software: 
  - PANTHER, GIGA, EmsembleCompara use reconciliation approach
  - PhylomeDB, MetaPhOrs, ETE library use the species overlap approach

---
class: left, top

# Orthology inference methods

### Graph-based methods
- Avoid inferring trees and instead
compare sequences in a pairwise fashion, and build a graph with genes as nodes and some
measure of sequence similarity as edges
- Assumption: orthologs tend to be the pairs of sequences that have diverged the least
- Rely on computational approaches to identify clusters in the graph to be considered the orthologous groups
- Software: Inparanoid, OMA, OrthoMCL, OrthoFinder, OrthoInspector, QuartetS

---
class: left, top

# Impact on phylogenomics inference

- Initially, there was no need to search for orthologs
  - The experimental design in molecular phylogenetics included the identification
of highly conserved regions in the organismal lineage of interest, that were amplified with
specific probes by means of a polymerase chain reaction (PCR). As the same marker gene
 (i.e. the orthologous gene) was specifically sequenced from each of the species of interest,
there was no need to search for orthologs

- High-throughput sequencing and the availability of complete (or nearly complete)
genomes and transcriptomes allow us in principle to choose among virtually any marker gene.
In these cases, there is a need of inferring orthologous genes from the source genomic datasets

- Few studies have compared how sets of orthologs inferred through different methods vary and how it
affects species tree reconstruction (but see [Dalquen et al 2013](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0056925))


---
class: left, top

# OrthoFinder

- Paper [Emms and Kelly, 2015](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0721-2)
- [Github repo](https://github.com/davidemms/OrthoFinder)

- Why OrthoFinder?  
  - infers "orthogroups": an orthogroup is the set of genes that are descended from a single gene in the last common ancestor of all the species being considered. An orthogroup by definition contains both orthologues and paralogues
  - A standard OrthoFinder run produces a set of files describing the orthogroups, orthologs, gene trees, resolve gene trees, the rooted species tree, gene duplication events and comparative genomic statistics for the set of species being analysed
  - In some simulations, OrthoFinder outperforms OrthoMCL which is one of the most cited orthology inference methods


---
class: left, top

# Before the OrthoFinder algorithm...

Let's talk about graph clustering algorithms


---
class: left, top

# OrthoFinder algorithm

<div style="text-align:center"><img src="../assets/pics/orthofinder.png" width="550"/></div>

_Figure 7 in Emms and Kelly (2015)_


---
class: left, top

# OrthoFinder algorithm

1) BLAST all-versus-all search (Fig. 7b)
  - Protein BLAST (blastp) with an e-value threshold of 10−3 is used so as to avoid discarding putative good hits for very short sequences
  - A relaxed threshold is used at this stage of the method as subsequent steps filter out false positive hits using stringent, orthogroup-specific criteria for inclusion (described below)
  - Note: BLAST E-value is the number of expected hits of similar quality (score) that could be found just by chance. E-value of 10 means that up to 10 hits can be expected to be found just by chance, given the same size of a random database.


---
class: left, top

# OrthoFinder algorithm

2) Gene length and phylogenetic distance normalisation of the BLAST bit scores (Fig. 7c). 
  - The aim of this normalisation procedure is to remove gene length bias from BLAST bit scores and to normalise for phylogenetic distance between species
  - This step models the all-vs-all BLAST hits for each pairwise comparison between species to identify and remove the gene similarity dependency on gene length and phylogenetic distance
  - This is done so that the best hits between all species achieve the same scores regardless of sequence length or phylogenetic distance
  - The clustering algorithm that they use (MCL) converts sets of similarity scores into clusters by breaking apart clusters of genes that have low similarity scores (and therefore are unlikely to be orthogroups) and preserving clusters of sequences that have high similarity scores. If the similarity scores between long sequences are inherently larger than the similarity scores between short sequences then the clustering will preferentially break apart clusters of short sequences while preserving clusters of long sequences
  
---
class: left, top

# OrthoFinder algorithm

3) Delimitation of orthogroup sequence similarity thresholds using RBNHs (Fig. 7d)
  - We construct a similarity measure between sequences based on the bit-score normalised to take into account the query and hit sequences lengths and the phylogenetic distance between species
  - This step uses information from RBNHs (Reciprocal Best length-Normalised hit) to define the lower limit of sequence similarity for putative cognate genes of each query gene
  - To be included in the orthogroup graph a gene-pair must be an RBNH or produce a hit that is better scoring than the lowest scoring RBNH (irrespective of species) for either gene

4) Constructing an orthogroup graph for input into the clustering algorithm (MCL) (Fig. 7e)
  - Putative cognate gene-pairs are identified as above and are connected in the orthogroup graph with weights given by the normalised BLAST bit scores.

5) Clustering of genes into orthogroups using the clustering algorithm [MCL](https://www.micans.org/mcl/index.html?sec_software) (Fig. 7f)

---
class: left, top

# In-class activity

**Time:** 25 minutes

**Instructions:** Go over the [OrthoFinder Tutorial](https://davidemms.github.io/menu/tutorials.html) and create our own reproducible script.

**Disclaimer:** I have not done the steps ahead of time to make sure that everything runs smoothly. My idea is to troubleshoot this pipeline together, but maybe this will backfire.

#### Options for you

1. "I think that I can follow the pipeline by myself or with a small group of peers": you should join the Congregate room
2. "I need to see step by step": you can stay here in the zoom room

---
class: left, top

# In-class discussion (if time allows)

**Time:** 10 minutes individual/small-group work and 5 minutes class discussion

**Instructions:**
Now that you have a better idea of the OrthoFinder algorithm, what do you think are the main weaknesses of this (or similar) software? What assumptions are they making?

Use the 
[Google slides](https://docs.google.com/presentation/d/177UUJovYy18neX03vRHxoxvUqvL0hKUYrecS6q4GO-0/edit?usp=sharing) to record your answer. Feel free to group in teams in Congregate.

---
class: left, top

# Further reading

- Read again the [OrthoFinder paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0721-2) and read also the [extension](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1832-y)
- Check out more on the [OrthoFinder github repo](https://github.com/davidemms/OrthoFinder)
- Learn more about the [Quest for Orthologs](https://questfororthologs.org/) meeting
- Read about BBH in the original paper [Overbeek et al 1999](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC15866/) and its limitations [Dalquen & Dessimoz, 2013](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3814191/)
- Read a review paper on new tools in orthology analysis: [Nichio et al 2017](https://www.frontiersin.org/articles/10.3389/fgene.2017.00165/full)
- Read Inferring Orthologs: Open Questions and Perspectives in [Tekaia2016](https://journals.sagepub.com/doi/10.4137/GEI.S37925)
- Read Finding Orthologs in the Twilight and Midnight Zones of Sequence Similarity in [Haberman2016](https://link.springer.com/chapter/10.1007%2F978-3-319-41324-2_22)



