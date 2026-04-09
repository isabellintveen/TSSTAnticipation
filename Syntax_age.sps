* Encoding: UTF-8.
* Analysis TSST Anticipation Supplementary Analysis with age as a covariate 
    last edited 2026_04_09 by Isabell Int-Veen 

* Benjamini Hochberg correction 

sort cases by p (a).
compute i=$casenum.
sort cases by i (d).
compute q=.05.
compute m=max(i,lag(m)).
compute crit=q*i/m.
compute test=(p le crit).
compute test=max(test,lag(test)).
execute.
formats i m test(f8.0) q (f8.2) crit(f8.6).
value labels test 1 'Significant' 0 'Not Significant'.


* load data 

GET
  FILE='Q:\NAS\Ehlis_Auswertung\Laufwerk_S\AG-Mitglieder\David\Artikel\TSST '+
    'Anticipation\Auswertung\2026_01_27_Gesamtdaten_TSSTAnticipation.sav'.


* Mahalanobis distance fNIRS anticipation window (window 1) oxy

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER CTL1_lIFG_Cui_anticipation CTL1_lDLPFC_Cui_anticipation CTL1_rIFG_Cui_anticipation CTL1_rDLPFC_Cui_anticipation CTL1_SAC_Cui_anticipation
                                       CTL2_lIFG_Cui_anticipation CTL2_lDLPFC_Cui_anticipation CTL2_rIFG_Cui_anticipation CTL2_rDLPFC_Cui_anticipation CTL2_SAC_Cui_anticipation
                                       Arith_lIFG_Cui_anticipation Arith_lDLPFC_Cui_anticipation Arith_rIFG_Cui_anticipation Arith_rDLPFC_Cui_anticipation Arith_SAC_Cui_anticipation
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,15).
EXECUTE.


FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.


* rmANOVA anticipation (window 1) oxy 

GLM CTL1_lIFG_Cui_anticipation CTL1_lDLPFC_Cui_anticipation CTL1_rIFG_Cui_anticipation 
    CTL1_rDLPFC_Cui_anticipation CTL1_SAC_Cui_anticipation CTL2_lIFG_Cui_anticipation 
    CTL2_lDLPFC_Cui_anticipation CTL2_rIFG_Cui_anticipation CTL2_rDLPFC_Cui_anticipation 
    CTL2_SAC_Cui_anticipation Arith_lIFG_Cui_anticipation Arith_lDLPFC_Cui_anticipation 
    Arith_rIFG_Cui_anticipation Arith_rDLPFC_Cui_anticipation Arith_SAC_Cui_anticipation BY Group WITH 
    Alter
  /WSFACTOR=condition 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(condition) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=condition ROI condition*ROI
  /DESIGN=Alter Group.





* Mahalanobis distance fNIRS anticipation window (window 1) deoxy 

DATASET ACTIVATE DataSet2.

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER CTL1_lIFG_Deoxy_anticipation CTL1_lDLPFC_Deoxy_anticipation CTL1_rIFG_Deoxy_anticipation CTL1_rDLPFC_Deoxy_anticipation CTL1_SAC_Deoxy_anticipation
                                       CTL2_lIFG_Deoxy_anticipation CTL2_lDLPFC_Deoxy_anticipation CTL2_rIFG_Deoxy_anticipation CTL2_rDLPFC_Deoxy_anticipation CTL2_SAC_Deoxy_anticipation
                                       Arith_lIFG_Deoxy_anticipation Arith_lDLPFC_Deoxy_anticipation Arith_rIFG_Deoxy_anticipation Arith_rDLPFC_Deoxy_anticipation Arith_SAC_Deoxy_anticipation
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,15).
EXECUTE.

    
FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

* rmANOVA anticipation (window 1) deoxy 

GLM CTL1_lIFG_Deoxy_anticipation CTL1_lDLPFC_Deoxy_anticipation CTL1_rIFG_Deoxy_anticipation 
    CTL1_rDLPFC_Deoxy_anticipation CTL1_SAC_Deoxy_anticipation CTL2_lIFG_Deoxy_anticipation 
    CTL2_lDLPFC_Deoxy_anticipation CTL2_rIFG_Deoxy_anticipation CTL2_rDLPFC_Deoxy_anticipation 
    CTL2_SAC_Deoxy_anticipation Arith_lIFG_Deoxy_anticipation Arith_lDLPFC_Deoxy_anticipation 
    Arith_rIFG_Deoxy_anticipation Arith_rDLPFC_Deoxy_anticipation Arith_SAC_Deoxy_anticipation BY Group 
    WITH Alter
  /WSFACTOR=condition 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(condition) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=condition ROI condition*ROI
  /DESIGN=Alter Group.






