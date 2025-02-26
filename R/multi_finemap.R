

#' Check for necessary columns
#'
#' @examples
#' data("BST1");
#' finemap_methods <- c("ABF","FINEMAP","SUSIE","POLYFUN_SUSIE")
#' finemap_methods <- check_necessary_cols(subset_DT=BST1, finemap_methods=finemap_methods)
check_necessary_cols <- function(subset_DT,
                                 finemap_methods,
                                 sample_size=NULL,
                                 dataset_type="GWAS",
                                 verbose=T){
  for_all <- c("SNP","CHR","POS","Effect","StdErr")
  required_dict <- list(ABF=c(for_all,
                              if(is.null(sample_size)) "N" else NULL,
                              if(dataset_type=="GWAS") "proportion_cases" else NULL),
                        FINEMAP=c(for_all),
                        SUSIE=c(for_all),
                        POLYFUN_SUSIE=c(for_all,"P","A1","A2"),
                        COLOC=c(for_all),
                        PAINTOR=c(for_all),
                        COJO=c(for_all,"A1","A2"))
  suggested_dict <- list(ABF=c("MAF"),
                         FINEMAP=c("A1","A2","MAF","N"),
                         SUSIE=c("N"),
                         POLYFUN_SUSIE=c("MAF","N"),
                         PAINTOR=c("MAF"),
                         COJO=c("Freq","P","N")) # check these
  finemap_methods_suggests <-  finemap_methods
  for(m in finemap_methods){
    message("vvvvv-- ",m," --vvvvv")
    # Check required cols
    if(!all(required_dict[[m]] %in% colnames(subset_DT))){
      finemap_methods <- finemap_methods[finemap_methods!=m]
      missing_cols <- required_dict[[m]][!required_dict[[m]] %in% colnames(subset_DT)]
      message("⛔ Missing required columns for ",m,": ",paste(missing_cols,collapse=", ")," (Skipping)");
      next()
    } else{message("✅ All required columns present.")}
    # Check suggested cols
    if(!m %in% names(suggested_dict)) next()
    if(is.null(suggested_dict[[m]])) next()
    if(!all(suggested_dict[[m]] %in% colnames(subset_DT))){
      missing_cols <- suggested_dict[[m]][!suggested_dict[[m]] %in% colnames(subset_DT)]
      message("⚠️  Missing optional columns for ",m,": ",paste(missing_cols,collapse=", "))
    } else{message("✅ All suggested columns present.")}
  }
  return(finemap_methods)
}




