# AnthroGen

This repo contains the code/scripts for the analyses presented in “Improving GWAS performance in underrepresented groups by appropriate modeling of genetics, environment, and sociocultural factors” by Cataldo-Ramirez et al. (in review). See Cataldo-Ramirez et al. (will update upon publication) for a detailed discussion and recommended use. This preprint can be found on biorxiv: https://www.biorxiv.org/content/10.1101/2024.10.28.620716v1



### UKB environmental variables recoding

At the time of our UKB application, there were no resources available (or at least known to me) regarding guidance for data recoding. *UKB_data_recoding.R* provides an example of how we recoded the data for the statistical analyses conducted in the research cited above. All data fields retain the UKB UDI code as received at the start of our project. Some of the codes may have been changed or removed by the UKB since that time.


### SVM for genetic ancestry

Following the PCA described in Cataldo-Ramirez et al. (in review), the resulting PCs were used as input for a support vector machine developed to better understand the genetic affinities among UKB participants. *SVM_for_gen.R* outlines this workflow.

### GWAS summary statistics pooling

Our environmentally-adjusted GWAS of height reflects the pooled results of 5 GWAS utilizing imputed environmental covariates. *GWAS_pool.R* demonstrates our use of Rubin's recombining rules to combine all GWAS outputs.