* Mahalanobis distance fNIRS trialnoanticipation window (window 2) oxy 

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER CTL1_lIFG_Cui_trialnoanticipation CTL1_lDLPFC_Cui_trialnoanticipation CTL1_rIFG_Cui_trialnoanticipation CTL1_rDLPFC_Cui_trialnoanticipation CTL1_SAC_Cui_trialnoanticipation
                                       CTL2_lIFG_Cui_trialnoanticipation CTL2_lDLPFC_Cui_trialnoanticipation CTL2_rIFG_Cui_trialnoanticipation CTL2_rDLPFC_Cui_trialnoanticipation CTL2_SAC_Cui_trialnoanticipation
                                       Arith_lIFG_Cui_trialnoanticipation Arith_lDLPFC_Cui_trialnoanticipation Arith_rIFG_Cui_trialnoanticipation Arith_rDLPFC_Cui_trialnoanticipation Arith_SAC_Cui_trialnoanticipation
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,15).
EXECUTE.
    
FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.


* rmANOVA trialnoanticipation (window 2) oxy 

GLM CTL1_lIFG_Cui_trialnoanticipation CTL1_lDLPFC_Cui_trialnoanticipation CTL1_rIFG_Cui_trialnoanticipation 
    CTL1_rDLPFC_Cui_trialnoanticipation CTL1_SAC_Cui_trialnoanticipation CTL2_lIFG_Cui_trialnoanticipation 
    CTL2_lDLPFC_Cui_trialnoanticipation CTL2_rIFG_Cui_trialnoanticipation CTL2_rDLPFC_Cui_trialnoanticipation 
    CTL2_SAC_Cui_trialnoanticipation Arith_lIFG_Cui_trialnoanticipation Arith_lDLPFC_Cui_trialnoanticipation 
    Arith_rIFG_Cui_trialnoanticipation Arith_rDLPFC_Cui_trialnoanticipation Arith_SAC_Cui_trialnoanticipation BY Group WITH 
    Alter
  /WSFACTOR=condition 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(condition) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=condition ROI condition*ROI
  /DESIGN=Alter Group.




* Mahalanobis distance fNIRS trialnoanticipation window (window 2) deoxy 

DATASET ACTIVATE DataSet2.

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER CTL1_lIFG_Deoxy_trialnoanticipation CTL1_lDLPFC_Deoxy_trialnoanticipation CTL1_rIFG_Deoxy_trialnoanticipation CTL1_rDLPFC_Deoxy_trialnoanticipation CTL1_SAC_Deoxy_trialnoanticipation
                                       CTL2_lIFG_Deoxy_trialnoanticipation CTL2_lDLPFC_Deoxy_trialnoanticipation CTL2_rIFG_Deoxy_trialnoanticipation CTL2_rDLPFC_Deoxy_trialnoanticipation CTL2_SAC_Deoxy_trialnoanticipation
                                       Arith_lIFG_Deoxy_trialnoanticipation Arith_lDLPFC_Deoxy_trialnoanticipation Arith_rIFG_Deoxy_trialnoanticipation Arith_rDLPFC_Deoxy_trialnoanticipation Arith_SAC_Deoxy_trialnoanticipation
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,15).
EXECUTE.
    
FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.


* rmANOVA trialnoanticipation (window 2) deoxy 

GLM CTL1_lIFG_Deoxy_trialnoanticipation CTL1_lDLPFC_Deoxy_trialnoanticipation CTL1_rIFG_Deoxy_trialnoanticipation 
    CTL1_rDLPFC_Deoxy_trialnoanticipation CTL1_SAC_Deoxy_trialnoanticipation CTL2_lIFG_Deoxy_trialnoanticipation 
    CTL2_lDLPFC_Deoxy_trialnoanticipation CTL2_rIFG_Deoxy_trialnoanticipation CTL2_rDLPFC_Deoxy_trialnoanticipation 
    CTL2_SAC_Deoxy_trialnoanticipation Arith_lIFG_Deoxy_trialnoanticipation Arith_lDLPFC_Deoxy_trialnoanticipation 
    Arith_rIFG_Deoxy_trialnoanticipation Arith_rDLPFC_Deoxy_trialnoanticipation Arith_SAC_Deoxy_trialnoanticipation BY Group WITH 
    Alter
  /WSFACTOR=condition 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(condition) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=condition ROI condition*ROI
  /DESIGN=Alter Group.