#' Adds fine-mapping summary columns
#'
#' Adds several columns that summarise the results across all fine-mapping tools that were run:
#' \describe{
#' \item{Support}{The number of tools in which the SNP was proposed in a credible set.}
#' \item{mean.PP}{The mean per-SNP PP across all fine-mapping tools used.}
#' \item{Consensus_SNP}{Whether or not the SNP was in the credible set of ≥ \code{consensus_thresh} SNPs (\emph{default=2}).}
#' }
#' @family finemapping functions
#' @param consensus_thresh Threshold for determining \strong{Consensus_SNP} status.
#' @inheritParams finemap_pipeline
#' @export
#' @examples
#' data("merged_DT")
#' merged_DT <- find_consensus_SNPs(finemap_dat=merged_DT, top_CS_only=F)
find_consensus_SNPs <- function(finemap_dat,
                                credset_thresh=.95,
                                consensus_thresh=2,
                                sort_by_support=T,
                                exclude_methods=NULL,
                                top_CS_only=F,
                                replace_PP_NAs=T,
                                verbose=F){
  printer("+ Identifying Consensus SNPs...",v=verbose)
  exclude_methods <- append(exclude_methods,"mean")
  # Find SNPs that are in the credible set for all fine-mapping tools
  finemap_dat <- update_cols(finemap_dat = finemap_dat)
  CS_cols <- grep(".CS$",colnames(finemap_dat), value = T)
  CS_cols <- CS_cols[!(CS_cols %in% c(paste0(exclude_methods,".CS"), paste0(exclude_methods,".Credible_Set")))]
  if(consensus_thresh=="all"){consensus_thresh<-length(CS_cols)}
  printer("++ support_thresh =",consensus_thresh,v=verbose)
  # Get the number of tools supporting each SNP
  ## Make sure each CS is set to 1
  support_sub <- subset(finemap_dat, select = CS_cols) %>% data.frame()
  if(top_CS_only){
    printer("++ top_CS_only=TRUE",v=verbose)
    support_sub <- ifelse(support_sub == 1, 1, 0)
  }else {
    printer("++ top_CS_only=FALSE",v=verbose)
    support_sub <- ifelse(support_sub >= 1, 1, 0)
  }

  finemap_dat$Support <- rowSums(support_sub, na.rm = T)
  finemap_dat$Consensus_SNP <- finemap_dat$Support >= consensus_thresh
  # Sort
  if(sort_by_support){
    finemap_dat <- finemap_dat %>%
      dplyr::arrange(dplyr::desc(Consensus_SNP), dplyr::desc(Support))
  }
  # Calculate mean PP
  printer("+ Calculating mean Posterior Probability (mean.PP)...",v=verbose)
  PP.cols <- grep(".PP$",colnames(finemap_dat), value = T)
  PP.cols <- PP.cols[!(PP.cols %in% paste0(exclude_methods,".PP"))]
  PP.sub <- subset(finemap_dat, select=c("SNP",PP.cols)) %>% data.frame()# %>% unique()
  if(replace_PP_NAs){
    printer("+ Replacing PP==NA with 0", v=verbose)
    PP.sub[is.na(PP.sub)] <- 0
  }
  if(NCOL(PP.sub[,-1]) > 1){
    finemap_dat$mean.PP <- rowMeans(PP.sub[,-1], na.rm = T)
  } else{
    finemap_dat$mean.PP <- PP.sub[,-1]
  }
  finemap_dat$mean.CS <- ifelse(finemap_dat$mean.PP >= credset_thresh,1,0)

  # PP.sub %>% arrange(desc(mean.PP)) %>% head()
  printer("++",length(CS_cols),"fine-mapping methods used.",v=verbose)
  printer("++",dim(subset(finemap_dat,Support>0))[1],"Credible Set SNPs identified.",v=verbose)
  printer("++",dim(subset(finemap_dat,Consensus_SNP==T))[1],"Consensus SNPs identified.",v=verbose)
  return(finemap_dat)
}
# finemap_dat <- find_consensus_SNPs(finemap_dat)
# locus_dir <- "Data/GWAS/Kunkle_2019/PTK2B"
# subset_DT <- fread( file.path(locus_dir,"PTK2B_Kunkle_2019_subset.txt"))
# dataset_type <- "GWAS"
# load(file.path(locus_dir, "plink/LD_matrix.RData"))




