---
layout: default
title: syllabus
nav_exclude: true
---

# Syllabus: Botany/Plant Path 563 
## Phylogenetic Analysis of Molecular Data (UW-Madison)

Spring 2024: Tuesdays and Thursdays 1:00-2:15pm

**Instructor:** 

- Claudia Solis-Lemus, PhD
- email: solislemus@wisc.edu
- website: https://solislemuslab.github.io/
- Office hours: Tuesday 2:15-3:15pm, or by appointment

**Class description:** 
A course in the theory and practice of phylogenetic inference from DNA sequence data. Students will learn all the necessary components of state-of-the-art phylogenomic analyses and apply the knowledge to the data analyses of their own organisms.

- Credits: 3
- Level: Advanced
- Breadth: Biological Science
- L&S Credit Type: Counts as LAS credit (L&S)
- Course Options: 50% Graduate Coursework Requirement
- This class meets for two, 75-minute class periods each week over the Spring semester and carries the expectation that students will work on course learning activities (reading, writing, problem sets, studying, etc) for **about 3 hours out of the classroom for every class period**. The syllabus includes more information about meeting times and expectations for student work

**Requisites:**
None, but strongly encouraged:

- A course in genetics/evolution/systematics
- A course in stats/probability


**Class website:** https://github.com/crsl4/phylogenetics-class


## Learning outcomes

By the end of the course, you will be able to

1. Explain in details all the steps in the pipeline for phylogenetic inference and how different data and model choices affect the inference outcomes
2. Plan and produce reproducible scripts with the analysis of your own biological data
3. Justify the data and model choices in your own data analysis
4. Interpret the results of the most widely used phylogenetic methods in biological terms
5. Orally present the results of your own phylogenomic data analyses based on the best scientific and reproducibility practices (graduate students only)


