* Encoding: UTF-8.
* Analysis TSST Anticipation
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


* Demographic data 
    
SORT CASES  BY Group.
SPLIT FILE LAYERED BY Group.

DESCRIPTIVES VARIABLES=Alter BDI RRS
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=Geschlecht
  /ORDER=ANALYSIS.

DATASET ACTIVATE DataSet1.
CROSSTABS
  /TABLES=Diagnosen_neu_Worte BY Studie
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL.


* Mahalanobis distance stress

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER Stress_1 Stress_2 Stress_3 Stress_4 Stress_5 Stress_6 Stress_7 Stress_8 Stress_9
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,9).
EXECUTE.

 * 1 missing data (ID14) + 6 outliers: p < .001, ID45, ID48, ID137, ID53, ID134, ID23

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

*rmANOVA stress

GLM Stress_1 Stress_2 Stress_3 Stress_4 Stress_5 Stress_6 Stress_7 Stress_8 Stress_9 BY Group
  /WSFACTOR=time 9 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time 
  /DESIGN=Group.

FILTER OFF.
USE ALL.
DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.


* Mahalanobis distance state rumination 

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER staterum_rest1_totalscore staterum_rest2_totalscore
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,2).
EXECUTE.

 * 0 missing data and 0 outliers: p < .001

*rmANOVA state rumination 

GLM staterum_rest1_totalscore staterum_rest2_totalscore BY Group
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time 
  /DESIGN=Group.

DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.


* Mahalanobis distance positive affect

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER PA1 PA2 
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,2).
EXECUTE.

 * no missing data, 1 outlier: p < .001 (ID49)
    
FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.


* rmANOVA positive affect 

GLM PA1 PA2 BY Group
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time 
  /DESIGN=Group.

FILTER OFF.
USE ALL.
DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.


* Mahalanobis distance negative affect

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER NA1 NA2
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,2).
EXECUTE.

 * no missing data, 2 outliers: p < .001 ID141, ID49
    
FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

* rmANOVA negative affect 

GLM NA1 NA2 BY Group
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time 
  /DESIGN=Group.

FILTER OFF.
USE ALL.
DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.


* Mahalanobis distance cortisol

REGRESSION
    /MISSING LISTWISE
    /STATISTICS COEFF OUTS R ANOVA
    /CRITERIA=PIN(.05) POUT(.10)
    /NOORIGIN
    /DEPENDENT ID
    /METHOD=ENTER korrigiert_Cortisol_Konzentration.1 korrigiert_Cortisol_Konzentration.2 korrigiert_Cortisol_Konzentration.3 korrigiert_Cortisol_Konzentration.4 korrigiert_Cortisol_Konzentration.5
    /SAVE MAHAL.

COMPUTE Probability_MAH_1=1-CDF.CHISQ(MAH_1,5).
EXECUTE.

* 16 missing data, 7 outliers (p < .001): ID1, ID14, ID38, ID48, ID31, ID41, ID8, ID32, ID53, ID39, ID13, ID30, ID35, ID34, ID36, ID50, ID73, ID5, ID7, ID67, ID66, ID85, ID115

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

FILTER OFF.
USE ALL.
SELECT IF (Probability_MAH_1 >= 0.001).

FREQUENCIES VARIABLES=Subject
  /FORMAT=NOTABLE
  /ORDER=ANALYSIS.

GLM korrigiert_Cortisol_Konzentration.1 korrigiert_Cortisol_Konzentration.2 korrigiert_Cortisol_Konzentration.3 korrigiert_Cortisol_Konzentration.4 korrigiert_Cortisol_Konzentration.5 BY Group
  /WSFACTOR=time 5 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time 
  /DESIGN=Group.

FILTER OFF.
USE ALL.
DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.



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

 * no missing data, 0 outliers p < .001
    

* rmANOVA anticipation (window 1) oxy 

GLM CTL1_lIFG_Cui_anticipation CTL1_lDLPFC_Cui_anticipation CTL1_rIFG_Cui_anticipation 
    CTL1_rDLPFC_Cui_anticipation CTL1_SAC_Cui_anticipation CTL2_lIFG_Cui_anticipation 
    CTL2_lDLPFC_Cui_anticipation CTL2_rIFG_Cui_anticipation CTL2_rDLPFC_Cui_anticipation 
    CTL2_SAC_Cui_anticipation Arith_lIFG_Cui_anticipation Arith_lDLPFC_Cui_anticipation 
    Arith_rIFG_Cui_anticipation Arith_rDLPFC_Cui_anticipation Arith_SAC_Cui_anticipation BY Group
  /WSFACTOR=time 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group time*ROI Group*ROI) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /EMMEANS=TABLES(Group*ROI) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*ROI) COMPARE(ROI) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(time) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(ROI) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time ROI time*ROI
  /DESIGN=Group.

DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.




* Mahalanobis distance fNIRS anticipation window (window 1) deoxy 

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

 * no missing data, 3 outliers p < .001 (ID103, ID123, ID68)
    
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
  /WSFACTOR=time 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group time*ROI Group*ROI) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /EMMEANS=TABLES(Group*ROI) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*ROI) COMPARE(ROI) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(time) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(ROI) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time ROI time*ROI
  /DESIGN=Group.

FILTER OFF.
USE ALL.
DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.







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

 * no missing data, 0 outliers: p < .001
 

* rmANOVA trialnoanticipation (window 2) oxy 