#' Fine-map using multiple fine-mapping tools
#'
#' Fine-mapping will be repeated on the same locus using each of the tools in \code{finemap_method_list}.
#' Then, all results will be merged into the locus-specific multi-finemap file,
#' along with the original per-SNP GWAS/QTL summary statistics.
#' Each tools will have the following columns:
#' \describe{
#'  \item{<tool>.PP}{The posterior probability (PP) of a SNP being causal for the trait. Though this is a generalization and the exact meaning of PP will differ by tools (e.g. Posterior Inclusion Probability for SUSIE).}
#'  \item{<tool>.CS}{Which credible set the SNP is part of (within a locus). If \code{=0}, then the SNP was not part of any credible set. Some tools only produce one credible set per locus.}
#' }
#'
#' @family finemapping functions
#' @inheritParams finemap_pipeline
#' @keywords internal
#' @examples
#' \dontrun{
#' data("BST1"); data("BST1_LD_matrix");
#' subset_DT <- BST1
#' finemap_method_list <- c("ABF","SUSIE")
#' }
multi_finemap <- function(locus_dir,
                          fullSS_path,
                          finemap_method_list,
                          finemap_args=NULL,
                          subset_DT,
                          dataset_type,
                          LD_matrix=NULL,
                          n_causal=5,
                          sample_size=NULL,
                          # snp_col="SNP",
                          # freq_col="Freq",
                          # effect_col="Effect",
                          # stderr_col="StdErr",
                          # pval_col="P",
                          # N_cases_col="N_cases",
                          # N_controls_col="N_controls",
                          # A1_col="A1",
                          # A2_col="A2",
                          PAINTOR_QTL_datasets=NULL,
                          PP_threshold=.95,
                          case_control=T,
                          verbose=T,
                          nThread=4,
                          conda_env="echoR"){
  # PAINTOR_QTL_datasets=NULL;PP_threshold=.95; effect_col="Effect"; n_causal=5; sample_size=1000; stderr_col="StdErr"; pval_col="P"; N_cases_col="N_cases"; N_controls_col="N_controls"; A1_col="A1"; A2_col="A2";conditioned_snps=NULL;
  printer("++ Fine-mapping using multiple tools:", paste(finemap_method_list, collapse=", "),v=verbose)
  # Check overlap
  sub.out <- subset_common_snps(LD_matrix = LD_matrix,
                                finemap_dat = subset_DT,
                                verbose = F)
  LD_matrix <- sub.out$LD
  subset_DT <- sub.out$DT

  select_cols <- colnames(subset_DT)[!grepl(colnames(subset_DT),
                                            pattern = paste(c(finemap_method_list,"Support","Consensus_SNP"),collapse = "|"))]
  merged_dat <- subset(subset_DT, select = select_cols)

  for(i in 1:length(unique(finemap_method_list))){
    m <- unique(finemap_method_list)[i];
    message("\n+++ Multi-finemap:: ",m," +++")
    finemap_dat <- null_DT <- data.table::data.table(SNP=merged_dat$SNP,
                                                     CS=NA,
                                                     PP=NA);
    # DT <- tryCatch({
      # EXPRESSION
     try({
       finemap_dat <- finemap_method_handler(fullSS_path = fullSS_path,
                                             locus_dir = locus_dir,
                                             finemap_method = m,
                                             finemap_args=finemap_args,
                                             subset_DT = data.table::as.data.table(subset_DT),
                                             dataset_type = dataset_type,
                                             LD_matrix = LD_matrix,
                                             n_causal = n_causal,
                                             sample_size = sample_size,
                                             # snp_col = snp_col,
                                             # freq_col = freq_col,
                                             # effect_col = effect_col,
                                             # stderr_col = stderr_col,
                                             # pval_col = pval_col,
                                             # N_cases_col = N_cases_col,
                                             # N_controls_col = N_controls_col,
                                             # A1_col = A1_col,
                                             # A2_col = A2_col,
                                             PAINTOR_QTL_datasets = PAINTOR_QTL_datasets,
                                             PP_threshold = PP_threshold,
                                             case_control = case_control,
                                             conditioned_snps = conditioned_snps,

                                             verbose = verbose,
                                             nThread=nThread,
                                             conda_env = conda_env)
     })
      # },
      # # WARNING
      # warning = function(w){printer("WARNING")},
      # # ERROR
      # error = function(e){
      #   message("SUSIE::Error:: Could not identify Credible Set.");
      #   return(null_DT)
      #   }
      # ) ## End tryCatch
      try({printer("++ Credible Set SNPs identified =",nrow(subset(finemap_dat, CS>0)),v=verbose )})
      # Add results to method-specific columns
      printer("++ Merging",m,"results with multi-finemap data.",v=verbose);
      value_var <- if(m=="COJO"){"Conditioned_Effect"}else{"PP"};
      dat_select <- subset(finemap_dat, select = c("SNP","CS",value_var) );
      # Rename columns according to method name
      cols <- colnames(dat_select);
      colnames(dat_select) <- c("SNP", paste(m, cols[2:length(cols)], sep="." ));
      # Merge new columns into DT
      ####--------------------------------------------------####
      #### Something wacky is going on here with data.table ####
      ## Only SUSIE results are merging, the rest are NAs, unless you set
      ## all.y=TRUE, in which case duplicate SNPs/row are generated.
      ## Even setting the keys doesn't seem to help.
      ##
      ## The only way to fix this seems to be converting to data.frames
      ## temporarily, merge, and then convert back to data.table.
      merged_dat <- merge(x = data.frame(merged_dat,check.names = FALSE),
                          y = data.frame(dat_select, check.names = FALSE),
                          by = "SNP",
                          all.x = T);
      merged_dat <- data.table::data.table(merged_dat)
      ####--------------------------------------------------####
  }
  if(nrow(merged_dat)!=dplyr::n_distinct(merged_dat$SNP)) stop("Duplicate SNP rows detected.")
  return(merged_dat)
}


####### Fine-mapping Handler #######




#' @family finemapping functions
#' @keywords internal
create_method_path <- function(locus_dir,
                               finemap_method,
                               LD_reference=NULL,
                               create_dir=T,
                               compress=F){
  method_dir <- file.path(locus_dir, finemap_method)
  # Make finemapping results folder
  if(create_dir) dir.create(method_dir, recursive = T, showWarnings = F)
  # Return results file name
  dataset <- basename(dirname(locus_dir))
  locus <- basename(locus_dir)
  if(is.null(LD_reference)){
    file_path <- file.path(method_dir, paste0("*Multi-finemap.tsv", if(compress) ".gz" else "*"))
  } else{
    file_path <- file.path(method_dir,
                           paste0(paste(paste0(LD_reference,"_LD"),finemap_method,"tsv", sep="."),
                                  if(compress) ".gz" else "*")
    )
  }
  return(file_path)
}




