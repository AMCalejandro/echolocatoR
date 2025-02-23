% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GoShifter.R
\name{GOSHIFTER.run}
\alias{GOSHIFTER.run}
\title{Run \code{GoShifter} enrichment test}
\source{
\href{https://github.com/immunogenomics/goshifter}{GitHub}
\href{https://pubmed.ncbi.nlm.nih.gov/26140449/}{Publication}
}
\usage{
GOSHIFTER.run(
  finemap_dat,
  locus_dir,
  GRlist,
  permutations = 1000,
  goshifter_path = NULL,
  chromatin_state = "TssA",
  R2_filter = 0.8,
  overlap_threshold = 1,
  remove_tmps = T,
  verbose = T
)
}
\description{
\code{GoShifter}: Locus-specific enrichment tool.
}
\examples{
data("BST1"); data("locus_dir")
peaks <- NOTT_2019.get_epigenomic_peaks(convert_to_GRanges = T)
grl.peaks <- GenomicRanges::makeGRangesListFromDataFrame(data.frame(peaks), split.field ="Cell_type", names.field ="seqnames" )
GS_results <- GOSHIFTER.run(finemap_dat=subset(BST1, P<5e-8), locus_dir=locus_dir, GRlist=grl.peaks)
}