GLM CTL1_lIFG_Cui_trialnoanticipation CTL1_lDLPFC_Cui_trialnoanticipation CTL1_rIFG_Cui_trialnoanticipation 
    CTL1_rDLPFC_Cui_trialnoanticipation CTL1_SAC_Cui_trialnoanticipation CTL2_lIFG_Cui_trialnoanticipation 
    CTL2_lDLPFC_Cui_trialnoanticipation CTL2_rIFG_Cui_trialnoanticipation CTL2_rDLPFC_Cui_trialnoanticipation 
    CTL2_SAC_Cui_trialnoanticipation Arith_lIFG_Cui_trialnoanticipation Arith_lDLPFC_Cui_trialnoanticipation 
    Arith_rIFG_Cui_trialnoanticipation Arith_rDLPFC_Cui_trialnoanticipation Arith_SAC_Cui_trialnoanticipation BY Group
  /WSFACTOR=time 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*ROI) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*ROI) COMPARE(ROI) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(time) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(ROI) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time ROI time*ROI
  /DESIGN=Group.


* Mahalanobis distance fNIRS trialnoanticipation window (window 2) deoxy 

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

 * no missing data, 2 outliers: p < .001 (ID73, ID7)
    
    
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
    Arith_rIFG_Deoxy_trialnoanticipation Arith_rDLPFC_Deoxy_trialnoanticipation Arith_SAC_Deoxy_trialnoanticipation BY Group
  /WSFACTOR=time 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*ROI) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*ROI) COMPARE(ROI) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(time) ADJ(LSD)
  /EMMEANS=TABLES(time*ROI) COMPARE(ROI) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time ROI time*ROI
  /DESIGN=Group.

FILTER OFF.
USE ALL.
DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.






* Mahalanobis distance fNIRS trialstandard window (wimdow 3) oxy

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

 * no missing data, 0 outliers: p < .001
    
* rmANOVA trialstandard (window 3) oxy 

GLM CTL1_lIFG_Cui_trialstandard CTL1_lDLPFC_Cui_trialstandard CTL1_rIFG_Cui_trialstandard 
    CTL1_rDLPFC_Cui_trialstandard CTL1_SAC_Cui_trialstandard CTL2_lIFG_Cui_trialstandard 
    CTL2_lDLPFC_Cui_trialstandard CTL2_rIFG_Cui_trialstandard CTL2_rDLPFC_Cui_trialstandard 
    CTL2_SAC_Cui_trialstandard Arith_lIFG_Cui_trialstandard Arith_lDLPFC_Cui_trialstandard 
    Arith_rIFG_Cui_trialstandard Arith_rDLPFC_Cui_trialstandard Arith_SAC_Cui_trialstandard BY Group
  /WSFACTOR=time 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time ROI time*ROI
  /DESIGN=Group.


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

 * no missing data, 2 outliers: p < .001 (ID73, ID123) 
    
    
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
    Arith_rIFG_Deoxy_trialstandard Arith_rDLPFC_Deoxy_trialstandard Arith_SAC_Deoxy_trialstandard BY Group
  /WSFACTOR=time 3 Polynomial ROI 5 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*Group) TYPE=LINE ERRORBAR=SE(1) MEANREFERENCE=NO YAXIS=AUTO
  /EMMEANS=TABLES(Group*time) COMPARE(Group) ADJ(LSD)
  /EMMEANS=TABLES(Group*time) COMPARE(time) ADJ(LSD)
  /PRINT=DESCRIPTIVE ETASQ OPOWER 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time ROI time*ROI
  /DESIGN=Group.

FILTER OFF.
USE ALL.
DELETE VARIABLES MAH_1 Probability_MAH_1.
EXECUTE.






* comparison of srtudies within HC and DP subsamples 

SORT CASES  BY Group.
SPLIT FILE SEPARATE BY Group.

T-TEST GROUPS=Studie(2 3)
  /MISSING=ANALYSIS
  /VARIABLES=Alter BDI RRS
  /ES DISPLAY(TRUE)
  /HOMOGENEITY DISPLAY(TRUE)
  /CRITERIA=CI(.95).

CROSSTABS
  /TABLES=Geschlecht BY Studie
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

DATASET ACTIVATE DataSet1.
SPLIT FILE OFF.


* correlations window 1

CORRELATIONS
  /VARIABLES=Arith_lIFG_Cui_anticipation Arith_lDLPFC_Cui_anticipation Arith_rIFG_Cui_anticipation 
    Arith_rDLPFC_Cui_anticipation Arith_SAC_Cui_anticipation korrigiert_Cortisol_Konzentration.3 
    TSST_BPM.arit NA2 staterum_rest2_totalscore Stress_5
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

* correlations window 2

CORRELATIONS
  /VARIABLES=Arith_lIFG_Cui_trialnoanticipation Arith_lDLPFC_Cui_trialnoanticipation Arith_rIFG_Cui_trialnoanticipation 
    Arith_rDLPFC_Cui_trialnoanticipation Arith_SAC_Cui_trialnoanticipation korrigiert_Cortisol_Konzentration.3 
    TSST_BPM.arit NA2 staterum_rest2_totalscore Stress_5
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

* correlations window 3

CORRELATIONS
  /VARIABLES=Arith_lIFG_Cui_trialstandard Arith_lDLPFC_Cui_trialstandard Arith_rIFG_Cui_trialstandard
    Arith_rDLPFC_Cui_trialstandard Arith_SAC_Cui_trialstandard korrigiert_Cortisol_Konzentration.3 
    TSST_BPM.arit NA2 staterum_rest2_totalscore Stress_5
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

