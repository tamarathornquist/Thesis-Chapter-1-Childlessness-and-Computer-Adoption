/*

*/

** In this do file I prepare census 1950 file for further analysis.
cd "C:\Users..."
use "temp_cz\census1950", clear
count
** keep in working age
keep if age>15 & age<65
tab sex
** drop not in the labor force status
tab empstat sex
drop if empstat==3
tab empstat sex
** drop in gq
tab gq
keep if gq<3 



********************************************************************************
** assing occupations from AD(13)
********************************************************************************

sum occ
tab occ
merge m:1 occ using "raw\occ1950_occ1990dd.dta", keepusing(occ1990dd)
sum occ1990dd
drop _merge

********************************************************************************
** recode from Barany 2018
********************************************************************************
do "do_prepare\recode_occ1990dd_occ1990cszb_long.do"
count
sum occ*
********************************************************************************
** recoding to 10 occupation groups
********************************************************************************
do "do_prepare\recode_occ10.do"
count
sum occ*
********************************************************************************
** recoding to 3 occupation groups
********************************************************************************
do "do_prepare\recode_occ3.do"
count
sum occ*

********************************************************************************
** creater balanced industry codes. Code from Barany 2018
********************************************************************************
do "do_prepare\create-balanced-industry-codes.do"
count
sum ind*
********************************************************************************
** creater 16 industry codes. Code from Barany 2018
********************************************************************************
do "do_prepare\create-16-industry-codes.do"
count
sum ind*
********************************************************************************
** create-11-industry-codes
********************************************************************************
do "do_prepare\create-11-industry-codes.do"
count
sum ind*
********************************************************************************
** recode to 3 industries
********************************************************************************
recode ind16 (1/6=1) (7/9=2) (10/16=3), gen(ind3)
count
sum ind*
********************************************************************************
** create 3 sectors
********************************************************************************
do "do_prepare\create-ind1990-3-sectors"
count
sum ind* occ*

********************************************************************************
** create hours worked last year
********************************************************************************
sum wkswork1 hrswork1
count if wkswork1==0 /*1,264,955*/
count if hrswork1==0 /*100,222*/
** note there are many wrong zeros in wkswork1 and uhrswork (hrswork1) - which mean N/A
** could set these zeros to the mean of those observed, which would be done by the following lines
** in the orinial code from BS(2018) the condition workedyr==2 is used. 
** Since this var is not available in census 1950, the code is run without it. 
** It should be still ok since incwage var is still used. 
tab wkswork1 if incwage>0 & incwage<. & hrswork1>0 & hrswork1<., m
sum wkswork1 if incwage>0 & incwage<. & hrswork1>0 & hrswork1<. & wkswork1>0
replace wkswork1=`r(mean)' if wkswork1==0 & incwage>0 & incwage<. & hrswork1>0 & hrswork1<.

tab hrswork1 if incwage>0 & incwage<. & wkswork1>0 & wkswork1<., m
sum hrswork1 if incwage>0 & incwage<. & wkswork1>0 & wkswork1<. & hrswork1>0
replace hrswork1=`r(mean)' if incwage>0 & incwage<. & wkswork1>0 & wkswork1<. & hrswork1==0


** wkswork1 weeks worked last year
** wkswork2 weeks worked last year, intervalled
** hrswork1 hours worked last week
** hrswork2 hours worked last week, intervalled

** gen weeks worked last year
sum wkswork1 wkswork2, d
** I use wkswork1 weeks worked last year since there are no problems with
** top coded values 
gen weekslastyear=wkswork1 

** gen hours worked last week
** I use hrswork1. For individuals with 60+ hours worked (hrswork2==8)
** I set hours worked to 70. 
gen hourslastweek=hrswork1
replace hourslastweek=70 if hrswork2==8

** gen hours worked last year
gen hourslastyear=weekslastyear*hourslastweek
sum weekslastyear hourslastweek hourslastyear

label var weekslastyear "weeks worked last year"
label var hourslastweek "hours worked last week"
label var hourslastyear "hours worked last year"