#' @family finemapping functions
#' @keywords internal
save_finemap_results <- function(finemap_dat,
                                 file_dir,
                                 nThread=4){
  data.table::fwrite(finemap_dat, file_dir, sep = "\t", na = NA, quote = F,
                     nThread = nThread)
}


finemap_args_interpreter <- function(finemap_args,
                                     method="FINEMAP"){
  # method <- "SUSIE"
  # finemap_args=list("FINEMAP"=list("--n-threads"=4),
  #                   "SUSIE"=list("scaled_prior_variance"=.001,
  #                                "max_iter"=100,
  #                                "doofus"=42))
  if(method %in% names(finemap_args)){
    args_list <- finemap_args[[method]]
    if(method=="FINEMAP") return(args_list)

  } else {return(NULL)}
}

SUSIE.args_intrepreter <- function(args_list,
                                   arg_name){
    valid_args <- names(args_list)[names(args_list) %in% names(formals(SUSIE))]
    # if(length(args_list)>length(valid_args)){
    #   invalid_args <- names(args_list)[!names(args_list) %in% valid_args]
    #   warning(paste0(method,":: Ignoring unrecognized arguments: ",
    #                  paste(invalid_args,collapse=", ")))
    # }
    if(length(valid_args)>0) return(args_list)
}




#' @family finemapping functions
#' @inheritParams finemap_pipeline
#' @keywords internal
finemap_method_handler <- function(locus_dir,
                                   fullSS_path,
                                   finemap_method="SUSIE",
                                   finemap_args=NULL,
                                   subset_DT,
                                   dataset_type="GWAS",
                                   force_new_finemap=T,
                                   LD_matrix=NULL,
                                   n_causal=5,
                                   conditioned_snps,
                                   sample_size=NULL,
                                   # snp_col="SNP",
                                   # freq_col="Freq",
                                   # effect_col="Effect",
                                   # stderr_col="StdErr",
                                   # pval_col="P",
                                   # N_cases_col="N_cases",
                                   # N_controls_col="N_controls",
                                   # A1_col="A1",
                                   # A2_col="A2",
                                   PAINTOR_QTL_datasets=NULL,
                                   PP_threshold=.95,
                                   case_control=T,

                                   verbose=T,
                                   nThread=4,
                                   conda_env="echoR"){
  sub.out <- subset_common_snps(LD_matrix=LD_matrix,
                                finemap_dat=subset_DT,
                                verbose = F)
  LD_matrix <- sub.out$LD
  subset_DT <- sub.out$DT
  # INITIATE FINE-MAPPING
  if(finemap_method=="SUSIE"){
    #### SUSIE ####
    finemap_dat <- SUSIE(subset_DT = subset_DT,
                        dataset_type = dataset_type,
                        LD_matrix = LD_matrix,
                        max_causal = n_causal,
                        sample_size = sample_size,
                        PP_threshold = PP_threshold,
                        verbose = verbose)

  } else if(finemap_method=="POLYFUN_SUSIE"){
    #### PolyFun+SUSIE ####
    finemap_dat <- POLYFUN_SUSIE(locus_dir = locus_dir,
                                finemap_dat = subset_DT,
                                LD_matrix = LD_matrix,
                                dataset_type = dataset_type,
                                max_causal = n_causal,
                                sample_size = sample_size,
                                polyfun_approach = "precomputed",#"non-parametric",
                                PP_threshold = PP_threshold,
                                conda_env = conda_env)

  }else if(finemap_method=="ABF"){
    #### ABF ####
    finemap_dat <- ABF(subset_DT = subset_DT,
                       PP_threshold = PP_threshold,
                       sample_size = sample_size,
                       case_control = case_control)


  } else if(finemap_method=="FINEMAP"){
    #### FINEMAP ####
    finemap_dat <- FINEMAP(subset_DT = subset_DT,
                           locus_dir = locus_dir,
                           LD_matrix = LD_matrix,
                           n_samples = sample_size,
                           n_causal = n_causal,
                           credset_thresh = PP_threshold,
                           args_list = if("FINEMAP" %in% names(finemap_args)) finemap_args[["FINEMAP"]] else NULL)


  } else if("COJO" %in% finemap_method){
    #### COJO ####
    conditioned_snps <- subset(subset_DT, leadSNP==T)$SNP
    finemap_dat <- COJO(subset_DT = subset_DT,
                       locus_dir = locus_dir,
                       fullSS_path = fullSS_path,
                       conditioned_snps = conditioned_snps,
                       conditional_analysis = T,
                       stepwise_procedure = F

                       # snp_col = snp_col,
                       # freq_col = freq_col,
                       # effect_col = effect_col,
                       # stderr_col = stderr_col,
                       # pval_col = pval_col,
                       # A1_col = A1_col,
                       # A2_col = A2_col
                       )

  } else if("PAINTOR" %in% finemap_method) {
    #### PAINTOR ####
    finemap_dat <- PAINTOR(finemap_dat=subset_DT,
                           GWAS_datasets=ifelse(dataset_type=="GWAS",
                                                basename(dirname(locus_dir)),NULL),
                           QTL_datasets=NULL,
                           locus=basename(locus_dir),
                           n_causal=n_causal,
                           use_annotations=F,
                           PP_threshold=PP_threshold,
                           GWAS_populations="EUR",
                           LD_matrix=LD_matrix,
                           force_new_LD=F)
  } else {
    stop("[::ERROR::] Enter valid finemap_method: 'SUSIE', 'ABF', 'FINEMAP', 'COJO', and 'PAINTOR' are currently available.")
  }
  return(finemap_dat)
}



