# Notebook reproducible script for Botany 563 (Spring 2021)
Written by CSL

## To do
- look for assembly alternatives to trinity for Mac

## phyluce

### Installation

We are following the steps on the [Installation](https://phyluce.readthedocs.io/en/latest/installation.html).

1. Install Miniconda for pytho 2.7 by choosing the `Miniconda2 MacOSX 64-bit pkg` file from the list here: https://docs.conda.io/en/latest/miniconda.html

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

### ClustalW

1. Downloaded [ClustalW](http://www.clustal.org/clustal2/) file `clustalw-2.1-macosx.dmg` and copied the folder into `Dropbox/software`

2. Downloaded the `primatesAA.fasta` file from the Phylogenetic Handbook [website](https://www.kuleuven.be/aidslab/phylogenybook/Data_sets.html). I had to copy and paste the sequences into a file with the same name

```shell
cd Dropbox/Documents/teaching/phylogenetics-class/BOT563/data
grep ">" primatesAA.fasta | wc -l ## 22
```

3. We find the running commands in the [docs](http://www.clustal.org/download/clustalw_help.txt)

4. We run the command

```shell
$ ~/Dropbox/software/clustalw-2.1-macosx/clustalw2 -ALIGN -INFILE=primatesAA.fasta -OUTFILE=primatesAA-aligned.fasta -OUTPUT=PHYLIP

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

- Download the tar file from [here](http://www.tcoffee.org/Packages/Stable/Latest/): `T-COFFEE_distribution_Version_13.45.0.4846264.tar.gz`

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

## OrthoFinder

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

