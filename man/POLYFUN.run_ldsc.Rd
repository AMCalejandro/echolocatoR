% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/POLYFUN.R
\name{POLYFUN.run_ldsc}
\alias{POLYFUN.run_ldsc}
\title{Run a modified version of S-LDSC}
\source{
https://www.biorxiv.org/content/10.1101/807792v3
}
\usage{
POLYFUN.run_ldsc(
  polyfun = NULL,
  output_dir = NULL,
  munged.path,
  min_INFO = 0.6,
  min_MAF = 0.05,
  annotations.path = file.path(polyfun, "example_data/annotations."),
  weights.path = file.path(polyfun, "example_data/weights."),
  prefix = "LDSC",
  chrom = "all",
  compute_ldscores = F,
  allow_missing_SNPs = T,
 
    munged_path = "/sc/arion/projects/pd-omics/tools/polyfun/Nalls23andMe_2019.sumstats_munged.parquet",
  ref.prefix = "/sc/arion/projects/pd-omics/data/1000_Genomes/Phase1/1000G.mac5eur.",
  freq.prefix = "/sc/arion/projects/pd-omics/tools/polyfun/1000G_frq/1000G.mac5eur.",
  conda_env = "echoR"
)
}
\description{
Modifications to S-LDSC include L2-regularization.
}
\seealso{
Other polyfun: 
\code{\link{POLYFUN.compute_priors}()},
\code{\link{POLYFUN.download_ref_files}()},
\code{\link{POLYFUN.find_polyfun_folder}()},
\code{\link{POLYFUN.finemapper}()},
\code{\link{POLYFUN.functional_enrichment}()},
\code{\link{POLYFUN.gather_annotations}()},
\code{\link{POLYFUN.gather_ldscores}()},
\code{\link{POLYFUN.get_precomputed_priors}()},
\code{\link{POLYFUN.h2_enrichment_SNPgroups_plot}()},
\code{\link{POLYFUN.h2_enrichment_SNPgroups}()},
\code{\link{POLYFUN.h2_enrichment}()},
\code{\link{POLYFUN.help}()},
\code{\link{POLYFUN.initialize}()},
\code{\link{POLYFUN.ldsc_annot_enrichment}()},
\code{\link{POLYFUN.munge_summ_stats}()},
\code{\link{POLYFUN.plot}()},
\code{\link{POLYFUN.prepare_snp_input}()},
\code{\link{POLYFUN.read_parquet}()},
\code{\link{POLYFUN_SUSIE}()}
}
\concept{polyfun}
\keyword{internal}
