---
title: "Lecture 16"
author: "Botany 563"
subtitle: "Other topics in phylogenomics"
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

### [HAL 2.1] To What Extent Current Limits of Phylogenomics Can Be Overcome?

#### Concept flowchart

<div style="text-align:center"><img src="../assets/slides/lecture2/lecture2.001.jpeg" width="650"/></div>
---
class: left, top

## Phylogenomic pipeline (HAL 2.1)

<div style="text-align:center"><img src="../assets/pics/hal2.1-fig2.png" width="650"/></div>

---
class: left, top

## What do we know now?

- Motivation: phylogenomics pipeline: 
    - Reading: HAL 2.1

- Intro Illumina, quality control, assembly, alignment, filtering: 
    - Reading: Zhang 2019 UCE
    - Software: [phyluce](https://phyluce.readthedocs.io/en/latest/purpose.html)

- Alignment
    - Reading: HAL 2.2
    - Software: T-coffee, Clustal, Muscle: HB ch 3

- Orthology detection
    - Reading: HAL 2.4, Tekaia 2016, Habermann 2016
    - Software: [OrthoFinder](https://github.com/davidemms/OrthoFinder): HAL 2.4

- Overview of phylogenetic inference: criteria score, search in tree space

---
class: left, top

## What do we know now?

- Gene tree estimation
    1. Distance methods
        - Reading (supplemental): HB Ch 5, Baum Ch 8
        - Software: R packages ape, phangorn
    2. Parsimony methods
        - Reading (supplemental): HB Ch 8, Baum Ch 7
        - Software: R packages ape, phangorn
    3. Models of evolution
        - Reading: HAL 1.1
    4. Maximum likelihood
        - Reading: HAL 1.2
        - Software: RAxML (HAL 1.3) and [IQ-Tree](http://www.iqtree.org/workshop/molevol2019)
    5. Bayesian
        - Reading: HAL 1.4
        - Software: PhyloBayes HAL 1.5 and MrBayes HB Ch 7
    6. Model selection (invited guest: Rob Lanfear)


---
class: left, top

## What do we know now?

- Species tree/network estimation: the coalescent model
    - Reading: HAL 3.1, 3.3
    - Software: PhyloNetworks wiki pipeline (MDL, RAxML, MrBayes, BUCKy, ASTRAL, SNaQ)

- Co-estimation methods
    - Taming the BEAST [slides](https://github.com/Taming-the-BEAST/Taming-the-BEAST-2019-Eh-Lectures)

---
class: left, top

## What do we know now?


- Discussion topics:
    1. Measures of support
        - TICR
        - TBE: Lemoine 2018
        - aLRT: Anisimova 2006
        - local PP: Sayyari 2016
    2. Concatenation vs coalescence
        - Reading: HAL 3.4
        - Papers
            - Pro concatenation: Springer 2016, 2018
            - Pro coalescent: Edwards 2016
            - Concatenation+likelihood worse than concatenation+parsimony: Mendes 2018
            - Importance of data quality: Philippe 2017
    3. Phylogenomics in big data
        - Papers
            - Data heterogeneity: Bravo 2019
            - Discordant genes: Shen 2017
            - Phylogenomics pipeline: Young 2020
            - Parsimony vs likelihood: Steel 200


---
class: left, top

## Main conclusions

- Phylogenomics is hard
- Importance of data quality and phylogenetic signal
- Importance of clear description of methods used, assumptions and limitations
  - Make sure that you know (in general) what the method you are using does
- Importance of model selection and model fit
- Importance of measures of confidence
  - No desperate quest for 100 bootstrap support values!
- Importance of reproducibility
  - Every choice matters, so keep good track of the choices


---
class: left, top

## What else is out there?

- Dating
    - Reading: HAL 5.1
    - Supplemental reading: HB Ch 11
    - Bayesian dating: [Bromham 2017](https://onlinelibrary.wiley.com/doi/full/10.1111/brv.12390)
    - Software
        - RevBayes
            - HAL 5.2 
            - [Workshop](https://revbayes.github.io/workshops/online2020.html)
            - [Tutorial](https://revbayes.github.io/tutorials/fbd_simple/)
        - [DivTime](https://github.com/mariodosreis/divtime)
        - [BEAST](https://taming-the-beast.org/tutorials/)

- Reconciliation 
    - Reading: HAL 3.2

---
class: left, top

## What else is out there?

- Species delimitation
    - Reading: HAL 5.5
    - Software:
        - BPP: HAL 5.6
        - iBPP (morphology and genes): https://github.com/cecileane/iBPP

- SNP methods
  - [SVDquartets](http://www.phylosolutions.com/tutorials/ssb2018/svdquartets-tutorial.html)
  - SNAPP
  - [SNAPPnet](http://charles-elie.rabier.pagesperso-orange.fr/doc/SnapNetFiles/tutoSnappNet.pdf)
  - PhyloNet
  
---
class: left, top

## Final housekeeping

- Project deadline tomorrow: April 30
  - Final project
  - Reproducible script
  
- Class checkup poll

- Class feedback form

- Advice for future students: [slides](https://docs.google.com/presentation/d/1uBI-k4m0QDKSib70yAzawDMtbqxB4IC0EopSiYn_I2g/edit?usp=sharing)