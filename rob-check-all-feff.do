/*
*/

** Rob check with altnative measures of RSH, only 2SLS
** Estimation results by educ group 

cd "C:\Users\..."

use "data\ds-shares-women-with-children", clear

xi i.statefip*i.year

replace sh_c_2029_w=0 if sh_c_2029_w==.
replace sh_c_2029_m=0 if sh_c_2029_m==.

global fixed_effects "_IstaXyea* d_1990 d_2000 d_2010 _Istatefip_*"
global c_demogr "sh_c_2029_m sh_c_2029_w sh_c_3039_m sh_c_3039_w meaneduc_2029_m meaneduc_2029_w meaneduc_3039_m meaneduc_3039_w sh_black sh_hispanic sh_othrace sh_foreign sex_ratio_2029 sex_ratio_3039"
global c_demogr_4044 "sh_c_4044_m sh_c_4044_w meaneduc_4044_m meaneduc_4044_w sex_ratio_4044"
global c_labmarket "labf_nc_m labf_c_m labf_nc_f labf_c_f unempl_nc_m unempl_nc_w unempl_c_m unempl_c_w"
global c_empl_ind "sh_mnf_nc_m sh_hsk_nc_m sh_mnf_c_m sh_hsk_c_m sh_mnf_nc_w sh_hsk_nc_w sh_mnf_c_w sh_hsk_c_w"
global c_offsh "offind_nc_m offind_c_m offind_nc_w offind_c_w"
********************************************************************************
** age 20-39
********************************************************************************
** any educ
********************************************************************************
set more off

eststo clear
foreach var in d_sh_atleastonech d_sh_atleasttwoch d_sh_atleastthreech d_sh_threeplch{
eststo: ivregress 2sls `var' (meanrti=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table-robch.tex, replace nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(meanrti)

eststo clear
foreach var in d_sh_atleastonech d_sh_atleasttwoch d_sh_atleastthreech d_sh_threeplch{
eststo: ivregress 2sls `var' (rsh_abs=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table-robch.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh_abs)

********************************************************************************
** coll
********************************************************************************
eststo clear
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c{
eststo: ivregress 2sls `var' (meanrti=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table-robch.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(meanrti)

eststo clear
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c{
eststo: ivregress 2sls `var' (rsh_abs=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table-robch.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh_abs)

********************************************************************************
** non-coll
********************************************************************************
eststo clear
foreach var in d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: ivregress 2sls `var' (meanrti=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table-robch.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(meanrti)

eststo clear
foreach var in d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: ivregress 2sls `var' (rsh_abs=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table-robch.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh_abs)