## Textbooks:
- _Phylogenetics in the Genomic Era_ ([open access book](https://hal.inria.fr/PGE/page/table-of-contents)) by Celine Scornavacca, Frederic Delsuc and Nicolas Galtier
- _Tree thinking: an introduction to phylogenetic biology_ by David Baum and Stacey Smith (optional)
- _The Phylogenetic Handbook_ by Philippe Lemey, Marco Salemi and Anee-Mieke Vandamme (optional)

## Format of the class

The classes will be a combination of lectures and participative in-class exercises and discussions. Each student is expected to find a dataset that they would like to analyze and homework will involve students applying the material covered in lecture on their respective datasets. There will not be any graded homeworks.

Out-of-class communication will be done via Slack where students will be able to ask and answer questions regarding the lectures and exercises.

## Class assessments and key dates
- Formal assessments (20 points). Each assessment/quiz is worth 2 points for turning it in on time and 1 points if turned in late (one week after deadline). Maximum possible points from these assessments is 28, but only 20 count towards grade (that is, 4 full quizzes can be missed without penalty).
    - HAL 2.1 quiz
    - Shell basics quiz
    - Reproducibility HW Part 1
    - Reproducibility HW Part 2
    - Sequencing quiz
    - Alignment HW
    - HAL 1.1 quiz
    - Orthology method
    - HAL 1.2 quiz
    - HAL 1.4 quiz
    - Nascimento2017 quiz
    - HAL 3.1 quiz
    - HAL 3.3 quiz
    - SNaQ quiz
- GitHub commits (10 points). It is expected that students will work on their final project throughout the semester. Specific github commits are expected at certain dates (see canvas). Each commit is worth 2 points (1 if late within one week of deadline). Maximum possible points from these assessments is 14, but only 10 count towards grade (that is, 2 commits can be missed without penalty). 
    - Create github repo for final project
    - Sequencing HW Data and QC
    - Alignment method
    - Distance and parsimony methods
    - Maximum Likelihood method
    - Bayesian method
    - Coalescent method
- Final research report (50 points)
- Reproducible script (10 points)
- Final presentation (10 points). The presentation is not graded. All students get 10 points for presenting their work on the assigned day. There are no exceptions on the day and students unable to attend class on those days can record their presentation and turn it in ahead of time. The presentation is required for graduate students, and is optional for undergraduate students, but provides extra points.

Research report and reproducible script can be submitted up to one week late to the original deadline, bit they lose 20% of available points. That is, final research report is worth 50 points if turned in on time, but only 40 points if turned in one week late.

### Final project content

1. Abstract: 200 words or less
2. Introduction: convey the background, objective and significance of your analysis
3. Materials and Methods: describe in details the data and the different methods, software, assumptions or any methodological choices that you did; appropriately cite other papers or software used
4. Results: clearly and effectively describe the results of your analysis
5. Discussion: summarize the conclusion of your findings and highlight any weaknesses or limitations of your approach
6. References
7. Reproducible script: step-by-step description of the methodology that can be easily followed by others. This can be the link to a github repository or an actual file

Some notes:
- You do not need to run all the steps in the phylogenomics pipeline on your data, but your results should at least contain a comparison of phylogenies from **at least two different inference methods** as well as measures of support to the final estimated trees
- There are no page restrictions on the project report
- In the Methods section, it is not enough to write "we used X, Y, and Z". For every software/method, you should write (not with this wording necessarily) "We used X (reference) which [short description of the methodology]. We chose X because [short description of strengths]. We know that X has the following limitations [short description of weaknesses] and that it has the main following assumptions [short description of the assumptions]. The software X requires the user to input the following parameters: [parameter/user choices selected]"
    - Advice: read the software paper of the software you are citing and create a cheatsheet for yourself with the above items: description, strengths, weaknesses, assumptions, user choices
- There is not a specific file format required, but the chosen format should allow for an easy way to evaluate and offer feedback (for both peer evaluation and instructor evaluation). In particular,
    - markdown/Rmarkdown/latex files could be pushed to github for an easy evaluation via github comments or pull requests
    - google documents would make it easy to share a living document and receive feedback from instructor
    - word documents are the least sharable, but could be used if they are the student's preferred format


### Final presentation

During finals week, each student will present the main results of their analysis to the class in a short presentation (length of the presentation still to be determined but likely either 10 or 15 minutes long). Emphasis should be placed on science communication: 
- clear and concise presentation of goal, data, methods, results and conclusions
- good quality figures

### Final project guidelines

Note: this is not a grading rubric. This table is meant to give you an idea of what is adequate (or excellent) vs inadequate in your final project, but the categories (inadequate, adequate, good, excellent) do not correspond to grades. 

|  | ideal content  | inadequate | adequate | good | excellent |
| :---:   | :---: | :---: | :---: | :---:  | :---: |
| Title  | | Point of analysis cannot be determined by title | Title is not concise, point of analysis is difficult to determine by title, most key information is missing | Title conveys main point of analysis but could be more concise | Title is concise, conveys main point of analysis, and includes these key components: study system, variables, result & direction |
| Abstract | | Abstract is missing or, if present, provides no relevant information | Many key components of the analysis are missing; those stated are unclear and/or are not stated concisely | Covers most key components but could be done more clearly and/or concisely | Concisely & clearly covers all key components in 200 words or less: biological rationale, hypothesis, approach, result direction & conclusions |
| Introduction | i) enough biological background to understand the significance of the work, ii) goal of the project clearly stated | Most key components are very weak or missing; those stated are unclear and/or not stated concisely.  Weak/missing components make it difficult to follow the rest of the paper. Often results in hypothesis that “comes out of nowhere” | Covers most key components but could be done much more logically, clearly, and/or concisely | Covers all key components but could be done much more logically, clearly, and/or concisely | Clearly, concisely, & logically presents all key components: relevant & correctly cited background information, question, biological rationale (including biological assumptions), hypothesis (if any), approach |
| Materials and Methods | i) data description: where it came from, size, characteristics, ii) for every step in the pipeline, you include 1) name of the software, 2) reference, 3) short description of the method, 4) short description of strengths (why chosen?), 5) short description of weaknesses/limitations, 6) short description of the main assumptions of the method, 7) user choices (parameters that you had to choose and how) | So little information is presented that reader could not possibly replicate experiment | Procedure is presented such that a reader could replicate experiment only after learning several more key details | Concisely, clearly & chronologically describes procedure used so that reader could replicate most of analysis with the exception of a few relatively minor details | Concisely, clearly, & chronologically describes procedure used so that knowledgeable reader could replicate experiment and understand the results.  Methods used are appropriate for study. Briefly describes mathematical manipulations or statistical analyses |
| Results | Resulting tree with some measure of support and connection to original biological question posed in the introduction | Major problems that leave reader uninformed; narrative text is lacking entirely, tables & figures contain unclear and/or irrelevant information; it does not contain an estimated phylogeny | Has 3-5 problems comparable to the following: narrative text and & tables/figures are minimal and mostly uninformative, some relevant data are present but are mixed in with much unnecessary information, tables & figures lack legends | Has presented both a concise, narrative text & informative tables/figures without biological interpretation, but has made 1-2 minor omissions or has other relatively small problems | With a few minor exceptions, contains a concise, well-organized narrative text & tables/figures that highlight key trends/patterns/output.  Tables & figures have appropriate legends/ labels & can stand on their own |
| Discussion | Challenges encountered and potential future work | Many key components are missing or very weakly done e.g., illogical conclusions made based on data, no ties to biological rationale are made, no literature cited, little to no evaluation of methods/data | Covers most key components but could be more more logically, clearly, and/or concisely. e.g. literature is minimally cited, presents unranked laundry list of problems instead of logical evaluation of methods and data, suggests flashy new experiments/analyses that would not clearly shed light on current question | Covers all key components but could be done much more logically, clearly, and/or concisely e.g. clearly develops a good argument that refers to biological rationale, but fails to logically and objectively evaluate assumptions, methods and data reliability.  Remaining components are done reasonably well, though there is still room for improvement  | With a few minor exceptions, clearly, concisely, & logically presents all key components: interprets/integrates data; formulates argument for conclusions referring back to biological rationale & by comparing with relevant findings in literature, introduces new literature to discuss or support findings, evaluates methods, evaluates reliability of data, states knowledge generated & implications of results, suggests next investigation steps, includes unique observations, and ends paper with final conclusions |
| Literature Cited |  | Background information is presented but is consistently not cited; final citation list is missing | Very few references are cited in text of paper; final citation list is largely incomplete and/or is not formatted appropriately | References within body of paper are cited appropriately; references in final citation list are formatted appropriately but there are some exceptions | References within body of paper are cited appropriately; references in final citation list are formatted appropriately |
| Reproducible script | all steps from raw data to end product clearly explained (not just a list of commands) | No reproducible script or just a copy-paste of commands without any explanations| Sequence of commands interleaved with comments, but important details are missing that makes it impossible for anyone to follow the steps, e.g. information on software installed, information on format of input data, missing key steps in the sequence | Complete sequence of commands interleaved with comments, but comments could be improved to provide more guidance | Fully explained sequence of commands interleaved with comments which make the whole analysis easy to follow and reproduce; details on software installed and versions installed as well as necessary format for the data input files (or links to input data files if data is publicly available) |



