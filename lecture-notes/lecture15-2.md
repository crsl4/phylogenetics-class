---
layout: default
title: Co-estimation II
nav_order: 22
---

### Previous class check-up
- We studied the co-estimation method in BEAST

### Learning objectives

At the end of today's session, you will be able to
- explain in details the BEAST inference methods
- use BEAST software


### Pre-class work

- Read the papers corresponding to your group (in canvas):
  - BEAST 1: [Drummond and Rambaut, 2007](https://bmcecolevol.biomedcentral.com/articles/10.1186/1471-2148-7-214)
  - BEAST 2: [Bouckaert et al 2019](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006650)


---
class: left, top

# In-class discussion

**Objective:** Understand the main algorithms, assumptions and limitations of BEAST.

**Instructions:**

1. Separate group discussions (20 minutes): Students will discuss with their respective groups and prepare a 10-minute presentation for the whole class. Use the [software cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) as guideline for your discussion and presentation. Use these google slides:
  - [BEAST1](https://docs.google.com/presentation/d/1tIdioKHPdrytRcFfwSZwQdJofRR1Uz_MsW3g-3Rls0Q/edit?usp=sharing)
  - [BEAST2](https://docs.google.com/presentation/d/1Nc9bUMLf8n1EyJBX7gN53x6gT475aXIAHYoOdJtuu1M/edit?usp=sharing)
2. Group presentations (20 minutes total; 10 minutes per group): Each group will summarize their discussion in a 10-minute presentation to the class.

---
class: left, top

# Announcements

## 1. Changes in class dynamic after today

The three following classes will mostly be student discussions. Before each class, each student will have to read a paper which will be discussed in groups to prepare a 10-minute presentation for the whole class.
It is **very important** to read the paper carefully before class as group discussions will be ~20 minutes to allow sufficient time for presentations and whole class discussion.

- April 27: Measures of support
- April 29: Coalescent vs concatenation
- May 4: Phylogenomic pitfalls
- May 6 (last class): What else is out there? Summary of what we've learned and project Q&A
- May 9: Final project with reproducible script due
- May 11/13: Final presentations

---
class: left, top

## 2. Final project due on May 9

- Final project: 50 points out of 100 total points.
- Reproducible script(s) on your github repo: 10 points out of 100 total points
- Final presentation: 10 points out of 100 total points

Final project content:
- Abstract: 200 words or less
- Introduction: convey the background, objective and significance of your analysis
- Materials and Methods: describe in details the data and the different methods, software, assumptions or any methodological - choices that you did; appropriately cite other papers or software used
- Results: clearly and effectively describe the results of your analysis
- Discussion: summarize the conclusion of your findings and highlight any weaknesses or limitations of your approach
- References
- Reproducible script: step-by-step description of the methodology that can be easily followed by others. This file should be part of the github repository

---
class: left, top

## 2. Final project due on May 9

Some comments:
- There are no page restrictions (based on last year, 8-10 pages was the norm)
- In the Methods section, it is not enough to write "we used X, Y, and Z". For every software, you should write (not with this wording necessarily):

_We used X (reference) which [short description of the methodology]. We chose X because [short description of strengths]. We know that X has the following limitations [short description of weaknesses] and that it has the main following assumptions [short description of the assumptions]. The software X requires the user to input the following parameters: [parameter/user choices selected]_

- No specific file format: latex, markdown, Rmarkdown, google docs, word
- [Final project guidelines](https://github.com/crsl4/phylogenetics-class/blob/master/syllabus.md#final-project-guidelines)

---
class: left, top

## 2. Final presentations on May 11 and 13

- Final presentation is 8 minutes long (very strict!)
- Students divided in the two dates
- We meet in class as usual: 2:30pm (only need to attend the day you have to present, but you are welcome to support fellow students on the other date)
- Students unable to attend in person due to exam or travel conflicts can choose to present remotely or to submit a video recording of their presentation
- Most challenging is to fit a presentation in 8 minutes
- Where you able to work on your PhD data? Consider registering for a talk at [Evolution 2022](https://www.evolutionmeetings.org/registration.html). Virtual and in person options.


---
class: left, top

# Announcements

## 3. Student evaluations

- Very important for me (early career)!
- "Bribing you" to complete it: forward me the email after completion of the evaluation and it will count as one HW
  - Note that the email does not have information on your answers
- I have my own short survey to help me improve the class (on the last class)

---
class: left, top

# Continuing in-class dynamic: Taming the BEAST tutorial


Instructions: Choose a tutorial from the whole list of [BEAST tutorials](https://taming-the-beast.org/tutorials/). Two that stand out: 

- [Intro to BEAST](https://taming-the-beast.org/tutorials/Introduction-to-BEAST2/)
- [Multispecies coalescent on *BEAST](https://taming-the-beast.org/tutorials/StarBeast-Tutorial/)

Create our own reproducible script.

**Note** I still have not added these steps to the reproducible script: [notebook-log.md](https://github.com/crsl4/phylogenetics-class/tree/master/exercises/notebook-log.md).



---
class: left, top

## Take-home message: always read carefully the paper and the documentation of any phylogenetic method you use

Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).
