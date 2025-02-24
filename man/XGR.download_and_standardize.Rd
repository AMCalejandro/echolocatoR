% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/XGR.R
\name{XGR.download_and_standardize}
\alias{XGR.download_and_standardize}
\title{Download, standardize, and merge XGR annotations}
\usage{
XGR.download_and_standardize(
  lib.selections = c("ENCODE_TFBS_ClusteredV3_CellTypes", "TFBS_Conserved",
    "Uniform_TFBS"),
  as_GRangesList = F,
  finemap_dat,
  nCores = 4
)
}
\arguments{
\item{lib.selections}{Which XGR annotations to check overlap with.
For full list of libraries see:
 \url{http://xgr.r-forge.r-project.org/#annotations-at-the-genomic-region-level}}

\item{as_GRangesList}{Return as a \code{GRangesList}, instead of a single merged \code{GRanges} object.}
}
\value{
GRangesList
}
\description{
Merges a list of XGR annotations into a single GRanges object
}
\examples{
\dontrun{
data("BST1")
gr.lib <- XGR.download_and_standardize(lib.selections=c("ENCODE_DNaseI_ClusteredV3_CellTypes"), finemap_dat=BST1, nCores=1)
}
}
\seealso{
Other XGR: 
\code{\link{DT_to_GRanges}()},
\code{\link{GRanges_to_BED}()},
\code{\link{XGR.enrichment_bootstrap}()},
\code{\link{XGR.enrichment_plot}()},
\code{\link{XGR.enrichment}()},
\code{\link{XGR.filter_assays}()},
\code{\link{XGR.filter_sources}()},
\code{\link{XGR.import_annotations}()},
\code{\link{XGR.iterate_enrichment}()},
\code{\link{XGR.iterate_overlap}()},
\code{\link{XGR.merge_and_process}()},
\code{\link{XGR.plot_enrichment}()},
\code{\link{XGR.plot_peaks}()},
\code{\link{XGR.prepare_foreground_background}()}
}
\concept{XGR}
\keyword{internal}
