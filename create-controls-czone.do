/*
*/

** This do file constructs all controls by czone and saves them in folder temp_controls

********************************************************************************
** pop shares 
********************************************************************************
cd "C:\Users\..."
foreach y in 1960 {
use temp_cz\census`y', clear
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(year czone) 
bysort year: egen total_pop=sum(unique_ind)
gen pop_sh=unique_ind/total_pop
keep year pop_sh czone
label var pop_sh "czone population share"
save "temp_controls\pop_share_`y'", replace
}
** 
foreach y in 1970 {
use temp_cz\census`y', clear
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afact], by(year czone) 
bysort year: egen total_pop=sum(unique_ind)
gen pop_sh=unique_ind/total_pop
keep year pop_sh czone
label var pop_sh "czone population share"
save "temp_controls\pop_share_`y'", replace
}
**

foreach y in 1980 1990 2000 {
use temp_cz\census`y', clear
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(year czone) 
bysort year: egen total_pop=sum(unique_ind)
gen pop_sh=unique_ind/total_pop
keep year pop_sh czone
label var pop_sh "czone population share"
save "temp_controls\pop_share_`y'", replace
}
** 
foreach y in 2005 2010 2015 {
use temp_cz\acs`y', clear
gen unique_ind=1
collapse (count) unique_ind [pweight=perwt*afactor], by(year czone) 
bysort year: egen total_pop=sum(unique_ind)
gen pop_sh=unique_ind/total_pop
keep year pop_sh czone
label var pop_sh "czone population share"
save "temp_controls\pop_share_`y'", replace
}
** 
use temp_controls\pop_share_1980, clear
foreach y in  1990 2000 2005 2010 2018 {
append using "temp_controls\pop_share_`y'"
}
**
sum
save "temp_controls\pop_share_1980_2015", replace

use temp_controls\pop_share_1960, clear
foreach y in 1970 1980 1990 2000 2010 2018 {
append using "temp_controls\pop_share_`y'"
}
**
sum
tab year
save "temp_controls\pop_share_1960_2018", replace
********************************************************************************
** append raw data sets with czone 1980-2010 to create controls
********************************************************************************
use temp_cz\census1960, clear
foreach y in 1970 {
append using temp_cz\census`y'
}
foreach y in 2010 2018 {
append using temp_cz\acs`y'
}
** 
compress
replace afactor=afact if year==1970
save temp_controls\data_cz_1960_70_2010_2018, replace

