/*
*/

** Assemble data set and construct descriptives
cd "C:\Users\..."

********************************************************************************
** merge controls
********************************************************************************
** use pop shares 
use "temp_controls\pop_share_1980_2015", clear
** share coll
merge m:1 czone year using "temp_controls\controls_sh_c"
tab czone if _merge==2
drop _merge
** mean educ years
merge m:1 czone year using temp_controls\controls_meaneduc
drop _merge
** race, foreign sex share
merge m:1 czone year using "temp_controls\controls_race_foreign_sexratio"
drop _merge
** labor force particiation rates
merge m:1 czone year using "temp_controls\contros_labf"
drop _merge
** unempl rates
merge m:1 czone year using "temp_controls\controls_unempl"
drop _merge

** employment shares by ind
merge m:1 czone year using temp_controls\controls_empl_ind
drop _merge
** employment off ind
merge m:1 czone year using temp_controls\controls_offsh_ind
drop _merge
drop if year==2005
drop if year==2015
save "temp_controls\controls", replace


use "temp_controls\controls", clear
set more off
eststo clear
bysort year: eststo: estpost summarize meaneduc_2029_m meaneduc_2029_w meaneduc_3039_m meaneduc_3039_w meaneduc_4044_m meaneduc_4044_w sh_c_2029_m sh_c_2029_w sh_c_3039_m sh_c_3039_w sh_c_4044_m sh_c_4044_w sex_ratio_2029 sex_ratio_3039 sex_ratio_4044 sh_black sh_hispanic sh_othrace sh_foreign labf_nc_m labf_nc_f labf_c_m labf_c_f unempl_nc_m unempl_nc_w unempl_c_m unempl_c_w sh_mnf_nc_m sh_mnf_c_m sh_mnf_nc_w sh_mnf_c_w sh_hsk_nc_m sh_hsk_c_m sh_hsk_nc_w sh_hsk_c_w offind_nc_m offind_nc_w offind_c_m offind_c_w [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output_test\descr_controls.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar replace


use "temp_controls\controls", clear
merge m:1 czone year using temp\ds_rsh_1980_2015
drop if _merge!=3
drop _merge
label var rsh "share empl in routine intesive occ"
eststo clear
bysort year: eststo: estpost summarize rsh [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output_test\descr_controls.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar replace
