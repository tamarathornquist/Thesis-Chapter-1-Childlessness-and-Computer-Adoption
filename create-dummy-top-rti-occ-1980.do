/*

*/

** In this do file I create a dummy var that identfifies a set of occs that are in the top 
** employment weighted third of routine task-intensity in 1980. This dummy is
** further used to create empl shares in routine intensive occ by czone and year, RSH. 

cd "C:\Users\..."
use "temp\census1980", clear
** merge rti index
merge m:1 occ1990dd using temp\occ1990dd_task_alm
drop if _merge!=3
drop _merge
** create 99 quantiles 
xtile p99 = rti_ind [pw=lswt], nq(99)
keep p99 rti_ind occ1990dd
sum 
tab p99
** keep only unique obs
bysort occ1990dd: gen n=_n
keep if n==1
sum
drop rti_ind n
** rename 
rename p99 rti_top
label var rti_top "1, occs in top routine empl 1980"
** set rti_top to 1 if occ1990dd belongs to top third 
replace rti_top=0 if rti_top<67
replace rti_top=1 if rti_top>66
tab rti_top
save temp\dummy_rti_top, replace



