use temp_cz\census1980, clear
foreach y in 1990 2000 {
append using temp_cz\census`y'
}
compress
save temp_controls\data_cz_1980_90_2000, replace

********************************************************************************
** share unemployed noncoll men
********************************************************************************
use temp_controls\data_cz, clear
** working age
keep if age>15 & age<65
** keep non coll
gen coll=0 
replace coll=1 if educ>9
keep if coll==0
** keep with specified gender
keep if sex==1
** drop if not in labor force
tab empstat
drop if empstat==3
** count empl, unempl weighted
gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year empstat)
sum
** sum all in labor force
bysort czone year: egen count_all=total(NN)
** calculate unempl rate
gen unempl=NN/count_all
** keep unempl rate
keep if empstat==2
keep czone year unempl
** rename
rename unempl unempl_nc_m
sum
save "temp_controls\unempl_nc_m", replace

********************************************************************************
** share unemployed noncoll women
********************************************************************************
use temp_controls\data_cz, clear
** working age
keep if age>15 & age<65
** keep non coll
gen coll=0 
replace coll=1 if educ>9
keep if coll==0
** keep with specified gender
keep if sex==2
** drop if not in labor force
tab empstat
drop if empstat==3
** count empl, unempl weighted
gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year empstat)
sum
** sum all in labor force
bysort czone year: egen count_all=total(NN)
** calculate unempl rate
gen unempl=NN/count_all
** keep unempl rate
keep if empstat==2
keep czone year unempl
** rename
rename unempl unempl_nc_w
sum
save "temp_controls\unempl_nc_w", replace


********************************************************************************
** share unemployed coll men
********************************************************************************
use temp_controls\data_cz, clear
** working age
keep if age>15 & age<65
** keep non coll
gen coll=0 
replace coll=1 if educ>9
keep if coll==1
** keep with specified gender
keep if sex==1
** drop if not in labor force
tab empstat
drop if empstat==3
** count empl, unempl weighted
gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year empstat)
sum
** sum all in labor force
bysort czone year: egen count_all=total(NN)
** calculate unempl rate
gen unempl=NN/count_all
** keep unempl rate
keep if empstat==2
keep czone year unempl
** rename
rename unempl unempl_c_m
sum
save "temp_controls\unempl_c_m", replace

********************************************************************************
** share unemployed coll women
********************************************************************************
use temp_controls\data_cz, clear
** working age
keep if age>15 & age<65
** keep non coll
gen coll=0 
replace coll=1 if educ>9
keep if coll==1
** keep with specified gender
keep if sex==2
** drop if not in labor force
tab empstat
drop if empstat==3
** count empl, unempl weighted
gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year empstat)
sum
** sum all in labor force
bysort czone year: egen count_all=total(NN)
** calculate unempl rate
gen unempl=NN/count_all
** keep unempl rate
keep if empstat==2
keep czone year unempl
** rename
rename unempl unempl_c_w
sum
save "temp_controls\unempl_c_w", replace



********************************************************************************
** merge all unempl rates
********************************************************************************
use "temp_controls\unempl_nc_m", clear
merge 1:1 czone year using "temp_controls\unempl_nc_w"
drop _merge
merge 1:1 czone year using "temp_controls\unempl_c_m"
drop _merge
merge 1:1 czone year using "temp_controls\unempl_c_w"
drop _merge
sum
replace unempl_c_m=0 if unempl_c_m==.
replace unempl_c_w=0 if unempl_c_w==.
sum 
label var unempl_c_m "unempl rate coll men"
label var unempl_c_w "unempl rate coll women"
label var unempl_nc_m "unempl rate non coll men"
label var unempl_nc_w "unempl rate non coll women"
save "temp_controls\controls_unempl", replace
 

********************************************************************************
** labour force participation coll and non coll men
********************************************************************************
use temp_controls\data_cz, clear
keep if age>15 & age<65

gen coll=0 
replace coll=1 if educ>9

keep if sex==1

count
tab empstat
gen NN=1
gen lab_force=0
replace lab_force=1 if empstat<3
collapse (count) NN [pw=perwt*afactor], by(czone year lab_force coll)
sum
br
bysort czone year coll: egen count_all=total(NN)
gen labf=NN/count_all
keep if lab_force==1
keep czone year labf coll
reshape wide labf, i(czone year) j(coll)
rename labf0 labf_nc_m
rename labf1 labf_c_m
label var labf_nc_m "labor force particip non coll men"
label var labf_c_m "labor force particip coll men"
save "temp_controls\labf_ m", replace
sum 

********************************************************************************
** labour force participation coll and non coll women
********************************************************************************
use temp_controls\data_cz, clear
keep if age>15 & age<65

gen coll=0 
replace coll=1 if educ>9

keep if sex==2

count
tab empstat
gen NN=1
gen lab_force=0
replace lab_force=1 if empstat<3
collapse (count) NN [pw=perwt*afactor], by(czone year lab_force coll)
sum
br
bysort czone year coll: egen count_all=total(NN)
gen labf=NN/count_all
keep if lab_force==1
keep czone year labf coll
reshape wide labf, i(czone year) j(coll)
rename labf0 labf_nc_f
rename labf1 labf_c_f
label var labf_nc_f "labor force particip non coll women"
label var labf_c_f "labor force particip coll women"
save "temp_controls\labf_f", replace


********************************************************************************
** megre labour force participation men and women
********************************************************************************
use "temp_controls\labf_ m", clear
merge 1:1 czone year using "temp_controls\labf_f"
drop _merge
save "temp_controls\contros_labf", replace

********************************************************************************
** share black
********************************************************************************
use temp_controls\data_cz_1960_70_2010_2018, clear
gen NN=1
keep NN perwt afactor czone year race
gen black=0
replace black=1 if race==2
collapse (count) NN [pw=perwt*afactor], by(czone year black)
bysort czone year: egen total=sum(NN)
gen sh_black=NN/total
keep if black==1
keep czone year sh_* 
sum 
replace sh_black=0 if sh_black==.
save "temp_controls\controls_sh_black2", replace
use "temp_controls\controls_sh_black2", clear
append using "temp_controls\controls_sh_black" 
summarize
tab year
save, replace

********************************************************************************
** share hispanic
********************************************************************************
use temp_controls\data_cz_1960_70_2010_2018, clear
gen NN=1
keep NN perwt afactor czone year hispan
gen hispanic=0
replace hispanic=1 if hispan>0
compress
collapse (count) NN [pw=perwt*afactor], by(czone year hispanic)
bysort czone year: egen total=sum(NN)
gen sh_hispanic=NN/total
keep if hispanic==1
keep czone year sh_*
sum 
save "temp_controls\controls_sh_hispanic2", replace



********************************************************************************
** share other race
********************************************************************************
use temp_controls\data_cz_1960_70_2010_2018, clear
gen NN=1
keep NN perwt afactor czone year race hispan
gen white=0
replace white=1 if race==1
gen black=0
replace black=1 if race==2
gen hispanic=0
replace hispanic=1 if hispan>0
gen othrace=0
replace othrace=1 if (white==0 & black==0 & hispanic==0) 
compress
collapse (count) NN [pw=perwt*afactor], by(czone year othrace)
bysort czone year: egen total=sum(NN)
gen sh_othrace=NN/total
keep if othrace==1
keep czone sh_* year
save "temp_controls\controls_sh_othrace2", replace



********************************************************************************
** share born abroad
********************************************************************************
use temp_controls\data_cz_1960_70_2010_2018, clear

gen NN=1
keep NN perwt afactor czone year bpl

gen foreign=0
replace foreign=1 if bpl>120
tab foreign 
label var foreign "1,0 foreign/US born"

compress
collapse (count) NN [pw=perwt*afactor], by(czone year foreign)

bysort czone year: egen total=sum(NN)
gen sh_foreign=NN/total
keep if foreign==1

keep czone year sh_* year
sum 
save "temp_controls\controls_sh_foreign2", replace



********************************************************************************
** sex ratio 2029
********************************************************************************
use temp_controls\data_cz, clear
keep if age>19 & age<30
gen female=sex==2
gen NN=1
keep NN perwt afactor czone year female

collapse (count) NN [pw=perwt*afactor], by(czone year female)

reshape wide NN, i(year czone) j(female)
bysort czone year: gen sex_ratio_2029=NN1/NN0

keep czone year sex* year
sum
save "temp_controls\controls_sex_ratio_2029", replace
********************************************************************************
** sex ratio 3039
********************************************************************************
use temp_controls\data_cz, clear
keep if age>29 & age<40
gen female=sex==2
gen NN=1
keep NN perwt afactor czone year female

collapse (count) NN [pw=perwt*afactor], by(czone year female)

reshape wide NN, i(year czone) j(female)
bysort czone year: gen sex_ratio_3039=NN1/NN0

keep czone year sex* year
sum
save "temp_controls\controls_sex_ratio_3039", replace
********************************************************************************
** sex ratio 4044
********************************************************************************
use temp_controls\data_cz, clear
keep if age>39 & age<45
gen female=sex==2
gen NN=1
keep NN perwt afactor czone year female

collapse (count) NN [pw=perwt*afactor], by(czone year female)

reshape wide NN, i(year czone) j(female)
bysort czone year: gen sex_ratio_4044=NN1/NN0

keep czone year sex* year
sum
save "temp_controls\controls_sex_ratio_4044", replace

********************************************************************************
** merge race, foreign sex share
********************************************************************************
use "temp_controls\controls_sh_black", clear
merge 1:1 czone year using "temp_controls\controls_sh_hispanic"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_othrace"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_foreign"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sex_ratio_2029"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sex_ratio_3039"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sex_ratio_4044"
drop _merge
label var sh_black "share black"
label var sh_hispanic "share hispanic"
label var sh_othrace "share other race"
label var sh_foreign "share foreign born"
label var sex_ratio_2029 "number women/number men age 20-29"
label var sex_ratio_3039 "number women/number men age 30-39"
label var sex_ratio_4044 "number women/number men age 40-44"
sum 

replace sh_black=0 if sh_black==.

save "temp_controls\controls_race_foreign_sexratio", replace


********************************************************************************
** sex ratio 2637
********************************************************************************
use temp_controls\data_cz_1960_70_2010_2018, clear
compress
keep if age>25 & age<38
gen female=sex==2
gen NN=1
keep NN perwt afactor czone year female

collapse (count) NN [pw=perwt*afactor], by(czone year female)

reshape wide NN, i(year czone) j(female)
bysort czone year: gen sex_ratio_2637=NN1/NN0

keep czone year sex* year
sum
save "temp_controls\controls_sex_ratio_2637", replace

********************************************************************************
** mean education years 16-64 years
********************************************************************************
use temp_controls\data_cz_1960_70_2010_2018, clear
compress
keep if age>15 & age<65

gen female=sex==2

gen educ_years = 0
replace educ_years = 4  if educ== 1
replace educ_years = 8  if educ== 2
replace educ_years = 9  if educ== 3
replace educ_years = 10 if educ== 4
replace educ_years = 11 if educ== 5
replace educ_years = 12 if educ== 6
replace educ_years = 13 if educ== 7
replace educ_years = 14 if educ== 8
replace educ_years = 15 if educ== 9
replace educ_years = 16 if educ== 10
replace educ_years = 17 if educ== 11

tab educ_years educ
drop if educ_years==0

bysort female czone year: egen meaneduc=mean(educ_years)
bysort female czone year: gen n=_n
keep if n==1
keep year czone meaneduc female
reshape wide meaneduc, i(year czone) j(female)
rename meaneduc0 meaneduc_m
rename meaneduc1 meaneduc_w
keep meanedu* czone year
save "temp_controls\controls_meaneduc_1664", replace

********************************************************************************
** share coll 16-64
********************************************************************************
use temp_controls\data_cz_1960_70_2010_2018, clear
compress
keep if age>15 & age<65

gen coll=0 
replace coll=1 if educ>9

gen female=sex==2

gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year coll female)

bysort female czone year: egen count_all=total(NN)
gen sh_c=NN/count_all
keep if coll==1
drop coll NN cou*
reshape wide sh_c, i(czone year) j(female)
rename sh_c0 sh_c_m
rename sh_c1 sh_c_w
label var sh_c_m "share coll men age 16-64"
label var sh_c_w "share coll women age 16-64"
save "temp_controls\controls_sh_c_16664", replace

********************************************************************************
** sex ratio 2637
********************************************************************************
use temp_controls\data_cz_1980_90_2000, clear
compress
keep if age>25 & age<38
gen female=sex==2
gen NN=1
keep NN perwt afactor czone year female

collapse (count) NN [pw=perwt*afactor], by(czone year female)

reshape wide NN, i(year czone) j(female)
bysort czone year: gen sex_ratio_2637=NN1/NN0

keep czone year sex* year
sum
save "temp_controls\controls_sex_ratio_2637_2", replace

********************************************************************************
** mean education years 16-64 years
********************************************************************************
use temp_controls\data_cz_1980_90_2000, clear
compress
keep if age>15 & age<65

gen female=sex==2

gen educ_years = 0
replace educ_years = 4  if educ== 1
replace educ_years = 8  if educ== 2
replace educ_years = 9  if educ== 3
replace educ_years = 10 if educ== 4
replace educ_years = 11 if educ== 5
replace educ_years = 12 if educ== 6
replace educ_years = 13 if educ== 7
replace educ_years = 14 if educ== 8
replace educ_years = 15 if educ== 9
replace educ_years = 16 if educ== 10
replace educ_years = 17 if educ== 11

tab educ_years educ
drop if educ_years==0

bysort female czone year: egen meaneduc=mean(educ_years)
bysort female czone year: gen n=_n
keep if n==1
keep year czone meaneduc female
reshape wide meaneduc, i(year czone) j(female)
rename meaneduc0 meaneduc_m
rename meaneduc1 meaneduc_w
keep meanedu* czone year
save "temp_controls\controls_meaneduc_1664_2", replace

********************************************************************************
** share coll 16-64
********************************************************************************
use temp_controls\data_cz_1980_90_2000, clear
compress
keep if age>15 & age<65

gen coll=0 
replace coll=1 if educ>9

gen female=sex==2

gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year coll female)

bysort female czone year: egen count_all=total(NN)
gen sh_c=NN/count_all
keep if coll==1
drop coll NN cou*
reshape wide sh_c, i(czone year) j(female)
rename sh_c0 sh_c_m
rename sh_c1 sh_c_w
label var sh_c_m "share coll men age 16-64"
label var sh_c_w "share coll women age 16-64"
save "temp_controls\controls_sh_c_16664_2", replace


********************************************************************************
** merge race, foreign sex share 1960-2018
********************************************************************************
merge 1:1 czone year using "temp_controls\controls_sh_black2", update replace
drop _merge
sum
tab year

merge 1:1 czone year using "temp_controls\controls_sh_hispanic"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_hispanic2"
drop _merge

merge 1:1 czone year using "temp_controls\controls_sh_othrace"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_foreign"
drop _merge


merge 1:1 czone year using "temp_controls\controls_sh_othrace2"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_foreign2"
drop _merge

merge 1:1 czone year using "temp_controls\controls_sex_ratio_2736"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_c_16664"
drop _merge
merge 1:1 czone year using "temp_controls\controls_meaneduc_1664"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sex_ratio_2736_2"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_c_16664_2"
drop _merge
merge 1:1 czone year using "temp_controls\controls_meaneduc_1664_2"
drop _merge
label var sh_black "share black"
label var sh_hispanic "share hispanic"
label var sh_othrace "share other race"
label var sh_foreign "share foreign born"
label var sex_ratio_2736 "number women/number men age 20-29"

sum 

replace sh_black=0 if sh_black==.

save "temp_controls\controls_ch2", replace

********************************************************************************
** mean education years 20 29 years
********************************************************************************
use temp_controls\data_cz, clear

keep if age>19 & age<30

gen female=sex==2

gen educ_years = 0
replace educ_years = 4  if educ== 1
replace educ_years = 8  if educ== 2
replace educ_years = 9  if educ== 3
replace educ_years = 10 if educ== 4
replace educ_years = 11 if educ== 5
replace educ_years = 12 if educ== 6
replace educ_years = 13 if educ== 7
replace educ_years = 14 if educ== 8
replace educ_years = 15 if educ== 9
replace educ_years = 16 if educ== 10
replace educ_years = 17 if educ== 11

tab educ_years educ
drop if educ_years==0

bysort female czone year: egen meaneduc=mean(educ_years)
bysort female czone year: gen n=_n
keep if n==1
keep year czone meaneduc female
reshape wide meaneduc, i(year czone) j(female)
rename meaneduc0 meaneduc_2029_m
rename meaneduc1 meaneduc_2029_w
keep meanedu* czone year
save "temp_controls\controls_meaneduc_2029", replace

********************************************************************************
** mean education years 30 39 years
********************************************************************************
use temp_controls\data_cz, clear

keep if age>29 & age<40

gen female=sex==2

gen educ_years = 0
replace educ_years = 4  if educ== 1
replace educ_years = 8  if educ== 2
replace educ_years = 9  if educ== 3
replace educ_years = 10 if educ== 4
replace educ_years = 11 if educ== 5
replace educ_years = 12 if educ== 6
replace educ_years = 13 if educ== 7
replace educ_years = 14 if educ== 8
replace educ_years = 15 if educ== 9
replace educ_years = 16 if educ== 10
replace educ_years = 17 if educ== 11

drop if educ_years==0

bysort female czone year: egen meaneduc=mean(educ_years)
bysort female czone year: gen n=_n
keep if n==1
keep year czone meaneduc female
reshape wide meaneduc, i(year czone) j(female)
rename meaneduc0 meaneduc_3039_m
rename meaneduc1 meaneduc_3039_w
keep meanedu* czone year
save "temp_controls\controls_meaneduc_3039", replace


********************************************************************************
** mean education years 40 44 years
********************************************************************************
use temp_controls\data_cz, clear

keep if age>39 & age<45

gen female=sex==2

gen educ_years = 0
replace educ_years = 4  if educ== 1
replace educ_years = 8  if educ== 2
replace educ_years = 9  if educ== 3
replace educ_years = 10 if educ== 4
replace educ_years = 11 if educ== 5
replace educ_years = 12 if educ== 6
replace educ_years = 13 if educ== 7
replace educ_years = 14 if educ== 8
replace educ_years = 15 if educ== 9
replace educ_years = 16 if educ== 10
replace educ_years = 17 if educ== 11

drop if educ_years==0

bysort female czone year: egen meaneduc=mean(educ_years)
bysort female czone year: gen n=_n
keep if n==1
keep year czone meaneduc female
reshape wide meaneduc, i(year czone) j(female)
rename meaneduc0 meaneduc_4044_m
rename meaneduc1 meaneduc_4044_w
keep meanedu* czone year
save "temp_controls\controls_meaneduc_4044", replace

********************************************************************************
** merge mean educ years
********************************************************************************
use "temp_controls\controls_meaneduc_2029", clear
merge 1:1 czone year using "temp_controls\controls_meaneduc_3039"
drop _merge 
merge 1:1 czone year using "temp_controls\controls_meaneduc_4044"
drop _merge 
sum
label var meaneduc_2029_m "mean educ years men age 20-29"
label var meaneduc_2029_w "mean educ years women age 20-29"
label var meaneduc_3039_m "mean educ years men age 30-39"
label var meaneduc_3039_w "mean educ years women age 30-39"
label var meaneduc_4044_m "mean educ years men age 40-44"
label var meaneduc_4044_w "mean educ years women age 40-44"
save "temp_controls\controls_meaneduc", replace

********************************************************************************
** share coll 20-29
********************************************************************************
use temp_controls\data_cz, clear
keep if age>19 & age<30

gen coll=0 
replace coll=1 if educ>9

gen female=sex==2

gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year coll female)

bysort female czone year: egen count_all=total(NN)
gen sh_c=NN/count_all
keep if coll==1
drop coll NN cou*
reshape wide sh_c, i(czone year) j(female)
rename sh_c0 sh_c_2029_m
rename sh_c1 sh_c_2029_w
label var sh_c_2029_m "share coll men age 20-29"
label var sh_c_2029_w "share coll women age 20-29"
save "temp_controls\controls_sh_c_2029", replace

********************************************************************************
** share coll 30-39
********************************************************************************
use temp_controls\data_cz, clear
keep if age>29 & age<40

gen coll=0 
replace coll=1 if educ>9

gen female=sex==2

gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year coll female)

bysort female czone year: egen count_all=total(NN)
gen sh_c=NN/count_all
keep if coll==1
drop coll NN cou*
reshape wide sh_c, i(czone year) j(female)
rename sh_c0 sh_c_3039_m
rename sh_c1 sh_c_3039_w
label var sh_c_3039_m "share coll men age 30-39"
label var sh_c_3039_w "share coll women age 30-39"
save "temp_controls\controls_sh_c_3039", replace

********************************************************************************
** share coll 40-44
********************************************************************************
use temp_controls\data_cz, clear
keep if age>39 & age<44

gen coll=0 
replace coll=1 if educ>9

gen female=sex==2

gen NN=1
collapse (count) NN [pw=perwt*afactor], by(czone year coll female)

bysort female czone year: egen count_all=total(NN)
gen sh_c=NN/count_all
keep if coll==1
drop coll NN cou*
reshape wide sh_c, i(czone year) j(female)
rename sh_c0 sh_c_4044_m
rename sh_c1 sh_c_4044_w
label var sh_c_4044_m "share coll men age 40-44"
label var sh_c_4044_w "share coll women age 40-44"
save "temp_controls\controls_sh_c_4044", replace

********************************************************************************
** merge share coll
********************************************************************************
use "temp_controls\controls_sh_c_2029", clear
merge 1:1 czone year using "temp_controls\controls_sh_c_3039"
drop _merge 
merge 1:1 czone year using "temp_controls\controls_sh_c_4044"
drop _merge 
sum
save "temp_controls\controls_sh_c", replace





********************************************************************************
** merge race, foreign sex share 1960-2018
********************************************************************************
use "temp_controls\controls_sh_black2",clear

merge 1:1 czone year using "temp_controls\controls_sh_hispanic2"
drop _merge

merge 1:1 czone year using "temp_controls\controls_sh_othrace2"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_foreign2"
drop _merge



merge 1:1 czone year using "temp_controls\controls_sex_ratio_2736"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_c_16664"
drop _merge
merge 1:1 czone year using "temp_controls\controls_meaneduc_1664"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sex_ratio_2736_2"
drop _merge
merge 1:1 czone year using "temp_controls\controls_sh_c_16664_2"
drop _merge
merge 1:1 czone year using "temp_controls\controls_meaneduc_1664_2"
drop _merge
label var sh_black "share black"
label var sh_hispanic "share hispanic"
label var sh_othrace "share other race"
label var sh_foreign "share foreign born"
label var sex_ratio_2736 "number women/number men age 20-29"

sum 

replace sh_black=0 if sh_black==.

save "temp_controls\controls_ch2", replace




