% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/annotate.R
\name{ANNOTATE.plot_missense}
\alias{ANNOTATE.plot_missense}
\title{Plot any missense variants}
\usage{
ANNOTATE.plot_missense(
  merged_dat,
  snp_filter = "Support>0",
  label_yaxis = F,
  x_label = "UCS missense\\nmutations",
  show.legend = T,
  show_numbers = F,
  show_plot = T
)
}
\description{
Plot any missense variants
}
\examples{
\dontrun{
data("merged_DT");
gg_missense <- ANNOTATE.plot_missense(merged_dat=merged_DT, snp_filter="Support>0")
gg_missense <- ANNOTATE.plot_missense(merged_dat=merged_DT, snp_filter="Consensus_SNP==T")
}
}
\seealso{
Other annotate: 
\code{\link{ANNOTATE.annotate_missense}()},
\code{\link{SNPs_by_mutation_type}()},
\code{\link{biomart_geneInfo}()},
\code{\link{biomart_snp_info}()},
\code{\link{biomart_snps_to_geneInfo}()},
\code{\link{epigenetics_enrichment}()},
\code{\link{epigenetics_summary}()},
\code{\link{haploR.HaploReg}()},
\code{\link{haploR.regulomeDB}()},
\code{\link{merge_finemapping_results_each}()}
}
\concept{annotate}
