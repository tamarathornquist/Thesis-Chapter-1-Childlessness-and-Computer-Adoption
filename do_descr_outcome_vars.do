/*
*/

** Assemble data set and construct descriptives
cd "C:\Users\..."



********************************************************************************
** DESCRIPTIVES FOR DECADE CHANGES
********************************************************************************
********************************************************************************
** merge outcomes
********************************************************************************
use "temp_outcomes\dsh_women_atleastonech", clear
merge 1:1 czone year age using "temp_outcomes\dsh_women_atleasttwoch"
drop if _merge!=3
drop _merge

merge 1:1 czone year age using "temp_outcomes\dsh_women_atleastthreech"
drop if _merge!=3
drop _merge

merge 1:1 czone year age using "temp_outcomes\dsh_women_threeplch"
drop if _merge!=3
drop _merge

merge 1:1 czone year age using "temp_outcomes\dsh_women_youngch"
drop _merge

********************************************************************************
** merge pop shares
********************************************************************************
merge m:1 czone year using "temp_controls\pop_share_1980_2015"
drop if _merge!=3
drop _merge

drop if year==2005 
drop if year==2015

save "temp_controls\outcomes", replace

********************************************************************************
** descriptives outcomes wrighted by pop share  
********************************************************************************
use "temp_controls\outcomes", clear
** any educ
** 2039
set more off
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech d_sh_atleasttwoch d_sh_atleastthreech d_sh_threeplch d_sh_youngch if age==2039 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar replace
** 2029
set more off
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech d_sh_atleasttwoch d_sh_atleastthreech d_sh_threeplch d_sh_youngch if age==2029 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 3039
set more off
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech d_sh_atleasttwoch d_sh_atleastthreech d_sh_threeplch d_sh_youngch if age==3039 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 4044
set more off
eststo clear
bysort year: eststo: estpost summarize d_sh_youngch if age==4044 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append

** college
** 2039
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c d_sh_youngch_c if age==2039 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 2029
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c d_sh_youngch_c if age==2029 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 3039
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech_c d_sh_atleasttwoch_c d_sh_atleastthreech_c d_sh_threeplch_c d_sh_youngch_c if age==3039 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 4044
eststo clear
bysort year: eststo: estpost summarize d_sh_youngch_c if age==4044 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** non-college
** 2039
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc d_sh_youngch_nc if age==2039 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 2029
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc d_sh_youngch_nc if age==2029 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 3039
eststo clear
bysort year: eststo: estpost summarize d_sh_atleastonech_nc d_sh_atleasttwoch_nc d_sh_atleastthreech_nc d_sh_threeplch_nc d_sh_youngch_nc if age==3039 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append
** 4044
eststo clear
bysort year: eststo: estpost summarize d_sh_youngch_nc if age==4044 [aw=pop_sh], listwise
esttab est1 est2 est3 est4 using "output-test\descr_dec_ch_outcomes.tex", cell("mean (fmt(3)) sd (fmt(3))") noobs nogap nonumber nodepvar append


********************************************************************************
** DESCRIPTIVES FOR LEVELS
********************************************************************************
********************************************************************************
** Assemble data set and construct descriptives
cd "C:\Users\..."

********************************************************************************
** merge outcomes
********************************************************************************
use "temp_outcomes\sh_women_atleastonech", clear
merge 1:1 czone year age using "temp_outcomes\sh_women_atleasttwoch"
drop if _merge!=3
drop _merge

merge 1:1 czone year age using "temp_outcomes\sh_women_atleastthreech"
drop if _merge!=3
drop _merge

merge 1:1 czone year age using "temp_outcomes\sh_women_threeplch"
drop if _merge!=3
drop _merge

merge 1:1 czone year age using "temp_outcomes\sh_women_youngch"
drop _merge

********************************************************************************
** merge pop shares
********************************************************************************
merge m:1 czone year using "temp_controls\pop_share_1980_2015"
drop _merge

keep if year==1980 | year==2018

save "temp_controls\outcomes1980_2018", replace

use "temp_controls\outcomes1980_2018", clear

** any educ by age group
set more off
eststo clear
bysort year: eststo: estpost summarize sh_atleastonech sh_atleasttwoch sh_atleastthreech sh_threeplch sh_youngch if age==2039 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar replace

eststo clear
bysort year: eststo: estpost summarize sh_atleastonech sh_atleasttwoch sh_atleastthreech sh_threeplch sh_youngch if age==2029 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_atleastonech sh_atleasttwoch sh_atleastthreech sh_threeplch sh_youngch if age==3039 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_youngch if age==4044 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

** coll by age group 
set more off
eststo clear
bysort year: eststo: estpost summarize sh_atleastonech_c sh_atleasttwoch_c sh_atleastthreech_c sh_threeplch_c sh_youngch_c if age==2039 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_atleastonech_c sh_atleasttwoch_c sh_atleastthreech_c sh_threeplch_c sh_youngch_c if age==2029 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_atleastonech_c sh_atleasttwoch_c sh_atleastthreech_c sh_threeplch_c sh_youngch_c if age==3039 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_youngch_c if age==4044 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

** non coll by age group 
set more off
eststo clear
bysort year: eststo: estpost summarize sh_atleastonech_nc sh_atleasttwoch_nc sh_atleastthreech_nc sh_threeplch_nc sh_youngch_nc if age==2039 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_atleastonech_nc sh_atleasttwoch_nc sh_atleastthreech_nc sh_threeplch_nc sh_youngch_nc if age==2029 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_atleastonech_nc sh_atleasttwoch_nc sh_atleastthreech_nc sh_threeplch_nc sh_youngch_nc if age==3039 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append

eststo clear
bysort year: eststo: estpost summarize sh_youngch_nc if age==4044 [aw=pop_sh], listwise
esttab est1 est2 using "output_test\descr_levels_outcomes.tex", cell("mean (fmt(2)) sd (fmt(2))") noobs nogap nonumber nodepvar append











