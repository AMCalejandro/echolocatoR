% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/UKBiobank_LD.R
\name{LD.rds_to_npz}
\alias{LD.rds_to_npz}
\title{Convert .RDS file back to .npz format}
\usage{
LD.rds_to_npz(rds_path, conda_env = "echoR", verbose = T)
}
\description{
Convert .RDS file back to .npz format
}
\examples{
\dontrun{
data("BST1")
npz_path <- LD.rds_to_npz(rds_path="/Users/schilder/Desktop/Fine_Mapping/Data/GWAS/Nalls23andMe_2019/BST1/plink/UKB_LD.RDS")
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
