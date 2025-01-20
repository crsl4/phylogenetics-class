---
layout: default
nav_exclude: true
---

# Notebook reproducible script for Botany 563
(Written by CSL in Spring 2021; Updated by CSL in Spring 2022; Updated by CSL in Spring 2025)


## QC with phyluce

### To do
- look for assembly alternatives to trinity for Mac

### Installation

We are following the steps on the [Installation](https://phyluce.readthedocs.io/en/latest/installation.html).

1. Install Miniconda for python 2.7 by choosing the `Miniconda2 MacOSX 64-bit pkg` file from the list here: https://docs.conda.io/en/latest/miniconda.html

2. We double-clicked on the file and followed the installation steps

3. The folder `miniconda2` was saved in `~/opt/miniconda2`

4. We get into the `~/.bash_profile` file and added one line to the PATH

5. Check up at this point:
```shell
$ which conda
/Users/Clauberry/opt/miniconda2/condabin/conda
$ python -V
Python 2.7.10
$ echo $PYTHONPATH
```

6. We created the `~/.condarc` with the content below:
```
channels:
  - defaults
  - conda-forge
  - bioconda
```

7. We install phyluce in it’s own conda environment
```shell
conda create --name phyluce phyluce
```
This takes a little while.

8. To use this phyluce environment, you must run:
```shell
conda activate phyluce
```

Note that in the tutorial it says `source activate phyluce` but we get an error:
```shell
$ source activate phyluce
-bash: activate: No such file or directory
```
To deactivate an active environment, use `conda deactivate`:
```shell
$ conda deactivate
-bash: [: /Library/Internet\: binary operator expected
```

### Tutorial I: UCE Phylogenomics

We are following the steps in this [link](https://phyluce.readthedocs.io/en/latest/tutorial-one.html).

We will work on the class repository. This is the location in my computer:
```shell
cd Dropbox/Documents/teaching/phylogenetics-class/BOT563/exercises
```

0. Create a phyluce folder: `mkdir phyluce`.

1. Download the data

```shell
# create a project directory
mkdir uce-tutorial

# change to that directory
cd uce-tutorial

# download the data into a file names fastq.zip
wget -O fastq.zip https://ndownloader.figshare.com/articles/1284521/versions/1

# make a directory to hold the data
mkdir raw-fastq

# move the zip file into that directory
mv fastq.zip raw-fastq

# move into the directory we just created
cd raw-fastq

# unzip the fastq data
unzip fastq.zip

# delete the zip file
rm fastq.zip

# you should see 6 files in this directory now
$ ls
Alligator_mississippiensis_GGAGCTATGG_L001_R1_001.fastq.gz
Alligator_mississippiensis_GGAGCTATGG_L001_R2_001.fastq.gz
Anolis_carolinensis_GGCGAAGGTT_L001_R1_001.fastq.gz
Anolis_carolinensis_GGCGAAGGTT_L001_R2_001.fastq.gz
Gallus_gallus_TTCTCCTTCA_L001_R1_001.fastq.gz
Gallus_gallus_TTCTCCTTCA_L001_R2_001.fastq.gz
Mus_musculus_CTACAACGGC_L001_R1_001.fastq.gz
Mus_musculus_CTACAACGGC_L001_R2_001.fastq.gz
```

2. Count the read data: The next line of code will count the lines in each R1 file (which should be equal to the reads in the R2 file) and divide that number by 4 to get the number of sequence reads
```shell
for i in *_R1_*.fastq.gz; do echo $i; gunzip -c $i | wc -l | awk '{print $1/4}'; done

Alligator_mississippiensis_GGAGCTATGG_L001_R1_001.fastq.gz
1750000
Anolis_carolinensis_GGCGAAGGTT_L001_R1_001.fastq.gz
1874362
Gallus_gallus_TTCTCCTTCA_L001_R1_001.fastq.gz
376559
Mus_musculus_CTACAACGGC_L001_R1_001.fastq.gz
1298196
```

3. Clean the read data: 
- The raw reads contain adapter contamination and low quality bases
- The data we are trimming, here, are from TruSeq v3 libraries, but the indexes are 10 nucleotides long

- We need to create the configuration file `illumiprocessor.conf` outside the `raw-fastq` folder:
```shell
$ ls
illumiprocessor.conf raw-fastq
```

- Make sure to have activated `phyluce`: `conda activate phyluce`.

- Now, in the folder where the config file is, we need to run:
```shell
illumiprocessor \
    --input raw-fastq/ \
    --output clean-fastq \
    --config illumiprocessor.conf \
    --cores 4

2021-02-09 20:23:18,033 - illumiprocessor - INFO - ==================== Starting illumiprocessor ===================
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Version: 2.0.9
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --config: illumiprocessor.conf
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --cores: 4
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --input: /Users/Clauberry/Dropbox/Documents/teaching/phylogenetics-class/BOT563/exercises/phyluce/uce-tutorial/raw-fastq
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --log_path: None
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --min_len: 40
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --no_merge: False
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --output: /Users/Clauberry/Dropbox/Documents/teaching/phylogenetics-class/BOT563/exercises/phyluce/uce-tutorial/clean-fastq
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --phred: phred33
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --r1_pattern: None
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --r2_pattern: None
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --se: False
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --trimmomatic: /Users/Clauberry/opt/miniconda2/envs/phyluce/bin/trimmomatic
2021-02-09 20:23:18,034 - illumiprocessor - INFO - Argument --verbosity: INFO
2021-02-09 20:23:18,071 - illumiprocessor - INFO - Trimming samples with Trimmomatic
Running....
2021-02-09 20:25:20,348 - illumiprocessor - INFO - =================== Completed illumiprocessor ===================
```
The really important information is in the split-adapter-quality-trimmed directory - which now holds our reads that have had adapter-contamination and low-quality bases removed.

4. Quality control
```shell
# move to the directory holding our cleaned reads
cd clean-fastq/

# run this script against all directories of reads

for i in *;
do
    phyluce_assembly_get_fastq_lengths --input $i/split-adapter-quality-trimmed/ --csv;
done

All files in dir with alligator_mississippiensis-READ2.fastq.gz,3279362,294890805,89.9232243955,0.0100399681299,40,100,100.0
All files in dir with anolis_carolinensis-READ-singleton.fastq.gz,3456457,314839345,91.0873026917,0.00799863728967,40,100,100.0
All files in dir with gallus_gallus-READ2.fastq.gz,749026,159690692,213.197795537,0.0588973605565,40,251,250.0
All files in dir with mus_musculus-READ-singleton.fastq.gz,2332785,211828511,90.8049867433,0.0102813002698,40,100,100.0
```
The order of the output is: sample,reads,total bp,mean length, 95 CI length,min,max,median

5. Assemble the data: we are going to use [trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
- we need to create a another configuration file `assembly.conf` outside the `clean-fastq` folder. We need to put the absolute path to our clean raw reads and the structure of the subfolders need to match what was produced by `illumiprocessor`:
```
├── clean-fastq
    ├── alligator_mississippiensis
    │    └── split-adapter-quality-trimmed
    │       ├── alligator_mississippiensis-READ1.fastq.gz
    │       ├── alligator_mississippiensis-READ2.fastq.gz
    │       └── alligator_mississippiensis-READ-singleton.fastq.gz
    └── anolis_carolinensis
        └── split-adapter-quality-trimmed
            ├── anolis_carolinensis-READ1.fastq.gz
            ├── anolis_carolinensis-READ2.fastq.gz
            └── anolis_carolinensis-READ-singleton.fastq.gz
```

Now we run the assembly:
```shell
# run the assembly
phyluce_assembly_assemblo_trinity \
    --conf assembly.conf \
    --output trinity-assemblies \
    --clean \
    --cores 10

NOTE: assemblo_trinity and Trinity are no longer supported on Mac OS.
Trinity has been consistently hard to build on Mac OS and we will no
longer be supporting it (unless it becomes easier to build).  We
suggest you use Trinity on Linux _OR_ ABYSS, itero, or spades on Mac
OS.
```

Because I have a mac, I cannot continue with the pipeline. I will search for alternatives for the assembly.

Sections still missing:
- Assembly QC
- Finding the UCE loci
- Extracting the UCE loci.

We will not go over alignment at this stage as we will cover this in the next class.


## Alignment methods

Recently, we found out that it is easier to install all three software via [BioConda](https://bioconda.github.io/):

```
conda install -c bioconda clustalw
conda install -c bioconda t-coffee
conda install -c bioconda muscle
```

For some people, it is easier to do the similar installation but with [MiniConda](https://docs.anaconda.com/free/miniconda/).

The following sections include description of installation of each software, but that can be skipped if installation has been success with BioConda or MiniConda.

### ClustalW

1. Downloaded [ClustalW](http://www.clustal.org/clustal2/) file `clustalw-2.1-macosx.dmg` and copied the folder into `Dropbox/software`

Note that for Mac users, the executable in the link can be too old and incompatible. A reliable alternative is to install through conda (see [here](https://anaconda.org/bioconda/clustalw)):
```
conda install -c bioconda clustalw
```
Note that if you use this option, the executable `clustalw` will be added automatically to your path and you can call it from anywhere in the terminal.

2. Downloaded the `primatesAA.fasta` file from the Phylogenetic Handbook [website](https://www.kuleuven.be/aidslab/phylogenybook/Data_sets.html). I had to copy and paste the sequences into a file with the same name. The website stopped working at some point, so we have the file in the class repo [data folder](https://github.com/crsl4/phylogenetics-class/tree/master/data).

You can check how many sequences you have with `grep`:
```shell
cd Dropbox/Documents/teaching/phylogenetics-class/BOT563/data
grep ">" primatesAA.fasta | wc -l ## 22
```

3. We find the running commands in the [docs](http://www.clustal.org/download/clustalw_help.txt)

4. We run the command. Note that you do not need the full path if you installed ClustalW with conda, you only need to call `clustalw`

```shell
$ ~/Dropbox/software/clustalw-2.1-macosx/clustalw2 -ALIGN -INFILE=primatesAA.fasta -OUTFILE=primatesAA-aligned.fasta -OUTPUT=FASTA

CLUSTAL 2.1 Multiple Sequence Alignments

Sequence format is Pearson
Sequence 1: Human        493 aa
Sequence 2: Chimp        493 aa
Sequence 3: Gorilla      493 aa
Sequence 4: Orangutan    493 aa
Sequence 5: Gibbon       494 aa
Sequence 6: Rhes_cDNA    497 aa
Sequence 7: Baboon       497 aa
Sequence 8: AGM          515 aa
Sequence 9: AGM_cDNA     515 aa
Sequence 10: Tant_cDNA    515 aa
Sequence 11: Patas        495 aa
Sequence 12: Colobus      495 aa
Sequence 13: DLangur      495 aa
Sequence 14: PMarmoset    494 aa
Sequence 15: Tamarin      494 aa
Sequence 16: Squirrel     494 aa
Sequence 17: Owl          494 aa
Sequence 18: Titi         494 aa
Sequence 19: Saki         494 aa
Sequence 20: Howler       551 aa
Sequence 21: Spider       547 aa
Sequence 22: Woolly       547 aa
Start of Pairwise alignments
Aligning...

Sequences (1:2) Aligned. Score:  97
Sequences (1:3) Aligned. Score:  97
Sequences (1:4) Aligned. Score:  93
Sequences (1:5) Aligned. Score:  90
Sequences (1:6) Aligned. Score:  87
Sequences (1:7) Aligned. Score:  87
Sequences (1:8) Aligned. Score:  87
Sequences (1:9) Aligned. Score:  87
Sequences (1:10) Aligned. Score:  87
Sequences (1:11) Aligned. Score:  86
Sequences (1:12) Aligned. Score:  88
Sequences (1:13) Aligned. Score:  88
Sequences (1:14) Aligned. Score:  71
Sequences (1:15) Aligned. Score:  70
Sequences (1:16) Aligned. Score:  68
Sequences (1:17) Aligned. Score:  70
Sequences (1:18) Aligned. Score:  70
Sequences (1:19) Aligned. Score:  71
Sequences (1:20) Aligned. Score:  68
Sequences (1:21) Aligned. Score:  69
Sequences (1:22) Aligned. Score:  69
Sequences (2:3) Aligned. Score:  98
Sequences (2:4) Aligned. Score:  94
Sequences (2:5) Aligned. Score:  90
Sequences (2:6) Aligned. Score:  87
Sequences (2:7) Aligned. Score:  87
Sequences (2:8) Aligned. Score:  86
Sequences (2:9) Aligned. Score:  87
Sequences (2:10) Aligned. Score:  87
Sequences (2:11) Aligned. Score:  87
Sequences (2:12) Aligned. Score:  88
Sequences (2:13) Aligned. Score:  88
Sequences (2:14) Aligned. Score:  70
Sequences (2:15) Aligned. Score:  69
Sequences (2:16) Aligned. Score:  67
Sequences (2:17) Aligned. Score:  70
Sequences (2:18) Aligned. Score:  70
Sequences (2:19) Aligned. Score:  70
Sequences (2:20) Aligned. Score:  69
Sequences (2:21) Aligned. Score:  69
Sequences (2:22) Aligned. Score:  69
Sequences (3:4) Aligned. Score:  94
Sequences (3:5) Aligned. Score:  91
Sequences (3:6) Aligned. Score:  87
Sequences (3:7) Aligned. Score:  88
Sequences (3:8) Aligned. Score:  87
Sequences (3:9) Aligned. Score:  87
Sequences (3:10) Aligned. Score:  87
Sequences (3:11) Aligned. Score:  87
Sequences (3:12) Aligned. Score:  89
Sequences (3:13) Aligned. Score:  88
Sequences (3:14) Aligned. Score:  71
Sequences (3:15) Aligned. Score:  70
Sequences (3:16) Aligned. Score:  68
Sequences (3:17) Aligned. Score:  71
Sequences (3:18) Aligned. Score:  71
Sequences (3:19) Aligned. Score:  72
Sequences (3:20) Aligned. Score:  69
Sequences (3:21) Aligned. Score:  70
Sequences (3:22) Aligned. Score:  70
Sequences (4:5) Aligned. Score:  90
Sequences (4:6) Aligned. Score:  86
Sequences (4:7) Aligned. Score:  86
Sequences (4:8) Aligned. Score:  86
Sequences (4:9) Aligned. Score:  86
Sequences (4:10) Aligned. Score:  86
Sequences (4:11) Aligned. Score:  86
Sequences (4:12) Aligned. Score:  87
Sequences (4:13) Aligned. Score:  87
Sequences (4:14) Aligned. Score:  70
Sequences (4:15) Aligned. Score:  69
Sequences (4:16) Aligned. Score:  67
Sequences (4:17) Aligned. Score:  68
Sequences (4:18) Aligned. Score:  69
Sequences (4:19) Aligned. Score:  69
Sequences (4:20) Aligned. Score:  69
Sequences (4:21) Aligned. Score:  69
Sequences (4:22) Aligned. Score:  69
Sequences (5:6) Aligned. Score:  83
Sequences (5:7) Aligned. Score:  84
Sequences (5:8) Aligned. Score:  83
Sequences (5:9) Aligned. Score:  83
Sequences (5:10) Aligned. Score:  83
Sequences (5:11) Aligned. Score:  83
Sequences (5:12) Aligned. Score:  85
Sequences (5:13) Aligned. Score:  85
Sequences (5:14) Aligned. Score:  69
Sequences (5:15) Aligned. Score:  68
Sequences (5:16) Aligned. Score:  67
Sequences (5:17) Aligned. Score:  68
Sequences (5:18) Aligned. Score:  70
Sequences (5:19) Aligned. Score:  69
Sequences (5:20) Aligned. Score:  67
Sequences (5:21) Aligned. Score:  69
Sequences (5:22) Aligned. Score:  67
Sequences (6:7) Aligned. Score:  97
Sequences (6:8) Aligned. Score:  96
Sequences (6:9) Aligned. Score:  96
Sequences (6:10) Aligned. Score:  96
Sequences (6:11) Aligned. Score:  94
Sequences (6:12) Aligned. Score:  95
Sequences (6:13) Aligned. Score:  95
Sequences (6:14) Aligned. Score:  69
Sequences (6:15) Aligned. Score:  68
Sequences (6:16) Aligned. Score:  66
Sequences (6:17) Aligned. Score:  68
Sequences (6:18) Aligned. Score:  70
Sequences (6:19) Aligned. Score:  70
Sequences (6:20) Aligned. Score:  65
Sequences (6:21) Aligned. Score:  68
Sequences (6:22) Aligned. Score:  68
Sequences (7:8) Aligned. Score:  96
Sequences (7:9) Aligned. Score:  96
Sequences (7:10) Aligned. Score:  96
Sequences (7:11) Aligned. Score:  95
Sequences (7:12) Aligned. Score:  95
Sequences (7:13) Aligned. Score:  95
Sequences (7:14) Aligned. Score:  70
Sequences (7:15) Aligned. Score:  68
Sequences (7:16) Aligned. Score:  67
Sequences (7:17) Aligned. Score:  68
Sequences (7:18) Aligned. Score:  70
Sequences (7:19) Aligned. Score:  71
Sequences (7:20) Aligned. Score:  66
Sequences (7:21) Aligned. Score:  69
Sequences (7:22) Aligned. Score:  69
Sequences (8:9) Aligned. Score:  98
Sequences (8:10) Aligned. Score:  99
Sequences (8:11) Aligned. Score:  94
Sequences (8:12) Aligned. Score:  94
Sequences (8:13) Aligned. Score:  94
Sequences (8:14) Aligned. Score:  70
Sequences (8:15) Aligned. Score:  69
Sequences (8:16) Aligned. Score:  67
Sequences (8:17) Aligned. Score:  68
Sequences (8:18) Aligned. Score:  70
Sequences (8:19) Aligned. Score:  70
Sequences (8:20) Aligned. Score:  65
Sequences (8:21) Aligned. Score:  66
Sequences (8:22) Aligned. Score:  67
Sequences (9:10) Aligned. Score:  98
Sequences (9:11) Aligned. Score:  94
Sequences (9:12) Aligned. Score:  95
Sequences (9:13) Aligned. Score:  95
Sequences (9:14) Aligned. Score:  70
Sequences (9:15) Aligned. Score:  69
Sequences (9:16) Aligned. Score:  67
Sequences (9:17) Aligned. Score:  68
Sequences (9:18) Aligned. Score:  71
Sequences (9:19) Aligned. Score:  71
Sequences (9:20) Aligned. Score:  65
Sequences (9:21) Aligned. Score:  66
Sequences (9:22) Aligned. Score:  67
Sequences (10:11) Aligned. Score:  94
Sequences (10:12) Aligned. Score:  94
Sequences (10:13) Aligned. Score:  94
Sequences (10:14) Aligned. Score:  70
Sequences (10:15) Aligned. Score:  69
Sequences (10:16) Aligned. Score:  67
Sequences (10:17) Aligned. Score:  69
Sequences (10:18) Aligned. Score:  70
Sequences (10:19) Aligned. Score:  71
Sequences (10:20) Aligned. Score:  65
Sequences (10:21) Aligned. Score:  67
Sequences (10:22) Aligned. Score:  67
Sequences (11:12) Aligned. Score:  94
Sequences (11:13) Aligned. Score:  94
Sequences (11:14) Aligned. Score:  69
Sequences (11:15) Aligned. Score:  67
Sequences (11:16) Aligned. Score:  66
Sequences (11:17) Aligned. Score:  68
Sequences (11:18) Aligned. Score:  69
Sequences (11:19) Aligned. Score:  69
Sequences (11:20) Aligned. Score:  66
Sequences (11:21) Aligned. Score:  68
Sequences (11:22) Aligned. Score:  68
Sequences (12:13) Aligned. Score:  98
Sequences (12:14) Aligned. Score:  71
Sequences (12:15) Aligned. Score:  69
Sequences (12:16) Aligned. Score:  67
Sequences (12:17) Aligned. Score:  70
Sequences (12:18) Aligned. Score:  71
Sequences (12:19) Aligned. Score:  72
Sequences (12:20) Aligned. Score:  67
Sequences (12:21) Aligned. Score:  70
Sequences (12:22) Aligned. Score:  70
Sequences (13:14) Aligned. Score:  70
Sequences (13:15) Aligned. Score:  69
Sequences (13:16) Aligned. Score:  67
Sequences (13:17) Aligned. Score:  70
Sequences (13:18) Aligned. Score:  71
Sequences (13:19) Aligned. Score:  71
Sequences (13:20) Aligned. Score:  67
Sequences (13:21) Aligned. Score:  70
Sequences (13:22) Aligned. Score:  70
Sequences (14:15) Aligned. Score:  93
Sequences (14:16) Aligned. Score:  86
Sequences (14:17) Aligned. Score:  88
Sequences (14:18) Aligned. Score:  89
Sequences (14:19) Aligned. Score:  87
Sequences (14:20) Aligned. Score:  83
Sequences (14:21) Aligned. Score:  86
Sequences (14:22) Aligned. Score:  85
Sequences (15:16) Aligned. Score:  84
Sequences (15:17) Aligned. Score:  87
Sequences (15:18) Aligned. Score:  87
Sequences (15:19) Aligned. Score:  87
Sequences (15:20) Aligned. Score:  82
Sequences (15:21) Aligned. Score:  86
Sequences (15:22) Aligned. Score:  85
Sequences (16:17) Aligned. Score:  85
Sequences (16:18) Aligned. Score:  85
Sequences (16:19) Aligned. Score:  84
Sequences (16:20) Aligned. Score:  80
Sequences (16:21) Aligned. Score:  83
Sequences (16:22) Aligned. Score:  82
Sequences (17:18) Aligned. Score:  88
Sequences (17:19) Aligned. Score:  87
Sequences (17:20) Aligned. Score:  84
Sequences (17:21) Aligned. Score:  86
Sequences (17:22) Aligned. Score:  85
Sequences (18:19) Aligned. Score:  92
Sequences (18:20) Aligned. Score:  85
Sequences (18:21) Aligned. Score:  87
Sequences (18:22) Aligned. Score:  87
Sequences (19:20) Aligned. Score:  83
Sequences (19:21) Aligned. Score:  86
Sequences (19:22) Aligned. Score:  85
Sequences (20:21) Aligned. Score:  86
Sequences (20:22) Aligned. Score:  85
Sequences (21:22) Aligned. Score:  92
Guide tree file created:   [primatesAA.dnd]

There are 21 groups
Start of Multiple Alignment

Aligning...
Group 1: Sequences:   2      Score:10695
Group 2: Sequences:   3      Score:10693
Group 3: Sequences:   4      Score:10550
Group 4: Sequences:   5      Score:10317
Group 5: Sequences:   2      Score:11293
Group 6: Sequences:   3      Score:11222
Group 7: Sequences:   2      Score:10814
Group 8: Sequences:   5      Score:10697
Group 9: Sequences:   6      Score:10568
Group 10: Sequences:   2      Score:10784
Group 11: Sequences:   8      Score:10576
Group 12: Sequences:  13      Score:9953
Group 13: Sequences:   2      Score:10473
Group 14: Sequences:   3      Score:10194
Group 15: Sequences:   4      Score:10034
Group 16: Sequences:   2      Score:10399
Group 17: Sequences:   6      Score:10117
Group 18: Sequences:   2      Score:11561
Group 19: Sequences:   3      Score:11013
Group 20: Sequences:   9      Score:9780
Group 21: Sequences:  22      Score:8718
Alignment Score 573733


WARNING: Truncating sequence names to 10 characters for PHYLIP output.


PHYLIP-Alignment file created   [primatesAA-aligned.fasta]
```

### T-Coffee

1. To download [T-Coffee](http://www.tcoffee.org/Projects/tcoffee/index.html#DOWNLOAD), we follow the steps in the [documentation](http://www.tcoffee.org/Projects/tcoffee/documentation/index.html)

- Download the tar file from [here](http://tcoffee-packages.s3-website.eu-central-1.amazonaws.com/#Stable/Latest/): `T-COFFEE_distribution_Version_13.45.0.4846264.tar.gz`

- Move to the software folder:
```shell
mv ~/Downloads/T-COFFEE_distribution_Version_13.45.0.4846264.tar.gz ~/Dropbox/software/
cd Dropbox/software/
tar -xvf T-COFFEE_distribution_Version_13.45.0.4846264.tar.gz
cd T-COFFEE_distribution_Version_13.45.0.4846264
./install all


*********************************************************************
********              INSTALLATION SUMMARY          *****************
*********************************************************************
------- SUMMARY package Installation:
-------   Executable Installed in: /Users/Clauberry/.t_coffee/plugins/macosx
*------        clustalw        : installed [from binary]
*------        XML::Simple     : updated 
*------        clustalw2       : installed [from binary]
*------        mafft           : installed [from binary]
*------        poa             : installed [from binary]
*------        RNAplfold       : installed [from binary]
*------        mustang         : installed [from binary]
*------        sap             : installed [from binary]
*------        strike          : installed [from binary]
*------        famsa           : failed installation
*------        dialign-t       : installed [from binary]
*------        prank           : installed [from binary]
*------        muscle          : installed [from binary]
*------        TMalign         : installed [from binary]
*------        t_coffee        : installed [from binary]
*------        dialign-tx      : installed [from binary]
*------        pcma            : installed [from binary]
*------        probconsRNA     : installed [from binary]
*------        kalign          : installed [from binary]
*------        probcons        : installed [from binary]
*------        clustalo        : installed [from binary]
*------        proda           : installed [from binary]
*------        retree          : installed [from binary]
*------ SUMMARY mode Installation:
*------       MODE accurate      SUCCESSFULLY installed
*------       MODE trmsd         SUCCESSFULLY installed
*!!!!!!       famsa           : Missing
*!!!!!!       MODE rcoffee       UNSUCCESSFULLY installed
*------       MODE tcoffee       SUCCESSFULLY installed
*------       MODE t_coffee      SUCCESSFULLY installed
*------       MODE expresso      SUCCESSFULLY installed
*------       MODE seq_reformat  SUCCESSFULLY installed
*------       MODE psicoffee     SUCCESSFULLY installed
*!!!!!!       famsa           : Missing
*!!!!!!       MODE mcoffee       UNSUCCESSFULLY installed
*------       MODE 3dcoffee      SUCCESSFULLY installed
```


- I cannot find the `t_coffee` executable for mac, so I will install again, but only `t_coffee`:
```shell
./install tcoffee


*********************************************************************
********              INSTALLATION SUMMARY          *****************
*********************************************************************
------- SUMMARY package Installation:
-------   Executable Installed in: /Users/Clauberry/.t_coffee/plugins/macosx
*------        strike          : updated [from binary]
*------        t_coffee        : installed [from binary]
*------ SUMMARY mode Installation:
*------       MODE tcoffee       SUCCESSFULLY installed
*********************************************************************
********              FINALIZE YOUR INSTALLATION    *****************
*********************************************************************
------- Your third party executables are in:
-------       /Users/Clauberry/.t_coffee/plugins/macosx:
------- Your t_coffee exccutable is in
-------       /Users/Clauberry/.t_coffee/bin/macosx:
------- In order to make your installation permanent add these two lines
export PATH=/Users/Clauberry/.t_coffee/bin/macosx:$PATH
export PLUGINS_4_TCOFFEE=/Users/Clauberry/.t_coffee/plugins/macosx:
-------       to the file: /Users/Clauberry/.profile OR /Users/Clauberry/.basrc
```

- I will add the two lines to my `.bash_profile` followed by `source ~/.bash_profile`

2. Run `t_coffee` on the same file:
```shell
cd Dropbox/Documents/teaching/phylogenetics-class/BOT563/data
t_coffee primatesAA.fasta


PROGRAM: T-COFFEE Version_13.45.0.4846264 (Version_13.45.0.4846264)
-full_log      	S	[0] 
-genepred_score	S	[0] 	nsd
-run_name      	S	[0] 
-mem_mode      	S	[0] 	mem
-extend        	D	[1] 	1 
-extend_mode   	S	[0] 	very_fast_triplet
-max_n_pair    	D	[0] 	10 
-seq_name_for_quadruplet	S	[0] 	all
-compact       	S	[0] 	default
-clean         	S	[0] 	no
-do_self       	FL	[0] 	0
-do_normalise  	D	[0] 	1000 
-template_file 	S	[0] 
-setenv        	S	[0] 	0
-export        	S	[0] 	0
-template_mode 	S	[0] 
-flip          	D	[0] 	0 
-remove_template_file	D	[0] 	0 
-profile_template_file	S	[0] 
-in            	S	[0] 
-seq           	S	[1] 	primatesAA.fasta
-aln           	S	[0] 
-method_limits 	S	[0] 
-method        	S	[0] 
-lib           	S	[0] 
-profile       	S	[0] 
-profile1      	S	[0] 
-profile2      	S	[0] 
-pdb           	S	[0] 
-relax_lib     	D	[0] 	1 
-filter_lib    	D	[0] 	0 
-shrink_lib    	D	[0] 	0 
-out_lib       	W_F	[0] 	no
-out_lib_mode  	S	[0] 	primary
-lib_only      	D	[0] 	0 
-outseqweight  	W_F	[0] 	no
-seq_source    	S	[0] 	ANY
-cosmetic_penalty	D	[0] 	0 
-gapopen       	D	[0] 	0 
-gapext        	D	[0] 	0 
-fgapopen      	D	[0] 	0 
-fgapext       	D	[0] 	0 
-nomatch       	D	[0] 	0 
-newtree       	W_F	[0] 	default
-tree          	W_F	[0] 	NO
-usetree       	R_F	[0] 
-tree_mode     	S	[0] 	nj
-distance_matrix_mode	S	[0] 	ktup
-distance_matrix_sim_mode	S	[0] 	idmat_sim1
-quicktree     	FL	[0] 	0
-outfile       	W_F	[0] 	default
-maximise      	FL	[1] 	1
-output        	S	[0] 	aln	html
-len           	D	[0] 	0 
-infile        	R_F	[0] 
-matrix        	S	[0] 	default
-tg_mode       	D	[0] 	1 
-profile_mode  	S	[0] 	cw_profile_profile
-profile_comparison	S	[0] 	profile
-dp_mode       	S	[0] 	linked_pair_wise
-ktuple        	D	[0] 	1 
-ndiag         	D	[0] 	0 
-diag_threshold	D	[0] 	0 
-diag_mode     	D	[0] 	0 
-sim_matrix    	S	[0] 	vasiliky
-transform     	S	[0] 
-extend_seq    	FL	[0] 	0
-outorder      	S	[0] 	input
-inorder       	S	[0] 	aligned
-seqnos        	S	[0] 	off
-case          	S	[0] 	keep
-cpu           	D	[0] 	0 
-ulimit        	D	[0] 	-1 
-maxnseq       	D	[0] 	-1 
-maxlen        	D	[0] 	-1 
-sample_dp     	D	[0] 	0 
-weight        	S	[0] 	default
-seq_weight    	S	[0] 	no
-align         	FL	[1] 	1
-mocca         	FL	[0] 	0
-domain        	FL	[0] 	0
-start         	D	[0] 	0 
-len           	D	[0] 	0 
-scale         	D	[0] 	0 
-mocca_interactive	FL	[0] 	0
-method_evaluate_mode	S	[0] 	default
-color_mode    	S	[0] 	new
-aln_line_length	D	[0] 	0 
-evaluate_mode 	S	[0] 	triplet
-get_type      	FL	[0] 	0
-clean_aln     	D	[0] 	0 
-clean_threshold	D	[1] 	1 
-clean_iteration	D	[1] 	1 
-clean_evaluate_mode	S	[0] 	t_coffee_fast
-extend_matrix 	FL	[0] 	0
-prot_min_sim  	D	[0] 	0 
-prot_max_sim  	D	[100] 	100 
-psiJ          	D	[0] 	3 
-psitrim_mode  	S	[0] 	regtrim
-psitrim_tree  	S	[0] 	codnd
-psitrim       	D	[100] 	100 
-prot_min_cov  	D	[90] 	90 
-pdb_type      	S	[0] 	d
-pdb_min_sim   	D	[35] 	35 
-pdb_max_sim   	D	[100] 	100 
-pdb_min_cov   	D	[50] 	50 
-pdb_blast_server	W_F	[0] 	EBI
-blast         	W_F	[0] 
-blast_server  	W_F	[0] 	EBI
-pdb_db        	W_F	[0] 	pdb
-protein_db    	W_F	[0] 	uniref50
-method_log    	W_F	[0] 	no
-struc_to_use  	S	[0] 
-cache         	W_F	[0] 	use
-print_cache   	FL	[0] 	0
-align_pdb_param_file	W_F	[0] 	no
-align_pdb_hasch_mode	W_F	[0] 	hasch_ca_trace_bubble
-external_aligner	S	[0] 	NO
-msa_mode      	S	[0] 	tree
-et_mode       	S	[0] 	et
-master        	S	[0] 	no
-blast_nseq    	D	[0] 	0 
-lalign_n_top  	D	[0] 	10 
-iterate       	D	[0] 	0 
-trim          	D	[0] 	0 
-split         	D	[0] 	0 
-trimfile      	S	[0] 	default
-split         	D	[0] 	0 
-split_nseq_thres	D	[0] 	0 
-split_score_thres	D	[0] 	0 
-check_pdb_status	D	[0] 	0 
-clean_seq_name	D	[0] 	0 
-seq_to_keep   	S	[0] 
-dpa_master_aln	S	[0] 
-dpa_maxnseq   	D	[0] 	0 
-dpa_min_score1	D	[0] 
-dpa_min_score2	D	[0] 
-dpa_keep_tmpfile	FL	[0] 	0
-dpa_debug     	D	[0] 	0 
-multi_core    	S	[0] 	templates_jobs_relax_msa_evaluate
-n_core        	D	[0] 	1 
-thread        	D	[0] 	1 
-max_n_proc    	D	[0] 	1 
-lib_list      	S	[0] 
-prune_lib_mode	S	[0] 	5
-tip           	S	[0] 	none
-rna_lib       	S	[0] 
-no_warning    	D	[0] 	0 
-run_local_script	D	[0] 	0 
-proxy         	S	[0] 	unset
-email         	S	[0] 
-clean_overaln 	D	[0] 	0 
-overaln_param 	S	[0] 
-overaln_mode  	S	[0] 
-overaln_model 	S	[0] 
-overaln_threshold	D	[0] 	0 
-overaln_target	D	[0] 	0 
-overaln_P1    	D	[0] 	0 
-overaln_P2    	D	[0] 	0 
-overaln_P3    	D	[0] 	0 
-overaln_P4    	D	[0] 	0 
-exon_boundaries	S	[0] 
-display       	D	[0] 	100 

INPUT FILES
	Input File (S) primatesAA.fasta  Format fasta_seq
	Input File (M) proba_pair 

Identify Master Sequences [no]:

Master Sequences Identified
INPUT SEQUENCES: 22 SEQUENCES  [PROTEIN]
  Input File primatesAA.fasta Seq AGM       Length  515 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq AGM_cDNA  Length  515 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Baboon    Length  497 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Chimp     Length  493 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Colobus   Length  495 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq DLangur   Length  495 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Gibbon    Length  494 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Gorilla   Length  493 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Howler    Length  551 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Human     Length  493 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Orangutan Length  493 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Owl       Length  494 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq PMarmoset Length  494 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Patas     Length  495 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Rhes_cDNA Length  497 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Saki      Length  494 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Spider    Length  547 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Squirrel  Length  494 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Tamarin   Length  494 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Tant_cDNA Length  515 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Titi      Length  494 type PROTEIN Struct Unchecked
  Input File primatesAA.fasta Seq Woolly    Length  547 type PROTEIN Struct Unchecked

	Multi Core Mode (read): 1 processor(s):

	--- Process Method/Library/Aln SprimatesAA.fasta
	xxx Retrieved SprimatesAA.fasta
	--- Process Method/Library/Aln Mproba_pair

	xxx Retrieved Mproba_pair

	All Methods Retrieved

MANUAL PENALTIES: gapopen=0 gapext=0

	Library Total Size: [251618]

Library Relaxation: Multi_proc [1]
 
!		[Relax Library][TOT=   22][100 %]

Relaxation Summary: [251618]--->[243988]



UN-WEIGHTED MODE: EVERY SEQUENCE WEIGHTS 1

MAKE GUIDE TREE 
	[MODE=nj][DONE]

PROGRESSIVE_ALIGNMENT [Tree Based]
Group    1: AGM
Group    2: AGM_cDNA
Group    3: Baboon
Group    4: Chimp
Group    5: Colobus
Group    6: DLangur
Group    7: Gibbon
Group    8: Gorilla
Group    9: Howler
Group   10: Human
Group   11: Orangutan
Group   12: Owl
Group   13: PMarmoset
Group   14: Patas
Group   15: Rhes_cDNA
Group   16: Saki
Group   17: Spider
Group   18: Squirrel
Group   19: Tamarin
Group   20: Tant_cDNA
Group   21: Titi
Group   22: Woolly

#Single Thread

	Group   23: [Group   10 (   1 seq)] with [Group    4 (   1 seq)]-->[Len=  493][PID:68999]
	Group   24: [Group    8 (   1 seq)] with [Group   23 (   2 seq)]-->[Len=  493][PID:68999]
	Group   25: [Group   11 (   1 seq)] with [Group   24 (   3 seq)]-->[Len=  493][PID:68999]
	Group   26: [Group    7 (   1 seq)] with [Group   25 (   4 seq)]-->[Len=  494][PID:68999]
	Group   27: [Group   20 (   1 seq)] with [Group    1 (   1 seq)]-->[Len=  515][PID:68999]
	Group   28: [Group    2 (   1 seq)] with [Group   27 (   2 seq)]-->[Len=  515][PID:68999]
	Group   29: [Group   15 (   1 seq)] with [Group    3 (   1 seq)]-->[Len=  497][PID:68999]
	Group   30: [Group   29 (   2 seq)] with [Group   28 (   3 seq)]-->[Len=  515][PID:68999]
	Group   31: [Group    6 (   1 seq)] with [Group    5 (   1 seq)]-->[Len=  495][PID:68999]
	Group   32: [Group   31 (   2 seq)] with [Group   30 (   5 seq)]-->[Len=  515][PID:68999]
	Group   33: [Group   14 (   1 seq)] with [Group   32 (   7 seq)]-->[Len=  515][PID:68999]
	Group   34: [Group   33 (   8 seq)] with [Group   26 (   5 seq)]-->[Len=  515][PID:68999]
	Group   35: [Group   19 (   1 seq)] with [Group   13 (   1 seq)]-->[Len=  494][PID:68999]
	Group   36: [Group   35 (   2 seq)] with [Group   12 (   1 seq)]-->[Len=  494][PID:68999]
	Group   37: [Group   21 (   1 seq)] with [Group   16 (   1 seq)]-->[Len=  494][PID:68999]
	Group   38: [Group   37 (   2 seq)] with [Group   36 (   3 seq)]-->[Len=  494][PID:68999]
	Group   39: [Group   18 (   1 seq)] with [Group   38 (   5 seq)]-->[Len=  494][PID:68999]
	Group   40: [Group   22 (   1 seq)] with [Group   17 (   1 seq)]-->[Len=  547][PID:68999]
	Group   41: [Group   40 (   2 seq)] with [Group   39 (   6 seq)]-->[Len=  549][PID:68999]
	Group   42: [Group   41 (   8 seq)] with [Group    9 (   1 seq)]-->[Len=  558][PID:68999]
	Group   43: [Group   42 (   9 seq)] with [Group   34 (  13 seq)]-->[Len=  588][PID:68999]


!		[Final Evaluation][TOT=  294][100 %]

CLUSTAL FORMAT for T-COFFEE Version_13.45.0.4846264 [http://www.tcoffee.org] [MODE:  ], CPU=0.00 sec, SCORE=984, Nseq=22, Len=588 

Human           MASGILVNVKEEVTCPICLELLTQPLSLDCGHSFCQACLTANHKKSMLD-
Chimp           MASGILVNVKEEVTCPICLELLTQPLSLDCGHSFCQACLTANHKKSMLD-
Gorilla         MASGILVNVKEEVTCPICLELLTQPLSLDCGHSFCQACLTANHKKSMLD-
Orangutan       MASGILVNVKEEVTCPICLELLTQPLSLDCGHSFCQACLTANHKKSTLD-
Gibbon          MASGILVNVKEKVTCPICLELLTQPLSLDCGHSFCQACLTANHKTSMPD-
Rhes_cDNA       MASGILLNVKEEVTCPICLELLTEPLSLHCGHSFCQACITANHKKSMLYK
Baboon          MASGILLNVKEEVTCPICLELLTEPLSLPCGHSFCQACITANHRKSMLYK
AGM             MASGILLNVKEEVTCPICLELLTEPLSLPCGHSFCQACITANHKESMLYK
AGM_cDNA        MASGILVNVKEEVTCPICLELLTEPLSLPCGHSFCQACITANHKESMLYK
Tant_cDNA       MASGILLNVKEEVTCPICLELLTEPLSLPCGHSFCQACITANHKESMLYK
Patas           MASGILLNVKEEVTCPICLELLTEPLSLPCGHSFCQACITANHKKSMLYK
Colobus         MASGILVNIKEEVTCPICLELLTEPLSLHCGHSFCQACITANHKKSMLYK
DLangur         MASGILVNIKEEVTCPICLELLTEPLSLHCGHSFCQACITANHKKSMLYK
PMarmoset       MASRILVNIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKESTLH-
Tamarin         MASRILVNIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKESTPH-
Squirrel        MASRILGSIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKESMLH-
Owl             MASRILVNIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKKSMPH-
Titi            MASRILVNIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKESTLH-
Saki            MASRILMNIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKKSMLH-
Howler          MASKILVNIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKES----
Spider          MASEILLNIKEEVTCPICLELLTEPLSLDCGHSFCQACITANHKESTLH-
Woolly          MASEILVNIKEEVTCPICLDLLTEPLSLDCGHSFCQACITADHKESTLH-
                *** ** .:**:*******:***:**** *********:**:*: *    

Human           KGESSCPVCRISYQPENIRPNRHVANIVEKLREVKLSPE-GQKVDHCARH
Chimp           KGESSCPVCRISYQPENIRPNRHVANIVEKLREVKLSPE-GQKVDHCAHH
Gorilla         KGESSCPVCRISYQPENIRPNRHVANIVEKLREVKLSPE-GQKVDHCARH
Orangutan       KGERSCPVCRVSYQPKNIRPNRHVANIVEKLREVKLSPE-GQKVDHCARH
Gibbon          EGERSCPVCRISYQHKNIRPNRHVANIVEKLREVKLSPEEGQKVDHCARH
Rhes_cDNA       EGERSCPVCRISYQPENIQPNRHVANIVEKLREVKLSPEEGQKVDHCARH
Baboon          EGERSCPVCRISYQPENIQPNRHVANIVEKLREVKLSPEEGLKVDHCARH
AGM             EEERSCPVCRISYQPENIQPNRHVANIVEKLREVKLSPEEGQKVDHCARH
AGM_cDNA        EEERSCPVCRISYQPENIQPNRHVANIVEKLREVKLSPEEGQKVDHCARH
Tant_cDNA       EEERSCPVCRISYQPENIQPNRHVANIVEKLREVKLSPEEGQKVDHCARH
Patas           EEERSCPVCRISYQPENIQPNRHVANIVEKLREVKLSPEEGQKVDHCARH
Colobus         EGERSCPVCRISYQPENIRPNRHVANIVEKLREVKLSPEEGQKVDHCARH
DLangur         EGERSCPVCRISYQPENIRPNRHVANIVEKLREVKLSPEEGQKVDHCARH
PMarmoset       QGERSCPLCRMSYPSENLRPNRHLANIVERLKEVMLSPEEGQKVDHCARH
Tamarin         QGERSCPLCRMSYPSENLRPNRHLANIVERLKEVMLSPEEGQKVGHCARH
Squirrel        QGERSCPLCRLPYQSENLRPNRHLASIVERLREVMLRPEERQNVDHCARH
Owl             QGERSCPLCRISYSSENLRPNRHLVNIVERLREVMLSPEEGQKVDHCAHH
Titi            QGERSCPLCRISYPSENLRPNRHLANIVERLREVVLSPEEGQKVDLCARH
Saki            QGERSCPLCRISYPSENLRPNRHLANIVERLREVMLSPEEGQKVDHCARH
Howler          -RERSCPLCRVSYHSENLRPNRHLANIAERLREVMLSPEEGQKVDRCARH
Spider          QGERSCPLCRVSYQSENLRPNRHLANIAERLREVMLSPEEGQKVDRCARH
Woolly          QGERSCPLCRVGYQSENLRPNRHLANIAERLREVMLSPEEGQKVDRCARH
                  * ***:**: *  :*::****:..*.*:*:** * **   :*. **:*

Human           GEKLLLFCQEDGKVICWLCERSQEHRGHHTFLTEEVAREYQVKLQAALEM
Chimp           GEKLLLFCQEDGKVICWLCERSQEHRGHHTFLTEEVAREYQVKLQAALEM
Gorilla         GEKLLLFCQEDGKVICWLCERSQEHRGHHTFLTEEVAQEYQVKLQAALEM
Orangutan       GEKLLLFCKEDGKVICWLCERSQEHRGHHTFLTEEVAQKYQVKLQAALEM
Gibbon          GKKLLLFCQEDRKVICWLCERSQEHRGHHTFLTEEVAQEYQMKLQAALQM
Rhes_cDNA       GEKLLLFCQEDSKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
Baboon          GEKLLLFCQEDSKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
AGM             GEKLLLFCQEDSKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
AGM_cDNA        GEKLLLFCQEDSKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
Tant_cDNA       GEKLLLFCQEDSKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
Patas           GEKLLLFCQEDRKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
Colobus         GEKLLLFCQEDRKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
DLangur         GEKLLLFCQEDRKVICWLCERSQEHRGHHTFLMEEVAQEYHVKLQTALEM
PMarmoset       GEKLLLFCQQDGNVICWLCERSQEHRGHHTFLVEEVAEKYQGKLQVALEM
Tamarin         GEKLLLFCEQDGNVICWLCERSQEHRGHHTLLVEEVAEKYQEKLQVALEM
Squirrel        GEKLLLFCEQDGNIICWLCERSQEHRGHNTFLVEEVAQKYREKLQVALET
Owl             GEKLVLFCQQDGNVICWLCERSQEHRGHQTFLVEEVAQKYREKLQVALEM
Titi            GEKLLLFCQQDGNVICWLCERSQEHRGHHTFLVEEVAQTYRENLQVVLEM
Saki            GEKLLLFCQQDGNVICWLCERSQEHRGHHTLLVEEVAQTYRENLQVALET
Howler          GEKLLLFCQQHGNVICWLCERSEEHRGHRTSLVEEVAQKYREKLQAALEM
Spider          GEKLLLFCQQHGNVICWLCERSQEHRGHSTFLVEEVAQKYQEKLQVALEM
Woolly          GEKLLLFCQQHGNVICWLCERSQEHRGHSTFLVEEVAQKYREKLQVALEM
                *:**:***::. ::********:***** * * ****. *: :**..*: 

Human           LRQKQQEAEELEADIREEKASWKTQIQYDKTNVLADFEQLRDILDWEESN
Chimp           LRQKQQEAEELEADIREEKASWKTQIQYDKTNVLADFEQLRDILDWEESN
Gorilla         LRQKQQEAEELEADIREEKASWKTQIQYDKTNVLADFEQLRDILDWEESN
Orangutan       LRQKQQEAEELEADIREEKASWKTQIQYDKTSVLADFEQLRDILDWEESN
Gibbon          LRQKQQEAEELEADIREEKASWKTQIQYDKTNILADFEQLRHILDWVESN
Rhes_cDNA       LRQKQQEAEKLEADIREEKASWKIQIDYDKTNVSADFEQLREILDWEESN
Baboon          LRQKQQEAEKLEADIREEKASWKIQIDYDKTNVSADFEQLREILDWEESN
AGM             LRQKQQEAEKLEADIREEKASWKIQIDYDKTNVSADFEQLREILDWEESN
AGM_cDNA        LRQKQQEAEKLEADIREEKASWKIQIDYDKTNVSADFEQLREILDWEESN
Tant_cDNA       LRQKQQEAEKLEADIREEKASWKIQIDYDKTNVSADFEQLREILDWEESN
Patas           LRQKQQEAEKLEADIREEKASWKIQIDYDKTNVLADFEQLREILDWEESN
Colobus         LRQKQQEAEKLEADIREEKASWKIQIDYDKTNVLADFEQLREILDWEESN
DLangur         LRQKQQEAEKLEADIREEKASWKIQIDCDKTNVLADFEQLREILDWEESN
PMarmoset       MRQKQQDAEKLEADVREEQASWKIQIQNDKTNIMAEFKQLRDILDCEESK
Tamarin         MRQKQQDAEKLEADVREEQASWKIQIRNDKTNIMAEFKQLRDILDCEESK
Squirrel        MRQKQQDAEKLEADVRQEQASWKIQIQNDKTNIMAEFKQLRDILDCEESN
Owl             MRQKQKDAEKLEADVREEQASWKIQIQNDKTNIMAEFKKRRDILDCEESK
Titi            MRQKHQDAEKLEADVREEQASWKIQIQNDKTNIMAEFKQLRDILDCEESN
Saki            MRQKQQDAEKLEADVREEQASWKIQIRDDKTNIMAEFKQLRDILDCEESN
Howler          MRQKEQDAEMLEADVREEQASWKIQIENDKTSTLAEFKQLRDILDCEESN
Spider          MRQKQQDAEKLEADVREEQASWKIQIENDKTNILAEFKQLRDILDCEESN
Woolly          MREKQQDAEKLEADVREEQASWKIQIKNDKTNILAEFKQLRDILDCEESN
                :*:*.::** ****:*:*:**** **  ***.  *:*:: *.***  **:

Human           ELQNLEKEEEDILKSLTNSETEMVQQTQSLRELISDLEHRLQGSVMELLQ
Chimp           ELQNLEKEEEDILKSLTKSETEMVQQTQSVRELISDLERRLQGSVMELLQ
Gorilla         ELQNLEKEEEDILKRLTKSETEMVQQTQSVRELISDLEHRLQGSVMELLQ
Orangutan       ELQNLEKEEEDILKSLTKSETEMVQQTQSVRELISDVEHRLQGSVMELLQ
Gibbon          ELQNLEKEEKDVLKRLMRSEIEMVQQTQSVRELISDLEHRLQGSVMELLQ
Rhes_cDNA       ELQNLEKEEEDILKSLTKSETEMVQQTQYMRELISELEHRLQGSMMDLLQ
Baboon          ELQNLEKEEEDILKSLTKSETEMVQQTQYMRELISDLEHRLQGSMMELLQ
AGM             ELQNLEKEEEDILKSLTKSETEMVQQTQYMRELISDLEHRLQGSMMELLQ
AGM_cDNA        ELQNLEKEEEDILKSLTKSETEMVQQTQYMRELISDLEHRLQGSMMELLQ
Tant_cDNA       ELQNLEKEEEDILKSLTKSETEMVQQTQYMRELISDLEHRLQGSMMELLQ
Patas           ELQYLEKEEEDILKSLTKSETKMVRQTQYVRELISDLEHRLQGSMMELLQ
Colobus         ELQNLEKEEEDILKSLTKSETEMVQQTQYMRELVSDLEHRLQGSVMELLQ
DLangur         ELQNLEKEEEDILKSLTKSETEMVQQTQYMRELISDLEHRLQGSMMELLQ
PMarmoset       ELQNLEKEEKNILKRLVQSESDMVLQTQSIRVLISDLERRLQGSVMELLQ
Tamarin         ELQNLEKEEKNILKRLVQSESDMVLQTQSMRVLISDLERRLQGSVLELLQ
Squirrel        ELQNLEKEEKNILKRLVQSENDMVLQTQSVRVLISDLERRLQGSVVELLQ
Owl             ELQNLEKEEKNILKRLVQSENDMVLQTQSVRVLISDLEHRLQGSVMELLQ
Titi            ELQNLEKEEKNILKRLVQSENDMVLQTQSISVLISDLEHRLQGSVMELLQ
Saki            ELQILEKEEKNILKRLTQSENDMVLQTQSMGVLISDLEHRLQGSVMELLQ
Howler          ELQKLEKEEENLLKRLVQSENDMVLQTQSIRVLIADLERRLQGSVMELLQ
Spider          ELQNLEKEEENLLKTLAQSENDMVLQTQSMRVLIADLEHRLQGSVMELLQ
Woolly          ELQNLEKEEENLLKILAQSENDMVLQTQSMRVLIADLEHRLQGSVMELLQ
                *** *****:::** * .** .** *** :  *::::*:*****:::***

Human           GVDGVIKRTENVTLKKPETFPKNQRRVFRAPDLKGMLEVFRELTDVRRYW
Chimp           GVDGVIKRMENVTLKKPETFPKNQRRVFRAPDLKGMLEVFRELTDVRRYW
Gorilla         GVDGVIKRMENVTLKKPETFPKNRRRVFRAPDLKGMLEVFRELTDVRRYW
Orangutan       GVDGIIKRMQNVTLKKPETFPKNQRRVFRAPNLKGMLEVFRELTDVRRYW
Gibbon          GVDGVIKRMKNVTLKKPETFPKNRRRVFRAADLKVMLEVLRELRDVRRYW
Rhes_cDNA       GVDGIIKRIENMTLKKPKTFHKNQRRVFRAPDLKGMLDMFRELTDARRYW
Baboon          GVDGIIKRIENMTLKKPKTFHKNQRRVFRAPDLKGMLDMFRELTDVRRYW
AGM             GVDGIIKRIENMTLKKPKTFHKNQRRVFRAPDLKGMLDMFRELTDVRRYW
AGM_cDNA        GVDGIIKRVENMTLKKPKTFHKNQRRVFRAPDLKGMLDMFRELTDVRRYW
Tant_cDNA       GVDGIIKRIENMTLKKPKTFHKNQRRVFRAPDLKGMLDMFRELTDVRRYW
Patas           GVDGIIKRIENMTLKKPETFHKNQRRVFRAPALKGMLDMFRELTDVRRYW
Colobus         GVDGIIKRIEDMTLKKPKTFPKNQRRVFRAPDLKGMLDMFRELTDVRRYW
DLangur         GVDGIIKRIENMTLKKPKTFPKNQRRVFRAPDLKGILDMFRELTDVRRYW
PMarmoset       GVDDVIKRIEKVTLQKPKTFLNEKRRVFRAPDLKGMLQAFKELTEVQRYW
Tamarin         GVDDVIKRIETVTLQKPKTFLNEKRRVFRAPDLKAMLQAFKELTEVQRYW
Squirrel        DVDGVIKRIEKVTLQKPKTFLNEKRRVFRAPDLKRMLQVLKELTEVQRYW
Owl             GVDGVIKRIEKVTLQNPKTFLNEKRRIFQTPDLKGTLQVFKEPTEVQRYW
Titi            GVDGVIKRVKNVTLQKPKTFLNEKRRVFRVPDLKGMLQVSKELTEVQRYW
Saki            GVDEVIKRVKNVTLQKPKTFLNEKRRVFRAPDLKGMLQVFKELTEVQRYW
Howler          GVEGVIKRIKNVTLQKPETFLNEKRRVFQAPDLKGMLQVFKELKEVQCYW
Spider          DVEGVIKRIKNVTLQKPKTFLNEKRRVFRAPDLKGMLQVFKELKEVQCYW
Woolly          GVEGIIKRTTNVTLQKPKTFLNEKRRVFRAPNLKGMLQVFKELKEVQCYW
                .*: :***   :**::*:** :::**:*:.. **  *:  :*  :.: **

Human           VDVTVAPNNISCAVISEDKRQVSSPKPQIIYGARGTR-YQ----------
Chimp           VDVTVAPNNISCAVISEDMRQVSSPKPQIIYGARGTR-YQ----------
Gorilla         VDVTVAPNNISCAVISEDMRQVSSPKPQIIYGAQGTR-YQ----------
Orangutan       VDVTVAPNDISYAVISEDMRQVSCPEPQIIYGAQGTT-YQ----------
Gibbon          VDVTVAPNNISYAVISEDMRQVSSPEPQIIFEAQGTI-SQ----------
Rhes_cDNA       VDVTLATNNISHAVIAEDKRQVSSRNPQIMYQAPGTL-FT----------
Baboon          VDVTLAPNNISHAVIAEDKRQVSSRNPQITYQAPGTL-FS----------
AGM             VDVTLAPNNISHAVIAEDKRQVSYQNPQIMYQAPGSS-FGSLTNFNYCTG
AGM_cDNA        VDVTLAPNNISHAVIAEDKRQVSYRNPQIMYQSPGSL-FGSLTNFSYCTG
Tant_cDNA       VDVTLAPNNISHAVIAEDKRQVSYQNPQIMYQAPGSS-FGSLTNFNYCTG
Patas           VDVTLAPNNISHVVIAEDKRQVSSRNPQIMYWAQGKL-FQ----------
Colobus         VDVTLAPNNISHAVIAEDKRRVSSPNPQIMYRAQGTL-FQ----------
DLangur         VDVTLAPNNISHAVIAEDKRQVSSPNPQIMCRARGTL-FQ----------
PMarmoset       AHVTLVPSHPSCTVISEDERQVRYQVP---------I-HQ----------
Tamarin         AHVTLVPSHPSYAVISEDERQVRYQFQ---------I-HQ----------
Squirrel        AHVTLVPSHPSYTIISEDGRQVRYQKP---------I-RH----------
Owl             AHVTLVPSHPSCTVISEDERQVRYQKR---------I-YQ----------
Titi            AHVTLVASHPSRAVISEDERQVRYQEW---------I-HQ----------
Saki            VHVTLVPSHLSCAVISEDERQVRYQER---------I-HQ----------
Howler          AHVTLIPNHPSCTVISEDKREVRYQEQ---------IHHH----------
Spider          AHVTLVPSHPSCTVISEDERQVRYQEQ---------I-HQ----------
Woolly          AHVTLVPSHPSCAVISEDQRQVRYQKQ---------R-HR----------
                ..**: ... * .:*:** *.*                            

Human           ----------TFVNFNYCTGILGSQSITSGKHYWEVDVSKKTAWILGVCA
Chimp           ----------TFMNFNYCTGILGSQSITSGKHYWEVDVSKKSAWILGVCA
Gorilla         ----------TFMNFNYCTGILGSQSITSGKHYWEVDVSKKSAWILGVCA
Orangutan       ----------TYVNFNYCTGILGSQSITSGKHYWEVDVSKKSAWILGVCA
Gibbon          ----------TFVNFNYCTGILGSQSITSGKHYWEVDVSKKSAWILGVCA
Rhes_cDNA       --------FPSLTNFNYCTGVLGSQSITSGKHYWEVDVSKKSAWILGVCA
Baboon          --------FPSLTNFNYCTGVLGSQSITSGKHYWEVDVSKKSAWILGVCA
AGM             VLGSQSITSRKLTNFNYCTGVLGSQSITSGKHYWEVDVSKKSAWILGVCA
AGM_cDNA        VPGSQSITSGKLTNFNYCTGVLGSQSITSGKHYWEVDVSKKSAWILGVCA
Tant_cDNA       VLGSQSITSRKLTNFNYCTGVLGSQSITSGKHYWEVDVSKKSAWILGVCA
Patas           ----------SLKNFNYCTGILGSQSITSGKHYWEVDVSKKSAWILGVCA
Colobus         ----------SLKNFIYCTGVLGSQSITSGKHYWEVDVSKKSAWILGVCA
DLangur         ----------SLKNFIYCTGVLGSQSITSGKHYWEVDVSKKSAWILGVCA
PMarmoset       ----------PLVKVKYFYGVLGSLSITSGKHYWEVDVSNKRGWILGVCG
Tamarin         ----------PSVKVNYFYGVLGSPSITSGKHYWEVDVTNKRDWILGICV
Squirrel        ----------LLVKVQYFYGVLGSPSITSGKHYWEVDVSNKRAWTLGVCV
Owl             ----------PFLKVKYFCGVLGSPSITSGKHYWEVDVSNKSEWILGVCV
Titi            ----------SSGRVKYFYGVLGSPSITSGKHYWEVDVSNKSAWILGVCV
Saki            ----------SFGKVKYFYGVLGSPSIRSGKHYWEVDVSNKSAWILGVCV
Howler          ----------PSMEVKYFYGILGSPSITSGKHYWEVDVSNKSAWILGVCV
Spider          ----------PSVKVKYFCGVLGSPGFTSGKHYWEVDVSDKSAWILGVCV
Woolly          ----------PSVKAKYFYGVLGSPSFTSGKHYWEVDVSNKSAWILGVCV
                             .  *  *:*** .: **********:.*  * **:* 

Human           GFQPDAMCNIEKNENYQPKYGYWVIGLEEGVKCS----------------
Chimp           GFQPDAMCNIEKNENYQPKYGYWVIGLEEGVKCS----------------
Gorilla         GFQPDATCNIEKNENYQPKYGYWVIGLEEGVKCS----------------
Orangutan       GFQPDAMYNIEQNENYQPQYGYWVIGLEEGVKCS----------------
Gibbon          GLQPDAMYNIEQNENYQPKYGYWVIGLEEGVKCN----------------
Rhes_cDNA       GFQSDAMYNIEQNENYQPKYGYWVIGLQEGVKYS----------------
Baboon          GFQPDAMYNIEQNENYQPKYGYWVIGLQEGVKYS----------------
AGM             GFQPDATYNIEQNENYQPKYGYWVIGLQEGDKYS----------------
AGM_cDNA        GFQPDATYNIEQNENYQPKYGYWVIGLQEGDKYS----------------
Tant_cDNA       GFQPDATYNIEQNENYQPKYGYWVIGLQEGDKYS----------------
Patas           GFQPDAMYDVEQNENYQPKYGYWVIGLQEGVKYS----------------
Colobus         GFQPDAMYNIEQNENYQPKYGYWVIGLQEGVKYS----------------
DLangur         GFQPDAMYNIEQNENYQPKYGYWVIGLQEGVKYN----------------
PMarmoset       SWKCNAKWNVLRPENYQPKNGYWVIGLRNTDNYSAF--------------
Tamarin         SFKCNAKWNVLRPENYQPKNGYWVIGLQNTNNYSAF--------------
Squirrel        SLKCTANQSVSGTENYQPKNGYWVIGLRNAGNYRAF--------------
Owl             SLKRTASCSVPRIENDQPKNGYWVIGLRNADNYSAF--------------
Titi            SLKCAANRNGPGVENYQPKNGYWVIGLRNADNYSAF--------------
Saki            SLKCTANRNGPRIENYQPKNGYWVIGLWNAGNYSAF--------------
Howler          SLKCIG--NFPGIENYQPQNGYWVIGLRNADNYSAFQDAVPETENYQPKN
Spider          SLKCTA--NVPGIENYQPKNGYWVIGLQNANNYSAFQDAVPGTENYQPKN
Woolly          SLKCTA--NVPGIENYQPKNGYWVIGLQNADNYSAFQDAVPGTEDYQPKN
                . :  .  .    ** **: ******* :  :                  

Human           --------------------------------------------------
Chimp           --------------------------------------------------
Gorilla         --------------------------------------------------
Orangutan       --------------------------------------------------
Gibbon          --------------------------------------------------
Rhes_cDNA       --------------------------------------------------
Baboon          --------------------------------------------------
AGM             --------------------------------------------------
AGM_cDNA        --------------------------------------------------
Tant_cDNA       --------------------------------------------------
Patas           --------------------------------------------------
Colobus         --------------------------------------------------
DLangur         --------------------------------------------------
PMarmoset       -----------------------------------------------QDA
Tamarin         -----------------------------------------------QDA
Squirrel        -----------------------------------------------QSS
Owl             -----------------------------------------------QDA
Titi            -----------------------------------------------QDS
Saki            -----------------------------------------------QDS
Howler          RN-RFTGLQNADNCSAFQNAFPGIQSYQPKKSHLFTGLQNLSNYNAFQNK
Spider          GNRRNKGLRNADNYSAFRDTF------QPINDSWVTGLRNVDNYNAFQDA
Woolly          GCWRNTGLRNADNYSAFQDVF------QPKNDYWVTGLWNADNYNAFQDA
                                                                  

Human           ------AFQDSSFHTPSVPFIVPLSVIICPDRVGVFLDYEACTVSFFNIT
Chimp           ------AFQDGSFHTPSAPFIVPLSVIICPDRVGVFLDYEACTVSFFNIT
Gorilla         ------AFQDGSFHTPSAPFIVPLSVIICPDRVGVFLDYEACTVSFFNIT
Orangutan       ------AFQDGSFHNPSAPFIVPLSVIICPDRVGVFLDYEACTVSFFNIT
Gibbon          ------AFQDGSIHTPSAPFVVPLSVNICPDRVGVFLDYEACTVSFFNIT
Rhes_cDNA       ------VFQDGSSHTPFAPFIVPLSVIICPDRVGVFVDYEACTVSFFNIT
Baboon          ------VFQDGSSHTPFAPFIVPLSVIICPDRVGVFVDYEACTVSFFNIT
AGM             ------VFQDSSSHTPFAPFIVPLSVIICPDRVGVFVDYEACTVSFFNIT
AGM_cDNA        ------VFQDGSSHTPFAPFIVPLSVIICPDRVGVFVDYEACTVSFFNIT
Tant_cDNA       ------VFQDGSSHTPFAPFIVPLSVIICPDRVGVFVDYEACTVSFFNIT
Patas           ------VFQDGSSHTPFAPFIAPLSVIFCPDRVGVFVDYEACTVSFFNIT
Colobus         ------VFQDGSSHTPFAPFIVPLSVIICPDRVGVFVDYEACTVSFFNIT
DLangur         ------VFQDGSSHTPFAPFIVPLSVIICPDRVGVFVDYEACTVSFFNIT
PMarmoset       V--KYSDVQDGSRSVSSGPLIVPLFMTICPNRVGVFLDYEACTISFFNVT
Tamarin         V--KYSDFQIGSRSTASVPLIVPLFMTIYPNRVGVFLDYEACTVSFFNVT
Squirrel        F--EFRDFLAGSRLTLSPPLIVPLFMTICPNRVGVFLDYEARTISFFNVT
Owl             V--EYSDFQDGSRSTPSAPLIVPLFMTICPNRVGVFLDYEACTVSFFNVT
Titi            V--KYNDFQDGSRSTTYAPLIVPLFMTICPNRVGVFLDYEACTVSFFNVT
Saki            V--KYSDFQDGSHSATYGPLIVPLFMTICPNRVGVFLDYEACTVSFFNVT
Howler          VQYNYIDFQDDSLSTPSAPLIVPLFMTICPKRVGVFLDYEACTVSFFNVT
Spider          V--KYSDFQDGSCSTPSAPLMVPLFMTICPKRVGVFLDCKACTVSFFNVT
Woolly          G--KYSDFQDGSCSTPFAPLIVPLFMTIRPKRVGVFLDYEACTVSFFNVT
                       .  .*      *::.** : : *.*****:* :* *:****:*

Human           NHGFLIYKFSHCSFSQPVFPYLNPRKCGVPMTLCSPSS
Chimp           NHGSLIYKFSHCSFSQPVFPYLNPRKCGVPMTLCSPSS
Gorilla         NHGFLIYKFSHCSFSQPVFPYLNPRKCRVPMTLCSPSS
Orangutan       NHGFLIYKFSHCSFSQPVFPYLNPRKCRVPMTLCSPSS
Gibbon          DHGFLIYKFSHCSFSQPVFPYLNPRKCTVPMTLCSPSS
Rhes_cDNA       NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
Baboon          NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
AGM             NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
AGM_cDNA        NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
Tant_cDNA       NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
Patas           NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
Colobus         NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
DLangur         NHGFLIYKFSQCSFSKPVFPYLNPRKCTVPMTLCSPSS
PMarmoset       SNGFLIYKFSNCHFSYPVFPYFSPTTCELPMTLCSPSS
Tamarin         NNGFLIYKFSNCHFSYPVFPYFSPMTCELPMTLCSPSS
Squirrel        SNGFLIYKFSDCHFSYPVFPYFNPMTCELPMTLCSPRS
Owl             NNGFLIYKFSNCHFCYPVFPYFSPMTCELPMTLCSPSS
Titi            SNGFLIYKFSNCHFSYPVFPYFSPMTCELPMTLCSPRS
Saki            SNGFLIYKFSNCRFSDSVFPYFSPMTCELPMTLCSPRS
Howler          SNGYLIYKFSNCQFSYPVFPYFSPMTCELPMTLCSPSS
Spider          SNGCLIYKFSKCHFSYPVFPYFSPMICKLPMTLCSPSS
Woolly          SNGCLIYKFSNCHFSCPVFPYFSPMTCKLPMTLCSPSS
                .:* ******.* *. .****:.*  * :******* *


OUTPUT RESULTS
	#### File Type= GUIDE_TREE      Format= newick          Name= primatesAA.dnd
	#### File Type= MSA             Format= aln             Name= primatesAA.aln
	#### File Type= MSA             Format= html            Name= primatesAA.html

# Command Line: t_coffee primatesAA.fasta  [PROGRAM:T-COFFEE]
# T-COFFEE Memory Usage: Current= 35.742 Mb, Max= 42.809 Mb
# Results Produced with T-COFFEE Version_13.45.0.4846264 (Version_13.45.0.4846264)
# T-COFFEE is available from http://www.tcoffee.org
# Register on: https://groups.google.com/group/tcoffee/
```


### MUSCLE

1. Downloaded [MUSCLE](https://www.drive5.com/muscle/downloads.htm) with file `muscle3.8.31_i86darwin64.tar.gz`

Note that from 2024 on, MUSCLE is not downloaded as a tar file, but as an executable directy, so you might need to skip step 2. Check the MUSCLE [docs](https://drive5.com/muscle5/manual/install.html) if your computer does not recognize the file as an executable.

2. Move to software and untar:
```shell
mv ~/Downloads/muscle3.8.31_i86darwin64.tar.gz ~/Dropbox/software/
cd ~/Dropbox/software/
tar -zxvf muscle3.8.31_i86darwin64.tar.gz
```
This produces the executable directly: `muscle3.8.31_i86darwin64`

3. Run MUSCLE on the primate data:
```shell
cd Dropbox/Documents/teaching/phylogenetics-class/BOT563/data
~/Dropbox/software/muscle3.8.31_i86darwin64 -in primatesAA.fasta -out primatesAA-aligned-muscle.fasta


MUSCLE v3.8.31 by Robert C. Edgar

http://www.drive5.com/muscle
This software is donated to the public domain.
Please cite: Edgar, R.C. Nucleic Acids Res 32(5), 1792-97.

primatesAA 22 seqs, max length 551, avg  length 504
00:00:00      2 MB(0%)  Iter   1  100.00%  K-mer dist pass 1
00:00:00      2 MB(0%)  Iter   1  100.00%  K-mer dist pass 2
00:00:00      9 MB(0%)  Iter   1  100.00%  Align node       
00:00:00      9 MB(0%)  Iter   1  100.00%  Root alignment
00:00:00     10 MB(0%)  Iter   2  100.00%  Refine tree   
00:00:00     10 MB(0%)  Iter   2  100.00%  Root alignment
00:00:00     10 MB(0%)  Iter   2  100.00%  Root alignment
00:00:00     10 MB(0%)  Iter   3  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter   4  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter   5  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter   6  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter   7  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter   8  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter   9  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  10  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  11  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  12  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  13  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  14  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  15  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  16  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  17  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  18  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  19  100.00%  Refine biparts
00:00:00     10 MB(0%)  Iter  20  100.00%  Refine biparts
```

## Orthology detection (optional topic) with OrthoFinder

Following the steps in the [tutorial](https://davidemms.github.io/orthofinder_tutorials/downloading-and-running-orthofinder.html).

1. In a Mac machine, I will install with:
```shell
conda install -c bioconda orthofinder
```
This steps takes some minutes.

2. To check it was installed correctly:
```shell
orthofinder -h
```

Note that `orthofinder` is installed in `~/opt/miniconda2/pkgs/orthofinder-2.2.7-0`.

3. To download data, we go to the https://useast.ensembl.org/index.html website
    - Click on "Human"
    - Click on "Download FASTA"
    - Click on "pep"
    - Click on `Homo_sapiens.GRCh38.pep.all.fa.gz`
    - We want to repeat the steps for 
        - Mouse: `Mus_musculus.GRCm39.pep.all.fa.gz `
        - Zebrafish: `Danio_rerio.GRCz11.pep.all.fa.gz`

4. Move data files to our data folder and untar:
```shell
cd Dropbox/Documents/teaching/phylogenetics-class/BOT563/data
gunzip *.gz
```

5. We’ll use a script provided with OrthoFinder to extract just the longest transcript variant per gene and run OrthoFinder on these files. 
Also, note that the python script is not installed when running the conda installation, so we will need to get the python scripts from the github repo:
```shell
cd software
git clone https://github.com/davidemms/OrthoFinder.git
```

Note that I had to change the path to the python script:
```shell
for f in *fa ; do python ~/software/OrthoFinder/tools/primary_transcript.py $f ; done


Looking for "gene=" of "gene:" to identify isoforms of same gene
Found 52089 accessions, 30313 genes, 0 unidentified transcripts
Wrote 30313 genes
/Users/Clauberry/Dropbox/Documents/teaching/phylogenetics-class/BOT563/data/primary_transcripts/Danio_rerio.GRCz11.pep.all.fa

Looking for "gene=" of "gene:" to identify isoforms of same gene
Found 115262 accessions, 23472 genes, 0 unidentified transcripts
Wrote 23472 genes
/Users/Clauberry/Dropbox/Documents/teaching/phylogenetics-class/BOT563/data/primary_transcripts/Homo_sapiens.GRCh38.pep.all.fa

Looking for "gene=" of "gene:" to identify isoforms of same gene
Found 67174 accessions, 22481 genes, 0 unidentified transcripts
Wrote 22481 genes
/Users/Clauberry/Dropbox/Documents/teaching/phylogenetics-class/BOT563/data/primary_transcripts/Mus_musculus.GRCm39.pep.all.fa
```
The folder `primary_transcripts` is created.

6. Run OrthoFinder:
```shell
orthofinder -f primary_transcripts/


OrthoFinder version 2.2.7 Copyright (C) 2014 David Emms

2021-02-23 14:38:07 : Starting OrthoFinder
16 thread(s) for highly parallel tasks (BLAST searches etc.)
1 thread(s) for OrthoFinder algorithm

Checking required programs are installed
----------------------------------------
Test can run "makeblastdb -help" - ok
Test can run "blastp -help" - ok
Test can run "mcl -h" - ok
Test can run "fastme -i /Users/Clauberry/Dropbox/Documents/teaching/phylogenetics-class/BOT563/data/primary_transcripts/SimpleTest.phy -o /Users/Clauberry/Dropbox/Documents/teaching/phylogenetics-class/BOT563/data/primary_transcripts/SimpleTest.tre" - ok

Dividing up work for BLAST for parallel processing
--------------------------------------------------
2021-02-23 14:38:09 : Creating Blast database 1 of 3
2021-02-23 14:38:10 : Creating Blast database 2 of 3
2021-02-23 14:38:11 : Creating Blast database 3 of 3

Running BLAST all-versus-all
----------------------------
Using 16 thread(s)
2021-02-23 14:38:11 : This may take some time....
```
Killed at 15:38 (1 hour) because it has not finished.


# Distance-based methods

We are following this [great tutorial](https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf).

The following commands are run inside R.

1. Installing necessary packages:
```r
install.packages("adegenet", dep=TRUE)
install.packages("phangorn", dep=TRUE)
```

2. Loading
```r
library(ape)
library(adegenet)
library(phangorn)
```

3. Loading the sample data
```r
dna <- fasta2DNAbin(file="http://adegenet.r-forge.r-project.org/files/usflu.fasta")
```

4. Computing the genetic distances. They choose a Tamura
and Nei 1993 model which allows for different rates of transitions and transversions, heterogeneous base frequencies, and between-site variation of the substitution rate.
```r
D <- dist.dna(dna, model="TN93")
```

5. Get the NJ tree
```r
tre <- nj(D)
```

6. Before plotting, we can use the [`ladderize` function](https://rdrr.io/cran/ape/man/ladderize.html) which reorganizes the internal structure of the tree to get the ladderized effect when plotted
```r
tre <- ladderize(tre)
```

7. We can plot the tree
```r
plot(tre, cex=.6)
title("A simple NJ tree")
```

# Parsimony method

We are following this [great tutorial](https://adegenet.r-forge.r-project.org/files/MSc-intro-phylo.1.1.pdf).

The following commands are run inside R.

1. Installing necessary packages (if you have not installed them for the distance section above)
```r
install.packages("adegenet", dep=TRUE)
install.packages("phangorn", dep=TRUE)
```

2. Loading
```r
library(ape)
library(adegenet)
library(phangorn)
```

3. Loading the sample data
```r
dna <- fasta2DNAbin(file="http://adegenet.r-forge.r-project.org/files/usflu.fasta")

## read as phangorn object:
dna2 <- as.phyDat(dna)
```

4. We need a starting tree for the search on tree space and compute the parsimony of this tree
```r
tre.ini <- nj(dist.dna(dna,model="raw"))
parsimony(tre.ini, dna2)
## 422
```

5. Search for the tree with maximum parsimony:
```r
tre.pars <- optim.parsimony(tre.ini, dna2)
## Final p-score 420 after  2 nni operations
```

6. Plot tree:
```r
plot(tre.pars, cex=0.6)
```

# Maximum Likelihood

## RAxML-NG

We are following HAL 1.3.

1. Download `raxml-ng` from [here](https://github.com/amkozlov/raxml-ng). You get a zipped folder: `raxml-ng_v1.0.2_macos_x86_64` which I placed in my `software` folder

2. Checking the version
```shell
cd Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/
./raxml-ng -v


RAxML-NG v. 1.0.2 released on 22.02.2021 by The Exelixis Lab.
Developed by: Alexey M. Kozlov and Alexandros Stamatakis.
Contributors: Diego Darriba, Tomas Flouri, Benoit Morel, Sarah Lutteropp, Ben Bettisworth.
Latest version: https://github.com/amkozlov/raxml-ng
Questions/problems/suggestions? Please visit: https://groups.google.com/forum/#!forum/raxml

System: Intel(R) Xeon(R) W-2191B CPU @ 2.30GHz, 18 cores, 256 GB RAM
```

3. We will clone the [ng-tutorial](https://github.com/amkozlov/ng-tutorial) to have the datasets and scripts. We do this inside the same folder above.
```shell
git clone https://github.com/amkozlov/ng-tutorial.git
```


4. Check for the MSA:
```shell
./raxml-ng --check --msa ng-tutorial/bad.fa --model GTR+G


RAxML-NG v. 1.0.2 released on 22.02.2021 by The Exelixis Lab.
Developed by: Alexey M. Kozlov and Alexandros Stamatakis.
Contributors: Diego Darriba, Tomas Flouri, Benoit Morel, Sarah Lutteropp, Ben Bettisworth.
Latest version: https://github.com/amkozlov/raxml-ng
Questions/problems/suggestions? Please visit: https://groups.google.com/forum/#!forum/raxml

System: Intel(R) Xeon(R) W-2191B CPU @ 2.30GHz, 18 cores, 256 GB RAM

RAxML-NG was called at 16-Mar-2021 13:45:06 as follows:

./raxml-ng --check --msa ng-tutorial/bad.fa --model GTR+G

Analysis options:
  run mode: Alignment validation
  start tree(s): 
  random seed: 1615920306
  SIMD kernels: AVX2
  parallelization: coarse-grained (auto), PTHREADS (auto)

[00:00:00] Reading alignment from file: ng-tutorial/bad.fa
[00:00:00] Loaded alignment with 9 taxa and 8 sites

WARNING: Fully undetermined columns found: 2

WARNING: Fully undetermined sequences found: 2

WARNING: Sequences t3 1200bp and t8 are exactly identical!
WARNING: Duplicate sequences found: 1

NOTE: Reduced alignment (with duplicates and gap-only sites/taxa removed) 
NOTE: was saved to: /Users/Clauberry/Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/ng-tutorial/bad.fa.raxml.reduced.phy

ERROR: Following taxon name contains invalid characters: t9'
ERROR: Following taxon name contains invalid characters: t6)
ERROR: Following taxon name contains invalid characters: t3 1200bp

NOTE: Following symbols are not allowed in taxa names to ensure Newick compatibility:
NOTE: " " (space), ";" (semicolon), ":" (colon), "," (comma), "()" (parentheses), "'" (quote). 
NOTE: Please either correct the names manually, or use the reduced alignment file
NOTE: generated by RAxML-NG (see above).

ERROR: Alignment check failed (see details above)!
```

RAXML tried to solve most of the issue and created the following files:
```
bad.fa.raxml.log
bad.fa.raxml.reduced.phy
```

5. Rerun the MSA check for the corrected file:
```shell
./raxml-ng --check --msa ng-tutorial/bad.fa.raxml.reduced.phy --model GTR+G


RAxML-NG v. 1.0.2 released on 22.02.2021 by The Exelixis Lab.
Developed by: Alexey M. Kozlov and Alexandros Stamatakis.
Contributors: Diego Darriba, Tomas Flouri, Benoit Morel, Sarah Lutteropp, Ben Bettisworth.
Latest version: https://github.com/amkozlov/raxml-ng
Questions/problems/suggestions? Please visit: https://groups.google.com/forum/#!forum/raxml

System: Intel(R) Xeon(R) W-2191B CPU @ 2.30GHz, 18 cores, 256 GB RAM

RAxML-NG was called at 16-Mar-2021 13:47:58 as follows:

./raxml-ng --check --msa ng-tutorial/bad.fa.raxml.reduced.phy --model GTR+G

Analysis options:
  run mode: Alignment validation
  start tree(s): 
  random seed: 1615920478
  SIMD kernels: AVX2
  parallelization: coarse-grained (auto), PTHREADS (auto)

[00:00:00] Reading alignment from file: ng-tutorial/bad.fa.raxml.reduced.phy
[00:00:00] Loaded alignment with 6 taxa and 6 sites

Alignment comprises 1 partitions and 6 sites

Partition 0: noname
Model: GTR+FO+G4m
Alignment sites: 6
Gaps: 13.89 %
Invariant sites: 16.67 %


Alignment can be successfully read by RAxML-NG.


Execution log saved to: /Users/Clauberry/Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/ng-tutorial/bad.fa.raxml.reduced.phy.raxml.log

Analysis started: 16-Mar-2021 13:47:58 / finished: 16-Mar-2021 13:47:58

Elapsed time: 0.002 seconds
```
Note that this file has only 6 sites!

6. We will do the check on a larger file with 12 taxa and 898 sites. For this case, raxml recommends that we use the `--parse` option to compress the sequences for efficient use in raxml:
```shell
./raxml-ng --parse --msa ng-tutorial/prim.phy --model GTR+G


RAxML-NG v. 1.0.2 released on 22.02.2021 by The Exelixis Lab.
Developed by: Alexey M. Kozlov and Alexandros Stamatakis.
Contributors: Diego Darriba, Tomas Flouri, Benoit Morel, Sarah Lutteropp, Ben Bettisworth.
Latest version: https://github.com/amkozlov/raxml-ng
Questions/problems/suggestions? Please visit: https://groups.google.com/forum/#!forum/raxml

System: Intel(R) Xeon(R) W-2191B CPU @ 2.30GHz, 18 cores, 256 GB RAM

RAxML-NG was called at 16-Mar-2021 13:53:07 as follows:

./raxml-ng --parse --msa ng-tutorial/prim.phy --model GTR+G

Analysis options:
  run mode: Alignment parsing and compression
  start tree(s): 
  random seed: 1615920787
  tip-inner: OFF
  pattern compression: ON
  per-rate scalers: OFF
  site repeats: ON
  branch lengths: proportional (ML estimate, algorithm: NR-FAST)
  SIMD kernels: AVX2
  parallelization: coarse-grained (auto), PTHREADS (auto)

[00:00:00] Reading alignment from file: ng-tutorial/prim.phy
[00:00:00] Loaded alignment with 12 taxa and 898 sites

Alignment comprises 1 partitions and 413 patterns

Partition 0: noname
Model: GTR+FO+G4m
Alignment sites / patterns: 898 / 413
Gaps: 0.28 %
Invariant sites: 41.98 %


NOTE: Binary MSA file created: ng-tutorial/prim.phy.raxml.rba

* Estimated memory requirements                : 2 MB

* Recommended number of threads / MPI processes: 2

Please note that numbers given above are rough estimates only. 
Actual memory consumption and parallel performance on your system may differ!

Alignment can be successfully read by RAxML-NG.


Execution log saved to: /Users/Clauberry/Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/ng-tutorial/prim.phy.raxml.log

Analysis started: 16-Mar-2021 13:53:07 / finished: 16-Mar-2021 13:53:07

Elapsed time: 0.003 seconds
```
**Question** Why do we need to specify the model here?

7. Infer the ML tree

```shell
./raxml-ng --msa ng-tutorial/prim.phy --model GTR+G --prefix T3 --threads 2 --seed 2
```
The above command will perform 20 tree searches using 10 random and 10 parsimony- based starting trees.

If we want to do more starting trees, see [option here](https://github.com/amkozlov/raxml-ng/wiki/Input-data#starting-trees).

Very important: set the `--seed` to be able to replicate the analyses exactly.

```shell
./raxml-ng --msa ng-tutorial/prim.phy --model GTR+G --prefix T3-myseed --threads 2 --seed 3162021


RAxML-NG v. 1.0.2 released on 22.02.2021 by The Exelixis Lab.
Developed by: Alexey M. Kozlov and Alexandros Stamatakis.
Contributors: Diego Darriba, Tomas Flouri, Benoit Morel, Sarah Lutteropp, Ben Bettisworth.
Latest version: https://github.com/amkozlov/raxml-ng
Questions/problems/suggestions? Please visit: https://groups.google.com/forum/#!forum/raxml

System: Intel(R) Xeon(R) W-2191B CPU @ 2.30GHz, 18 cores, 256 GB RAM

RAxML-NG was called at 16-Mar-2021 14:04:35 as follows:

./raxml-ng --msa ng-tutorial/prim.phy --model GTR+G --prefix T3-myseed --threads 2 --seed 3162021

Analysis options:
  run mode: ML tree search
  start tree(s): random (10) + parsimony (10)
  random seed: 3162021
  tip-inner: OFF
  pattern compression: ON
  per-rate scalers: OFF
  site repeats: ON
  fast spr radius: AUTO
  spr subtree cutoff: 1.000000
  branch lengths: proportional (ML estimate, algorithm: NR-FAST)
  SIMD kernels: AVX2
  parallelization: coarse-grained (auto), PTHREADS (2 threads), thread pinning: OFF

[00:00:00] Reading alignment from file: ng-tutorial/prim.phy
[00:00:00] Loaded alignment with 12 taxa and 898 sites

Alignment comprises 1 partitions and 413 patterns

Partition 0: noname
Model: GTR+FO+G4m
Alignment sites / patterns: 898 / 413
Gaps: 0.28 %
Invariant sites: 41.98 %


NOTE: Binary MSA file created: T3-myseed.raxml.rba

Parallelization scheme autoconfig: 2 worker(s) x 1 thread(s)

Parallel reduction/worker buffer size: 1 KB  / 0 KB

[00:00:00] Generating 10 random starting tree(s) with 12 taxa
[00:00:00] Generating 10 parsimony starting tree(s) with 12 taxa
[00:00:00] Data distribution: max. partitions/sites/weight per thread: 1 / 413 / 6608
[00:00:00] Data distribution: max. searches per worker: 10

Starting ML tree search with 20 distinct starting trees

[00:00:00 -7827.344127] Initial branch length optimization
[00:00:00 -7011.670732] Model parameter optimization (eps = 10.000000)
[00:00:00 -6170.320886] AUTODETECT spr round 1 (radius: 5)
[00:00:00 -5729.034582] AUTODETECT spr round 2 (radius: 10)
[00:00:00 -5729.030434] SPR radius for FAST iterations: 5 (autodetect)
[00:00:00 -5729.030434] Model parameter optimization (eps = 3.000000)
[00:00:00 -5721.119481] FAST spr round 1 (radius: 5)
[00:00:00 -5709.340669] FAST spr round 2 (radius: 5)
[00:00:00 -5709.340615] Model parameter optimization (eps = 1.000000)
[00:00:00 -5709.087525] SLOW spr round 1 (radius: 5)
[00:00:00] [worker #1] ML tree search #2, logLikelihood: -5708.925988
[00:00:00 -5709.080704] SLOW spr round 2 (radius: 10)
[00:00:00 -5709.080649] Model parameter optimization (eps = 0.100000)

[00:00:00] [worker #0] ML tree search #1, logLikelihood: -5708.994872

[00:00:00 -7667.412882] Initial branch length optimization
[00:00:00 -6978.829125] Model parameter optimization (eps = 10.000000)
[00:00:00 -6168.290720] AUTODETECT spr round 1 (radius: 5)
[00:00:00 -5744.435289] AUTODETECT spr round 2 (radius: 10)
[00:00:00 -5744.426628] SPR radius for FAST iterations: 5 (autodetect)
[00:00:00 -5744.426628] Model parameter optimization (eps = 3.000000)
[00:00:00 -5737.758089] FAST spr round 1 (radius: 5)
[00:00:00 -5709.399905] FAST spr round 2 (radius: 5)
[00:00:00 -5709.399485] Model parameter optimization (eps = 1.000000)
[00:00:00 -5709.055677] SLOW spr round 1 (radius: 5)
[00:00:01 -5709.055006] SLOW spr round 2 (radius: 10)
[00:00:01] [worker #1] ML tree search #4, logLikelihood: -5709.003899
[00:00:01 -5709.055002] Model parameter optimization (eps = 0.100000)

[00:00:01] [worker #0] ML tree search #3, logLikelihood: -5708.969195

[00:00:01 -7761.812115] Initial branch length optimization
[00:00:01 -7192.495441] Model parameter optimization (eps = 10.000000)
[00:00:01 -6364.697714] AUTODETECT spr round 1 (radius: 5)
[00:00:01 -5741.377222] AUTODETECT spr round 2 (radius: 10)
[00:00:01 -5741.373520] SPR radius for FAST iterations: 5 (autodetect)
[00:00:01 -5741.373520] Model parameter optimization (eps = 3.000000)
[00:00:01 -5733.875174] FAST spr round 1 (radius: 5)
[00:00:01 -5709.260444] FAST spr round 2 (radius: 5)
[00:00:01 -5709.259828] Model parameter optimization (eps = 1.000000)
[00:00:01 -5709.002819] SLOW spr round 1 (radius: 5)
[00:00:01] [worker #1] ML tree search #6, logLikelihood: -5709.579954
[00:00:01 -5709.002398] SLOW spr round 2 (radius: 10)
[00:00:01 -5709.002396] Model parameter optimization (eps = 0.100000)

[00:00:01] [worker #0] ML tree search #5, logLikelihood: -5708.961405

[00:00:01 -7669.970459] Initial branch length optimization
[00:00:01 -6991.829969] Model parameter optimization (eps = 10.000000)
[00:00:01 -6245.390662] AUTODETECT spr round 1 (radius: 5)
[00:00:01 -5780.045401] AUTODETECT spr round 2 (radius: 10)
[00:00:01 -5780.039423] SPR radius for FAST iterations: 5 (autodetect)
[00:00:01 -5780.039423] Model parameter optimization (eps = 3.000000)
[00:00:01 -5768.315977] FAST spr round 1 (radius: 5)
[00:00:02 -5709.307524] FAST spr round 2 (radius: 5)
[00:00:02 -5709.305903] Model parameter optimization (eps = 1.000000)
[00:00:02 -5708.990855] SLOW spr round 1 (radius: 5)
[00:00:02] [worker #1] ML tree search #8, logLikelihood: -5708.927625
[00:00:02 -5708.989050] SLOW spr round 2 (radius: 10)
[00:00:02 -5708.989044] Model parameter optimization (eps = 0.100000)

[00:00:02] [worker #0] ML tree search #7, logLikelihood: -5708.942480

[00:00:02 -7552.866465] Initial branch length optimization
[00:00:02 -6973.317807] Model parameter optimization (eps = 10.000000)
[00:00:02 -6203.075195] AUTODETECT spr round 1 (radius: 5)
[00:00:02 -5793.478160] AUTODETECT spr round 2 (radius: 10)
[00:00:02 -5793.460290] SPR radius for FAST iterations: 5 (autodetect)
[00:00:02 -5793.460290] Model parameter optimization (eps = 3.000000)
[00:00:02 -5789.314156] FAST spr round 1 (radius: 5)
[00:00:02 -5717.186654] FAST spr round 2 (radius: 5)
[00:00:02] [worker #1] ML tree search #10, logLikelihood: -5708.939968
[00:00:02 -5711.670768] FAST spr round 3 (radius: 5)
[00:00:02 -5711.670760] Model parameter optimization (eps = 1.000000)
[00:00:02 -5709.207639] SLOW spr round 1 (radius: 5)
[00:00:02 -5709.200464] SLOW spr round 2 (radius: 10)
[00:00:03 -5709.200442] Model parameter optimization (eps = 0.100000)

[00:00:03] [worker #0] ML tree search #9, logLikelihood: -5708.989525

[00:00:03 -6553.430050] Initial branch length optimization
[00:00:03 -6281.740036] Model parameter optimization (eps = 10.000000)
[00:00:03 -5722.929651] AUTODETECT spr round 1 (radius: 5)
[00:00:03 -5715.929670] AUTODETECT spr round 2 (radius: 10)
[00:00:03 -5715.929589] SPR radius for FAST iterations: 5 (autodetect)
[00:00:03 -5715.929589] Model parameter optimization (eps = 3.000000)
[00:00:03] [worker #1] ML tree search #12, logLikelihood: -5709.017898
[00:00:03 -5710.650249] FAST spr round 1 (radius: 5)
[00:00:03 -5710.624506] Model parameter optimization (eps = 1.000000)
[00:00:03 -5709.719275] SLOW spr round 1 (radius: 5)
[00:00:03 -5709.708839] SLOW spr round 2 (radius: 10)
[00:00:03 -5709.708702] Model parameter optimization (eps = 0.100000)

[00:00:03] [worker #0] ML tree search #11, logLikelihood: -5709.020378

[00:00:03 -6543.163074] Initial branch length optimization
[00:00:03 -6276.968345] Model parameter optimization (eps = 10.000000)
[00:00:03 -5716.021602] AUTODETECT spr round 1 (radius: 5)
[00:00:03 -5715.923419] SPR radius for FAST iterations: 5 (autodetect)
[00:00:03 -5715.923419] Model parameter optimization (eps = 3.000000)
[00:00:03] [worker #1] ML tree search #14, logLikelihood: -5709.018012
[00:00:03 -5710.646310] FAST spr round 1 (radius: 5)
[00:00:03 -5710.615380] Model parameter optimization (eps = 1.000000)
[00:00:03 -5709.710894] SLOW spr round 1 (radius: 5)
[00:00:03 -5709.701508] SLOW spr round 2 (radius: 10)
[00:00:04 -5709.701477] Model parameter optimization (eps = 0.100000)

[00:00:04] [worker #0] ML tree search #13, logLikelihood: -5709.017548

[00:00:04 -6553.430050] Initial branch length optimization
[00:00:04 -6281.728037] Model parameter optimization (eps = 10.000000)
[00:00:04 -5722.987968] AUTODETECT spr round 1 (radius: 5)
[00:00:04 -5715.912950] AUTODETECT spr round 2 (radius: 10)
[00:00:04 -5715.912842] SPR radius for FAST iterations: 5 (autodetect)
[00:00:04 -5715.912842] Model parameter optimization (eps = 3.000000)
[00:00:04] [worker #1] ML tree search #16, logLikelihood: -5709.021261
[00:00:04 -5710.640040] FAST spr round 1 (radius: 5)
[00:00:04 -5710.583448] Model parameter optimization (eps = 1.000000)
[00:00:04 -5709.712656] SLOW spr round 1 (radius: 5)
[00:00:04 -5709.687124] SLOW spr round 2 (radius: 10)
[00:00:04 -5709.686954] Model parameter optimization (eps = 0.100000)

[00:00:04] [worker #0] ML tree search #15, logLikelihood: -5709.017601

[00:00:04 -6553.430050] Initial branch length optimization
[00:00:04 -6281.724535] Model parameter optimization (eps = 10.000000)
[00:00:04 -5722.820956] AUTODETECT spr round 1 (radius: 5)
[00:00:04 -5715.844202] AUTODETECT spr round 2 (radius: 10)
[00:00:04 -5715.843887] SPR radius for FAST iterations: 5 (autodetect)
[00:00:04 -5715.843887] Model parameter optimization (eps = 3.000000)
[00:00:04] [worker #1] ML tree search #18, logLikelihood: -5709.012967
[00:00:04 -5710.601653] FAST spr round 1 (radius: 5)
[00:00:04 -5710.557183] Model parameter optimization (eps = 1.000000)
[00:00:04 -5709.697141] SLOW spr round 1 (radius: 5)
[00:00:04 -5709.674004] SLOW spr round 2 (radius: 10)
[00:00:04 -5709.673892] Model parameter optimization (eps = 0.100000)

[00:00:05] [worker #0] ML tree search #17, logLikelihood: -5709.020480

[00:00:05 -6543.163074] Initial branch length optimization
[00:00:05 -6277.021663] Model parameter optimization (eps = 10.000000)
[00:00:05 -5716.033447] AUTODETECT spr round 1 (radius: 5)
[00:00:05] [worker #1] ML tree search #20, logLikelihood: -5709.037466
[00:00:05 -5715.846753] AUTODETECT spr round 2 (radius: 10)
[00:00:05 -5715.844922] SPR radius for FAST iterations: 5 (autodetect)
[00:00:05 -5715.844922] Model parameter optimization (eps = 3.000000)
[00:00:05 -5710.671775] FAST spr round 1 (radius: 5)
[00:00:05 -5710.599745] Model parameter optimization (eps = 1.000000)
[00:00:05 -5709.704490] SLOW spr round 1 (radius: 5)
[00:00:05 -5709.677355] SLOW spr round 2 (radius: 10)
[00:00:05 -5709.677148] Model parameter optimization (eps = 0.100000)

[00:00:05] [worker #0] ML tree search #19, logLikelihood: -5709.013553


Optimized model parameters:

   Partition 0: noname
   Rate heterogeneity: GAMMA (4 cats, mean),  alpha: 0.368150 (ML),  weights&rates: (0.250000,0.012400) (0.250000,0.157595) (0.250000,0.694379) (0.250000,3.135626) 
   Base frequencies (ML): 0.355287 0.322178 0.080278 0.242257 
   Substitution rates (ML): 3.631208 44.119402 3.098326 2.370349 35.518029 1.000000 


Final LogLikelihood: -5708.925988

AIC score: 11477.851975 / AICc score: 11479.997304 / BIC score: 11621.857077
Free parameters (model + branch lengths): 30

Best ML tree saved to: /Users/Clauberry/Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/T3-myseed.raxml.bestTree
All ML trees saved to: /Users/Clauberry/Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/T3-myseed.raxml.mlTrees
Optimized model saved to: /Users/Clauberry/Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/T3-myseed.raxml.bestModel

Execution log saved to: /Users/Clauberry/Dropbox/software/raxml-ng_v1.0.2_macos_x86_64/T3-myseed.raxml.log

Analysis started: 16-Mar-2021 14:04:35 / finished: 16-Mar-2021 14:04:41

Elapsed time: 5.544 seconds
```

**Note:** We did not find any information on convergence of the algorithm.

## IQ-Tree

We are following the tutorial in [here](http://www.iqtree.org/workshop/molevol2019).

1. Download for mac [here](http://www.iqtree.org/#download). Downloaded a zipped folder `iqtree-1.6.12-MacOSX` and placed in `software`.

2. Check the installation worked, following steps [here](http://www.iqtree.org/doc/Quickstart).

Read carefully the output file as it provides information on starting tree and parameters used. No information found on convergence criteria, but they do provide information on how long it took to converge.

```shell
cd Dropbox/software/iqtree-1.6.12-MacOSX
bin/iqtree -s example.phy

IQ-TREE multicore version 1.6.12 for Mac OS X 64-bit built Aug 15 2019
Developed by Bui Quang Minh, Nguyen Lam Tung, Olga Chernomor,
Heiko Schmidt, Dominik Schrempf, Michael Woodhams.

Host:    C02Z60BVM0XV.local (AVX512, FMA3, 256 GB RAM)
Command: bin/iqtree -s example.phy
Seed:    391895 (Using SPRNG - Scalable Parallel Random Number Generator)
Time:    Sun Mar  7 07:48:19 2021
Kernel:  AVX+FMA - 1 threads (36 CPU cores detected)

HINT: Use -nt option to specify number of threads because your CPU has 36 cores!
HINT: -nt AUTO will automatically determine the best number of threads to use.

Reading alignment file example.phy ... Phylip format detected
Alignment most likely contains DNA/RNA sequences
Alignment has 17 sequences with 1998 columns, 1152 distinct patterns
1009 parsimony-informative, 303 singleton sites, 686 constant sites
           Gap/Ambiguity  Composition  p-value
   1  LngfishAu    0.15%    passed      6.20%
   2  LngfishSA    0.00%    failed      0.62%
   3  LngfishAf    0.05%    failed      1.60%
   4  Frog         0.05%    passed     58.01%
   5  Turtle       0.15%    passed     44.25%
   6  Sphenodon    0.10%    passed     59.78%
   7  Lizard       0.90%    passed     38.67%
   8  Crocodile    0.35%    failed      2.51%
   9  Bird         0.00%    failed      0.00%
  10  Human        0.00%    failed      0.85%
  11  Seal         0.00%    passed     68.93%
  12  Cow          0.00%    passed     59.11%
  13  Whale        0.00%    passed     97.83%
  14  Mouse        0.05%    failed      1.43%
  15  Rat          0.00%    passed     39.69%
  16  Platypus     0.00%    failed      3.46%
  17  Opossum      0.00%    failed      0.01%
****  TOTAL        0.11%  8 sequences failed composition chi2 test (p-value<5%; df=3)


Create initial parsimony tree by phylogenetic likelihood library (PLL)... 0.002 seconds
NOTE: ModelFinder requires 6 MB RAM!
ModelFinder will test 286 DNA models (sample size: 1998) ...
 No. Model         -LnL         df  AIC          AICc         BIC
  1  JC            23650.090    31  47362.181    47363.190    47535.778
  2  JC+I          22582.953    32  45229.905    45230.980    45409.102
  3  JC+G4         22261.254    32  44586.508    44587.583    44765.705
  4  JC+I+G4       22247.807    33  44561.614    44562.756    44746.411
  5  JC+R2         22284.451    33  44634.902    44636.044    44819.699
  6  JC+R3         22237.152    35  44544.304    44545.588    44740.300
  7  JC+R4         22237.058    37  44548.116    44549.550    44755.312
 14  F81+F         23509.732    34  47087.463    47088.676    47277.860
 15  F81+F+I       22401.487    35  44872.975    44874.259    45068.971
 16  F81+F+G4      22037.142    35  44144.285    44145.569    44340.281
 17  F81+F+I+G4    22024.011    36  44120.022    44121.381    44321.619
 18  F81+F+R2      22074.203    36  44220.406    44221.764    44422.002
 19  F81+F+R3      22015.103    38  44106.205    44107.718    44319.002
 20  F81+F+R4      22015.031    40  44110.061    44111.737    44334.057
 27  K2P           23306.003    32  46676.005    46677.080    46855.202
 28  K2P+I         22218.512    33  44503.024    44504.166    44687.820
 29  K2P+G4        21852.729    33  43771.457    43772.600    43956.254
 30  K2P+I+G4      21837.999    34  43743.998    43745.211    43934.395
 31  K2P+R2        21897.033    34  43862.067    43863.279    44052.464
 32  K2P+R3        21827.620    36  43727.239    43728.598    43928.836
 33  K2P+R4        21827.579    38  43731.159    43732.672    43943.955
 40  HKY+F         23122.817    35  46315.634    46316.919    46511.631
 41  HKY+F+I       21962.106    36  43996.212    43997.570    44197.808
 42  HKY+F+G4      21498.501    36  43069.001    43070.360    43270.598
 43  HKY+F+I+G4    21483.768    37  43041.535    43042.970    43248.732
 44  HKY+F+R2      21586.303    37  43246.606    43248.040    43453.802
 45  HKY+F+R3      21471.393    39  43020.786    43022.380    43239.183
 46  HKY+F+R4      21471.360    41  43024.721    43026.481    43254.317
 53  TNe           23212.914    33  46491.829    46492.971    46676.626
 54  TNe+I         22133.437    34  44334.873    44336.086    44525.270
 55  TNe+G4        21727.286    34  43522.572    43523.784    43712.969
 56  TNe+I+G4      21717.356    35  43504.711    43505.996    43700.708
 57  TNe+R2        21782.582    35  43635.164    43636.448    43831.160
 58  TNe+R3        21712.362    37  43498.724    43500.158    43705.920
 59  TNe+R4        21712.293    39  43502.585    43504.179    43720.981
 66  TN+F          22996.000    36  46064.000    46065.359    46265.597
 67  TN+F+I        21865.731    37  43805.463    43806.897    44012.659
 68  TN+F+G4       21381.494    37  42836.988    42838.423    43044.184
 69  TN+F+I+G4     21372.252    38  42820.505    42822.018    43033.301
 70  TN+F+R2       21468.251    38  43012.502    43014.015    43225.299
 71  TN+F+R3       21369.063    40  42818.126    42819.802    43042.122
 72  TN+F+R4       21369.053    42  42822.106    42823.953    43057.301
 79  K3P           23305.550    33  46677.101    46678.243    46861.897
 80  K3P+I         22218.096    34  44504.192    44505.405    44694.589
 81  K3P+G4        21852.521    34  43773.041    43774.254    43963.438
 82  K3P+I+G4      21837.967    35  43745.933    43747.218    43941.930
 83  K3P+R2        21896.658    35  43863.317    43864.601    44059.314
 84  K3P+R3        21827.528    37  43729.056    43730.490    43936.252
 85  K3P+R4        21827.427    39  43732.855    43734.448    43951.251
 92  K3Pu+F        23122.378    36  46316.756    46318.114    46518.352
 93  K3Pu+F+I      21961.415    37  43996.830    43998.265    44204.026
 94  K3Pu+F+G4     21498.044    37  43070.087    43071.522    43277.284
 95  K3Pu+F+I+G4   21483.337    38  43042.675    43044.188    43255.471
 96  K3Pu+F+R2     21585.224    38  43246.449    43247.962    43459.245
 97  K3Pu+F+R3     21471.104    40  43022.208    43023.885    43246.205
 98  K3Pu+F+R4     21471.067    42  43026.133    43027.981    43261.329
105  TPM2+F        22822.041    36  45716.081    45717.440    45917.678
106  TPM2+F+I      21713.154    37  43500.308    43501.743    43707.504
107  TPM2+F+G4     21311.672    37  42697.345    42698.780    42904.541
108  TPM2+F+I+G4   21298.849    38  42673.697    42675.210    42886.494
109  TPM2+F+R2     21369.634    38  42815.269    42816.782    43028.065
110  TPM2+F+R3     21290.291    40  42660.582    42662.258    42884.578
111  TPM2+F+R4     21290.280    42  42664.560    42666.407    42899.756
118  TPM2u+F       22822.039    36  45716.078    45717.436    45917.674
119  TPM2u+F+I     21713.155    37  43500.310    43501.745    43707.507
120  TPM2u+F+G4    21311.689    37  42697.378    42698.813    42904.575
121  TPM2u+F+I+G4  21298.832    38  42673.664    42675.177    42886.461
122  TPM2u+F+R2    21369.633    38  42815.267    42816.780    43028.063
123  TPM2u+F+R3    21290.291    40  42660.582    42662.258    42884.578
124  TPM2u+F+R4    21290.290    42  42664.580    42666.427    42899.776
131  TPM3+F        23121.230    36  46314.459    46315.818    46516.056
132  TPM3+F+I      21961.610    37  43997.220    43998.655    44204.417
133  TPM3+F+G4     21497.751    37  43069.501    43070.936    43276.698
134  TPM3+F+I+G4   21482.992    38  43041.983    43043.496    43254.779
135  TPM3+F+R2     21586.294    38  43248.589    43250.102    43461.385
136  TPM3+F+R3     21470.760    40  43021.519    43023.195    43245.515
137  TPM3+F+R4     21470.700    42  43025.400    43027.247    43260.596
144  TPM3u+F       23121.227    36  46314.454    46315.813    46516.051
145  TPM3u+F+I     21961.610    37  43997.219    43998.654    44204.416
146  TPM3u+F+G4    21497.747    37  43069.493    43070.928    43276.689
147  TPM3u+F+I+G4  21482.990    38  43041.981    43043.494    43254.777
148  TPM3u+F+R2    21586.295    38  43248.590    43250.103    43461.386
149  TPM3u+F+R3    21470.771    40  43021.542    43023.218    43245.538
150  TPM3u+F+R4    21470.686    42  43025.372    43027.220    43260.568
157  TIMe          23212.472    34  46492.944    46494.157    46683.341
158  TIMe+I        22133.046    35  44336.091    44337.376    44532.088
159  TIMe+G4       21727.188    35  43524.377    43525.661    43720.373
160  TIMe+I+G4     21717.269    36  43506.539    43507.897    43708.135
161  TIMe+R2       21782.296    36  43636.592    43637.951    43838.189
162  TIMe+R3       21712.262    38  43500.524    43502.037    43713.320
163  TIMe+R4       21712.214    40  43504.428    43506.104    43728.424
170  TIM+F         22995.561    37  46065.122    46066.556    46272.318
171  TIM+F+I       21865.037    38  43806.074    43807.587    44018.870
172  TIM+F+G4      21381.147    38  42838.295    42839.808    43051.091
173  TIM+F+I+G4    21371.853    39  42821.707    42823.300    43040.103
174  TIM+F+R2      21467.368    39  43012.736    43014.330    43231.132
175  TIM+F+R3      21368.698    41  42819.396    42821.157    43048.992
176  TIM+F+R4      21368.665    43  42823.331    42825.267    43064.127
183  TIM2e         22744.601    34  45557.202    45558.415    45747.599
184  TIM2e+I       21720.391    35  43510.781    43512.066    43706.778
185  TIM2e+G4      21330.698    35  42731.397    42732.681    42927.393
186  TIM2e+I+G4    21317.957    36  42707.915    42709.273    42909.511
187  TIM2e+R2      21385.483    36  42842.966    42844.324    43044.562
188  TIM2e+R3      21311.773    38  42699.545    42701.058    42912.342
189  TIM2e+R4      21311.627    40  42703.253    42704.929    42927.249
196  TIM2+F        22711.069    37  45496.139    45497.573    45703.335
197  TIM2+F+I      21627.479    38  43330.958    43332.471    43543.754
198  TIM2+F+G4     21172.248    38  42420.496    42422.009    42633.293
199  TIM2+F+I+G4   21164.169    39  42406.339    42407.932    42624.735
200  TIM2+F+R2     21250.859    39  42579.718    42581.311    42798.114
201  TIM2+F+R3     21161.472    41  42404.944    42406.705    42634.540
202  TIM2+F+R4     21161.448    43  42408.895    42410.832    42649.691
209  TIM3e         23211.506    34  46491.012    46492.224    46681.409
210  TIM3e+I       22132.948    35  44335.895    44337.180    44531.892
211  TIM3e+G4      21726.608    35  43523.217    43524.501    43719.213
212  TIM3e+I+G4    21716.695    36  43505.389    43506.748    43706.985
213  TIM3e+R2      21782.533    36  43637.066    43638.424    43838.662
214  TIM3e+R3      21711.819    38  43499.639    43501.152    43712.435
215  TIM3e+R4      21711.743    40  43503.487    43505.163    43727.483
222  TIM3+F        22994.252    37  46062.504    46063.938    46269.700
223  TIM3+F+I      21865.205    38  43806.411    43807.924    44019.207
224  TIM3+F+G4     21380.441    38  42836.881    42838.394    43049.678
225  TIM3+F+I+G4   21371.201    39  42820.403    42821.996    43038.799
226  TIM3+F+R2     21468.161    39  43014.322    43015.915    43232.718
227  TIM3+F+R3     21368.551    41  42819.103    42820.864    43048.699
228  TIM3+F+R4     21368.426    43  42822.851    42824.788    43063.647
235  TVMe          22817.713    35  45705.426    45706.711    45901.423
236  TVMe+I        21797.850    36  43667.700    43669.058    43869.296
237  TVMe+G4       21428.286    36  42928.571    42929.930    43130.168
238  TVMe+I+G4     21413.119    37  42900.238    42901.673    43107.434
239  TVMe+R2       21479.691    37  43033.382    43034.817    43240.578
240  TVMe+R3       21406.117    39  42890.235    42891.828    43108.631
241  TVMe+R4       21406.009    41  42894.018    42895.779    43123.614
248  TVM+F         22815.643    38  45707.287    45708.800    45920.083
249  TVM+F+I       21707.713    39  43493.427    43495.020    43711.823
250  TVM+F+G4      21307.950    39  42693.901    42695.494    42912.297
251  TVM+F+I+G4    21295.083    40  42670.167    42671.843    42894.163
252  TVM+F+R2      21366.214    40  42812.428    42814.104    43036.424
253  TVM+F+R3      21286.821    42  42657.641    42659.489    42892.837
254  TVM+F+R4      21286.745    44  42661.489    42663.517    42907.885
261  SYM           22738.988    36  45549.977    45551.335    45751.573
262  SYM+I         21715.761    37  43505.521    43506.956    43712.718
263  SYM+G4        21327.259    37  42728.517    42729.952    42935.714
264  SYM+I+G4      21314.475    38  42704.950    42706.463    42917.746
265  SYM+R2        21382.507    38  42841.013    42842.526    43053.810
266  SYM+R3        21308.459    40  42696.919    42698.595    42920.915
267  SYM+R4        21308.453    42  42700.906    42702.754    42936.102
274  GTR+F         22704.654    39  45487.308    45488.901    45705.704
275  GTR+F+I       21622.109    40  43324.218    43325.894    43548.214
276  GTR+F+G4      21168.172    40  42416.343    42418.019    42640.340
277  GTR+F+I+G4    21160.196    41  42402.391    42404.152    42631.987
278  GTR+F+R2      21247.035    41  42576.070    42577.831    42805.666
279  GTR+F+R3      21157.735    43  42401.470    42403.407    42642.266
280  GTR+F+R4      21157.665    45  42405.331    42407.452    42657.326
Akaike Information Criterion:           GTR+F+R3
Corrected Akaike Information Criterion: GTR+F+R3
Bayesian Information Criterion:         TIM2+F+I+G4
Best-fit model: TIM2+F+I+G4 chosen according to BIC

All model information printed to example.phy.model.gz
CPU time for ModelFinder: 9.083 seconds (0h:0m:9s)
Wall-clock time for ModelFinder: 9.134 seconds (0h:0m:9s)

NOTE: 2 MB RAM (0 GB) is required!
Estimate model parameters (epsilon = 0.100)
Thoroughly optimizing +I+G parameters from 10 start values...
Init pinv, alpha: 0.000, 1.000 / Estimate: 0.000, 0.485 / LogL: -21172.273
Init pinv, alpha: 0.038, 1.000 / Estimate: 0.047, 0.538 / LogL: -21168.913
Init pinv, alpha: 0.076, 1.000 / Estimate: 0.100, 0.618 / LogL: -21165.840
Init pinv, alpha: 0.114, 1.000 / Estimate: 0.123, 0.663 / LogL: -21164.910
Init pinv, alpha: 0.153, 1.000 / Estimate: 0.156, 0.736 / LogL: -21164.117
Init pinv, alpha: 0.191, 1.000 / Estimate: 0.185, 0.813 / LogL: -21164.278
Init pinv, alpha: 0.229, 1.000 / Estimate: 0.190, 0.826 / LogL: -21164.407
Init pinv, alpha: 0.267, 1.000 / Estimate: 0.190, 0.828 / LogL: -21164.424
Init pinv, alpha: 0.305, 1.000 / Estimate: 0.190, 0.827 / LogL: -21164.417
Init pinv, alpha: 0.343, 1.000 / Estimate: 0.189, 0.823 / LogL: -21164.376
Optimal pinv,alpha: 0.156, 0.736 / LogL: -21164.117

Parameters optimization took 1.048 sec
Computing ML distances based on estimated model parameters... 0.003 sec
Computing BIONJ tree...
0.000 seconds
Log-likelihood of BIONJ tree: -21157.759
--------------------------------------------------------------------
|             INITIALIZING CANDIDATE TREE SET                      |
--------------------------------------------------------------------
Generating 98 parsimony trees... 0.124 second
Computing log-likelihood of 98 initial trees ... 0.421 seconds
Current best score: -21157.759

Do NNI search on 20 best initial trees
Estimate model parameters (epsilon = 0.100)
BETTER TREE FOUND at iteration 1: -21157.726
Estimate model parameters (epsilon = 0.100)
BETTER TREE FOUND at iteration 2: -21152.527
Iteration 10 / LogL: -21157.757 / Time: 0h:0m:1s
Iteration 20 / LogL: -21152.533 / Time: 0h:0m:2s
Finish initializing candidate tree set (2)
Current best tree score: -21152.527 / CPU time: 1.086
Number of iterations: 20
--------------------------------------------------------------------
|               OPTIMIZING CANDIDATE TREE SET                      |
--------------------------------------------------------------------
Iteration 30 / LogL: -21152.781 / Time: 0h:0m:2s (0h:0m:6s left)
Iteration 40 / LogL: -21157.761 / Time: 0h:0m:2s (0h:0m:4s left)
Iteration 50 / LogL: -21154.462 / Time: 0h:0m:3s (0h:0m:3s left)
Iteration 60 / LogL: -21152.551 / Time: 0h:0m:3s (0h:0m:2s left)
Iteration 70 / LogL: -21157.853 / Time: 0h:0m:3s (0h:0m:1s left)
Iteration 80 / LogL: -21152.557 / Time: 0h:0m:4s (0h:0m:1s left)
Iteration 90 / LogL: -21152.770 / Time: 0h:0m:4s (0h:0m:0s left)
Iteration 100 / LogL: -21152.797 / Time: 0h:0m:4s (0h:0m:0s left)
TREE SEARCH COMPLETED AFTER 103 ITERATIONS / Time: 0h:0m:4s

--------------------------------------------------------------------
|                    FINALIZING TREE SEARCH                        |
--------------------------------------------------------------------
Performs final model parameters optimization
Estimate model parameters (epsilon = 0.010)
1. Initial log-likelihood: -21152.527
Optimal log-likelihood: -21152.525
Rate parameters:  A-C: 5.58313  A-G: 7.64725  A-T: 5.58313  C-G: 1.00000  C-T: 22.61200  G-T: 1.00000
Base frequencies:  A: 0.355  C: 0.228  G: 0.192  T: 0.225
Proportion of invariable sites: 0.157
Gamma shape alpha: 0.734
Parameters optimization took 1 rounds (0.010 sec)
BEST SCORE FOUND : -21152.525
Total tree length: 4.216

Total number of iterations: 103
CPU time used for tree search: 3.819 sec (0h:0m:3s)
Wall-clock time used for tree search: 3.827 sec (0h:0m:3s)
Total CPU time used: 4.892 sec (0h:0m:4s)
Total wall-clock time used: 4.903 sec (0h:0m:4s)

Analysis results written to: 
  IQ-TREE report:                example.phy.iqtree
  Maximum-likelihood tree:       example.phy.treefile
  Likelihood distances:          example.phy.mldist
  Screen log file:               example.phy.log

Date and Time: Sun Mar  7 07:48:33 2021
```

## MrBayes

Following [this tutorial](http://hydrodictyon.eeb.uconn.edu/eebedia/index.php/Phylogenetics:_MrBayes_Lab).

1. Download MrBayes from [here](http://nbisweden.github.io/MrBayes/). In mac:
```shell
brew tap brewsci/bio
brew install mrbayes --with-open-mpi

$ which mb
/usr/local/bin/mb
```

Had to troubleshoot a lot!
```shell
brew reinstall mrbayes
sudo chown -R $(whoami) /usr/local/Cellar/open-mpi/4.1.0
brew reinstall mrbayes
```

2. Download the data (`algaemb.nex`)

```shell
cd Dropbox/Documents/teaching/phylogenetics-class/BOT563/data
curl -O http://hydrodictyon.eeb.uconn.edu/people/plewis/courses/phylogenetics/data/algaemb.nex
```

3. Now, we want to create a mrbayes block. I do this in a separate text file called `mbblock.txt`. Note that we need to add `mcmc;sumt;` at the end so that the mb block is executed.
`mcmc` is the command to run MCMC and `sumt` is the command to obtain a summary tree.

```
begin mrbayes;
 set autoclose=yes;
 prset brlenspr=unconstrained:exp(10.0);
 prset shapepr=exp(1.0);
 prset tratiopr=beta(1.0,1.0);
 prset statefreqpr=dirichlet(1.0,1.0,1.0,1.0);
 lset nst=2 rates=gamma ngammacat=4;
 mcmcp ngen=10000 samplefreq=10 printfreq=100 nruns=1 nchains=3 savebrlens=yes;
 outgroup Anacystis_nidulans;
 mcmc;
 sumt;
end;
```

4. Now, I append the MrBayes block to the end of the nexus file with the data `algaemb.nex`:

```shell
cat algaemb.nex mbblock.txt > algaemb-mb.nex
```

5. Now, we run MrBayes:

```shell
mb algaemb-mb.nex



                            MrBayes 3.2.7a x86_64

                      (Bayesian Analysis of Phylogeny)

                             (Parallel version)
                         (1 processors available)

              Distributed under the GNU General Public License


               Type "help" or "help <command>" for information
                     on the commands that are available.

                   Type "about" for authorship and general
                       information about the program.



   Executing file "algaemb-mb.nex"
   DOS line termination
   Longest line length = 80
   Parsing file
   Expecting NEXUS formatted file
   Reading taxa block
      Allocated taxon set
      Defining new set of 8 taxa
   Exiting taxa block
   Deleting previously defined taxa
   Reading data block
      Allocated taxon set
      Allocated matrix
      Defining new matrix with 8 taxa and 920 characters
      Data is Rna
      Missing data coded as ?
      Gaps coded as -
      Taxon 1 -> Tobacco
      Taxon 2 -> Rice
      Taxon 3 -> Marchantia
      Taxon 4 -> Chlamydomonas
      Taxon 5 -> Chlorella
      Taxon 6 -> Euglena
      Taxon 7 -> Anacystis_nidulans
      Taxon 8 -> Olithodiscus
      Successfully read matrix
      Setting default partition (does not divide up characters)
      Setting model defaults
      Seed (for generating default start values) = 1617459021
      Setting output file names to "algaemb-mb.nex.run<i>.<p|t>"
   Exiting data block
   Reading mrbayes block
      Setting autoclose to yes
      Setting Brlenspr to Unconstrained:Exponential(10.00)
      Successfully set prior model parameters
      Setting Shapepr to Exponential(1.00)
      Successfully set prior model parameters
      Setting Tratiopr to Beta(1.00,1.00)
      Successfully set prior model parameters
      Setting Statefreqpr to Dirichlet(1.00,1.00,1.00,1.00)
      Successfully set prior model parameters
      Setting Nst to 2
      Setting Rates to Gamma
      Setting Ngammacat to 4
      Successfully set likelihood model parameters
      Setting number of generations to 10000
      Setting sample frequency to 10
      Setting print frequency to 100
      WARNING: Reallocation of zero size attempted. This is probably a bug. Problems may follow.
      WARNING: Reallocation of zero size attempted. This is probably a bug. Problems may follow.
      Setting number of runs to 1
      WARNING: Allocation of zero size attempted. This is probably a bug; problems may follow.
      Setting number of chains to 3
      Setting chain output file names to "algaemb-mb.nex.<p/t>"
      Successfully set chain parameters
      Setting outgroup to taxon "Anacystis_nidulans"
      Running Markov chain
      MCMC stamp = 8063218354
      Seed = 989486596
      Swapseed = 1617459021
      Model settings:

         Data not partitioned --
            Datatype  = RNA
            Nucmodel  = 4by4
            Nst       = 2
                        Transition and transversion  rates, expressed
                        as proportions of the rate sum, have a
                        Beta(1.00,1.00) prior
            Covarion  = No
            # States  = 4
                        State frequencies have a Dirichlet prior
                        (1.00,1.00,1.00,1.00)
            Rates     = Gamma
                        The distribution is approximated using 4 categories.
                        Shape parameter is exponentially
                        distributed with parameter (1.00).

      Active parameters: 

         Parameters
         ---------------------
         Tratio              1
         Statefreq           2
         Shape               3
         Ratemultiplier      4
         Topology            5
         Brlens              6
         ---------------------

         1 --  Parameter  = Tratio
               Type       = Transition and transversion rates
               Prior      = Beta(1.00,1.00)

         2 --  Parameter  = Pi
               Type       = Stationary state frequencies
               Prior      = Dirichlet

         3 --  Parameter  = Alpha
               Type       = Shape of scaled gamma distribution of site rates
               Prior      = Exponential(1.00)

         4 --  Parameter  = Ratemultiplier
               Type       = Partition-specific rate multiplier
               Prior      = Fixed(1.0)

         5 --  Parameter  = Tau
               Type       = Topology
               Prior      = All topologies equally probable a priori
               Subparam.  = V

         6 --  Parameter  = V
               Type       = Branch lengths
               Prior      = Unconstrained:Exponential(10.0)


      Number of chains per MPI processor = 3

      The MCMC sampler will use the following moves:
         With prob.  Chain will use move
            1.89 %   Dirichlet(Tratio)
            0.94 %   Dirichlet(Pi)
            0.94 %   Slider(Pi)
            1.89 %   Multiplier(Alpha)
            9.43 %   ExtSPR(Tau,V)
            9.43 %   ExtTBR(Tau,V)
            9.43 %   NNI(Tau,V)
            9.43 %   ParsSPR(Tau,V)
           37.74 %   Multiplier(V)
           13.21 %   Nodeslider(V)
            5.66 %   TLMultiplier(V)

      Division 1 has 178 unique site patterns
      Initializing conditional likelihoods

      Running benchmarks to automatically select fastest BEAGLE resource... 
      Using BEAGLE v3.1.2 resource 0 for division 1:
         Rsrc Name : CPU
         Impl Name : CPU-4State-Single
         Flags: PROCESSOR_CPU PRECISION_SINGLE COMPUTATION_SYNCH EIGEN_REAL
                SCALING_MANUAL SCALERS_RAW VECTOR_NONE THREADING_CPP         MODEL STATES: 4

      Initial log likelihoods and log prior probs:
         Chain 1 -- -3759.825459 -- 18.876285
         Chain 2 -- -3702.099422 -- 18.876285
         Chain 3 -- -3739.136439 -- 18.876285


      Chain results (10000 generations requested):

         0 -- [-3759.825] (-3702.099) (-3739.136) (...0 remote chains...) 
       100 -- (-3353.395) (-3347.153) [-3280.734] (...0 remote chains...) -- 0:00:00
       200 -- (-3306.317) (-3298.108) [-3241.949] (...0 remote chains...) -- 0:00:00
       300 -- (-3283.194) [-3227.173] (-3225.352) (...0 remote chains...) -- 0:00:00
       400 -- (-3281.870) (-3224.687) [-3224.098] (...0 remote chains...) -- 0:00:00
       500 -- (-3266.355) (-3199.826) [-3182.320] (...0 remote chains...) -- 0:00:00
       600 -- (-3241.760) (-3203.766) [-3183.467] (...0 remote chains...) -- 0:00:00
       700 -- (-3236.628) (-3200.126) [-3185.338] (...0 remote chains...) -- 0:00:00
       800 -- (-3231.015) (-3194.926) [-3180.164] (...0 remote chains...) -- 0:00:00
       900 -- (-3217.827) (-3184.216) [-3178.889] (...0 remote chains...) -- 0:00:00
      1000 -- (-3195.190) [-3184.355] (-3183.678) (...0 remote chains...) -- 0:00:00
      1100 -- (-3192.223) [-3178.895] (-3179.926) (...0 remote chains...) -- 0:00:00
      1200 -- (-3178.715) [-3179.211] (-3176.804) (...0 remote chains...) -- 0:00:00
      1300 -- (-3176.553) (-3177.750) [-3178.823] (...0 remote chains...) -- 0:00:00
      1400 -- (-3176.467) [-3179.437] (-3181.574) (...0 remote chains...) -- 0:00:00
      1500 -- [-3183.282] (-3176.957) (-3180.743) (...0 remote chains...) -- 0:00:00
      1600 -- (-3181.371) (-3178.273) [-3180.235] (...0 remote chains...) -- 0:00:00
      1700 -- [-3179.620] (-3175.754) (-3184.869) (...0 remote chains...) -- 0:00:00
      1800 -- [-3179.730] (-3174.753) (-3183.184) (...0 remote chains...) -- 0:00:00
      1900 -- (-3180.505) [-3179.671] (-3186.008) (...0 remote chains...) -- 0:00:00
      2000 -- [-3184.664] (-3182.241) (-3186.777) (...0 remote chains...) -- 0:00:00
      2100 -- (-3180.064) [-3188.069] (-3188.436) (...0 remote chains...) -- 0:00:00
      2200 -- [-3181.685] (-3180.572) (-3180.552) (...0 remote chains...) -- 0:00:00
      2300 -- (-3179.195) (-3180.901) [-3176.199] (...0 remote chains...) -- 0:00:00
      2400 -- (-3178.852) (-3184.149) [-3176.425] (...0 remote chains...) -- 0:00:00
      2500 -- (-3184.212) (-3175.047) [-3179.531] (...0 remote chains...) -- 0:00:00
      2600 -- (-3182.521) [-3176.479] (-3177.626) (...0 remote chains...) -- 0:00:00
      2700 -- (-3182.899) (-3179.200) [-3183.085] (...0 remote chains...) -- 0:00:00
      2800 -- (-3182.914) [-3177.533] (-3180.915) (...0 remote chains...) -- 0:00:00
      2900 -- (-3180.871) (-3179.146) [-3185.498] (...0 remote chains...) -- 0:00:00
      3000 -- [-3186.474] (-3180.030) (-3177.632) (...0 remote chains...) -- 0:00:00
      3100 -- (-3183.345) (-3179.069) [-3176.737] (...0 remote chains...) -- 0:00:00
      3200 -- (-3175.511) [-3181.196] (-3178.613) (...0 remote chains...) -- 0:00:00
      3300 -- [-3176.828] (-3181.322) (-3182.329) (...0 remote chains...) -- 0:00:00
      3400 -- (-3176.869) [-3180.169] (-3176.778) (...0 remote chains...) -- 0:00:00
      3500 -- (-3174.747) (-3180.622) [-3177.945] (...0 remote chains...) -- 0:00:00
      3600 -- (-3179.714) [-3178.250] (-3179.186) (...0 remote chains...) -- 0:00:00
      3700 -- (-3179.598) (-3188.674) [-3184.173] (...0 remote chains...) -- 0:00:00
      3800 -- [-3177.332] (-3188.028) (-3182.412) (...0 remote chains...) -- 0:00:00
      3900 -- (-3178.186) [-3178.082] (-3186.137) (...0 remote chains...) -- 0:00:00
      4000 -- (-3173.430) [-3178.177] (-3187.433) (...0 remote chains...) -- 0:00:00
      4100 -- [-3175.895] (-3176.054) (-3178.803) (...0 remote chains...) -- 0:00:00
      4200 -- (-3180.242) (-3181.884) [-3175.935] (...0 remote chains...) -- 0:00:00
      4300 -- [-3182.494] (-3184.167) (-3175.051) (...0 remote chains...) -- 0:00:00
      4400 -- [-3183.247] (-3187.316) (-3176.281) (...0 remote chains...) -- 0:00:00
      4500 -- [-3179.956] (-3184.521) (-3184.126) (...0 remote chains...) -- 0:00:00
      4600 -- (-3183.176) (-3183.810) [-3179.572] (...0 remote chains...) -- 0:00:00
      4700 -- (-3185.077) [-3184.858] (-3181.104) (...0 remote chains...) -- 0:00:00
      4800 -- [-3178.355] (-3185.939) (-3179.460) (...0 remote chains...) -- 0:00:00
      4900 -- [-3174.345] (-3183.450) (-3180.649) (...0 remote chains...) -- 0:00:00
      5000 -- [-3178.869] (-3182.610) (-3182.627) (...0 remote chains...) -- 0:00:00
      5100 -- (-3186.838) [-3176.949] (-3185.346) (...0 remote chains...) -- 0:00:00
      5200 -- (-3175.196) (-3179.961) [-3183.729] (...0 remote chains...) -- 0:00:00
      5300 -- (-3185.150) (-3179.676) [-3181.571] (...0 remote chains...) -- 0:00:00
      5400 -- [-3181.734] (-3178.326) (-3185.810) (...0 remote chains...) -- 0:00:00
      5500 -- [-3182.337] (-3182.883) (-3184.292) (...0 remote chains...) -- 0:00:00
      5600 -- (-3185.635) [-3177.900] (-3179.411) (...0 remote chains...) -- 0:00:00
      5700 -- (-3181.867) (-3178.463) [-3179.230] (...0 remote chains...) -- 0:00:00
      5800 -- [-3178.576] (-3182.170) (-3177.209) (...0 remote chains...) -- 0:00:00
      5900 -- [-3180.475] (-3181.036) (-3180.487) (...0 remote chains...) -- 0:00:00
      6000 -- (-3184.769) [-3180.163] (-3187.583) (...0 remote chains...) -- 0:00:00
      6100 -- [-3178.123] (-3184.955) (-3185.543) (...0 remote chains...) -- 0:00:00
      6200 -- [-3177.295] (-3178.714) (-3176.608) (...0 remote chains...) -- 0:00:00
      6300 -- [-3186.024] (-3181.882) (-3183.340) (...0 remote chains...) -- 0:00:00
      6400 -- (-3179.892) (-3190.756) [-3179.995] (...0 remote chains...) -- 0:00:00
      6500 -- [-3179.452] (-3185.336) (-3183.170) (...0 remote chains...) -- 0:00:00
      6600 -- (-3176.169) [-3186.239] (-3182.716) (...0 remote chains...) -- 0:00:00
      6700 -- [-3179.675] (-3184.730) (-3181.033) (...0 remote chains...) -- 0:00:00
      6800 -- [-3175.040] (-3177.573) (-3188.196) (...0 remote chains...) -- 0:00:00
      6900 -- [-3175.664] (-3185.497) (-3184.356) (...0 remote chains...) -- 0:00:00
      7000 -- [-3177.964] (-3183.668) (-3184.600) (...0 remote chains...) -- 0:00:00
      7100 -- (-3180.991) (-3177.802) [-3179.543] (...0 remote chains...) -- 0:00:00
      7200 -- (-3175.904) [-3179.617] (-3181.589) (...0 remote chains...) -- 0:00:00
      7300 -- (-3184.867) (-3176.631) [-3187.276] (...0 remote chains...) -- 0:00:00
      7400 -- [-3178.121] (-3181.399) (-3181.721) (...0 remote chains...) -- 0:00:00
      7500 -- (-3178.015) [-3178.664] (-3177.271) (...0 remote chains...) -- 0:00:00
      7600 -- [-3185.636] (-3183.791) (-3173.629) (...0 remote chains...) -- 0:00:00
      7700 -- (-3185.497) (-3185.767) [-3174.464] (...0 remote chains...) -- 0:00:00
      7800 -- (-3183.996) (-3188.534) [-3176.742] (...0 remote chains...) -- 0:00:00
      7900 -- (-3184.967) [-3190.058] (-3177.931) (...0 remote chains...) -- 0:00:00
      8000 -- (-3180.265) (-3193.064) [-3177.111] (...0 remote chains...) -- 0:00:00
      8100 -- (-3186.522) [-3190.527] (-3178.535) (...0 remote chains...) -- 0:00:00
      8200 -- (-3179.201) (-3183.305) [-3179.911] (...0 remote chains...) -- 0:00:00
      8300 -- (-3177.099) [-3179.418] (-3180.000) (...0 remote chains...) -- 0:00:00
      8400 -- (-3178.369) [-3180.151] (-3181.331) (...0 remote chains...) -- 0:00:00
      8500 -- (-3179.846) (-3190.499) [-3179.051] (...0 remote chains...) -- 0:00:00
      8600 -- (-3176.245) (-3187.241) [-3183.481] (...0 remote chains...) -- 0:00:00
      8700 -- [-3177.287] (-3188.540) (-3184.361) (...0 remote chains...) -- 0:00:00
      8800 -- (-3175.809) [-3179.570] (-3179.106) (...0 remote chains...) -- 0:00:00
      8900 -- [-3175.401] (-3177.233) (-3178.733) (...0 remote chains...) -- 0:00:00
      9000 -- (-3174.233) [-3176.472] (-3178.749) (...0 remote chains...) -- 0:00:00
      9100 -- (-3174.608) [-3176.467] (-3181.590) (...0 remote chains...) -- 0:00:00
      9200 -- (-3176.358) [-3181.941] (-3176.371) (...0 remote chains...) -- 0:00:00
      9300 -- (-3185.855) [-3174.466] (-3171.889) (...0 remote chains...) -- 0:00:00
      9400 -- [-3178.352] (-3175.461) (-3173.370) (...0 remote chains...) -- 0:00:00
      9500 -- (-3173.858) (-3186.138) [-3175.535] (...0 remote chains...) -- 0:00:00
      9600 -- [-3176.441] (-3186.226) (-3174.411) (...0 remote chains...) -- 0:00:00
      9700 -- [-3177.655] (-3184.349) (-3175.636) (...0 remote chains...) -- 0:00:00
      9800 -- (-3179.726) (-3175.420) [-3176.869] (...0 remote chains...) -- 0:00:00
      9900 -- (-3180.197) (-3179.664) [-3180.942] (...0 remote chains...) -- 0:00:00
      10000 -- (-3182.122) (-3182.789) [-3176.193] (...0 remote chains...) -- 0:00:00

      Analysis completed in 1 second
      Analysis used 0.64 seconds of CPU time on processor 0
      Log likelihood of best state for "cold" chain was -3171.63

      Acceptance rates for the moves in the "cold" chain:
         With prob.   (last 100)   chain accepted proposals by move
            33.3 %     ( 37 %)     Dirichlet(Tratio)
             NA           NA       Dirichlet(Pi)
             NA           NA       Slider(Pi)
            41.9 %     ( 43 %)     Multiplier(Alpha)
             6.2 %     (  8 %)     ExtSPR(Tau,V)
             6.8 %     ( 11 %)     ExtTBR(Tau,V)
             9.0 %     ( 10 %)     NNI(Tau,V)
             9.5 %     (  3 %)     ParsSPR(Tau,V)
            49.3 %     ( 34 %)     Multiplier(V)
            32.7 %     ( 38 %)     Nodeslider(V)
            17.7 %     ( 18 %)     TLMultiplier(V)

      Chain swap information:

                 1     2     3 
           --------------------
         1 |        0.76  0.57 
         2 |  3255        0.75 
         3 |  3371  3374       

      Upper diagonal: Proportion of successful state exchanges between chains
      Lower diagonal: Number of attempted state exchanges between chains

      Chain information:

        ID -- Heat 
       -----------
         1 -- 1.00  (cold chain)
         2 -- 0.91 
         3 -- 0.83 

      Heat = 1 / (1 + T * (ID - 1))
         (where T = 0.10 is the temperature and ID is the chain number)

      Summarizing trees in file "algaemb-mb.nex.t"
      Using relative burnin ('relburnin=yes'), discarding the first 25 % of sampled trees
      Writing statistics to files algaemb-mb.nex.<parts|tstat|vstat|trprobs|con>
      Examining file ...
      Found one tree block in file "algaemb-mb.nex.t" with 1001 trees in last block

      Tree reading status:

      0      10      20      30      40      50      60      70      80      90     100
      v-------v-------v-------v-------v-------v-------v-------v-------v-------v-------v
      *********************************************************************************

      Read 1001 trees from last tree block (sampling 751 of them)
                                                                                   
      General explanation:                                                          
                                                                                   
      In an unrooted tree, a taxon bipartition (split) is specified by removing a   
      branch, thereby dividing the species into those to the left and those to the  
      right of the branch. Here, taxa to one side of the removed branch are denoted 
      '.' and those to the other side are denoted '*'. Specifically, the '.' symbol 
      is used for the taxa on the same side as the outgroup.                        
                                                                                   
      In a rooted or clock tree, the tree is rooted using the model and not by      
      reference to an outgroup. Each bipartition therefore corresponds to a clade,  
      that is, a group that includes all the descendants of a particular branch in  
      the tree.  Taxa that are included in each clade are denoted using '*', and    
      taxa that are not included are denoted using the '.' symbol.                  
                                                                                   
      The output first includes a key to all the bipartitions with frequency larger 
      or equual to (Minpartfreq) in at least one run. Minpartfreq is a parameter to 
      sumt command and currently it is set to 0.10.  This is followed by a table  
      with statistics for the informative bipartitions (those including at least    
      two taxa), sorted from highest to lowest probability. For each bipartition,   
      the table gives the number of times the partition or split was observed in all
      runs (#obs) and the posterior probability of the bipartition (Probab.), which 
      is the same as the split frequency. If several runs are summarized, this is   
      followed by the minimum split frequency (Min(s)), the maximum frequency       
      (Max(s)), and the standard deviation of frequencies (Stddev(s)) across runs.  
      The latter value should approach 0 for all bipartitions as MCMC runs converge.
                                                                                   
      This is followed by a table summarizing branch lengths, node heights (if a    
      clock model was used) and relaxed clock parameters (if a relaxed clock model  
      was used). The mean, variance, and 95 % credible interval are given for each 
      of these parameters. If several runs are summarized, the potential scale      
      reduction factor (PSRF) is also given; it should approach 1 as runs converge. 
      Node heights will take calibration points into account, if such points were   
      used in the analysis.                                                         
                                                                                    
      Note that Stddev may be unreliable if the partition is not present in all     
      runs (the last column indicates the number of runs that sampled the partition 
      if more than one run is summarized). The PSRF is not calculated at all if     
      the partition is not present in all runs.The PSRF is also sensitive to small  
      sample sizes and it should only be considered a rough guide to convergence    
      since some of the assumptions allowing one to interpret it as a true potential
      scale reduction factor are violated in MrBayes.                               
                                                                                    
      List of taxa in bipartitions:                                                 
                                                                                   
         1 -- Tobacco
         2 -- Rice
         3 -- Marchantia
         4 -- Chlamydomonas
         5 -- Chlorella
         6 -- Euglena
         7 -- Anacystis_nidulans
         8 -- Olithodiscus

      Key to taxon bipartitions (saved to file "algaemb-mb.nex.parts"):

      ID -- Partition
      --------------
       1 -- *.......
       2 -- .*......
       3 -- ..*.....
       4 -- ...*....
       5 -- ....*...
       6 -- .....*..
       7 -- ******.*
       8 -- .......*
       9 -- ***.....
      10 -- **......
      11 -- ******..
      12 -- ****....
      13 -- *****...
      14 -- ....**..
      15 -- .....*.*
      --------------

      Summary statistics for informative taxon bipartitions
         (saved to file "algaemb-mb.nex.tstat"):

      ID   #obs    Probab.
      --------------------
       9   750    0.998668
      10   750    0.998668
      11   669    0.890812
      12   601    0.800266
      13   442    0.588549
      14   272    0.362184
      15    81    0.107856
      --------------------

      Summary statistics for branch and node parameters
         (saved to file "algaemb-mb.nex.vstat"):

                                              95% HPD Interval
                                            --------------------
      Parameter      Mean       Variance     Lower       Upper       Median
      ---------------------------------------------------------------------
      length[1]     0.008161    0.000011    0.002427    0.014307    0.007719
      length[2]     0.023876    0.000032    0.013570    0.034100    0.023029
      length[3]     0.007419    0.000013    0.001953    0.014742    0.006779
      length[4]     0.104244    0.000249    0.078615    0.140039    0.102775
      length[5]     0.028415    0.000080    0.014044    0.048425    0.027800
      length[6]     0.131972    0.000478    0.090502    0.171280    0.130754
      length[7]     0.117047    0.000487    0.073892    0.158182    0.114494
      length[8]     0.109015    0.000353    0.078083    0.148798    0.107979
      length[9]     0.030881    0.000064    0.017233    0.048161    0.030458
      length[10]    0.020222    0.000031    0.011416    0.032282    0.019576
      length[11]    0.034847    0.000182    0.010263    0.062116    0.035234
      length[12]    0.014920    0.000056    0.000411    0.029187    0.014737
      length[13]    0.021550    0.000102    0.003188    0.039851    0.021096
      length[14]    0.015335    0.000047    0.003886    0.026494    0.014376
      length[15]    0.028468    0.000118    0.003274    0.044160    0.028945
      ---------------------------------------------------------------------




      Clade credibility values:

      /---------------------------------------------------------- Anacystis_nidul~ (7)
      |                                                                               
      |---------------------------------------------------------- Olithodiscus (8)
      |                                                                               
      |                                               /---------- Tobacco (1)
      |                                      /---100--+                               
      |                                      |        \---------- Rice (2)
      +                            /---100---+                                        
      |                            |         \------------------- Marchantia (3)
      |                  /----80---+                                                  
      |                  |         \----------------------------- Chlamydomonas (4)
      |         /---59---+                                                            
      |         |        \--------------------------------------- Chlorella (5)
      \----89---+                                                                     
                \------------------------------------------------ Euglena (6)
                                                                                      

      Phylogram (based on average branch lengths):

      /---------------------------------------- Anacystis_nidul~ (7)
      |                                                                               
      |-------------------------------------- Olithodiscus (8)
      |                                                                               
      |                                         /--- Tobacco (1)
      |                                   /-----+                                     
      |                                   |     \--------- Rice (2)
      +                        /----------+                                           
      |                        |          \-- Marchantia (3)
      |                   /----+                                                      
      |                   |    \------------------------------------ Chlamydomonas (4)
      |           /-------+                                                           
      |           |       \---------- Chlorella (5)
      \-----------+                                                                   
                  \---------------------------------------------- Euglena (6)
                                                                                      
      |----------------| 0.050 expected changes per site

      Calculating tree probabilities...

      Credible sets of trees (16 trees sampled):
         50 % credible set contains 2 trees
         90 % credible set contains 6 trees
         95 % credible set contains 8 trees
         99 % credible set contains 11 trees

   Exiting mrbayes block
   Reached end of file

   Tasks completed, exiting program because mode is noninteractive
   To return control to the command line after completion of file processing, 
   set mode to interactive with 'mb -i <filename>' (i is for interactive)
   or use 'set mode=interactive'
```

The command produces multiple output files:

```shell
(master) $ ls algaemb-mb.nex*
algaemb-mb.nex         algaemb-mb.nex.con.tre algaemb-mb.nex.parts   algaemb-mb.nex.tstat
algaemb-mb.nex.ckp     algaemb-mb.nex.mcmc    algaemb-mb.nex.t       algaemb-mb.nex.vstat
algaemb-mb.nex.ckp~    algaemb-mb.nex.p       algaemb-mb.nex.trprobs
```

For more on interpreting the results, continue reading the tutorial [here](http://hydrodictyon.eeb.uconn.edu/eebedia/index.php/Phylogenetics:_MrBayes_Lab#Running_MrBayes_and_interpreting_the_results).

- Note that the `prset` lines are setting up the priors (how to set priors? Look at the [MrBayes tutorial](http://hydrodictyon.eeb.uconn.edu/eebedia/index.php/Phylogenetics:_MrBayes_Lab))
- Note that the `lset` line is defining the substitution model (also check the MrBayes tutorial for other models; you can use the same model as for maximum likelihood)
- The `mcmcp` line has the settings for the MCMC. You DO NOT want to only run 10000 generations (ngen=10000). Please increase this number a lot for your project.
- Last, check out the Tracer tutorial (same link as MrBayes) on how we assess if the chain converged and had good mixing