#' @inheritParams finemap_pipeline
#' @family finemapping functions
#' @keywords internal
finemap_handler <- function(locus_dir,
                            fullSS_path,
                            finemap_methods=c("SUSIE","FINEMAP"),
                            finemap_args=NULL,
                            subset_DT,
                            dataset_type="GWAS",
                            force_new_finemap=T,
                            LD_reference=NULL,
                            LD_matrix=NULL,
                            n_causal=5,
                            sample_size=NULL,
                            conditioned_snps=NULL,
                            # snp_col="SNP",
                            # freq_col="Freq",
                            # effect_col="Effect",
                            # stderr_col="StdErr",
                            # pval_col="P",
                            # N_cases_col="N_cases",
                            # N_controls_col="N_controls",
                            # A1_col="A1",
                            # A2_col="A2",
                            PAINTOR_QTL_datasets=NULL,
                            PP_threshold=.95,
                            consensus_threshold=2,
                            case_control=T,
                            conda_env="echoR",
                            nThread=4,
                            verbose=T){
  start_FM <- Sys.time()
  set.seed(1)
  # First, check if there's more than one fin-mapping method given. If so, switch to multi-finemap function
  # if(length(finemap_methods)>1){
    ## Next, see if fine-mapping has previously been done (with multi-finemap)
    file_path <- create_method_path(locus_dir = locus_dir,
                                   LD_reference = LD_reference,
                                   finemap_method = "Multi-finemap",
                                   compress = T)
    ### If so, import the previous results
    if(file.exists(file_path) & force_new_finemap==F){
      printer("++ Previously multi-finemap results identified. Importing:",file_path, v=verbose)
      finemap_dat <- data.table::fread(file_path, nThread=nThread)
    } else {
      ### If not, or if forcing new fine-mapping is set to TRUE, fine-map using multiple tools
      finemap_methods <- check_necessary_cols(subset_DT = subset_DT,
                                              finemap_methods = finemap_methods,
                                              sample_size = sample_size,
                                              dataset_type = dataset_type,
                                              verbose = verbose)
      finemap_dat <- multi_finemap(locus_dir = locus_dir,
                                   fullSS_path = fullSS_path,
                                   finemap_method_list = finemap_methods,
                                   finemap_args = finemap_args,
                                   subset_DT = subset_DT,
                                   dataset_type = dataset_type,
                                   LD_matrix = LD_matrix,
                                   n_causal = n_causal,
                                   sample_size = sample_size,

                                   # snp_col = snp_col,
                                   # freq_col = freq_col,
                                   # effect_col = effect_col,
                                   # stderr_col = stderr_col,
                                   # pval_col = pval_col,
                                   # N_cases_col = N_cases_col,
                                   # N_controls_col = N_controls_col,
                                   # A1_col = A1_col,
                                   # A2_col = A2_col,
                                   PAINTOR_QTL_datasets = PAINTOR_QTL_datasets,
                                   PP_threshold = PP_threshold,
                                   case_control = case_control,

                                   verbose = verbose,
                                   nThread = nThread,
                                   conda_env = conda_env)
      finemap_dat <- find_consensus_SNPs(finemap_dat = finemap_dat,
                                         credset_thresh = PP_threshold,
                                         consensus_thresh = consensus_threshold,
                                         verbose = verbose)
      save_finemap_results(finemap_dat, file_path)
    }
  end_FM <- Sys.time()
  printer("+ Fine-mapping with '", paste0(finemap_methods, collapse=", "),"' completed:",v=verbose)
  print(round(end_FM-start_FM,2))
  return(finemap_dat)
}



