---
layout: default
nav_exclude: true
---

# Sequencing HW

## Choosing your data and performing QC if necessary

**Objective:** Select the data that you will use for the rest of the semester and begin with QC steps.

**Instructions:**

1. Identify which dataset you will use for the rest of the semester: This data can be related to your research or it can be a public dataset considering the following characteristics:
    - The data must have 10-100 taxa (for the sake of computational running time). If you want to use a data with more taxa, please come talk to me first
    - The data should have more than one locus/gene/marker to perform multilocus analyses
    - Genes or loci should be orthologs and single copies
    - The data can be alignments that have undergone QC already. You do not need to start with raw reads necessarily, but if you are using clean alignments, make sure that you know what software was used to align them
2. Create your reproducible notebook (preferably md format, for example [`notebook-log.md`](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/notebook-log.md))
3. Add a short description of your dataset to your notebook and add one slide describing your dataset to share with the class in the [class google slides](https://docs.google.com/presentation/d/14rwavNB3waBzd01EQQm_aFR1i82ny7IcjstGWeTmqIA/edit?usp=sharing)
4. Identify the stage of your dataset
    - Do you have raw reads? Perform the quality control steps with FastQC
    - Do you have UCEs? Use `phyluce` for quality control, assembly and mapping
    - Feel free to use other QC software if you include a description of what they do
5. Make sure to record all steps taken with the data in your reproducible notebook and push the most updated version to github
6. Submit the link to your commit in canvas (see deadline in canvas)
