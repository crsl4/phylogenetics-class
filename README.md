# Botany 563 Phylogenetic Analysis of Molecular Data (UW-Madison)

A course in the theory and practice of phylogenetic inference from DNA sequence data. Students will learn all the necessary components of state-of-the-art phylogenomic analyses and apply the knowledge to the data analyses of their own organisms.

- Spring 2021: Tuesday and Thursday 1:00-2:15pm (online via Zoom)
- Instructor: Claudia Solis-Lemus, PhD 
    - Email: solislemus@wisc.edu
    - website: https://solislemuslab.github.io/
- Office hours: Tuesday 2:30-3:30pm, or by appointment


## Learning outcomes

By the end of the course, you will be able to

1. Explain in details all the steps in the pipeline for phylogenetic inference and how different data and model choices affect the inference outcomes
2. Plan and produce reproducible scripts with the analysis of your own biological data
3. Justify the data and model choices in your own data analysis
4. Interpret the results of the most widely used phylogenetic methods in biological terms
5. Orally present the results of your own phylogenomic data analyses based on the best scientific and reproducibility practices


## Textbooks

- _Phylogenetics in the Genomic Era_ ([open access book](https://hal.inria.fr/PGE/page/table-of-contents)) by Celine Scornavacca, Frederic Delsuc and Nicolas Galtier (denoted HAL in the schedule)
- _Tree thinking: an introduction to phylogenetic biology_ by David Baum and Stacey Smith (optional: denoted Baum in the schedule)
- _The Phylogenetic Handbook_ by Philippe Lemey, Marco Salemi and Anne-Mieke Vandamme (optional: denoted HB in the schedule)


## Schedule

| Session | Topic | Reading before class | At the end of the session | Notes |
| :---:   | :---: | :---:       | :---:                     | :---: |
| 01/26 | Introduction | [Syllabus](https://github.com/crsl4/phylogenetics-class/blob/master/syllabus.md) | You will know what will be the structure of the class, the learning outcomes and the grading | [lecture1.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture1.md) | 
| 01/28 | Motivation: why learning phylogenomics? | HAL 2.1 | You will identify the different components in phylogenomic analyses | [lecture2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture2.md) |
| 02/02 | Reproducibility crash course | [Notes on mindful programming](https://github.com/crsl4/mindful-programming/blob/master/lecture.md) | You will prioritize reproducibility and good computing practices throughout the semester (and beyond) | [lecture3.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture3.md) |
| 02/04 | Continue with reproducibility | Have [git](https://happygitwithr.com/install-git.html) installed | | |
| 02/09 | Introduction to sequences | Watch [video1](https://www.youtube.com/watch?v=CZeN-IgjYCo), [video2](https://www.youtube.com/watch?v=fCd6B5HRaZ8), and read [Zhang et al, 2019](https://academic.oup.com/isd/article/3/5/3/5573097) | You will be able to describe the next-generation sequencing pipeline (and UCE pipeline) as well as the post-processing bioinformatics steps for quality control | [lecture4.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture4.md) |
| 02/11 | Alignment  | HAL 2.2 | You will be able to explain the most widely used algorithms for multiple sequence alignment | [lecture5.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture5.md) |
| 02/16 | Continue with alignment | | | |
| 02/18 | Continue with alignment | | | |
| 02/23 | Orthology detection  | HAL 2.4 and the [OrthoFinder paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0721-2) | You will know about the different orthology inference methods and will be able to explain the OrthoFinder algorithm | [lecture6.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture6.md) |
| 02/25 | Overview of phylogenetic inference | | You will be able to explain the overall methodology of phylogenetic inference as well as the main weaknesses | [lecture7.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture7.pdf) |
| 03/02 | Distance and parsimony methods  | [Install R](https://cloud.r-project.org/) and optional readings: HB Ch 5-6, Baum Ch 7-8 | You will be able to explain both algorithms to reconstruct trees: 1) based on distances and 2) based on parsimony | [lecture8.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture8.md) |
| 03/04 | Continue with distance and parsimony methods | | | |
| 03/09 | Models of evolution  | HAL 1.1 | You will be able to explain the main characteristics and assumptions of the substitution models | [lecture9.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture9.pdf) | 
| 03/11 | Continue with models of evolution | | | |
| 03/16 | Maximum likelihood  | HAL 1.2 and optional: install RAxML-NG (HAL 1.3) or [IQ-Tree](http://www.iqtree.org/workshop/molevol2019) | You will be able to explain the main steps in maximum likelihood inference and the strength/weaknesses of the approach | [lecture10.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture10.pdf) |
| 03/18 | Comparison of distances, parsimony and likelihood | Investigate the pros/cons of the method of your team | You will be able to assess the strenghts and weaknesses of distances, parsimony and likelihood methods in phylogenetic inference | [lecture11.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture11.md) |
| 03/23 | Bayesian inference  | | | |
| 03/25 | Model selection  | | | |
| 03/30 
| 04/01 | The coalescent  | | | |
| 04/06 | (1-min presentation of students' project data/goal) | Create a slide describing your data [here](https://docs.google.com/presentation/d/1-DRevm_ntBOD6F5PMnQkzbMuhSiJMjjaBiD8FvUhfY4/edit?usp=sharing) | | |
| 04/08 | 
| **04/09** | Deadline: Draft of final report  | | | |
| 04/13 | Co-estimation methods  | | | |
| 04/15
| **04/16** | Deadline: Peer evaluation of another student's report  | | | |
| 04/20
| 04/22 | Discussion: Measures of support  | One per group: 1) [Stenz2015](https://pubmed.ncbi.nlm.nih.gov/26117705/), 2) [Lemoine2018](https://www.nature.com/articles/s41586-018-0043-0), 3) [Anisimova2006](https://academic.oup.com/sysbio/article/55/4/539/1675125), 4) [Sayyari2016](https://academic.oup.com/mbe/article/33/7/1654/2579300) | You will be able to compare and contrast the different ways in which we can measure confidence in our phylogenetic estimates | [Slides](https://docs.google.com/presentation/d/1yXLxhtNP3m0uVIRGR5du3nrhfxnY4FRvGUvgMTSZ3Y8/edit?usp=sharing) |
| 04/27 | Discussion: Coalescent vs concatenation  | All: HAL 3.4. One per group: 1) [Springer2018](https://www.mdpi.com/2073-4425/9/3/123), 2) [Mendes2018](https://academic.oup.com/sysbio/article/67/1/158/3953674), 3) [Philippe2017](https://europeanjournaloftaxonomy.eu/index.php/ejt/article/view/407), 4) [Springer2016](https://www.sciencedirect.com/science/article/pii/S1055790315002225?via%3Dihub), 5) [Edwards2016](https://www.sciencedirect.com/science/article/pii/S1055790315003309?via%3Dihub) | You will be able to justify the choice of concatenation vs coalescent in specific scenarios | [Slides](https://docs.google.com/presentation/d/1eKHNe_YLcEqyta5MZerCo2DgzbaYfhRmoupjX_CGXaA/edit?usp=sharing) |
| 04/29 | Discussion: Phylogenomics pitfalls  | One per group: 1) [Bravo2019](https://peerj.com/articles/6399/), 2) [Shen2017](https://www.nature.com/articles/s41559-017-0126), 3) [Young2020](https://onlinelibrary.wiley.com/doi/full/10.1111/syen.12406), 4) [Steel2005](https://www.sciencedirect.com/science/article/pii/S0168952505000946?via%3Dihub) | You will be able to describe and analyze some of the main pitfalls of phylogenomic analysis of big data | [Slides](https://docs.google.com/presentation/d/1W_LJU7AFqm4D-fz-bIOV88XXftFQNLu1SAhrVvv9J94/edit?usp=sharing) |
| **04/30** | Deadline: Final report with reproducible script  | | | |
| 05/04 | Project presentations  | | | |
| 05/06 | Project presentations  | | | |


### More details

See list of topics, grading and academic policies in the [syllabus](https://github.com/crsl4/phylogenetics-class/blob/master/syllabus.md)