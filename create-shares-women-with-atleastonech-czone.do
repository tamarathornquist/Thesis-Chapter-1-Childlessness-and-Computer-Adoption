/*
*/ 

** In this do file I create shares of women with at least one child by 
** age group, coll, czone and year 

cd "C:\Users\..."

********************************************************************************
** share of women by age group 20-39, educ, cz and year with at least one child
********************************************************************************
foreach y in 1980 1990 2000 {
use temp_cz\census`y', clear
** keep females
keep if sex==2
keep if age>19 & age<40
** gen coll
gen coll=0
replace coll=1 if educ>9
** gen at least one children
gen atleastonech=0
replace atleastonech=1 if nchild!=0
*tab atleastonech nchild
** count 
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(coll atleastonech year czone) 
rename unique_ind unique_ind_coll
reshape wide unique_ind_coll, i(atleastonech year czone)  j(coll)
rename unique_ind_coll0 ind_coll0_ch
rename unique_ind_coll1 ind_coll1_ch
** replace for noll if missing 
replace ind_coll0_ch=0 if ind_coll0_ch==.
replace ind_coll1_ch=0 if ind_coll1_ch==.

reshape wide ind_coll0_ch ind_coll1_ch, i(year czone)  j(atleastonech)
** replace for noll if missing 
replace ind_coll0_ch1=0 if ind_coll0_ch1==.
replace ind_coll0_ch0=0 if ind_coll0_ch0==.
replace ind_coll1_ch1=0 if ind_coll1_ch1==.
replace ind_coll1_ch0=0 if ind_coll1_ch0==.

** share all women with at least one children
gen sh_atleastonech=(ind_coll0_ch1+ind_coll1_ch1)/(ind_coll0_ch1+ind_coll1_ch1+ind_coll0_ch0+ind_coll1_ch0)
gen sh_atleastonech_c=(ind_coll1_ch1)/(ind_coll1_ch1+ind_coll1_ch0)
gen sh_atleastonech_nc=(ind_coll0_ch1)/(ind_coll0_ch1+ind_coll0_ch0)
keep year czone sh_*
gen age=2039
*sum
save temp_outcomes\sh_women_a20_39_atleastonech_`y', replace
}
** 
foreach y in 2005 2010 2018 {
use temp_cz\acs`y', clear
** keep females
keep if sex==2
keep if age>19 & age<40
** gen coll
gen coll=0
replace coll=1 if educ>9
** gen at least one children
gen atleastonech=0
replace atleastonech=1 if nchild!=0
*tab atleastonech nchild
** count 
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(coll atleastonech year czone) 
rename unique_ind unique_ind_coll
reshape wide unique_ind_coll, i(atleastonech year czone)  j(coll)
rename unique_ind_coll0 ind_coll0_ch
rename unique_ind_coll1 ind_coll1_ch
** replace for noll if missing 
replace ind_coll0_ch=0 if ind_coll0_ch==.
replace ind_coll1_ch=0 if ind_coll1_ch==.

reshape wide ind_coll0_ch ind_coll1_ch, i(year czone)  j(atleastonech)
** replace for noll if missing 
replace ind_coll0_ch1=0 if ind_coll0_ch1==.
replace ind_coll0_ch0=0 if ind_coll0_ch0==.
replace ind_coll1_ch1=0 if ind_coll1_ch1==.
replace ind_coll1_ch0=0 if ind_coll1_ch0==.

** share all women with at least one children
gen sh_atleastonech=(ind_coll0_ch1+ind_coll1_ch1)/(ind_coll0_ch1+ind_coll1_ch1+ind_coll0_ch0+ind_coll1_ch0)
gen sh_atleastonech_c=(ind_coll1_ch1)/(ind_coll1_ch1+ind_coll1_ch0)
gen sh_atleastonech_nc=(ind_coll0_ch1)/(ind_coll0_ch1+ind_coll0_ch0)
keep year czone sh_*
gen age=2039
*sum
save temp_outcomes\sh_women_a20_39_atleastonech_`y', replace
}
** 

