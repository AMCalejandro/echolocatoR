% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IMPACT.R
\name{IMPACT.postprocess_annotations}
\alias{IMPACT.postprocess_annotations}
\title{Prepare \emph{IMPACT} annotations}
\usage{
IMPACT.postprocess_annotations(ANNOT_MELT, order_loci = T, no_no_loci = NULL)
}
\description{
Transform \emph{IMPACT} annotations from wide format (one row per SNP) to
long format (multiple rows per SNP).
}
\seealso{
Other IMPACT: 
\code{\link{IMPACT.get_annotation_key}()},
\code{\link{IMPACT.get_annotations}()},
\code{\link{IMPACT.get_top_annotations}()},
\code{\link{IMPACT.iterate_get_annotations}()},
\code{\link{IMPACT.snp_group_boxplot}()},
\code{\link{IMPACT_annotation_key}},
\code{\link{IMPACT_heatmap}()},
\code{\link{prepare_mat_meta}()}
}
\concept{IMPACT}
\keyword{internal}
