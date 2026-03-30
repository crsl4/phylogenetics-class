---
layout: default
title: Bayesian Inference (MrBayes)
nav_order: 16
---

# Bayesian Inference (MrBayes)

### Previous class check-up
- We studied Bayesian inference and focused on the main contributors to good or poor performance: priors, convergence and burnin.

### Learning objectives

At the end of today's session, you will be able to
- explain in details the MrBayes inference methods
- use MrBayes software


{: .important-title}
> Pre-class work
>
> Read the papers:
> [MrBayes1](https://academic.oup.com/bioinformatics/article/17/8/754/235132) and [MrBayes2](https://academic.oup.com/bioinformatics/article/19/12/1572/257621)


# In-class discussion

## Individual work (15 minutes)

**Instructions:** Based on the MrBayes papers you read, write down (somewhere) the following questions:

1. What limitations of existing phylogenetic methods motivated MrBayes?
  - What problems with maximum parsimony and early ML methods do the authors emphasize?
  - Which of these are biological concerns (e.g., uncertainty, model realism)?

2. What does “Bayesian phylogenetic inference” promise to users?
  - Direct probability statements about trees/clades
  - Integration over uncertainty (trees, parameters)
  - Use of prior information
  - Which of these would actually matter to you as a biologist?

3. What is the role of MCMC in this story?
  - Why can’t we just “compute” the posterior exactly?
  - What trade-off are we making by using MCMC?

4. What choices does the user have to make when running MrBayes?
  - Which of these choices are “biological” rather than statistical?

5. What could go wrong if the user treats MrBayes as a black box?

6. If you were reviewing a paper that used MrBayes, what would you want the authors to report?

## Whole class work (15 minutes)

Let's discuss the questions together!

{: .important }
**Take-home message:** always read carefully the paper and the documentation of any phylogenetic method you use

{: .note }
Create your own [cheatsheet](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/software-cheatsheet.md) with description, strengths, weaknesses, assumptions and user choices (and other things you find relevant).

# Software

1. Download MrBayes from [here](http://nbisweden.github.io/MrBayes/). 

In Mac, you can:
```shell
brew install mrbayes
```

And you can check installation with:
```
$ which mb
/usr/local/bin/mb
```

People can also install with `conda`"
```
conda install -c bioconda mrbayes
```

2. We will use a new dataset (`algaemb.nex`) in the [data folder](https://github.com/crsl4/phylogenetics-class/tree/master/data) in the class repository.


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

### Explanation of MrBayes commands

`begin mrbayes;`
Starts the MrBayes command block. All commands until end; are interpreted by MrBayes.

`set autoclose=yes;`
Automatically exits MrBayes after all commands in the block have finished executing (useful for non-interactive or scripted runs).

`prset brlenspr=unconstrained:exp(10.0);`
Sets the prior on branch lengths. Branch lengths are allowed to vary freely, with an exponential prior having mean 0.1 substitutions per site. This reflects the expectation that most branches are short but longer branches are possible.

`prset shapepr=exp(1.0);`
Sets the prior on the gamma shape parameter controlling rate variation among sites. An exponential prior with mean 1 assumes moderate rate heterogeneity while remaining weakly informative.

`prset tratiopr=beta(1.0,1.0);`
Sets the prior on the transition/transversion rate ratio. A Beta(1,1) distribution is uniform, indicating no prior preference for particular values.

`prset statefreqpr=dirichlet(1.0,1.0,1.0,1.0);`
Sets the prior on nucleotide base frequencies (A, C, G, T). A uniform Dirichlet prior assumes no prior bias toward any nucleotide composition.

`lset nst=2 rates=gamma ngammacat=4;`
Specifies the substitution model: the HKY model (separate transition and transversion rates) with gamma-distributed rate variation across sites, approximated using four rate categories.

`mcmcp ngen=10000 samplefreq=10 printfreq=100 nruns=1 nchains=3 savebrlens=yes;`
Sets MCMC run parameters: 10,000 generations, sampling every 10 generations, progress printed every 100 generations, one independent run with three chains (one cold, two heated), and branch lengths saved for sampled trees.

`outgroup Anacystis_nidulans;`
Specifies Anacystis_nidulans as the outgroup for rooting the tree, reflecting an external biological assumption about ancestry.

`mcmc;`
Executes the Markov chain Monte Carlo analysis using the specified model, priors, and run settings.

`sumt;`
Summarizes the sampled trees and produces a consensus tree with posterior probabilities for clades.

`end;`
Ends the MrBayes command block.


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

6. We now will use Tracer to assess if the chain converged and had good mixing.

We download Tracer [here](https://github.com/beast-dev/tracer/releases/tag/v1.7.2).

We need to `File -> Import Trace File` and select `algaemb-mb.nex.p`.

Look at the trace plot:
- Good behavior:
  - The trace looks like a fuzzy horizontal band
  - No obvious trends up or down after burn-in

- Bad behavior:
  - Strong trends
  - Long flat stretches
  - Sudden jumps followed by no mixing

ESS Rules of thumb:
- ESS > 200 → acceptable
- ESS > 500 → good
- ESS < 100 → problematic

We can do a quick and dirty plot in R:

```r
library(ape)
tre = read.nexus(file="algaemb-mb.nex.con.tre")
plot(tre)
```

{: .important }
After the computer lab, make sure to read the [MrBayes tutorial](https://github.com/gdw-workshop/2018_GDW_Workshop/blob/master/exercises/MrBayesTutorial.md) carefully to determine the appropriate MrBayes block for your data.

{: .important }
**Bonus points** for paying attention to the importants aspects that affect the performance of the chosen method.

{: .important }
**Double bonus points** for comparing how do results differ if we use an alignment from a different method. That is, `primatesAA-aligned-muscle.fasta` are the aligned sequences with MUSCLE. I can run MrBayes on this file and on `primatesAA-aligned.fasta` which was aligned with ClustalW and compare with the estimated trees.


# Homework

See the details of the Bayesian Inference HW in [here](https://github.com/crsl4/phylogenetics-class/blob/master/exercises/hw-bayesian.md). 