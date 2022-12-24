---
layout: default
title: About
nav_order: 1
---

# Botany/PlantPath 563 

## Phylogenetic Analysis of Molecular Data (UW-Madison)

A course in the theory and practice of phylogenetic inference from DNA sequence data. Students will learn all the necessary components of state-of-the-art phylogenomic analyses and apply the knowledge to the data analyses of their own organisms.

- Spring 2023: Tuesday and Thursday 1:00-2:15pm
- Instructor: Claudia Solis-Lemus, PhD 
    - Email: solislemus@wisc.edu
    - website: https://solislemuslab.github.io/
- Office hours: Tuesday 2:15-3:15pm, or by appointment


## Learning outcomes

By the end of the course, you will be able to

1. Explain in details all the steps in the pipeline for phylogenetic inference and how different data and model choices affect the inference outcomes
2. Plan and produce reproducible scripts with the analysis of your own biological data
3. Justify the data and model choices in your own data analysis
4. Interpret the results of the most widely used phylogenetic methods in biological terms
5. Orally present the results of your own phylogenomic data analyses based on the best scientific and reproducibility practices


## Textbooks and references

- _Phylogenetics in the Genomic Era_ ([open access book](https://hal.inria.fr/PGE/page/table-of-contents)) by Celine Scornavacca, Frederic Delsuc and Nicolas Galtier (denoted HAL in the schedule)
- _Tree thinking: an introduction to phylogenetic biology_ by David Baum and Stacey Smith (optional: denoted Baum in the schedule)
- _The Phylogenetic Handbook_ by Philippe Lemey, Marco Salemi and Anne-Mieke Vandamme (optional: denoted HB in the schedule)
- The full list of papers used in this class can be found in [this link](https://paperpile.com/shared/xs8tDo)



## Schedule 2023

| Session | Topic | Pre-class work | At the end of the session | Lecture notes | Homework | 
| :---:   | :---: | :---:       | :---:                     | :---: | :---: | 
| 01/24 | Introduction |  | You will know what will be the structure of the class, the learning outcomes and the grading | [lecture1](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture1.html) | Go over ready-for-class checklist |
| 01/26 | Reproducibility crash course (Part 1) | Review [shell resources](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/shell-resources.md) and do canvas quiz | You will prioritize reproducibility and good computing practices throughout the semester (and beyond) | [lecture3](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture3.html) | [Learn@Home: Why learning phylogenomics?](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture2.md) (due 01/31) | 
| 01/31 | Reproducibility crash course (Part 2) | Have [git](https://happygitwithr.com/install-git.html) installed | | | [Reproducibility HW](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/git-hw.md) (due 02/07) |
| 01/31 | HW due: Learn@Home Phylogenomics | | | | |
| 02/02 | Alignment (Part 1) |  | You will be able to explain the most widely used algorithms for multiple sequence alignment | [lecture5.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture5.md) | [Learn@Home: Sequencing](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture4.md) (due 02/09) |
| 02/07 | Alignment (Part 2) | | | [lecture5-2.md](https://github.com/crsl4/phylogenetics-class/blob/master/lecture-notes/lecture5-2.md) | [Needleman-Wunsch HW](https://github.com/crsl4/phylogenetics-class/blob/master/lecture-notes/lecture5.md#homework-recap) and canvas quiz (due 02/14) |
| 02/07 | HW due: Reproducibility | | | | |
| 02/09 | Alignment (paper discussion) | One paper assigned per student: 1) [ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/), 2) [MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623), 3) [T-Coffee](https://www.sciencedirect.com/science/article/pii/S0022283600940427) | | [lecture5-3.md](https://github.com/crsl4/phylogenetics-class/blob/master/lecture-notes/lecture5-3.md) | |
| 02/09 | HW due: Learn@Home Sequencing | | | | |
| 02/14 | Alignment (computer lab) | | | | 1) Read [Alignathon paper](https://genome.cshlp.org/content/24/12/2077); 2) Choose and run an alignment method on your data (github commit) (due 02/21) |
| 02/07 | HW due: Needleman-Wunsch | | | | |
| 02/16 | Overview of phylogenetic inference | | You will be able to explain the overall methodology of phylogenetic inference as well as the main weaknesses | [lecture7.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture7.pdf) | [Learn@Home: Orthology and Filtering](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture6.md) (due 02/23) |
| 02/21 | Distance and parsimony methods (Part 1)  | Optional readings: HB Ch 5-6, Baum Ch 7-8 | You will be able to explain both algorithms to reconstruct trees: 1) based on distances and 2) based on parsimony | [lecture8.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture8.md) | | 
| 02/21 | HW due: Alignment | | | | |
| 02/23 | Distance and parsimony methods (Part 2) |  |  |  | | 
| 02/23 | HW due: Learn@Home Orthology and Filtering | | | | |
| 02/28 | Distance and parsimony methods (computer lab) | [Install R](https://cloud.r-project.org/) | | |  Run distance and parsimony methods on your own data (git commit) (due 03/07) |
| 03/02 | Models of evolution (Part 1)  | HAL 1.1 and canvas quiz | You will be able to explain the main characteristics and assumptions of the substitution models | [lecture9.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture9.pdf) | | 
| 03/07 | Models of evolution (Part 2) | | | | | 
| 03/07 | HW due: Distance+Parsimony | | | | |
| 03/09 | Maximum likelihood  | HAL 1.2 and canvas quiz | You will be able to explain the main steps in maximum likelihood inference and the strength/weaknesses of the approach | [lecture10.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture10.pdf) | |
| 03/14 | Spring break
| 03/16 | Spring break
| 03/21 | Maximum likelihood (paper discussion) | Two papers assigned per student: 1) IQ-Tree papers: [one](https://academic.oup.com/mbe/article/37/5/1530/5721363), [two](https://academic.oup.com/mbe/article/32/1/268/2925592); 2) RAxML papers: [one](https://academic.oup.com/bioinformatics/article/35/21/4453/5487384), [two](https://academic.oup.com/bioinformatics/article/30/9/1312/238053) | | [lecture10-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture10-2.md) | [Learn@Home: Model Selection]() (due 03/23) |
| 03/23 | Maximum likelihood (computer lab) | | | | Run ML method to run in your own data (due 03/30)
| 03/23 | HW due: Learn@Home Model Selection | | | | |
| 03/28 | Bayesian inference (Part 1) | HAL 1.4 and canvas quiz | You will be able to explain the main components of Bayesian inference and their effect on the inference performance | [lecture12.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture12.pdf) | |
| 03/30 | Bayesian inference (Part 2) | Read [Nascimento et al, 2017](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5624502/) and quiz | | | Read [YangRannala1997](https://pubmed.ncbi.nlm.nih.gov/9214744/) | 
| 03/30 | HW due: Maximum Likelihood | | | | |
| 04/04 | Bayesian inference (paper discussion) | Read depending on your canvas group: 1) MrBayes papers: [one](https://academic.oup.com/bioinformatics/article/17/8/754/235132), [two](https://academic.oup.com/bioinformatics/article/19/12/1572/257621); 2) [Larget and Simon, 1999](https://academic.oup.com/mbe/article/16/6/750/2925469) | | [lecture12-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture12-2.md) | 
| 04/06 | Bayesian inference (computer lab) | | | | Run MrBayes on your own data (due 04/13) |
| 04/11 | The coalescent  | HAL 3.1 and quiz, HAL 3.3 and quiz | You will be able to explain the coalescent model for species trees and networks | [lecture14.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture14.pdf) | |
| 04/13 | The coalescent (paper discussion) | One paper per student: [ASTRAL](https://arxiv.org/abs/1904.03826) or [BUCKy](https://academic.oup.com/mbe/article/24/2/412/1146040) | | [lecture14-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture14-2.md) | Run ASTRAL or BUCKy on your own data (due 04/25) |
| 04/13 | HW due: Bayesian | | | | |
| 04/18 | The coalescent (networks) | [SNaQ chapter](https://github.com/crsl4/phylogenetics-class/tree/master/assets/snaq.pdf) and quiz | | [lecture14-3.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture14-3.pdf) | |
| 04/20 | Co-estimation methods  | Optional reading: HB 18 | You will be able to explain the main components of co-estimation methods and follow the BEAST tutorial | [lecture15.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture15.md) | |
| 04/25 | Co-estimation methods (paper discussion and computer lab) | Read BEAST papers: [one](https://bmcecolevol.biomedcentral.com/articles/10.1186/1471-2148-7-214), [two](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006650) | | [lecture15-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture15-2.md) | |
| 04/25 | HW due: The coalescent | | | | |
| 04/27 | What else is out there? (Final project Q&A) | Read [Jermiin2020](https://academic.oup.com/nargab/article/2/2/lqaa041/5861483) again | You will hear a brief overview of topics not covered in this class and will have access to resources to learn more | [lecture16.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture16.md) | |
| 05/02 | Project presentations
| 05/04 | Project presentations
| **05/05** | Final project due  | | | |


### More details

See list of topics, grading and academic policies in the [syllabus](https://crsl4.github.io/phylogenetics-class/syllabus.html)
