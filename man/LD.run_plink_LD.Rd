% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LD.R
\name{LD.run_plink_LD}
\alias{LD.run_plink_LD}
\title{Calculate LD (r or r2)}
\usage{
LD.run_plink_LD(
  bim,
  LD_folder,
  plink_prefix = "plink",
  r_format = "r",
  extract_file = NULL
)
}
\arguments{
\item{bim}{A bim file produced by \emph{plink}}

\item{LD_folder}{Locus-specific LD output folder.}

\item{r_format}{Whether to fill the matrix with \code{r} or \code{r2}.}
}
\description{
This appriach computes and LD matrix of r or r2 (instead of D') from a vcf.
See \code{\link{LD.dprime_table}} for a slower (but more flexible) alternative to computing LD.
}
\examples{
\dontrun{
data("LRRK2")
LD_folder <- "/Users/schilder/Desktop/Fine_Mapping/Data/GWAS/Nalls23andMe_2019/LRRK2/plink/saved"
bim_path <- file.path(LD_folder, "plink.bim");
bim <- data.table::fread(bim_path, col.names = c("CHR","SNP","V3","POS","A1","A2"), stringsAsFactors = F)
bim <- subset(bim, SNP \%in\% LRRK2$SNP)
ld.bin <- file.path(LD_folder, paste0("plink",".ld.bin"))
SNPs <- data.table::fread(file.path(LD_folder,"SNPs.txt"), col.names = 'RSID')
bin.vector <- readBin(ld.bin, what = "numeric", n=length(SNPs$RSID)^2)
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
\code{\link{LD.load_or_create}()},
\code{\link{LD.plink_LD}()},
\code{\link{LD.plink_file}()},
\code{\link{LD.plot_LD}()},
\code{\link{LD.query_vcf}()},
\code{\link{LD.rds_to_npz}()},
\code{\link{LD.read_bin}()},
\code{\link{LD.read_ld_table}()},
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
