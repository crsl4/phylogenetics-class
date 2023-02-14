---
layout: default
title: Alignment IV
nav_order: 6
---


# Alignment methods (Part 4: computer lab)

### Previous class check-up
- We reviewed the algorithms for pairwise and multiple sequence alignments

### Learning objectives

At the end of today's session, you
- will learn to use different software options: ClustalW, T-Coffee and MUSCLE


{: .note }
No pre-class work.


{: .highlight }
Let's take a look at data from last year's projects [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/data-examples.md).


# MSA software key insights

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
- more scalable than T-coffee, but still not super scalable

### Hidden markov model
- [UPP](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0688-z)
- [pasta](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4424971/)

### Simultaneous estimation tree/alignment
- [sate](https://phylo.bio.ku.edu/software/sate/sate.html)


### Other considerations

- Nucleotide vs amino acid sequence
  - when there is choice (protein-coding genes), amino acid alignments are easier to carry out and less ambiguous; also nucleotide alignments do not recognize codon as a unit and can break up the reading frame; typically, you align the amino acids and then generate the corresponding nucleotide sequence alignment
  - when sequences are not protein coding, only choice is to align nucleotides
- Manual editing and visualizing alignments
  - manual editing is scary because it is not reproducible
  - but many times it is necessary because automatic alignment methods are not as accurate as they should be


### Which program to choose?
- Not a clear answer
- Scalability vs accuracy
- HW reading: [Alignathon](https://genome.cshlp.org/content/24/12/2077)
- **Strategy:**
  - Run multiple programs and parameter choices
  - Filtering is more important than the specific program used (more on filtering later)
  - Read program papers and documentation carefully
  - Take good note of choices and keep track of all comparisons to justify final choice


# Software tools for alignment

## ClustalW

- [ClustalW](http://www.clustal.org/clustal2/)
- From the [docs](http://www.clustal.org/download/clustalw_help.txt):

```
DATA (sequences)

-INFILE=file.ext                             :input sequences.
-PROFILE1=file.ext  and  -PROFILE2=file.ext  :profiles (old alignment).


                VERBS (do things)

-OPTIONS            :list the command line parameters
-HELP  or -CHECK    :outline the command line params.
-FULLHELP           :output full help content.
-ALIGN              :do full multiple alignment.
-TREE               :calculate NJ tree.
-PIM                :output percent identity matrix (while calculating the tree)
-BOOTSTRAP(=n)      :bootstrap a NJ tree (n= number of bootstraps; def. = 1000).
-CONVERT            :output the input sequences in a different file format.

                PARAMETERS (set things)

***General settings:****
-INTERACTIVE :read command line, then enter normal interactive menus
-QUICKTREE   :use FAST algorithm for the alignment guide tree
-TYPE=       :PROTEIN or DNA sequences
-NEGATIVE    :protein alignment with negative values in matrix
-OUTFILE=    :sequence alignment file name
-OUTPUT=     :GCG, GDE, PHYLIP, PIR or NEXUS
-OUTORDER=   :INPUT or ALIGNED
-CASE        :LOWER or UPPER (for GDE output only)
-SEQNOS=     :OFF or ON (for Clustal output only)
-SEQNO_RANGE=:OFF or ON (NEW: for all output formats)
-RANGE=m,n   :sequence range to write starting m to m+n
-MAXSEQLEN=n :maximum allowed input sequence length
-QUIET       :Reduce console output to minimum
-STATS=      :Log some alignents statistics to file

***Multiple Alignments:***
-NEWTREE=      :file for new guide tree
-USETREE=      :file for old guide tree
-MATRIX=       :Protein weight matrix=BLOSUM, PAM, GONNET, ID or filename
-DNAMATRIX=    :DNA weight matrix=IUB, CLUSTALW or filename
-GAPOPEN=f     :gap opening penalty        
-GAPEXT=f      :gap extension penalty
-ENDGAPS       :no end gap separation pen. 
-GAPDIST=n     :gap separation pen. range
-NOPGAP        :residue-specific gaps off  
-NOHGAP        :hydrophilic gaps off
-HGAPRESIDUES= :list hydrophilic res.    
-MAXDIV=n      :% ident. for delay
-TYPE=         :PROTEIN or DNA
-TRANSWEIGHT=f :transitions weighting
-ITERATION=    :NONE or TREE or ALIGNMENT
-NUMITER=n     :maximum number of iterations to perform
-NOWEIGHTS     :disable sequence weighting
```

{: .warning }
What are the default values of these options?

Another thing to notice:

```
==ITERATION==

 A remove first iteration scheme has been added. This can be used to improve the final
 alignment or improve the alignment at each stage of the progressive alignment. During the 
 iteration step each sequence is removed in turn and realigned. If the resulting alignment 
 is better than the  previous alignment it is kept. This process is repeated until the score
 converges (the  score is not improved) or until the maximum number of iterations is 
 reached. The user can  iterate at each step of the progressive alignment by setting the 
 iteration parameter to  TREE or just on the final alignment by seting the iteration 
 parameter to ALIGNMENT. The default is no iteration. The maximum number of  iterations can 
 be set using the numiter parameter. The default number of iterations is 3.
  
 -ITERATION=    :NONE or TREE or ALIGNMENT
 
 -NUMITER=n     :Maximum number of iterations to perform
```

{: .note }
**Further reading:** Read the ClustalW [documentation](http://www.clustal.org/download/clustalw_help.txt). Is it clear what the algorithm is doing and how to best select the parameters involved? What is missing (if any) from this documentation?


## T-Coffee

[T-Coffee documentation](http://www.tcoffee.org/Projects/tcoffee/documentation/index.html#quick-start-t-coffee)

```shell
$ t_coffee sample_seq1.fasta
```

- When aligning, T-Coffee will always at least generate three files:
  - `sample_seq1.aln` : Multiple Sequence Alignment (ClustalW format by default)
  - `sample_seq1.dnd` : guide tree (Newick format)
  - `sample_seq1.html` : colored MSA according to consistency (html format)
- `T-Coffee` also has a great [documentation](http://www.tcoffee.org/Projects/tcoffee/documentation/index.html#document-tcoffee_main_documentation)
- Specifically, it has a good description of the parameters, see [here](http://www.tcoffee.org/Projects/tcoffee/documentation/index.html#t-coffee-parameters-flags)
- Don't forget to check out [M-Coffee](http://www.tcoffee.org/Projects/tcoffee/documentation/index.html#m-coffee) that combines the output of eight aligners (MUSCLE, ProbCons, POA, DIALIGN-T, MAFFT, ClustalW, PCMA and T-Coffee)


## MUSCLE

- [MUSCLE documentation](https://www.drive5.com/muscle/)
- The different parameter options are explained [here](https://www.drive5.com/muscle/manual/options.html)
- The default settings are chosen for maximum accuracy (how?), but you can change the settings for more speed (see [here](https://www.drive5.com/muscle/manual/index.html))



# In-class exercise

**Instructions:** Run and compare the results of all three MSA software on the toy dataset of primates (see the class repo [data folder](https://github.com/crsl4/phylogenetics-class/tree/master/data)). You can use my reproducible script as guideline: [notebook-log.md](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/notebook-log.md).

**ClustalW**

1. Download [ClustalW](http://www.clustal.org/clustal2/)
2. Download the `primatesAA.fasta` file from the Phylogenetic Handbook website (22 primate aminoacid sequences). The website stopped working at some point, so we have the file in the class repo [data folder](https://github.com/crsl4/phylogenetics-class/tree/master/data).
3. Run `ClustalW`, see [docs](http://www.clustal.org/download/clustalw_help.txt)

**T-Coffee**

1. Download [T-Coffee](http://www.tcoffee.org/Projects/tcoffee/index.html#DOWNLOAD)
2. Run `T-Coffee` on the same `primatesAA.fasta` data. See the [docs](http://www.tcoffee.org/Projects/tcoffee/documentation/index.html#quick-start-t-coffee)

**MUSCLE**

1. Download [MUSCLE](https://www.drive5.com/muscle/downloads.htm)
2. Run `MUSCLE` on the same `primatesAA.fasta` data. See the [docs](https://www.drive5.com/muscle/manual/basic_alignment.html)



{: .highlight }
**Homework:** Check out the alignment HW [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-alignment.md).


# Learn more!

- Read Chapter 3 of the Phylogenetic Handbook (HB)
- Read Sections 9.1-9.5, 9.11, 9.12, 9.13 of [Computational phylogenetics](https://www.amazon.com/Computational-Phylogenetics-Introduction-Designing-Estimation/dp/1107184711) (Warnow) 
- Read HAL 2.3 on a new alignment method `MACSE`