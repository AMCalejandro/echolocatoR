<img src='https://github.com/RajLabMSSM/echolocatoR/raw/master/inst/hex/hex.png' height='300'><br><br>
[![](https://img.shields.io/badge/devel%20version-0.2.2-black.svg)](https://github.com/RajLabMSSM/echolocatoR)
[![R build
status](https://github.com/RajLabMSSM/echolocatoR/workflows/R-CMD-check-bioc/badge.svg)](https://github.com/RajLabMSSM/echolocatoR/actions)
[![](https://img.shields.io/github/last-commit/RajLabMSSM/echolocatoR.svg)](https://github.com/RajLabMSSM/echolocatoR/commits/master)
[![](https://codecov.io/gh/RajLabMSSM/echolocatoR/branch/master/graph/badge.svg)](https://codecov.io/gh/RajLabMSSM/echolocatoR)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://cran.r-project.org/web/licenses/MIT)
[![](https://img.shields.io/badge/doi-10.1093/bioinformatics/btab658-blue.svg)](https://doi.org/10.1093/bioinformatics/btab658)
<h5>
Author: <i>Brian M. Schilder</i>
</h5>
<h5>
README updated: <i>Mar-04-2022</i>
</h5>

<center>
<h1>
) ) ) ) ))) :bat: echolocatoR :bat: ((( ( ( ( (
</h1>
</center>
<h3>
Automated statistical and functional fine-mapping with extensive access
to genome-wide datasets
</h3>
<hr>

If you use `echolocatoR`, please cite:

> Brian M Schilder, Jack Humphrey, Towfique Raj (2021) echolocatoR: an
> automated end-to-end statistical and functional genomic fine-mapping
> pipeline, *Bioinformatics*; btab658,
> <https://doi.org/10.1093/bioinformatics/btab658>

## Introduction

Fine-mapping methods are a powerful means of identifying causal variants
underlying a given phenotype, but are underutilized due to the technical
challenges of implementation. ***echolocatoR*** is an R package that
automates end-to-end genomics fine-mapping, annotation, and plotting in
order to identify the most probable causal variants associated with a
given phenotype.

It requires minimal input from users (a GWAS or QTL summary statistics
file), and includes a suite of statistical and functional fine-mapping
tools. It also includes extensive access to datasets (linkage
disequilibrium panels, epigenomic and genome-wide annotations, QTL).

The elimination of data gathering and preprocessing steps enables rapid
fine-mapping of many loci in any phenotype, complete with locus-specific
publication-ready figure generation. All results are merged into a
single per-SNP summary file for additional downstream analysis and
results sharing. Therefore ***echolocatoR*** drastically reduces the
barriers to identifying causal variants by making the entire
fine-mapping pipeline rapid, robust and scalable.

![echoFlow](./images/echolocatoR_Fig1.png)

## Documentation

### [Website](https://rajlabmssm.github.io/echolocatoR)

### [Getting started](https://rajlabmssm.github.io/echolocatoR/articles/echolocatoR)

### Bugs/requests

Please report any bugs/requests on [GitHub
Issues](https://github.com/RajLabMSSM/echolocatoR/issues).

[Contributions](https://github.com/RajLabMSSM/echolocatoR/pulls) are
welcome!

## Literature

### For applications of ***echolocatoR*** in the literature, please see:

> 1.  E Navarro, E Udine, K de Paiva Lopes, M Parks, G Riboldi, BM
>     Schilder…T Raj (2020) Dysregulation of mitochondrial and
>     proteo-lysosomal genes in Parkinson’s disease myeloid cells.
>     Nature Genetics. <https://doi.org/10.1101/2020.07.20.212407>
> 2.  BM Schilder, T Raj (2021) Fine-Mapping of Parkinson’s Disease
>     Susceptibility Loci Identifies Putative Causal Variants. Human
>     Molecular Genetics, ddab294,
>     <https://doi.org/10.1093/hmg/ddab294>  
> 3.  K de Paiva Lopes, G JL Snijders, J Humphrey, A Allan, M Sneeboer,
>     E Navarro, BM Schilder…T Raj (2022) Genetic analysis of the human
>     microglial transcriptome across brain regions, aging and disease
>     pathologies. Nature Genetics,
>     <https://doi.org/10.1038/s41588-021-00976-y>

<br>

## Installation

### General tips

-   We generally recommend users upgrading to R>=4.0.0 before trying to
    install *echolocatoR.* While *echolocatoR* should technically be
    able to run in R>=3.6.0, some additional challenges with getting
    dependency versions not to conflict with one another.

### Quick installation

In R:

``` r
if(!require("remotes")) install.packages("remotes")

remotes::install_github("RajLabMSSM/echolocatoR")
```

### Robust installation (*conda*)

As with most softwares, installation is half the battle. The easiest way
to install all of ***echolocatoR***’s dependencies (which include R,
Python, and command line tools) and make sure they play well together is
to create a [*conda*](https://docs.conda.io/en/latest/) environment.

1.  If you haven’t done so already, install
    [*conda*](https://docs.conda.io/en/latest/).

2.  In command line, create the env from the *.yml* file (this file
    tells *conda* what to install):
    `conda env create -f https://github.com/RajLabMSSM/echolocatoR/raw/master/inst/conda/echoR.yml`

3.  Activate the new env:  
    `conda activate echoR`

4.  Install *echolocatoR* from command line so that it installs
    **within** the *conda* env:

5.  Open Rstudio from the command line interface (not by clicking the
    Rstudio icon). This helps to ensure Rstudio can find the paths to
    the packages in the conda env:  
    `open model_celltype_conservation.Rproj`

    Alternatively, the *conda* env also comes with
    [*radian*](https://github.com/randy3k/radian), which is a convenient
    R console that’s much more advanced than the default R console, but
    doesn’t require access to a GUI. This can be especially useful on
    computing clusters that don’t support RStudio or other IDEs.  
    `radian`

6.  Finally, to make extra sure ***echolocatoR*** uses the packages in
    this env (esp. if using from RStudio), you can then supply the env
    name to the `finemap_loci()` function (and many other
    ***echolocatoR*** functions) using `conda_env="echoR"`.

### Clone installation (*Rstudio*)

Lastly, if you’d like (or if for some reason none of the other
installation methods are working for you), you can alternatively clone
and then build ***echolocatoR***:

1.  Clone *echolocatoR:  
    `git clone https://github.com/RajLabMSSM/echolocatoR.git`*
2.  Open *echolocatoR.Rproj* within the echolocatoR folder.
3.  Then, within *Rstudio*, build ***echolocatoR*** by clicking the
    following drop down menu items: `Build --> Install and Restart` (or
    pressing the keys `CMD + SHIFT + B` on a Mac).

### 

<br>

### Dependencies

#### R

For a full list of required and suggested packages, see
[DESCRIPTION](https://github.com/RajLabMSSM/echolocatoR/blob/master/DESCRIPTION).

Additionally, there’s some optional R dependencies (e.g.
[XGR](https://github.com/hfang-bristol/XGR),
[Rgraphviz](https://www.bioconductor.org/packages/release/bioc/html/Rgraphviz.html))
that can be a bit tricky to install, so we’ve removed them as
requirements and instead provided a separate R function that helps users
to install them afterwards if needed:

``` r
library(echolocatoR)
extra_installs()
```

#### Python

For a full list of required python packages, see the *conda* env
[*echoR.yml*](https://github.com/RajLabMSSM/echolocatoR/blob/master/inst/conda/echoR.yml).
But here are some of the key ones.

    - python>=3.6.1  
    - pandas>=0.25.0   
    - pandas-plink  
    - pyarrow  
    - fastparquet  
    - scipy  
    - scikit-learn  
    - tqdm  
    - bitarray  
    - networkx  
    - rpy2  
    - requests  

#### Command line

##### [tabix](http://www.htslib.org/doc/tabix.html)

-   Rapid querying of summary stats files.
-   To use it, specify `query_by="tabix"` in `finemap_loci()`.
-   If you encounter difficulties using a *conda* distribution of tabix,
    we recommend you uninstall it from the env and instead install its
    parent package, [*htslib*](https://anaconda.org/bioconda/htslib) as
    this should be more up to date. *htslib* is now included in the
    echoR *conda* env by default.
-   Alternatively, you may install *htslib* to your machine globally via
    [*Brew*](https://formulae.brew.sh/formula/htslib) (for Mac users) or
    from [source](http://www.htslib.org/download).

##### [bcftools](http://samtools.github.io/bcftools/bcftools.html)

-   Used here for filtering populations in vcf files.
-   Can be installed via
    [*Brew*](https://formulae.brew.sh/formula/bcftools) (for Mac users)
    or [*conda*](https://anaconda.org/bioconda/bcftools).

##### [axel](https://github.com/axel-download-accelerator/axel)

-   Rapid multi-core downloading of large files (e.g. LD matrices from
    UK Biobank).

-   To use it, specify `download_method="axel"` in `finemap_loci()`.

-   **Update**: A conda version of *axel* has been kindly provided by
    [@jdblischak](https://github.com/RajLabMSSM/echolocatoR/pull/23), no
    longer requiring a separate installation.

-   However, if you want to use *axel* without the conda env, see this
    [tutorial](https://www.tecmint.com/axel-commandline-download-accelerator-for-linux/)
    for more info on installation. Here’s a quick overview:

    -   **Mac**: Install [brew](https://brew.sh/), then:
        `brew install axel`
    -   **CentOS/RHEL 7**: `yum install epel-release; yum install axel`
    -   **Fedora**: `yum install axel; dnf install axel`
    -   **Debian Jessie (e.g. Ubuntu, Linux Mint)**:
        `aptitude install axel`

<br>

## Fine-mapping tools

***echolocatoR*** will automatically check whether you have the
necessary columns to run each tool you selected in
`finemap_loci(finemap_methods=...)`. It will remove any tools that for
which there are missing necessary columns, and produces a message
letting you know which columns are missing. Note that some columns (e.g.
`MAF`,`N`,`t-stat`) can be automatically inferred if missing.  
For easy reference, we list the necessary columns here as well.  
See `?finemap_loci()` for descriptions of these columns.  
All methods require the columns: `SNP`,`CHR`,`POS`,`Effect`,`StdErr`

Additional required columns:

### [ABF](https://cran.r-project.org/web/packages/coloc/vignettes/vignette.html)

#### `proportion_cases`,`MAF`

### [FINEMAP](http://www.christianbenner.com)

#### `A1`,`A2`,`MAF`,`N`

### [SuSiE](https://github.com/stephenslab/susieR)

#### `N`

### [PolyFun](https://github.com/omerwe/polyfun)

#### `A1`,`A2`,`P`,`N`

### [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0)

#### `A1`,`A2`,`t-stat`

### [GCTA-COJO](https://cnsgenomics.com/software/gcta/#COJO)

#### `A1`,`A2`,`Freq`,`P`,`N`

### [coloc](https://cran.r-project.org/web/packages/coloc/vignettes/vignette.html)

#### `N`,`MAF`

<br>

## Multi-finemap results files

The main output of ***echolocatoR*** are the multi-finemap files (for
example, `data("BST1")`). They are stored in the locus-specific
*Multi-finemap* subfolders.

### Column descriptions

-   **Standardized GWAS/QTL summary statistics**: e.g.
    `SNP`,`CHR`,`POS`,`Effect`,`StdErr`. See `?finemap_loci()` for
    descriptions of each.  
-   **leadSNP**: The designated proxy SNP per locus, which is the SNP
    with the smallest p-value by default.
-   **\<tool>.CS**: The 95% probability Credible Set (CS) to which a SNP
    belongs within a given fine-mapping tool’s results. If a SNP is not
    in any of the tool’s CS, it is assigned `NA` (or `0` for the
    purposes of plotting).  
-   **\<tool>.PP**: The posterior probability that a SNP is causal for a
    given GWAS/QTL trait.  
-   **Support**: The total number of fine-mapping tools that include the
    SNP in its CS.
-   **Consensus_SNP**: By default, defined as a SNP that is included in
    the CS of more than `N` fine-mapping tool(s), i.e. `Support>1`
    (default: `N=1`).  
-   **mean.PP**: The mean SNP-wise PP across all fine-mapping tools
    used.
-   **mean.CS**: If mean PP is greater than the 95% probability
    threshold (`mean.PP>0.95`) then `mean.CS` is 1, else 0. This tends
    to be a very stringent threshold as it requires a high degree of
    agreement between fine-mapping tools.

### Notes

-   Separate multi-finemap files are generated for each LD reference
    panel used, which is included in the file name (e.g.
    *UKB_LD.Multi-finemap.tsv.gz*).

-   Each fine-mapping tool defines its CS and PP slightly differently,
    so please refer to the associated original publications for the
    exact details of how these are calculated (links provided above).

<br>

## Datasets

For more detailed information about each dataset, use `?`:  
`R   library(echolocatoR)   ?NOTT_2019.interactome # example dataset`

### Epigenomic & genome-wide annotations

#### [Nott et al. (2019)](https://science.sciencemag.org/content/366/6469/1134.abstract)

-   Data from this publication contains results from cell type-specific
    (neurons, oligodendrocytes, astrocytes, microglia, & peripheral
    myeloid cells) epigenomic assays (H3K27ac, ATAC, H3K4me3) from human
    brain tissue.

-   For detailed metadata, see:

    ``` r
    data("NOTT_2019.bigwig_metadata")
    ```

-   Built-in datasets:

    -   Enhancer/promoter coordinates (as *GenomicRanges*)

    ``` r
    data("NOTT_2019.interactome")
    # Examples of the data nested in "NOTT_2019.interactome" object:
    NOTT_2019.interactome$`Neuronal promoters`
    NOTT_2019.interactome$`Neuronal enhancers`
    NOTT_2019.interactome$`Microglia promoters`
    NOTT_2019.interactome$`Microglia enhancers`
    ...
    ...
    ```

    -   PLAC-seq enhancer-promoter interactome coordinates

    ``` r
    NOTT_2019.interactome$H3K4me3_around_TSS_annotated_pe
    NOTT_2019.interactome$`Microglia interactome`
    NOTT_2019.interactome$`Neuronal interactome`
    NOTT_2019.interactome$`Oligo interactome`
    ...
    ...
    ```

-   API access to full bigWig files on UCSC Genome Browser, which
    includes

    -   Epigenomic reads (as *GenomicRanges*)  
    -   Aggregate epigenomic *score* for each cell type - assay
        combination

#### [Corces et al. (2020)](https://www.biorxiv.org/content/10.1101/2020.01.06.896159v1)

-   Data from this preprint contains results from bulk and single-cell
    chromatin accessibility epigenomic assays in 39 human brains.

    ``` r
    data("CORCES_2020.bulkATACseq_peaks")
    data("CORCES_2020.cicero_coaccessibility")
    data("CORCES_2020.HiChIP_FitHiChIP_loop_calls")
    data("CORCES_2020.scATACseq_celltype_peaks")
    data("CORCES_2020.scATACseq_peaks")
    ```

#### [XGR](http://xgr.r-forge.r-project.org)

-   API access to a diverse library of cell type/line-specific
    epigenomic (e.g. ENCODE) and other genome-wide annotations.

#### [Roadmap](http://www.roadmapepigenomics.org)

-   API access to cell type-specific epigenomic data.

#### [biomaRt](https://bioconductor.org/packages/release/bioc/html/biomaRt.html)

-   API access to various genome-wide SNP annotations (e.g. missense,
    nonsynonmous, intronic, enhancer).

#### [HaploR](https://cran.r-project.org/web/packages/haploR/vignettes/haplor-vignette.html)

-   API access to known per-SNP QTL and epigenomic data hits.

### QTLs

#### [eQTL Catalogue](https://www.ebi.ac.uk/eqtl/)

-   API access to full summary statistics from many standardized
    e/s/t-QTL datasets.  
-   Data access and colocalization tests facilitated through the
    [catalogueR](https://github.com/RajLabMSSM/catalogueR) R package.

<br>

## Enrichment tools

### [XGR](http://xgr.r-forge.r-project.org)

-   Binomial enrichment tests between customisable foreground and
    background SNPs.

### [GoShifter](https://github.com/immunogenomics/goshifter)

-   LD-informed iterative enrichment analysis.

### [S-LDSC](https://www.nature.com/articles/ng.3954)

-   Genome-wide stratified LD score regression.
-   Inlccles 187-annotation baseline model from [Gazal et al.
    2018](https://www.nature.com/articles/s41588-018-0231-8).  
-   You can alternatively supply a custom annotations matrix.

### [motifbreakR](https://github.com/Simon-Coetzee/motifBreakR)

-   Identification of transcript factor binding motifs (TFBM) and
    prediction of SNP disruption to said motifs.
-   Includes a comprehensive list of TFBM databases via
    [MotifDB](https://bioconductor.org/packages/release/bioc/html/MotifDb.html)
    (9,900+ annotated position frequency matrices from 14 public
    sources, for multiple organisms).

### [GARFIELD](https://www.bioconductor.org/packages/release/bioc/html/garfield.html) (**under construction**)

-   Genomic enrichment with LD-informed heuristics.

<br>

## LD reference panels

### [UK Biobank](https://www.ukbiobank.ac.uk)

### [1000 Genomes Phase 1](https://www.internationalgenome.org)

### [1000 Genomes Phase 3](https://www.internationalgenome.org)

<hr>

## Creator

<a href="https://bschilder.github.io/BMSchilder/" target="_blank">Brian
M. Schilder, Bioinformatician II</a>  
<a href="https://rajlab.org" target="_blank">Raj Lab</a>  
<a href="https://icahn.mssm.edu/about/departments/neuroscience" target="_blank">Department
of Neuroscience, Icahn School of Medicine at Mount Sinai</a>  
![Sinai](./images/sinai.png)
