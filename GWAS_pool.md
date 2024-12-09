*Authors: Chelsea Cataldo-Ramirez & Mark N. Grote*

------------------------------------------------------------------------

# Multiple Imputation (MI) and GWAS

5 GWAS including imputed environmental covariates were run using gcta MLM-LOCO (--mlma-loco) (Yang et al., 2011).

Per the guidance for using multiply imputed data, the results must then be pooled using Rubin's Rules (outlined below; Little & Rubin, 2002).

------------------------------------------------------------------------

## Read in your GWAS summary statistics

*gcta GWAS output files include: chromosome, SNP, physical position, reference allele (the coded effect allele), the other allele, frequency of the reference allele, SNP effect, standard error, p-value*

*Also note that p-values reported in gcta are z-tests (relevant later)*

``` 
I1 <- read.delim("~/path/to/gwas_I1.loco.mlma", header = TRUE)
I2 <- read.delim("~/path/to/gwas_I2.loco.mlma", header = TRUE)
I3 <- read.delim("~/path/to/gwas_I3.loco.mlma", header = TRUE)
I4 <- read.delim("~/path/to/gwas_I4.loco.mlma", header = TRUE)
I5 <- read.delim("~/path/to/gwas_I5.loco.mlma", header = TRUE)
```

------------------------------------------------------------------------

## Rubin's Rules

*See section 5.4 (Little & Rubin, 2002) for further info.*

Combine or merge df's; here I used an index to ensure the SNPs were matched across outputs. cbind()/rbind() would work just as well.

``` R
index <- match(sig.I1$SNP,I2$SNP) 
sig.I1$I2.p <- I2$p[index]
sig.I1$I2.b <- I2$b[index]
sig.I1$I2.b.SE <- I2$se[index]

index <- match(sig.I1$SNP,I3$SNP) 
sig.I1$I3.p <- I3$p[index]
sig.I1$I3.b <- I3$b[index]
sig.I1$I3.b.SE <- I3$se[index]

index <- match(sig.I1$SNP,I4$SNP) 
sig.I1$I4.p <- I4$p[index]
sig.I1$I4.b <- I4$b[index]
sig.I1$I4.b.SE <- I4$se[index]

index <- match(sig.I1$SNP,I5$SNP) 
sig.I1$I5.p <- I5$p[index]
sig.I1$I5.b <- I5$b[index]
sig.I1$I5.b.SE <- I5$se[index]
```

### Pool effect estimates 

*(sum of betas / number of imputes)*

Add each imputed effect size & divide by number of imputed datasets

``` R
numI <- 5
sig.I1$pooled.b <- (sig.I1$b + sig.I1$I2.b + sig.I1$I3.b + sig.I1$I4.b + sig.I1$I5.b)/numI
```

### Pool standard errors 

*expression 5.18*

``` R
sig.I1$WbarD <- (sig.I1$se^2 + sig.I1$I2.b.SE^2 + sig.I1$I3.b.SE^2 + sig.I1$I4.b.SE^2 + sig.I1$I5.b.SE^2)/numI
```

### Calculate between imputation variance in betas 

``` R
sig.I1$Bd <- apply(cbind(sig.I1$b,sig.I1$I2.b,sig.I1$I3.b,sig.I1$I4.b,sig.I1$I5.b), MAR=1, FUN="var")
```

### Pool variance of effect sizes 

``` R
sig.I1$pooled.var <- sig.I1$WbarD + ((numI+1)/numI)*sig.I1$Bd
```

### Pool SE 

``` R
sig.I1$pooled.SE <- sqrt(sig.I1$pooled.var)
```

### Recalculate p-values (z-tests) 

``` R
sig.I1$pooled.STAT <- sig.I1$pooled.b/sig.I1$pooled.SE #effect size / standard error
sig.I1$pooled.P <- 2*(pnorm(abs(sig.I1$pooled.STAT), lower.tail = FALSE)) #z-test
```

------------------------------------------------------------------------

## Write out new, pooled GWAS summary stats file

``` R
RR <- sig.I1[, c("Chr","SNP","bp","A1","A2","Freq","pooled.b","pooled.SE","pooled.P")] 
write_delim(RR, "~/path/to/GWAS_envIMP_RR.txt", delim = '\t', col_names = TRUE)
```

------------------------------------------------------------------------

## Citations

**GCTA**: Yang et al. (2011) GCTA: a tool for Genome-wide Complex Trait Analysis. Am J Hum Genet. 88(1): 76-82. [PubMed ID: 21167468]

**Multiple Imputation & Rubin's Rules**: Little, R.J.A., Rubin, D.B., Little, R.J.A. and Rubin, D.B. (2002). Estimation of Imputation Uncertainty. In Statistical Analysis with Missing Data (eds R.J.A. Little and D.B. Rubin). <https://doi-org.libproxy1.usc.edu/10.1002/9781119013563.ch5>
