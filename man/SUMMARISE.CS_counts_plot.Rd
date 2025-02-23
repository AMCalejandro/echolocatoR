% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summarise.R
\name{SUMMARISE.CS_counts_plot}
\alias{SUMMARISE.CS_counts_plot}
\title{Bar plot of tool-specific CS sizes}
\usage{
SUMMARISE.CS_counts_plot(
  merged_dat,
  show_numbers = T,
  ylabel = "Locus",
  legend_nrow = 3,
  label_yaxis = T,
  top_CS_only = F,
  show_plot = T
)
}
\description{
Loci ordered by UCS size (smallest to largest).
}
\examples{
data("merged_DT")
gg_CS <- SUMMARISE.CS_counts_plot(merged_dat=merged_DT)
}
\seealso{
Other summarise: 
\code{\link{SUMMARISE.CS_bin_plot}()},
\code{\link{SUMMARISE.get_CS_bins}()},
\code{\link{SUMMARISE.get_CS_counts}()},
\code{\link{SUMMARISE.get_SNPgroup_counts}()},
\code{\link{SUMMARISE.peak_overlap_plot}()},
\code{\link{SUMMARISE.plot_dataset_overlap}()},
\code{\link{results_report}()},
\code{\link{super_summary_plot}()}
}
\concept{summarise}
