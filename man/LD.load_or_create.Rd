% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LD.R
\name{LD.load_or_create}
\alias{LD.load_or_create}
\title{Procure an LD matrix for fine-mapping}
\usage{
LD.load_or_create(
  locus_dir,
  subset_DT,
  force_new_LD = F,
  LD_reference = "1KGphase1",
  LD_genome_build = "hg19",
  superpopulation = "EUR",
  remote_LD = T,
  download_method = "direct",
  vcf_folder = NULL,
  LD_block = F,
  LD_block_size = 0.7,
  remove_correlates = F,
  fillNA = 0,
  verbose = T,
  server = F,
  remove_tmps = T,
  conda_env = "echoR",
  nThread = 4
)
}
\arguments{
\item{subset_DT}{The locus subset of the full summary stats file.}

\item{force_new_LD}{By default, if an LD matrix file for a given locus is already present,
then \pkg{echolocatoR} will just use the preexisting file.
Set \code{force_new_LD=T} to override this and extract a new subset.}

\item{LD_reference}{Which linkage disequilibrium reference panel do you want to use.
Options include:
\describe{
\item{"UKB"}{A pre-caclulated LD reference matrix from a subset of caucasian British individuals from the UK Biobank. See \href{https://www.biorxiv.org/content/10.1101/807792v2}{Wiessbrod et al. (2019)} for more details.}
\item{"1KGphase1"}{Download a subset of the 1000 Genomes Project Phase 1 vcf and calculate LD on the fly with plink.}
\item{"1KGphase3"}{Download a subset of the 1000 Genomes Project Phase 3 vcf and calculate LD on the fly with plink.}
\item{"<path>/*.vcf" or "<path>/*.vcf.gz"}{Alternatively, users can provide their own custom panel by supplying a list of \emph{.vcf} file path (one per locus) which \pkg{echolocatoR} will use to compute LD (using \emph{plink}).}
}}

\item{superpopulation}{Subset your LD reference panel by superopulation.
Setting the superpopulation is not currently possible when \code{LD_reference="UKB"}.
\href{https://www.internationalgenome.org/faq/which-populations-are-part-your-study/}{1KGphase1 options} include:
\describe{
\item{"AFR"}{African [descent]}
\item{"AMR"}{Ad-mixed American}
\item{"EAS"}{East Asian}
\item{"EUR"}{European}
\item{"SAS"}{South Asian}
}}

\item{remote_LD}{When acquiring LD matrices,
the default is to delete the full vcf or npz files after \pkg{echolocatoR} has extracted the necssary subset.
However, if you wish to keep these full files (which can be quite large) set \code{remote_LD=T}.}

\item{LD_block}{Calculate LD blocks with \emph{plink} and only include the block to which the lead SNP belongs.}

\item{LD_block_size}{Adjust the granularity of block sizes when \code{LD_block=T}.}

\item{remove_correlates}{A named list, where the names are the RSIDs of SNPs
whose LD correlates you wish to remove,
and the value is the absolute r2 threshold you wish to filter at for each RSID respectively
(e.g. \code{ remove_correlates = c("rs76904798"=.2, "rs10000737"=.8)}).
This will also remove the SNPs in \code{remove_correlates} themselves.}

\item{verbose}{Whether \pkg{echolocatoR} should be verbose or silent.}

\item{server}{Whether \pkg{echolocatoR} is being run on a computing cluster/server or on a local machine.}

\item{remove_tmps}{Whether to remove any temporary files (e.g. FINEMAP output files) after the pipeline is done running.}

\item{conda_env}{The name of a conda environment to use.}
}
\value{
A symmetric LD matrix of pairwise \emph{r} values.
}
\description{
Calculate and/or query linkage disequilibrium (LD) from reference panels (UK Biobank, 1000 Genomes),
or user-supplied datasets.
}
\details{
Options:
\itemize{
\item Download pre-computed LD matrix from UK Biobank.
\item Download raw vcf file from 1KG and compute LD on the fly.
\item Compute LD on the fly from a user-supplied vcf file.
\item Use a user-supplied pre-computed LD-matrix.
}
}
\examples{
\dontrun{
data("BST1"); data("locus_dir");
locus_dir <- file.path("~/Desktop",locus_dir)
 # BST1 <- limit_SNPs(500, BST1)

# UK Biobank LD
LD_matrix <- LD.load_or_create(locus_dir=locus_dir, subset_DT=BST1, LD_reference="UKB")

# 1000 Genomes
LD_matrix <- LD.load_or_create(locus_dir=locus_dir, subset_DT=BST1, LD_reference="1KGphase1", force_new_LD=T)

# Local vcf file
LD_reference="~/Desktop/results/GWAS/Nalls23andMe_2019/BST1/LD/BST1.1KGphase1.vcf.gz"
LD_matrix <- LD.load_or_create(locus_dir=locus_dir, subset_DT=BST1, LD_reference=LD_reference, force_new_LD=T)
}
}
\seealso{
Other LD: 
\code{\link{LD.1KG_download_vcf}()},
\code{\link{LD.1KG}()},
\code{\link{LD.LD_blocks}()},
\code{\link{LD.UKBiobank}()},
\code{\link{LD.calculate_LD}()},
\code{\link{LD.construct_subset_vcf_name}()},
\code{\link{LD.custom_panel}()},
\code{\link{LD.dprime_table}()},
\code{\link{LD.filter_LD}()},
\code{\link{LD.filter_vcf_gaston}()},
\code{\link{LD.filter_vcf}()},
\code{\link{LD.get_locus_vcf_folder}()},
\code{\link{LD.index_vcf}()},
\code{\link{LD.leadSNP_block}()},
\code{\link{LD.plink_LD}()},
\code{\link{LD.plink_file}()},
\code{\link{LD.plot_LD}()},
\code{\link{LD.query_vcf}()},
\code{\link{LD.rds_to_npz}()},
\code{\link{LD.read_bin}()},
\code{\link{LD.read_ld_table}()},
\code{\link{LD.run_plink_LD}()},
\code{\link{LD.save_LD_matrix}()},
\code{\link{LD.snpstats_get_LD}()},
\code{\link{LD.snpstats_get_MAF}()},
\code{\link{LD.translate_population}()},
\code{\link{LD.vcf_to_bed}()},
\code{\link{LDlinkR.LDproxy_batch}()},
\code{\link{popDat_1KGphase1}},
\code{\link{popDat_1KGphase3}},
\code{\link{saveSparse}()}
}
\concept{LD}
\keyword{internal}