*******************************************************************
** create education dummy variables to be used in lswt creation, then dropped
** from BS(2018)
*******************************************************************
** Note: The underlying variable differs between 1980, and 1990/2000
** The groups are defined as follows:
** 1) Less than high school (lths) - up to 11th grade of high school 
** 2) High school (hsch) - 12th grade of high school, with or without
** graduation (in 1990/2000, this category includes GEDs which cannot 
** be identified separately)
** 3) Some college (scoll) - 1 to 3 years of college in 1980; some college
** with no degree or associate degree in 1990/2000
** 4) Bachelors degree (bach) - 4+ years of college in 1980, bachelors degree
** in 1990 
** 5) Masters degree (master) - 6+ years of college in 1980, 

** For 1950, people too young to attend school and those who never attended
** school are lumped together as code 000 'N/A or No Schooling'.
** set Less than high school (lths)  set to 1 if never attanded school. 

foreach v in lths hsch scoll coll bach master {
gen edu_`v'=0 if (educd<=116)
}
**
replace edu_lths=(educd<=50)
replace edu_hsch=(educd>=60 & educd<=64)
replace edu_scoll=(educd>=65 & educd<=90)
replace edu_coll=(educd>=100 & educd<=116)
replace edu_bach=(educd==100 | educd==101)
replace edu_master=(educd>=110 & educd<=116)

assert edu_lths + edu_hsch + edu_scoll + edu_coll == 1 if (educ>=2 & educ<=116)
assert edu_bach + edu_master == edu_coll if (educ>=2 & educ<=116)

********************************************************************************
** labor supply weights
********************************************************************************
** Labor supply weight - calculate where possible, impute by occupation 
** for those with missing hours or weeks. Code from BS(2018)
** perwt multiplied by Hours worked per week devided by 35 multiplied with weeks worked per year
** devided by 50
gen lswt=perwt*(hourslastweek/35)*(weekslastyear/50)
label var lswt "labour supply weights (hourslastyear/35)*(weekslastyear/50)"
replace lswt=. if lswt==0
summ lswt perwt
count if lswt==. /*75,074*/

** many have n/a or no 
gen edu_test=edu_lths+edu_hsch+edu_scoll+edu_coll
assert edu_test==1 if edu_test!=.
gen edcat= 1*edu_lths + 2*edu_hsch + 3*edu_scoll + 4*edu_coll
assert edcat!=. if edcat>=1 & edcat<=4
egen mnwt=sum(lswt),by(occ1990cszb edcat)
egen temp=sum(perwt*(lswt!=.)),by(occ1990cszb edcat)
replace mnwt=mnwt/temp
summ mnwt
count if mnwt==.

gen byte impute=lswt==.
replace lswt=perwt*mnwt if lswt==.
tab impute, summ(lswt)

count if lswt==. /* 2 */
  
* One more level of imputation if needed
* use average edcat lswt for those who have missing lswt
count if lswt==.
drop temp mnwt
egen mnwt=sum(lswt),by(edcat)
egen temp=sum(perwt*(lswt!=.)),by(edcat)
replace mnwt=mnwt/temp
*assert mnwt!=.
replace lswt=perwt*mnwt if lswt==.
tab impute, summ(lswt)
drop mnwt temp

* One more level of imputation if needed
* use average occ1990cszb for those who have missing lswt
count if lswt==.
egen mnwt=sum(lswt),by(occ1990cszb)
egen temp=sum(perwt*(lswt!=.)),by(occ1990cszb)
replace mnwt=mnwt/temp
*assert mnwt!=.
replace lswt=perwt*mnwt if lswt==.
tab impute, summ(lswt)
drop mnwt temp
count if lswt==. /* 0 */

********************************************************************************
** save 
********************************************************************************
label data "Prepared Labor Force Census 1950"
save "temp\census1950", replace

drop cz_id
** 722
egen cz_id=group(czone)
sum cz_id
drop N 
bysort cz_id: gen N=_N
** 186 obs min
sum N, d