* Mahalanobis distance fNIRS trialstandard window (window 3) oxy 

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER CTL1_lIFG_Cui_trialstandard CTL1_lDLPFC_Cui_trialstandard CTL1_rIFG_Cui_trialstandard CTL1_rDLPFC_Cui_trialstandard CTL1_SAC_Cui_trialstandard
                                       CTL2_lIFG_Cui_trialstandard CTL2_lDLPFC_Cui_trialstandard CTL2_rIFG_Cui_trialstandard CTL2_rDLPFC_Cui_trialstandard CTL2_SAC_Cui_trialstandard
                                       Arith_lIFG_Cui_trialstandard Arith_lDLPFC_Cui_trialstandard Arith_rIFG_Cui_trialstandard Arith_rDLPFC_Cui_trialstandard Arith_SAC_Cui_trialstandard
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,15).
EXECUTE.

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.


* rmANOVA trialstandard (window 3) oxy 

GLM CTL1_lIFG_Cui_trialstandard CTL1_lDLPFC_Cui_trialstandard CTL1_rIFG_Cui_trialstandard 
    CTL1_rDLPFC_Cui_trialstandard CTL1_SAC_Cui_trialstandard CTL2_lIFG_Cui_trialstandard 
    CTL2_lDLPFC_Cui_trialstandard CTL2_rIFG_Cui_trialstandard CTL2_rDLPFC_Cui_trialstandard 
    CTL2_SAC_Cui_trialstandard Arith_lIFG_Cui_trialstandard Arith_lDLPFC_Cui_trialstandard 
    Arith_rIFG_Cui_trialstandard Arith_rDLPFC_Cui_trialstandard Arith_SAC_Cui_trialstandard BY Group WITH 
    Alter
  /WSFACTOR=condition 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(condition) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=condition ROI condition*ROI
  /DESIGN=Alter Group.






* Mahalanobis distance fNIRS trialstandard window (window 3) deoxy 

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER CTL1_lIFG_Deoxy_trialstandard CTL1_lDLPFC_Deoxy_trialstandard CTL1_rIFG_Deoxy_trialstandard CTL1_rDLPFC_Deoxy_trialstandard CTL1_SAC_Deoxy_trialstandard
                                       CTL2_lIFG_Deoxy_trialstandard CTL2_lDLPFC_Deoxy_trialstandard CTL2_rIFG_Deoxy_trialstandard CTL2_rDLPFC_Deoxy_trialstandard CTL2_SAC_Deoxy_trialstandard
                                       Arith_lIFG_Deoxy_trialstandard Arith_lDLPFC_Deoxy_trialstandard Arith_rIFG_Deoxy_trialstandard Arith_rDLPFC_Deoxy_trialstandard Arith_SAC_Deoxy_trialstandard
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,15).
EXECUTE.

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.


* rmANOVA trialstandard (window 3) deoxy 

GLM CTL1_lIFG_Deoxy_trialstandard CTL1_lDLPFC_Deoxy_trialstandard CTL1_rIFG_Deoxy_trialstandard 
    CTL1_rDLPFC_Deoxy_trialstandard CTL1_SAC_Deoxy_trialstandard CTL2_lIFG_Deoxy_trialstandard 
    CTL2_lDLPFC_Deoxy_trialstandard CTL2_rIFG_Deoxy_trialstandard CTL2_rDLPFC_Deoxy_trialstandard 
    CTL2_SAC_Deoxy_trialstandard Arith_lIFG_Deoxy_trialstandard Arith_lDLPFC_Deoxy_trialstandard 
    Arith_rIFG_Deoxy_trialstandard Arith_rDLPFC_Deoxy_trialstandard Arith_SAC_Deoxy_trialstandard BY Group WITH 
    Alter
  /WSFACTOR=condition 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*condition) WITH(Alter=MEAN)COMPARE(condition) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=condition ROI condition*ROI
  /DESIGN=Alter Group.



