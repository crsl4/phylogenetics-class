---
layout: default
title: About
nav_order: 1
---

# Botany/PlantPath 563 

## Phylogenetic Analysis of Molecular Data (UW-Madison)

A course in the theory and practice of phylogenetic inference from DNA sequence data. Students will learn all the necessary components of state-of-the-art phylogenomic analyses and apply the knowledge to the data analyses of their own organisms.

- Spring 2025: Tuesday and Thursday 1:00-2:15pm
- Instructor: Claudia Solis-Lemus, PhD 
    - Email: solislemus@wisc.edu
    - Website: [https://solislemuslab.github.io/](https://solislemuslab.github.io/)
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



## Schedule 2025

| Session | Topic | Pre-class work | At the end of the session | Lecture notes | Homework | 
| :---:   | :---: | :---:       | :---:                     | :---: | :---: | 
| 01/21 | Introduction |  | You will know what will be the structure of the class, the learning outcomes and the grading | [lecture1](https://github.com/crsl4/phylogenetics-class/blob/master/lecture-notes/lecture1.md) | Go over ready-for-class checklist |
| 01/23 | Reproducibility crash course (Part 1) | Review [shell resources](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/hw-shell.md) and do canvas quiz | You will prioritize reproducibility and good computing practices throughout the semester (and beyond) | [lecture3](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture3.html) | [Learn@Home: Why learn phylogenomics?](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture2-learn-home.md) (due 01/28) | 
| 01/28 | Reproducibility crash course (Part 2) | Have [git](https://happygitwithr.com/install-git.html) installed | | | [Reproducibility HW](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/hw-git.md) (due 02/04) |
| 01/28 | HW due: [Learn@Home: Why learn phylogenomics?](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture2-learn-home.md) | | | | |
| 01/30 | Alignment (Part 1) |  | You will be able to explain the most widely used algorithms for multiple sequence alignment | [lecture5](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture5.html) | [Learn@Home: Sequencing](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture4-learn-home.md) (due 02/06) |
| 02/04 | Alignment (Part 2) | | | [lecture5-2](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture5-2.html) | [Needleman-Wunsch HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-needleman.md) and canvas quiz (due 02/11) |
| 02/04 | HW due: [Reproducibility](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/hw-git.md) | | | | |
| 02/06 | Alignment (paper discussion) | One paper assigned per student: 1) [ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/), 2) [MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623), 3) [T-Coffee](https://www.sciencedirect.com/science/article/pii/S0022283600940427) | | [lecture5-3](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture5-3.html) | |
| 02/06 | HW due: [Learn@Home: Sequencing](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture4-learn-home.md) | | | | |
| 02/11 | Alignment (computer lab) | | | [lecture5-4](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture5-4.html) | [Alignment HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-alignment.md) (due 02/18) |
| 02/11 | HW due: [Needleman-Wunsch HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-needleman.md) | | | | |
| 02/13 | Overview of phylogenetic inference | | You will be able to explain the overall methodology of phylogenetic inference as well as the main weaknesses | [lecture7](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture7.html) | [Learn@Home: Orthology and Filtering](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture6-learn-home.md) (due 02/20) |
| 02/18 | Distance and parsimony methods (Part 1)  | Optional readings: HB Ch 5-6, Baum Ch 7-8 | You will be able to explain both algorithms to reconstruct trees: 1) based on distances and 2) based on parsimony | [lecture8](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture8.html) | | 
| 02/18 | HW due: [Alignment HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-alignment.md) | | | | |
| 02/20 | Distance and parsimony methods (Part 2) |  |  | [lecture8-2](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture8-2.html) | | 
| 02/20 | HW due: [Learn@Home: Orthology and Filtering](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture6-learn-home.md) | | | | |
| 02/25 | Distance and parsimony methods (computer lab) | [Install R](https://cloud.r-project.org/) | | [lecture8-3](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture8-3.html) |  [Distance and Parsimony HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-dist.md) (due 03/04) |
| 02/27 | Models of evolution (Part 1)  | HAL 1.1 and canvas quiz | You will be able to explain the main characteristics and assumptions of the substitution models | [lecture9](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture9.html) | | 
| 03/04 | Models of evolution (Part 2) | | | | | 
| 03/04 | HW due: [Distance and Parsimony HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-dist.md) | | | | |
| 03/06 | Maximum likelihood  | HAL 1.2 and canvas quiz | You will be able to explain the main steps in maximum likelihood inference and the strength/weaknesses of the approach | [lecture10](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture10.html) | |
| 03/11 | Maximum likelihood (paper discussion) | Two papers assigned per student: 1) IQ-Tree papers: [one](https://academic.oup.com/mbe/article/37/5/1530/5721363), [two](https://academic.oup.com/mbe/article/32/1/268/2925592); 2) RAxML papers: [one](https://academic.oup.com/bioinformatics/article/35/21/4453/5487384), [two](https://academic.oup.com/bioinformatics/article/30/9/1312/238053) | | [lecture10-2](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture10-2.html) | [Learn@Home: Model Selection](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture13-learn-home.md) (due 03/13) |
| 03/13 | Maximum likelihood (computer lab) | | | [lecture10-3](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture10-3.html) | [Maximum Likelihood HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-ml.md) (due 03/20)
| 03/13 | HW due: [Learn@Home: Model Selection](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture13-learn-home.md) | | | | |
| 03/18 | Bayesian inference (Part 1) | HAL 1.4 and canvas quiz | You will be able to explain the main components of Bayesian inference and their effect on the inference performance | [lecture12](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture12.html) | |
| 03/20 | Bayesian inference (Part 2) | Read [Nascimento et al, 2017](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5624502/) and quiz | | | Read [YangRannala1997](https://pubmed.ncbi.nlm.nih.gov/9214744/) | 
| 03/20 | HW due: [Maximum Likelihood HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-ml.md) | | | | |
| 03/25 | Spring break
| 03/27 | Spring break
| 04/01 | Bayesian inference (paper discussion) | Read depending on your canvas group: 1) MrBayes papers: [one](https://academic.oup.com/bioinformatics/article/17/8/754/235132), [two](https://academic.oup.com/bioinformatics/article/19/12/1572/257621); 2) [RevBayes](https://academic.oup.com/sysbio/article/65/4/726/1753608) | | [lecture12-2](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture12-2.html) | 
| 04/03 | Bayesian inference (computer lab) | | | [lecture12-3](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture12-3.html) | [Bayesian Inference HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-bayesian.md) (due 04/10) |
| 04/08 | The coalescent  | HAL 3.1 and quiz, HAL 3.3 and quiz | You will be able to explain the coalescent model for species trees and networks | [lecture14](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture14.html) | |
| 04/10 | The coalescent (computer lab) | Read [ASTRAL](https://arxiv.org/abs/1904.03826) and [BUCKy](https://academic.oup.com/mbe/article/24/2/412/1146040) | | [lecture14-2.md](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture14-2.html) | [Coalescent HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-coalescent.md) (due 04/22) |
| 04/10 | HW due: [Bayesian Inference HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-bayesian.md) | | | | |
| 04/15 | The coalescent (networks) | [SNaQ chapter](https://github.com/crsl4/phylogenetics-class/tree/master/assets/snaq.pdf) and quiz | | [lecture14-3](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture14-3.html) | |
| 04/17 | Co-estimation methods  | Optional reading: HB 18 | You will be able to explain the main components of co-estimation methods and follow the BEAST tutorial | [lecture15](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture15.html) | |
| 04/22 | Co-estimation methods (computer lab) | Optional: Read BEAST papers: [one](https://bmcecolevol.biomedcentral.com/articles/10.1186/1471-2148-7-214), [two](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006650) | | [lecture15-2](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture15-2.html) | |
| 04/22 | HW due: [Coalescent HW](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-coalescent.md) | | | | |
| 04/24 | What else is out there? (Final project Q&A) | Read [Jermiin2020](https://academic.oup.com/nargab/article/2/2/lqaa041/5861483) again | You will hear a brief overview of topics not covered in this class and will have access to resources to learn more | [lecture16](https://crsl4.github.io/phylogenetics-class/lecture-notes/lecture16.html) | |
| 04/29 | Project presentations
| 05/01 | Project presentations
| 05/05 | Final project+reproducible script due  | | | |


### More details

See list of topics, grading and academic policies in the [syllabus](https://crsl4.github.io/phylogenetics-class/syllabus.html)
