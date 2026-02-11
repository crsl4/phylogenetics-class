---
layout: default
title: Tree Visualization
nav_order: 17
---

# Tree Visualization

We will use [ggtree](https://yulab-smu.top/treedata-book/) to visualize and compare trees.

First we need to install (and load) the packages:
```r
# install once if needed
# if you use Bioconductor: BiocManager::install(c("treeio","ggtree","tidytree"))
# CRAN: install.packages(c("ape","phytools","phangorn","dendextend"))

library(treeio)    # read.raxml(), read.iqtree(), root methods for treedata
library(ggtree)    # plotting and geom_*2 helpers
library(ape)       # read.tree, comparePhylo if desired
library(phytools)  # cophylo tanglegram plotting
library(phangorn)  # RF.dist (Robinson-Foulds) and other tree distances
library(ggplot2)
```

Now we read the trees:
```r
raxml_td <- read.tree("primatesAA-aligned-muscle-raxml-boostrap.raxml.bestTree")
iq_td    <- read.tree("primatesAA-aligned-muscle.fasta-iqtree-bootstrap.contree")
```

We need to check if the root is in the right place:
```r
plot(raxml_td)
nodelabels()

raxml_rooted = root(raxml_td, node=33, resolve.root=TRUE)
plot(raxml_rooted)
```

```r
plot(iq_td)
nodelabels()

iq_rooted = root(iq_td, node=31, resolve.root=TRUE)
plot(iq_rooted)
```

Now, different tree layouts with `ggtree`:
```r
ggtree(raxml_rooted, layout = "rectangular") + geom_tiplab()
ggtree(raxml_rooted, layout = "slanted")     + geom_tiplab()
ggtree(raxml_rooted, layout = "circular")    + geom_tiplab2() # tip labels wrapped nicely
ggtree(raxml_rooted, layout = "fan")         + geom_tiplab2(offset = 0.5)
```

Let's plot both trees side by side:
```r
# RAxML tree plot
p1 <- ggtree(raxml_rooted) +
  geom_tiplab(size = 3) +
  ggtitle("RAxML Tree")

# IQ-TREE plot
p2 <- ggtree(iq_rooted) +
  geom_tiplab(size = 3) +
  ggtitle("IQ-TREE Tree")
```

Now combine side by side:
```r
# install.packages("patchwork") if not installed
library(patchwork)

# put them side by side
p1 + p2 + plot_layout(ncol = 2)
```

Now, let's try to compare the trees:
```r
comparePhylo(raxml_rooted, iq_rooted) 
```

And visualize a co-phylogeny:
```r
co <- cophylo(raxml_rooted, iq_rooted, rotate = TRUE)
plot(co, link.lty = "dashed")
```

# Extra: adding more information to the plots

```r
# RAxML tree with bootstrap values
raxml_td <- read.iqtree("primatesAA-aligned-muscle-raxml-boostrap.raxml.support")
raxml_phy <- as.phylo(raxml_td)  # convert to phylo object

# IQ-TREE consensus tree with bootstrap
iq_td <- read.iqtree("primatesAA-aligned-muscle.fasta-iqtree-bootstrap.contree")
iq_phy <- as.phylo(iq_td)

raxml_rooted <- root(raxml_phy, node = 33, resolve.root = TRUE)
iq_rooted    <- root(iq_phy, node = 31, resolve.root = TRUE)
```

We can do first inspection of the trees:
```r
plot(raxml_rooted); nodelabels()
plot(iq_rooted); nodelabels()
```

Now we need a function to extract numeric bootstrap values:
```r
extract_bs <- function(tree) {
  if(is.null(tree$node.label)) return(NULL)
  as.numeric(tree$node.label)
}

raxml_bs <- extract_bs(raxml_rooted)
iq_bs    <- extract_bs(iq_rooted)
```

Now let's plot side by side:
```r
# Create ggtree objects
p1 <- ggtree(raxml_rooted) +
  geom_tiplab(size = 3) +
  geom_point2(aes(subset = !isTip & !is.na(label),
                  size = as.numeric(label)), color = "steelblue") +
  geom_text2(aes(subset = !isTip & !is.na(label),
                   label = label), hjust=-0.2, vjust=-0.2, size=3) +
 scale_size_continuous(range=c(2,6)) +  # adjust circle sizes
  ggtitle("RAxML Tree")

p2 <- ggtree(iq_rooted) +
  geom_tiplab(size = 3) +
  geom_point2(aes(subset = !isTip & !is.na(label),
                  size = as.numeric(label)), color = "darkred") +
    geom_text2(aes(subset = !isTip & !is.na(label),
                   label = label), hjust=-0.2, vjust=-0.2, size=3) +
 scale_size_continuous(range=c(2,6)) +  # adjust circle sizes
  ggtitle("IQ-TREE Tree")

# Side-by-side layout
p1 + p2 + plot_layout(ncol = 2)
```

