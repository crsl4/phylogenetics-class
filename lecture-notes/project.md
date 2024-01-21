---
layout: default
nav_exclude: true
---

# Final Project

## Introduction
- enough background for non-experts to understand the significance of the work
- goal of the project clearly stated

---
class: left, top

## Methods
- data description: where it came from, size, characteristics
- for every step in the pipeline, you include 
    1. name of the software
    2. reference
    3. short description of the method
    4. short description of strengths (why chosen?)
    5. short description of weaknesses/limitations
    6. short description of the main assumptions of the method
    7. user choices (parameters that you had to choose and how)

- Not enough to write: "we used X, Y, and Z"
- Better to write: "We used X (reference) which [short description of the methodology]. We chose X because [short description of strengths]. We know that X has the following limitations [short description of weaknesses] and that it has the main following assumptions [short description of the assumptions]. The software X requires the user to input the following parameters: [parameter/user choices selected]"
- Use the Methods section in [Yi et al (2021)](https://pubmed.ncbi.nlm.nih.gov/33607033/) as a template of how to write the Methods section in your project

---
class: left, top

### Advice

Read the software paper of the software you are citing and create a cheatsheet for yourself with the above items: description, strengths, weaknesses, assumptions, user choices

#### Example: RAxML
- Description: performs maximum likelihood estimation of a phylogenetic tree from aligned sequences
- Strengths: accurate estimation and statistically consistent
- Weaknesses: not scalable for large datasets and potential model misspecification error
- Assumptions: the substitution model and other model choices are correct and the optimization algorithm has converged to the maximum
- User choices: User needs to specify the substitution model and other model characteristics (e.g. rate variation); user can select starting tree but if it is not selected by the user, RAxML choose 5 starting trees based on parsimony


---
class: left, top

## Class dynamic: Project Q&A

Options:
- Stay in the class for questions
- Log off and use the time to work on your project

Before leaving, please fill out a checkup poll!