********************************************************************************
** share of women by age group 20-29, educ, cz and year with at least one child
********************************************************************************
foreach y in 1980 1990 2000 {
use temp_cz\census`y', clear
** keep females
keep if sex==2
keep if age>19 & age<30
** gen coll
gen coll=0
replace coll=1 if educ>9
** gen at least one children
gen atleastonech=0
replace atleastonech=1 if nchild!=0
*tab atleastonech nchild
** count 
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(coll atleastonech year czone) 
rename unique_ind unique_ind_coll
reshape wide unique_ind_coll, i(atleastonech year czone)  j(coll)
rename unique_ind_coll0 ind_coll0_ch
rename unique_ind_coll1 ind_coll1_ch
** replace for noll if missing 
replace ind_coll0_ch=0 if ind_coll0_ch==.
replace ind_coll1_ch=0 if ind_coll1_ch==.

reshape wide ind_coll0_ch ind_coll1_ch, i(year czone)  j(atleastonech)
** replace for noll if missing 
replace ind_coll0_ch1=0 if ind_coll0_ch1==.
replace ind_coll0_ch0=0 if ind_coll0_ch0==.
replace ind_coll1_ch1=0 if ind_coll1_ch1==.
replace ind_coll1_ch0=0 if ind_coll1_ch0==.

** share all women with at least one children
gen sh_atleastonech=(ind_coll0_ch1+ind_coll1_ch1)/(ind_coll0_ch1+ind_coll1_ch1+ind_coll0_ch0+ind_coll1_ch0)
gen sh_atleastonech_c=(ind_coll1_ch1)/(ind_coll1_ch1+ind_coll1_ch0)
gen sh_atleastonech_nc=(ind_coll0_ch1)/(ind_coll0_ch1+ind_coll0_ch0)
keep year czone sh_*
gen age=2029
*sum
save temp_outcomes\sh_women_a20_29_atleastonech_`y', replace
}
** 
foreach y in 2005 2010 2018 {
use temp_cz\acs`y', clear
** keep females
keep if sex==2
keep if age>19 & age<30
** gen coll
gen coll=0
replace coll=1 if educ>9
** gen at least one children
gen atleastonech=0
replace atleastonech=1 if nchild!=0
*tab atleastonech nchild
** count 
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(coll atleastonech year czone) 
rename unique_ind unique_ind_coll
reshape wide unique_ind_coll, i(atleastonech year czone)  j(coll)
rename unique_ind_coll0 ind_coll0_ch
rename unique_ind_coll1 ind_coll1_ch
** replace for noll if missing 
replace ind_coll0_ch=0 if ind_coll0_ch==.
replace ind_coll1_ch=0 if ind_coll1_ch==.

reshape wide ind_coll0_ch ind_coll1_ch, i(year czone)  j(atleastonech)
** replace for noll if missing 
replace ind_coll0_ch1=0 if ind_coll0_ch1==.
replace ind_coll0_ch0=0 if ind_coll0_ch0==.
replace ind_coll1_ch1=0 if ind_coll1_ch1==.
replace ind_coll1_ch0=0 if ind_coll1_ch0==.

** share all women with at least one children
gen sh_atleastonech=(ind_coll0_ch1+ind_coll1_ch1)/(ind_coll0_ch1+ind_coll1_ch1+ind_coll0_ch0+ind_coll1_ch0)
gen sh_atleastonech_c=(ind_coll1_ch1)/(ind_coll1_ch1+ind_coll1_ch0)
gen sh_atleastonech_nc=(ind_coll0_ch1)/(ind_coll0_ch1+ind_coll0_ch0)
keep year czone sh_*
gen age=2029
*sum
save temp_outcomes\sh_women_a20_29_atleastonech_`y', replace
}
** 


