*Author: Chelsea Cataldo-Ramirez & Mark N. Grote*

------------------------------------------------------------------------

# SVM for population genetics

Qualitative assessments of PCA visualizations are commonly used to construct GWAS samples and/or assess population structure within a genetic dataset. Here we provide an example of a quantitative approach (support vector machine) to integrating information across PCs to create a GWAS sample.

------------------------------------------------------------------------

## **As a reminder:** 

-   **Ethnicity, race, and genetic ancestry are NOT synonymous terms. Ethnicity and race do not have a biological basis.**

-   **Human genetic diversity is not categorical. The co-opting of statistical methods designed to classify and discriminate between discrete data towards analyzing human genetic variation is employed here only to facilitate the incorporation of typically excluded participants in genetic studies.**

-   **Terms used (e.g., “classification”) reflect the statistical procedures conducted, and are not meant to impose identities or group affiliations outside of this context.**

-   **Any use of the procedures presented here to facilitate racial discrimination reflects a foundational misrepresentation of human biology and a clear lack of understanding of evolutionary concepts and basic sociocultural phenomena.**

------------------------------------------------------------------------

## Data

After running the PCA (I used FRAPOSA [Zhang et al., 2020]), read in the PC scores of your sample and references. UKB data were projected onto 1000 Genomes data, see Cataldo-Ramirez et al. [PREPRINT] for further info. 

``` R
UKB <- read.table("~/path/to/UKB_PCA.pcs", header = F) #UK Biobank data
colnames(UKB) <- c('POP', 'IID', 'PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6',
            'PC7', 'PC8', 'PC9', 'PC10','PC11', 'PC12', 'PC13', 'PC14', 'PC15', 
            'PC16', 'PC17', 'PC18', 'PC19', 'PC20')

G1k <- read.table("~/path/to/Ref_1000G.pcs",header = F) #1000 Genomes data
colnames(G1k) <- c('POP', 'IID', 'PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6',
            'PC7', 'PC8', 'PC9', 'PC10','PC11', 'PC12', 'PC13', 'PC14', 'PC15', 
            'PC16', 'PC17', 'PC18', 'PC19', 'PC20')
```

Within `UKB` data are participants who self-selected Bangladeshi, Indian, Pakistani, "Any other Asian" (`AOA`), and/or "White and Asian" (`WA`) as their ethnicity. In addition to 1000 Genomes (`G1k`) reference groups, participants with Bangladeshi or Pakistani self-selected ethnic identities were used to train an SVM to predict with which group `AOA` and `WA` participants likely share the highest genetic affinity.

### Remove outliers by `POP`

To incorporate UKB Bangladeshi and Pakistani participants as training or reference groups, outliers were removed. The function `subset_by_std_dev` was defined for this purpose:

``` R
subset_by_std_dev <- function(data) { 
  result_list <- list()
  pop_data <- data[data$POP == pop_group, ]

# reduce to number of PCs you want to include (here, 15 PCs)
  pc_columns <- c('PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6', 'PC7', 'PC8', 'PC9', 'PC10', 'PC11', 'PC12', 'PC13', 'PC14', 'PC15')
  pc_means <- colMeans(pop_data[, pc_columns]) # Calculate mean and standard deviation for the filtered columns
  pc_sds <- apply(pop_data[, pc_columns], 2, sd)

# Define threshold limits (here, +/- 4 standard deviations from the mean)
  lower_limit <- pc_means - 4 * pc_sds
  upper_limit <- pc_means + 4 * pc_sds

# Subset data based on threshold limits
  subset_data <- pop_data
  for (i in seq_along(pc_columns)) {
      subset_data <- subset_data[(subset_data[, pc_columns[i]] >= lower_limit[i]) &
      (subset_data[, pc_columns[i]] <= upper_limit[i]), ]
   }

# Store the subsetted dataframe in the result list
  result_list[[pop_group]] <- subset_data
  }
# Return the list of subsetted dataframes 
  return(result_list) 
}
```

Example usage:

``` R
BP <- subset(UKB, (POP %in% c('Bangladeshi', 'Pakistani')))
BP$POP <- factor(BP$POP)
subsetted_data <- subset_by_std_dev(BP)
```

### Create a training dataframe including all reference groups

