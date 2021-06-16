/*
*/
** Estimation results by educ group 

cd "C:\Users\..."

use "data\ds-shares-women-with-children", clear

xi i.statefip*i.year

replace sh_c_2029_w=0 if sh_c_2029_w==.
replace sh_c_2029_m=0 if sh_c_2029_m==.

global fixed_effects "d_1990 d_2000 d_2010 _Istatefip_* _IstaXyea*"
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
eststo clear
foreach var in d_sh_atleastonech d_sh_atleasttwoch d_sh_atleastthreech d_sh_threeplch{
eststo: reg `var' rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
esttab using output_test\table1-stbyyrfeff.tex, replace nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)
eststo clear

** IV
foreach var in d_sh_atleastonech d_sh_atleasttwoch d_sh_atleastthreech d_sh_threeplch{
eststo: ivregress 2sls `var' (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table1-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)

********************************************************************************
** coll
********************************************************************************
eststo clear
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c{
eststo: reg `var' rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
esttab using output_test\table1-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)
eststo clear
** IV 
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c{
eststo: ivregress 2sls `var' (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table1-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)

********************************************************************************
** non coll
********************************************************************************
eststo clear
foreach var in d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: reg `var' rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
esttab using output_test\table1-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)
eststo clear
** IV 
foreach var in d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: ivregress 2sls `var' (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
}
** 
esttab using output_test\table1-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)

********************************************************************************
** age 20-29 and 30-39
********************************************************************************
eststo clear
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: reg `var' rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
}
esttab using output_test\table2-stbyyrfeff.tex, replace nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)
eststo clear
** IV 
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: ivregress 2sls `var' (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
}
** 
esttab using output_test\table2-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)

eststo clear
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: reg `var' rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
}
esttab using output_test\table2-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)
eststo clear
** IV 
foreach var in d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc{
eststo: ivregress 2sls `var' (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
}
** 
esttab using output_test\table2-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("1 child" "2 children" "3 children" "3+ children") keep(rsh)


********************************************************************************
** women with young child
********************************************************************************
** any educ
********************************************************************************
** OLS
eststo clear
eststo: reg d_sh_youngch rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
eststo: reg d_sh_youngch rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
eststo: reg d_sh_youngch rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
eststo: reg d_sh_youngch rsh $fixed_effects $c_demogr $c_demogr_4044 $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==4044, cluster(statefip)

esttab using output_test\table3-stbyyrfeff.tex, replace nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("$\textit{20-39$" "20-29" "30-39" "40-44") keep(rsh)
eststo clear

** 2SLS
eststo clear
eststo: ivregress 2sls d_sh_youngch (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_demogr_4044 $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==4044, cluster(statefip)

esttab using output_test\table3-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("$\textit{20-39$" "20-29" "30-39" "40-44") keep(rsh)
eststo clear

********************************************************************************
** coll
********************************************************************************
** OLS
eststo clear
eststo: reg d_sh_youngch_c rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
eststo: reg d_sh_youngch_c rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
eststo: reg d_sh_youngch_c rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
eststo: reg d_sh_youngch_c rsh $fixed_effects $c_demogr $c_demogr_4044 $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==4044, cluster(statefip)

esttab using output_test\table3-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("$\textit{20-39$" "20-29" "30-39" "40-44") keep(rsh)
eststo clear

** 2SLS
eststo clear
eststo: ivregress 2sls d_sh_youngch_c (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch_c (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch_c (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch_c (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_demogr_4044 $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==4044, cluster(statefip)

esttab using output_test\table3-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("$\textit{20-39$" "20-29" "30-39" "40-44") keep(rsh)
eststo clear

********************************************************************************
** non coll
********************************************************************************
** OLS
eststo clear
eststo: reg d_sh_youngch_nc rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
eststo: reg d_sh_youngch_nc rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
eststo: reg d_sh_youngch_nc rsh $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
eststo: reg d_sh_youngch_nc rsh $fixed_effects $c_demogr $c_demogr_4044 $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==4044, cluster(statefip)

esttab using output_test\table3-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("$\textit{20-39$" "20-29" "30-39" "40-44") keep(rsh)
eststo clear

** 2SLS
eststo clear
eststo: ivregress 2sls d_sh_youngch_nc (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2039, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch_nc (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==2029, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch_nc (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==3039, cluster(statefip)
eststo: ivregress 2sls d_sh_youngch_nc (rsh=inst1950_1980 inst1950_1990 inst1950_2000 inst1950_2010) $fixed_effects $c_demogr $c_demogr_4044 $c_labmarket $c_empl_ind $c_offsh [aw=pop_sh] if age==4044, cluster(statefip)

esttab using output_test\table3-stbyyrfeff.tex, append nolabel scalars(r2) noobs starlevels( * 0.10 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3)))  booktabs mtitles("$\textit{20-39$" "20-29" "30-39" "40-44") keep(rsh)
eststo clear