## Topics

### Lecture topics

0. Motivation: phylogenomics pipeline
1. Intro Illumina, quality control, assembly, alignment, filtering
2. Alignment
3. Orthology detection
4. Gene tree estimation
    1. Distance methods
    2. Parsimony methods
    3. Models of evolution
    4. Maximum likelihood
    5. Bayesian
    6. Model selection
5. Species tree/network estimation: the coalescent model
6. Co-estimation methods


### Discussion topics

1. Measures of support
2. Concatenation vs coalescence
3. Phylogenomics in big data


### Topics if time allows

7. Dating
8. Reconciliation
9. Species delimitation
10. SNP methods

## Expectations

Students enrolled in the class are expected to:
- keep up with the class material
- attend lectures as much as possible
- read carefully the pre-class materials
- ask questions when things are unclear
- take ownership of their learning experience
- attend office hours to resolve doubts and problems regarding the class material or the final project
- participate in class discussions


## Academic Policies
- The course syllabus provides a general plan for the course; deviations may be necessary
- **Recordings.** Lecture materials and recordings of this course are protected intellectual property at UW-Madison. Students in this course may use the materials and recordings for their personal use related to participation in this class. Students may also take notes solely for their personal use. If a lecture is not already recorded, you are not authorized to record lectures without permission unless you are considered by the university to be a qualified student with a disability requiring accommodation. [Regent Policy Document 4-1] Students may not copy or have lecture materials and recordings outside of class, including posting on internet sites or selling to commercial entities. Students are also prohibited from providing or selling their personal notes to anyone else or being paid for taking notes by any person or commercial firm without the instructor’s express written permission. Unauthorized use of these copyrighted lecture materials and recordings constitutes copyright infringement and may be addressed under the university’s policies, UWS Chapters 14 and 17, governing student academic and non-academic misconduct.
- **Evaluations.** Your constructive assessment of this course plays an indispensable role in shaping education at UW-Madison. Upon completing the course, please take the time to fill out the online course evaluation.
- **Academic Integrity.** By enrolling in this course, each student assumes the responsibilities of an active participant in UW-Madison’s community of scholars in which everyone’s academic work and behavior are held to the highest academic integrity standards. Academic misconduct compromises the integrity of the university. Cheating, fabrication, plagiarism, unauthorized collaboration, and helping others commit these acts are examples of academic misconduct, which can result in disciplinary action. This includes but is not limited to failure on the assignment/course, disciplinary probation, or suspension. Substantial or repeated cases of misconduct will be forwarded to the Office of Student Conduct & Community Standards for additional review.
- **Accommodations for Students with Disabilities.** McBurney Disability Resource Center syllabus statement: The University of Wisconsin-Madison supports the right of all enrolled students to a full and equal educational opportunity. The Americans with Disabilities Act (ADA), Wisconsin State Statute (36.12), and UW-Madison policy (Faculty Document 1071) require that students with disabilities be reasonably accommodated in instruction and campus life. Reasonable accommodations for students with disabilities is a shared faculty and student responsibility. Students are expected to inform faculty of their need for instructional accommodations by the end of the third week of the semester, or as soon as possible after a disability has been incurred or recognized. Faculty will work either directly with the student or in coordination with the McBurney Center to identify and provide reasonable instructional accommodations. Disability information, including instructional accommodations as part of a student’s educational record, is confidential and protected under FERPA.
- **Diversity and Inclusion.** Institutional Statement on Diversity: Diversity is a source of strength, creativity, and innovation for UW-Madison. We value the contributions of each person and respect the profound ways their identity, culture, background, experience, status, abilities, and opinion enrich the university community. We commit ourselves to the pursuit of excellence in teaching, research, outreach, and diversity as inextricably linked goals. The University of Wisconsin-Madison fulfills its public mission by creating a welcoming and inclusive community for people from everybackground – people who as students, faculty, and staff serve Wisconsin and the world.
- **Religious Observances.** UW faculty policy states that mandatory academic requirements should not be scheduled on days when religious observances may cause substantial numbers of students to be absent. Refer to the university’s Academic Calendar for specific information.

### We highlight the COVID academic policies that everyone at UW-Madison is expected to follow
- **Quarantine or Isolation due to COVID-19.** Students should continually monitor themselves for COVID-19 symptoms and get tested for the virus if they have symptoms or have been in close contact with someone with COVID-19. Students should reach out to instructors as soon as possible if they become ill or need to isolate or quarantine, in order to make alternate plans for how to proceed with the course. Students are strongly encouraged to communicate with their instructor concerning their illness and the anticipated extent of their absence from the course (either in-person or remote). The instructor will work with the student to provide alternative ways to complete the course work.
