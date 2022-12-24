---
layout: default
nav_exclude: true
---

# Software for Botany 563

I am creating this list after a student requested it, but **people do not have to install these software ahead of class**. 
This is not a complete list for the whole semester.


**Instructions:** If you encounter any problems and had to find solutions online, please document those problems and solutions here. You can fork this class repository and add your description of problems/solutions via a pull request. I am very interested to know if people struggle in certain ways to install this software in order to create a more detailed set of instructions to install these tools in the future.


- [phyluce](https://phyluce.readthedocs.io/en/latest/purpose.html)
- [ClustalW](http://www.clustal.org/clustal2/)
- [T-Coffee](http://www.tcoffee.org/Projects/tcoffee/index.html#DOWNLOAD)
- [MUSCLE](https://www.drive5.com/muscle/downloads.htm)
- R packages ape and phangorn for distance and parsimony: [tutorial](https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf)
- [raxml-ng](https://github.com/amkozlov/raxml-ng)
- [iq-tree](http://www.iqtree.org/workshop/molevol2019)



## Trouble-shooting

Please include here any issue (and solution) that you encountered if you decide to install these software by yourself.

### ClustalW

Mac users with newest OS can run into problems when installing ClustalW.
From Beth: I also had a similar problem, where I was getting the error:
```
Bad CPU type in executable
```
which meant that the OS version was too advanced. But I ended up able to install clustalw using conda:
```
conda create -n clustalw2 -c biobuilds -y clustalw
```

### OrthoFinder

In Mac, you can install with (thanks Grant!):
```shell
conda install -c bioconda orthofinder
```

Note that in Mac, orthofinder can be found in the following path: `~/opt/miniconda2/pkgs/orthofinder-2.2.7-0` .

But note that the python script was not installed with the conda command, so we need to get it from the github repo directly: `git clone https://github.com/davidemms/OrthoFinder.git`:
```shell
for f in *fa ; do python PATH/OrthoFinder/tools/primary_transcript.py $f ; done
```
where PATH is the path where you cloned the repo.

### T-Coffee

Problems for linux users that have to download and install `famsa` separately and put in on their path.