********************************************************************************
** share of women by age group 30-39, educ, cz and year with at least one child
********************************************************************************
foreach y in 1980 1990 2000 {
use temp_cz\census`y', clear
** keep females
keep if sex==2
keep if age>29 & age<40
** gen coll
gen coll=0
replace coll=1 if educ>9
** gen at least one children
gen atleastonech=0
replace atleastonech=1 if nchild!=0
*tab atleastonech nchild
** count 
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(coll atleastonech year czone) 
rename unique_ind unique_ind_coll
reshape wide unique_ind_coll, i(atleastonech year czone)  j(coll)
rename unique_ind_coll0 ind_coll0_ch
rename unique_ind_coll1 ind_coll1_ch
** replace for noll if missing 
replace ind_coll0_ch=0 if ind_coll0_ch==.
replace ind_coll1_ch=0 if ind_coll1_ch==.

reshape wide ind_coll0_ch ind_coll1_ch, i(year czone)  j(atleastonech)
** replace for noll if missing 
replace ind_coll0_ch1=0 if ind_coll0_ch1==.
replace ind_coll0_ch0=0 if ind_coll0_ch0==.
replace ind_coll1_ch1=0 if ind_coll1_ch1==.
replace ind_coll1_ch0=0 if ind_coll1_ch0==.

** share all women with at least one children
gen sh_atleastonech=(ind_coll0_ch1+ind_coll1_ch1)/(ind_coll0_ch1+ind_coll1_ch1+ind_coll0_ch0+ind_coll1_ch0)
gen sh_atleastonech_c=(ind_coll1_ch1)/(ind_coll1_ch1+ind_coll1_ch0)
gen sh_atleastonech_nc=(ind_coll0_ch1)/(ind_coll0_ch1+ind_coll0_ch0)
keep year czone sh_*
gen age=3039
*sum
save temp_outcomes\sh_women_a30_39_atleastonech_`y', replace
}
** 
foreach y in 2005 2010 2018 {
use temp_cz\acs`y', clear
** keep females
keep if sex==2
keep if age>29 & age<40
** gen coll
gen coll=0
replace coll=1 if educ>9
** gen at least one children
gen atleastonech=0
replace atleastonech=1 if nchild!=0
*tab atleastonech nchild
** count 
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(coll atleastonech year czone) 
rename unique_ind unique_ind_coll
reshape wide unique_ind_coll, i(atleastonech year czone)  j(coll)
rename unique_ind_coll0 ind_coll0_ch
rename unique_ind_coll1 ind_coll1_ch
** replace for noll if missing 
replace ind_coll0_ch=0 if ind_coll0_ch==.
replace ind_coll1_ch=0 if ind_coll1_ch==.

reshape wide ind_coll0_ch ind_coll1_ch, i(year czone)  j(atleastonech)
** replace for noll if missing 
replace ind_coll0_ch1=0 if ind_coll0_ch1==.
replace ind_coll0_ch0=0 if ind_coll0_ch0==.
replace ind_coll1_ch1=0 if ind_coll1_ch1==.
replace ind_coll1_ch0=0 if ind_coll1_ch0==.

** share all women with at least one children
gen sh_atleastonech=(ind_coll0_ch1+ind_coll1_ch1)/(ind_coll0_ch1+ind_coll1_ch1+ind_coll0_ch0+ind_coll1_ch0)
gen sh_atleastonech_c=(ind_coll1_ch1)/(ind_coll1_ch1+ind_coll1_ch0)
gen sh_atleastonech_nc=(ind_coll0_ch1)/(ind_coll0_ch1+ind_coll0_ch0)
keep year czone sh_*
gen age=3039
*sum
save temp_outcomes\sh_women_a30_39_atleastonech_`y', replace
}
** 

********************************************************************************
** append all at least one child
********************************************************************************
use temp_outcomes\sh_women_a20_39_atleastonech_1980, clear
foreach y in 1990 2000 2010 2018 {
append using temp_outcomes\sh_women_a20_39_atleastonech_`y'
}
**
foreach y in 1980 1990 2000 2010 2018 {
append using temp_outcomes\sh_women_a20_29_atleastonech_`y'
append using temp_outcomes\sh_women_a30_39_atleastonech_`y'
}
**
sum
tab year
save "temp_outcomes\sh_women_atleastonech", replace

**
use "temp_outcomes\sh_women_atleastonech", clear
duplicates report 
sum
tab year age if sh_atleastonech_c==.
replace sh_atleastonech_c=0 if sh_atleastonech_c==.
sum sh_atleastonech if age==2039 & year==1980
sum sh_atleastonech if age==2039 & year==1990
sum sh_atleastonech if age==2039 & year==2000
sum sh_atleastonech if age==2039 & year==2010
** gen decade diff
foreach var in sh_atleastonech sh_atleastonech_c sh_atleastonech_nc {
bysort czone age (year): gen F`var'=`var'[_n+1]
bysort czone age (year): gen d_`var'=F`var'-`var'
}
** 
sum 
br czone age year F* sh* d*
keep czone age year d*
drop if year==2018
label var d_sh_atleastonech "decade change sh =>1 child, any educ"
label var d_sh_atleastonech_c "decade change sh =>1 child, coll"
label var d_sh_atleastonech_nc "decade change sh =>1 child, non coll"
save "temp_outcomes\dsh_women_atleastonech", replace








