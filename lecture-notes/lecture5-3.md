---
layout: default
title: Alignment (ClustalW)
nav_order: 5
---

# Alignment methods (ClustalW)

### Previous class check-up
- We studied the algorithms for multiple sequence alignment: Needleman-Wunsch, progresive alignment and improvements

### Learning objectives

At the end of today's session, you will be able to
- highlight the main strengths and weaknesses of ClustalW and how to run it


{: .important-title}
> Pre-class work
>
> Read the paper [ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/).


{: .new-title}
> Stop and check
> 
> **Project checklist:** heavy HW on your data starting now
>
> Until now:
>
>  - Created your project github repo
>  - Added the link to the `class-repos.md` via pull request
>  - Added me as collaborator on your github repo
>  - Data chosen and added 1 slide about it to the shared google slides (link in canvas. Don't wait on your data: you can use public data because you will be creating scripts to use later on the "real" data
>  - Added a description about your data in your `notebook-log.md` (or similar reproducible script) in your github repo and pushed
>  - QC on your data if needed: not perfect/complete, but at least a plan pushed to your github repo
> - Next item: Alignment work pushed to your github repo
>
> **Expectations as we move forward** to heavy HW on your data
>
> You will be working on your data at home:
>  - Troubleshooting with different data formats
>  - Troubleshooting with software installation for your operating system
>
> Actively ask questions!
>  - Slack
>  - Office hours


# Alignment software: Progressive alignment (ClustalW)

1. Compute rooted binary tree (guide tree) from pairwise distances
2. Build MSA from the bottom (leaves) up (root)

<div style="text-align:center"><img src="../assets/pics/fig9.9.png" width="400"/></div>

_Figure 9.9 in Warnow (2018) Computational phylogenetics_


## In-class activity: You are the reviewer (ClustalW)

Total time: 20 minutes

Google slides [here](https://docs.google.com/presentation/d/1wVkJUBkKM7EnA-RyDk77kfTJPC2DOvm2pzdYSfTP7P0/edit?usp=sharing)

**Instructions:** This is a fictional manuscript excerpt:

"Protein sequences were aligned using ClustalW with default parameters. The resulting alignment was used to infer homology and reconstruct phylogenetic relationships among species.”

You are a reviewer for a good journal. Your job is to decide whether this sentence is scientifically defensible based on what the ClustalW paper actually says.

(10 minutes) Split in groups of 3-4 and write one reviewer comment in the slides above that should
1. Refer to a concept, assumption, or design choice described in the ClustalW paper
2. Explain why the sentence above is incomplete, misleading, or potentially wrong
3. Suggest what the authors should clarify, justify, or test

(10 minutes) Whole group discussion

## Software: [ClustalW](http://www.clustal.org/clustal2/)

The easiest way to install ClustalW is with [BioConda](https://bioconda.github.io/):

```
conda install -c bioconda clustalw
```
For some people, it is easier to do the similar installation but with [MiniConda](https://docs.anaconda.com/free/miniconda/). There is also more information on how to download it in the [ClustalW website](http://www.clustal.org/clustal2/)

{: .highlight }
Check you have ClustalW correctly installed by typing `clustalw` in the terminal.

We will use the `primatesAA.fasta` file from the Phylogenetic Handbook [website](https://www.kuleuven.be/aidslab/phylogenybook/Data_sets.html). I had to copy and paste the sequences into a file with the same name. The website stopped working at some point, so we have the file in the class repo [data folder](https://github.com/crsl4/phylogenetics-class/tree/master/data).

We can check how many sequences you have with `grep` (in the `data` folder):
```shell
grep ">" primatesAA.fasta | wc -l ## 22
```

We can now run ClustalW:

```shell
$ clustalw2 -ALIGN -INFILE=primatesAA.fasta -OUTFILE=primatesAA-aligned.fasta -OUTPUT=FASTA

CLUSTAL 2.1 Multiple Sequence Alignments

Sequence format is Pearson
Sequence 1: Human        493 aa
Sequence 2: Chimp        493 aa
Sequence 3: Gorilla      493 aa
Sequence 4: Orangutan    493 aa
Sequence 5: Gibbon       494 aa
Sequence 6: Rhes_cDNA    497 aa
Sequence 7: Baboon       497 aa
Sequence 8: AGM          515 aa
Sequence 9: AGM_cDNA     515 aa
Sequence 10: Tant_cDNA    515 aa
Sequence 11: Patas        495 aa
Sequence 12: Colobus      495 aa
Sequence 13: DLangur      495 aa
Sequence 14: PMarmoset    494 aa
Sequence 15: Tamarin      494 aa
Sequence 16: Squirrel     494 aa
Sequence 17: Owl          494 aa
Sequence 18: Titi         494 aa
Sequence 19: Saki         494 aa
Sequence 20: Howler       551 aa
Sequence 21: Spider       547 aa
Sequence 22: Woolly       547 aa
Start of Pairwise alignments
Aligning...

Sequences (1:2) Aligned. Score:  97
Sequences (1:3) Aligned. Score:  97
Sequences (1:4) Aligned. Score:  93
Sequences (1:5) Aligned. Score:  90
Sequences (1:6) Aligned. Score:  87
Sequences (1:7) Aligned. Score:  87
Sequences (1:8) Aligned. Score:  87
Sequences (1:9) Aligned. Score:  87
Sequences (1:10) Aligned. Score:  87
Sequences (1:11) Aligned. Score:  86
Sequences (1:12) Aligned. Score:  88
Sequences (1:13) Aligned. Score:  88
Sequences (1:14) Aligned. Score:  71
Sequences (1:15) Aligned. Score:  70
Sequences (1:16) Aligned. Score:  68
Sequences (1:17) Aligned. Score:  70
Sequences (1:18) Aligned. Score:  70
Sequences (1:19) Aligned. Score:  71
Sequences (1:20) Aligned. Score:  68
Sequences (1:21) Aligned. Score:  69
Sequences (1:22) Aligned. Score:  69
Sequences (2:3) Aligned. Score:  98
Sequences (2:4) Aligned. Score:  94
Sequences (2:5) Aligned. Score:  90
Sequences (2:6) Aligned. Score:  87
Sequences (2:7) Aligned. Score:  87
Sequences (2:8) Aligned. Score:  86
Sequences (2:9) Aligned. Score:  87
Sequences (2:10) Aligned. Score:  87
Sequences (2:11) Aligned. Score:  87
Sequences (2:12) Aligned. Score:  88
Sequences (2:13) Aligned. Score:  88
Sequences (2:14) Aligned. Score:  70
Sequences (2:15) Aligned. Score:  69
Sequences (2:16) Aligned. Score:  67
Sequences (2:17) Aligned. Score:  70
Sequences (2:18) Aligned. Score:  70
Sequences (2:19) Aligned. Score:  70
Sequences (2:20) Aligned. Score:  69
Sequences (2:21) Aligned. Score:  69
Sequences (2:22) Aligned. Score:  69
Sequences (3:4) Aligned. Score:  94
Sequences (3:5) Aligned. Score:  91
Sequences (3:6) Aligned. Score:  87
Sequences (3:7) Aligned. Score:  88
Sequences (3:8) Aligned. Score:  87
Sequences (3:9) Aligned. Score:  87
Sequences (3:10) Aligned. Score:  87
Sequences (3:11) Aligned. Score:  87
Sequences (3:12) Aligned. Score:  89
Sequences (3:13) Aligned. Score:  88
Sequences (3:14) Aligned. Score:  71
Sequences (3:15) Aligned. Score:  70
Sequences (3:16) Aligned. Score:  68
Sequences (3:17) Aligned. Score:  71
Sequences (3:18) Aligned. Score:  71
Sequences (3:19) Aligned. Score:  72
Sequences (3:20) Aligned. Score:  69
Sequences (3:21) Aligned. Score:  70
Sequences (3:22) Aligned. Score:  70
Sequences (4:5) Aligned. Score:  90
Sequences (4:6) Aligned. Score:  86
Sequences (4:7) Aligned. Score:  86
Sequences (4:8) Aligned. Score:  86
Sequences (4:9) Aligned. Score:  86
Sequences (4:10) Aligned. Score:  86
Sequences (4:11) Aligned. Score:  86
Sequences (4:12) Aligned. Score:  87
Sequences (4:13) Aligned. Score:  87
Sequences (4:14) Aligned. Score:  70
Sequences (4:15) Aligned. Score:  69
Sequences (4:16) Aligned. Score:  67
Sequences (4:17) Aligned. Score:  68
Sequences (4:18) Aligned. Score:  69
Sequences (4:19) Aligned. Score:  69
Sequences (4:20) Aligned. Score:  69
Sequences (4:21) Aligned. Score:  69
Sequences (4:22) Aligned. Score:  69
Sequences (5:6) Aligned. Score:  83
Sequences (5:7) Aligned. Score:  84
Sequences (5:8) Aligned. Score:  83
Sequences (5:9) Aligned. Score:  83
Sequences (5:10) Aligned. Score:  83
Sequences (5:11) Aligned. Score:  83
Sequences (5:12) Aligned. Score:  85
Sequences (5:13) Aligned. Score:  85
Sequences (5:14) Aligned. Score:  69
Sequences (5:15) Aligned. Score:  68
Sequences (5:16) Aligned. Score:  67
Sequences (5:17) Aligned. Score:  68
Sequences (5:18) Aligned. Score:  70
Sequences (5:19) Aligned. Score:  69
Sequences (5:20) Aligned. Score:  67
Sequences (5:21) Aligned. Score:  69
Sequences (5:22) Aligned. Score:  67
Sequences (6:7) Aligned. Score:  97
Sequences (6:8) Aligned. Score:  96
Sequences (6:9) Aligned. Score:  96
Sequences (6:10) Aligned. Score:  96
Sequences (6:11) Aligned. Score:  94
Sequences (6:12) Aligned. Score:  95
Sequences (6:13) Aligned. Score:  95
Sequences (6:14) Aligned. Score:  69
Sequences (6:15) Aligned. Score:  68
Sequences (6:16) Aligned. Score:  66
Sequences (6:17) Aligned. Score:  68
Sequences (6:18) Aligned. Score:  70
Sequences (6:19) Aligned. Score:  70
Sequences (6:20) Aligned. Score:  65
Sequences (6:21) Aligned. Score:  68
Sequences (6:22) Aligned. Score:  68
Sequences (7:8) Aligned. Score:  96
Sequences (7:9) Aligned. Score:  96
Sequences (7:10) Aligned. Score:  96
Sequences (7:11) Aligned. Score:  95
Sequences (7:12) Aligned. Score:  95
Sequences (7:13) Aligned. Score:  95
Sequences (7:14) Aligned. Score:  70
Sequences (7:15) Aligned. Score:  68
Sequences (7:16) Aligned. Score:  67
Sequences (7:17) Aligned. Score:  68
Sequences (7:18) Aligned. Score:  70
Sequences (7:19) Aligned. Score:  71
Sequences (7:20) Aligned. Score:  66
Sequences (7:21) Aligned. Score:  69
Sequences (7:22) Aligned. Score:  69
Sequences (8:9) Aligned. Score:  98
Sequences (8:10) Aligned. Score:  99
Sequences (8:11) Aligned. Score:  94
Sequences (8:12) Aligned. Score:  94
Sequences (8:13) Aligned. Score:  94
Sequences (8:14) Aligned. Score:  70
Sequences (8:15) Aligned. Score:  69
Sequences (8:16) Aligned. Score:  67
Sequences (8:17) Aligned. Score:  68
Sequences (8:18) Aligned. Score:  70
Sequences (8:19) Aligned. Score:  70
Sequences (8:20) Aligned. Score:  65
Sequences (8:21) Aligned. Score:  66
Sequences (8:22) Aligned. Score:  67
Sequences (9:10) Aligned. Score:  98
Sequences (9:11) Aligned. Score:  94
Sequences (9:12) Aligned. Score:  95
Sequences (9:13) Aligned. Score:  95
Sequences (9:14) Aligned. Score:  70
Sequences (9:15) Aligned. Score:  69
Sequences (9:16) Aligned. Score:  67
Sequences (9:17) Aligned. Score:  68
Sequences (9:18) Aligned. Score:  71
Sequences (9:19) Aligned. Score:  71
Sequences (9:20) Aligned. Score:  65
Sequences (9:21) Aligned. Score:  66
Sequences (9:22) Aligned. Score:  67
Sequences (10:11) Aligned. Score:  94
Sequences (10:12) Aligned. Score:  94
Sequences (10:13) Aligned. Score:  94
Sequences (10:14) Aligned. Score:  70
Sequences (10:15) Aligned. Score:  69
Sequences (10:16) Aligned. Score:  67
Sequences (10:17) Aligned. Score:  69
Sequences (10:18) Aligned. Score:  70
Sequences (10:19) Aligned. Score:  71
Sequences (10:20) Aligned. Score:  65
Sequences (10:21) Aligned. Score:  67
Sequences (10:22) Aligned. Score:  67
Sequences (11:12) Aligned. Score:  94
Sequences (11:13) Aligned. Score:  94
Sequences (11:14) Aligned. Score:  69
Sequences (11:15) Aligned. Score:  67
Sequences (11:16) Aligned. Score:  66
Sequences (11:17) Aligned. Score:  68
Sequences (11:18) Aligned. Score:  69
Sequences (11:19) Aligned. Score:  69
Sequences (11:20) Aligned. Score:  66
Sequences (11:21) Aligned. Score:  68
Sequences (11:22) Aligned. Score:  68
Sequences (12:13) Aligned. Score:  98
Sequences (12:14) Aligned. Score:  71
Sequences (12:15) Aligned. Score:  69
Sequences (12:16) Aligned. Score:  67
Sequences (12:17) Aligned. Score:  70
Sequences (12:18) Aligned. Score:  71
Sequences (12:19) Aligned. Score:  72
Sequences (12:20) Aligned. Score:  67
Sequences (12:21) Aligned. Score:  70
Sequences (12:22) Aligned. Score:  70
Sequences (13:14) Aligned. Score:  70
Sequences (13:15) Aligned. Score:  69
Sequences (13:16) Aligned. Score:  67
Sequences (13:17) Aligned. Score:  70
Sequences (13:18) Aligned. Score:  71
Sequences (13:19) Aligned. Score:  71
Sequences (13:20) Aligned. Score:  67
Sequences (13:21) Aligned. Score:  70
Sequences (13:22) Aligned. Score:  70
Sequences (14:15) Aligned. Score:  93
Sequences (14:16) Aligned. Score:  86
Sequences (14:17) Aligned. Score:  88
Sequences (14:18) Aligned. Score:  89
Sequences (14:19) Aligned. Score:  87
Sequences (14:20) Aligned. Score:  83
Sequences (14:21) Aligned. Score:  86
Sequences (14:22) Aligned. Score:  85
Sequences (15:16) Aligned. Score:  84
Sequences (15:17) Aligned. Score:  87
Sequences (15:18) Aligned. Score:  87
Sequences (15:19) Aligned. Score:  87
Sequences (15:20) Aligned. Score:  82
Sequences (15:21) Aligned. Score:  86
Sequences (15:22) Aligned. Score:  85
Sequences (16:17) Aligned. Score:  85
Sequences (16:18) Aligned. Score:  85
Sequences (16:19) Aligned. Score:  84
Sequences (16:20) Aligned. Score:  80
Sequences (16:21) Aligned. Score:  83
Sequences (16:22) Aligned. Score:  82
Sequences (17:18) Aligned. Score:  88
Sequences (17:19) Aligned. Score:  87
Sequences (17:20) Aligned. Score:  84
Sequences (17:21) Aligned. Score:  86
Sequences (17:22) Aligned. Score:  85
Sequences (18:19) Aligned. Score:  92
Sequences (18:20) Aligned. Score:  85
Sequences (18:21) Aligned. Score:  87
Sequences (18:22) Aligned. Score:  87
Sequences (19:20) Aligned. Score:  83
Sequences (19:21) Aligned. Score:  86
Sequences (19:22) Aligned. Score:  85
Sequences (20:21) Aligned. Score:  86
Sequences (20:22) Aligned. Score:  85
Sequences (21:22) Aligned. Score:  92
Guide tree file created:   [primatesAA.dnd]

There are 21 groups
Start of Multiple Alignment

Aligning...
Group 1: Sequences:   2      Score:10695
Group 2: Sequences:   3      Score:10693
Group 3: Sequences:   4      Score:10550
Group 4: Sequences:   5      Score:10317
Group 5: Sequences:   2      Score:11293
Group 6: Sequences:   3      Score:11222
Group 7: Sequences:   2      Score:10814
Group 8: Sequences:   5      Score:10697
Group 9: Sequences:   6      Score:10568
Group 10: Sequences:   2      Score:10784
Group 11: Sequences:   8      Score:10576
Group 12: Sequences:  13      Score:9953
Group 13: Sequences:   2      Score:10473
Group 14: Sequences:   3      Score:10194
Group 15: Sequences:   4      Score:10034
Group 16: Sequences:   2      Score:10399
Group 17: Sequences:   6      Score:10117
Group 18: Sequences:   2      Score:11561
Group 19: Sequences:   3      Score:11013
Group 20: Sequences:   9      Score:9780
Group 21: Sequences:  22      Score:8718
Alignment Score 573733


WARNING: Truncating sequence names to 10 characters for PHYLIP output.


FASTA-Alignment file created   [primatesAA-aligned.fasta]
```

We will check the alignment with [AlignmentViewer](https://alignmentviewer.org/).

What are we looking for?

Reasonable:
- Gaps shared by several sequences
- Long indels occurring in blocks

Red flags:
- Many single-column gaps scattered across taxa
- Long gaps unique to one sequence
- Gaps breaking otherwise conserved regions

Note that we are only using the arguments `-ALIGN`, `-INFILE=primatesAA.fasta`, `-OUTFILE=primatesAA-aligned.fasta` and `-OUTPUT=FASTA`.

We can find all the commands in the [docs](http://www.clustal.org/download/clustalw_help.txt):
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

{: .important-title }
> Further reading
>
> Read the ClustalW [documentation](http://www.clustal.org/download/clustalw_help.txt). Is it clear what the algorithm is doing and how to best select the parameters involved? What is missing (if any) from this documentation?



