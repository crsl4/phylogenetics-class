# Botany 563 Phylogenetic Analysis of Molecular Data (UW-Madison)

A course in the theory and practice of phylogenetic inference from DNA sequence data. Students will learn all the necessary components of state-of-the-art phylogenomic analyses and apply the knowledge to the data analyses of their own organisms.

- Spring 2022: Wednesday and Friday 2:30-3:45pm (Russell A228)
- Instructor: Claudia Solis-Lemus, PhD 
    - Email: solislemus@wisc.edu
    - website: https://solislemuslab.github.io/
- Office hours: Wednesday 3:45-4:30pm, or by appointment


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



## Schedule 2022

| Session | Topic | Pre-class work | At the end of the session | Lecture notes | Homework | HW due |
| :---:   | :---: | :---:       | :---:                     | :---: | :---: | :---: |
| 01/26 | Introduction |  | You will know what will be the structure of the class, the learning outcomes and the grading | [lecture1.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture1.md) | Go over ready-for-class checklist |  |
| 01/28 | Motivation: why learning phylogenomics? | Read HAL 2.1 | You will identify the different components in phylogenomic analyses | [lecture2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture2.md) | Read HAL 2.1 and do canvas quiz and read [Jermiin2020](https://academic.oup.com/nargab/article/2/2/lqaa041/5861483) | 01/28 |
| 02/02 | Reproducibility crash course | Review [shell resources](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/shell-resources.md) and do canvas quiz | You will prioritize reproducibility and good computing practices throughout the semester (and beyond) | [lecture3.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture3.md) | | 
| 02/04 | Continue with reproducibility | Have [git](https://happygitwithr.com/install-git.html) installed | | | [Reproducibility HW](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/git-hw.md) | 02/09 |
| 02/09 | Introduction to sequences | Watch [video1](https://www.youtube.com/watch?v=CZeN-IgjYCo), [video2](https://www.youtube.com/watch?v=fCd6B5HRaZ8), and do canvas quiz | You will be able to describe the next-generation sequencing pipeline (and UCE pipeline) as well as the post-processing bioinformatics steps for quality control | [lecture4.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture4.md) | [Sequencing HW](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/seq-hw.md) | 02/18 |
| 02/11 | Alignment  |  | You will be able to explain the most widely used algorithms for multiple sequence alignment | [lecture5.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture5.md) | [Needleman-Wunsch HW](https://github.com/crsl4/phylogenetics-class/blob/master/lecture-notes/lecture5.md#homework-recap) and canvas quiz | 02/23 |
| 02/16 | Continue with alignment | | | [lecture5-2.md](https://github.com/crsl4/phylogenetics-class/blob/master/lecture-notes/lecture5-2.md) | 1) Read [Alignathon paper](https://genome.cshlp.org/content/24/12/2077); 2) Choose and run an alignment method on your data (github commit) | 03/02 |
| 02/18 | Continue with alignment | One paper assigned per student: 1) [ClustalW](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC308517/), 2) [MUSCLE](https://academic.oup.com/nar/article/32/5/1792/2380623), 3) [T-Coffee](https://www.sciencedirect.com/science/article/pii/S0022283600940427) | | [lecture5-3.md](https://github.com/crsl4/phylogenetics-class/blob/master/lecture-notes/lecture5-3.md) | | |
| 02/23 | Filtering and Orthology detection  | Optional HAL 2.2, 2.4; Make sure to add info on your data in [the slides](https://docs.google.com/presentation/d/1UW6P5wVKcDLwVLoshnJ2ilTbrsUEPFoH1MTXppQcpAc/edit?usp=sharing) | You will know about the different filtering and orthology inference methods | [lecture6.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture6.md) | 1) Read [Nichio2017](https://www.frontiersin.org/articles/10.3389/fgene.2017.00165/full); 2) Choose one orthology detection method, read its paper and add one slide about it in the [class google slides](https://docs.google.com/presentation/d/1iZVRWdLQ2wrdACiF06LhFKDVqe1H8WLMNwgsunofjy4/edit?usp=sharing) | 03/09 |
| 02/25 | Overview of phylogenetic inference | | You will be able to explain the overall methodology of phylogenetic inference as well as the main weaknesses | [lecture7.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture7.pdf) | | |
| 03/02 | Distance and parsimony methods  | [Install R](https://cloud.r-project.org/) and optional readings: HB Ch 5-6, Baum Ch 7-8 | You will be able to explain both algorithms to reconstruct trees: 1) based on distances and 2) based on parsimony | [lecture8.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture8.md) | | 
| 03/04 | Continue with distance and parsimony methods | | | | Run distance and parsimony methods on your own data (git commit) | 03/23 |
| 03/09 | Models of evolution  | HAL 1.1 and canvas quiz | You will be able to explain the main characteristics and assumptions of the substitution models | [lecture9.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture9.pdf) | | 
| 03/11 | Continue with models of evolution | Make sure to add info on your orthology method in [the slides](https://docs.google.com/presentation/d/1iZVRWdLQ2wrdACiF06LhFKDVqe1H8WLMNwgsunofjy4/edit?usp=sharing) | | | | 
| 03/16 | Spring break
| 03/18 | Spring break
| 03/23 | Maximum likelihood  | HAL 1.2 and canvas quiz | You will be able to explain the main steps in maximum likelihood inference and the strength/weaknesses of the approach | [lecture10.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture10.pdf) | |
| 03/25 | Continue maximum likelihood | Two papers assigned per student: 1) IQ-Tree papers: [one](https://academic.oup.com/mbe/article/37/5/1530/5721363), [two](https://academic.oup.com/mbe/article/32/1/268/2925592); 2) RAxML papers: [one](https://academic.oup.com/bioinformatics/article/35/21/4453/5487384), [two](https://academic.oup.com/bioinformatics/article/30/9/1312/238053) | | [lecture10-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture10-2.md) | Choose a ML method to run in your own data | 04/08 |
| 03/30 | Bayesian inference  | HAL 1.4 and canvas quiz | You will be able to explain the main components of Bayesian inference and their effect on the inference performance | [lecture12.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture12.pdf) | |
| 04/01 | Continue Bayesian inference | Read [Nascimento et al, 2017](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5624502/) and quiz | | | Read [YangRannala1997](https://pubmed.ncbi.nlm.nih.gov/9214744/) | 
| 04/06 | Continue Bayesian inference | Read depending on your canvas group: 1) MrBayes papers: [one](https://academic.oup.com/bioinformatics/article/17/8/754/235132), [two](https://academic.oup.com/bioinformatics/article/19/12/1572/257621); 2) [Larget and Simon, 1999](https://academic.oup.com/mbe/article/16/6/750/2925469) | | [lecture12-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture12-2.md) | Run MrBayes on your own data | 04/20 |
| 04/08 | The coalescent  | HAL 3.1 and quiz, HAL 3.3 and quiz | You will be able to explain the coalescent model for species trees and networks | [lecture14.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture14.pdf) | |
| 04/13 | Continue with the coalescent  | One paper per student: [ASTRAL](https://arxiv.org/abs/1904.03826) or [BUCKy](https://academic.oup.com/mbe/article/24/2/412/1146040) | | [lecture14-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture14-2.md) | Run ASTRAL or BUCKy on your own data | 04/29 |
| 04/15 | Continue with the coalescent | [SNaQ chapter](https://github.com/crsl4/phylogenetics-class/tree/master/assets/snaq.pdf) and quiz | | [lecture14-3.pdf](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture14-3.pdf) | |
| 04/20 | Co-estimation methods  | Optional reading: HB 18 | You will be able to explain the main components of co-estimation methods and follow the BEAST tutorial | [lecture15.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture15.md) | |
| 04/22 | Continue with co-estimation methods | Read BEAST papers: [one](https://bmcecolevol.biomedcentral.com/articles/10.1186/1471-2148-7-214), [two](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006650) | | [lecture15-2.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture15-2.md) | |
| 04/27 | Discussion: Measures of support  | One per group: 1) [Stenz2015](https://pubmed.ncbi.nlm.nih.gov/26117705/), 2) [Lemoine2018](https://www.nature.com/articles/s41586-018-0043-0), 3) [Anisimova2006](https://academic.oup.com/sysbio/article/55/4/539/1675125), 4) [Sayyari2016](https://academic.oup.com/mbe/article/33/7/1654/2579300) | You will be able to compare and contrast the different ways in which we can measure confidence in our phylogenetic estimates | [Slides](https://docs.google.com/presentation/d/1lcXMLinZDSTG6CxCeCnKEzaFq8QOyoGDS27l-wjqggw/edit?usp=sharing) |
| 04/29 | Discussion: Coalescent vs concatenation  | All: HAL 3.4. One per group: 1) [Springer2018](https://www.mdpi.com/2073-4425/9/3/123), 2) [Mendes2018](https://academic.oup.com/sysbio/article/67/1/158/3953674), 3) [Philippe2017](https://europeanjournaloftaxonomy.eu/index.php/ejt/article/view/407), 4) [Springer2016](https://www.sciencedirect.com/science/article/pii/S1055790315002225?via%3Dihub), 5) [Edwards2016](https://www.sciencedirect.com/science/article/pii/S1055790315003309?via%3Dihub) | You will be able to justify the choice of concatenation vs coalescent in specific scenarios | [Slides](https://docs.google.com/presentation/d/1mOfJuLAi_ZLjghKvq6_BOjcGk5yefxPVsjuONzfAj5Y/edit?usp=sharing) |
| 05/04 | Discussion: Phylogenomics pitfalls  | One per group: 1) [Bravo2019](https://peerj.com/articles/6399/), 2) [Shen2017](https://www.nature.com/articles/s41559-017-0126), 3) [Young2020](https://onlinelibrary.wiley.com/doi/full/10.1111/syen.12406), 4) [Steel2005](https://www.sciencedirect.com/science/article/pii/S0168952505000946?via%3Dihub) | You will be able to describe and analyze some of the main pitfalls of phylogenomic analysis of big data | [Slides](https://docs.google.com/presentation/d/1YyqoYxsrMrq4ifMM3t-Qh6aQVe6qrd7BolCjzB2pnPU/edit?usp=sharing) |
| 05/06 | What else is out there? | Read [Jermiin2020](https://academic.oup.com/nargab/article/2/2/lqaa041/5861483) again | You will hear a brief overview of topics not covered in this class and will have access to resources to learn more | [lecture16.md](https://github.com/crsl4/phylogenetics-class/tree/master/lecture-notes/lecture16.md) | |
| **05/09** | Final project due  | | | |
| 05/11 | Project presentations  | | | |
| 05/13 | Project presentations  | | | |


### More details

See list of topics, grading and academic policies in the [syllabus](https://github.com/crsl4/phylogenetics-class/blob/master/syllabus.md)