``` R
#Bangladeshi 
dat.B <- subsetted_data$Bangladeshi 
B.noOUT <- select(dat.B, -c('PC16', 'PC17', 'PC18', 'PC19', 'PC20'))

#Pakistani 
dat.P <- subsetted_data$Pakistani 
P.noOut <- select(dat.P, -c('PC16', 'PC17', 'PC18', 'PC19', 'PC20'))

bp.train <- rbind(B.noOut, P.noOut) 
bp.train$POP <- factor(bp.train$POP) #drop unused factor levels 

#combine BP training data w/1000G ref groups
train.1000g <- select(G1k, -c('PC16', 'PC17', 'PC18', 'PC19', 'PC20'))
svm_train <- rbind(bp.train, train.1000g)

#collapse African and European 1000 Genomes populations because we are interested in identifying a broadly South Asian GWAS sample
svm_train$POP <- factor(svm_train$POP)

table(svm_train$POP) #take a look at all possible reference populations
#Bangladeshi,BEB,CDX,CEU,CHB,CHS,ESN,GBR,GIH,GWD,IBS,ITU,
#JPT,KHV,LWK,MSL,Pakistani,PJL,STU,TSI,YRI 

svm_train$POP <- factor(svm_train$POP,
        levels = c("Bangladeshi", "BEB", "CDX", "CEU", "CHB", "CHS", "ESN",
         "GBR", "GIH", "GWD", "IBS", "ITU", "JPT", "KHV", "LWK", "MSL", 
         "Pakistani", "PJL", "STU", "TSI", "YRI"),
        labels = c("Bangladeshi", "BEB", "CDX", "EURO", "CHB", "CHS", 
          "AFR","EURO", "GIH", "AFR","EURO", "ITU", "JPT", "KHV", "AFR", "AFR", 
          "Pakistani", "PJL", "STU", "EURO", "AFR"),
        ordered = FALSE)
```

Put the sample you'd like to predict in another dataframe

``` R
predict.UKB <- subset(UKB, (POP %in% c('AOA','WA'))) 
predict.UKB$POP <- factor(predict.UKB$POP)
```

------------------------------------------------------------------------

## Train SVM

Required package:

``` R
install.packages("e1071") 
library(e1071)
```

Remove participant IDs and save your training dataset.

``` R
train1 <- svm_train[, -2]
#save this as an RDS
saveRDS(train1, "~/path/to/SVM_training_data.RDS")
```

### Tune cost and gamma parameters using k-fold cross validation

Iterate through several combinations of cost and gamma to find the lowest error rate.

``` R
# start broad and then narrow down values
tune.out1 <- tune(svm, POP ~ ., data=train1, kernel="radial", 
        ranges=list(cost=c(30, 50, 70, 90), 
        gamma=c(0.075, 0.1, 0.15, 0.2)), 
        tunecontrol=tune.control(cross=10))

# check summary to identify the parameters that yield the lowest error
summary(tune.out1)
# Parameter tuning of ‘svm’:
# - sampling method: 10-fold cross validation 
# - best parameters:
# cost gamma
# 70   0.075
# - best performance: 0.06546324

#tweaks to see if we can do better
tune.out2 <- tune(svm, POP ~ ., data=train1, kernel="radial", 
        ranges=list(cost=c(5, 8, 10, 12, 13, 16, 20, 30), 
        gamma=c(0.055, 0.062, 0.065, 0.068, 0.07, 0.0725, 0.075, 0.08)), 
        tunecontrol=tune.control(cross=10))

summary(tune.out2)
# best parameters:
# cost gamma
# 13   0.065
# - best performance: 0.06460614 
```

### Assess within-sample accuracy

Once best parameters chosen, run best model on the training data (this is the same data which were used to create the model, since we did not split our reference/training data in order to maintain the sample size) and calculate a confusion matrix to show within-sample accuracy.

``` R
svm1.opt <- svm(POP ~ ., data=train1, kernel="radial", 
      cost=13, gamma=0.065, probability = TRUE)

#save this as an RDS
saveRDS(svm1.opt, "~/path/to/svm_model.RDS")

svm1.pred <- predict(svm1.opt, train1[,-1])
tab.1 <- table(pred = svm1.pred, true = train1[,1])

classAgreement(tab = tab.1)
# $diag: percentage of data points in the main diagonal of the matrix
# $kappa: 'diag' corrected for agreement by chance
# $rand: Rand index
# $crand: Rand index corrected for agreement by chance

# $diag      $kappa.    $rand      $crand
# 0.9509776  0.9365779  0.9753584  0.929886
```

------------------------------------------------------------------------

## Apply SVM model to predict class membership

``` R
test <-predict.UKB[, -2] 
svm1.pred <- predict(svm1.opt, predict.UKB[,-1], decision.values = TRUE, probability = TRUE) 

svm1.prob <- data.frame(attr(svm1.pred, "probabilities")) 
svm1.prob$POP <- predict.UKB$POP 
svm1.prob$IID <- predict.UKB$IID 
svm1.prob$svm1PRED <- svm1.pred

#save your output
write.table(svm1.prob, "~/path/to/SVM_out_probs.txt", quote = FALSE, col.names = TRUE, row.names = FALSE, sep = "\t") 
```

------------------------------------------------------------------------

## Citations

**FRAPOSA**:

-   Daiwei Zhang, Rounak Dey, Seunggeun Lee, Fast and robust ancestry prediction using principal component analysis, *Bioinformatics*, Volume 36, Issue 11, June 2020, Pages 3439–3446, <https://doi.org/10.1093/bioinformatics/btaa152>

-   <https://github.com/daviddaiweizhang/fraposa/blob/master/README.md>

**e1071**:

-   Meyer D, Dimitriadou E, Hornik K, Weingessel A, Leisch F (2024). *e1071: Misc Functions of the Department of Statistics, Probability Theory Group (Formerly: E1071), TU Wien*. R package version 1.7-16, <https://CRAN.R-project.org/package=e1071>.
