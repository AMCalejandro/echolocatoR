% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IMPACT.R
\name{IMPACT.plot_impact_score_compare}
\alias{IMPACT.plot_impact_score_compare}
\title{Compare IMPACT scores between loci}
\usage{
IMPACT.plot_impact_score_compare(
  loci = c("CD19", "TRIM40", "NUCKS1", "LRRK2", "MED12L", "MEX3C")
)
}
\description{
First, identify the top annotations per locus;
the annotation with the highest mean IMPACT score across all fine-mapped Consensus SNPS.
Then, plot the IMPACT scores for those locus-specific top annotations.
}
\keyword{internal}
