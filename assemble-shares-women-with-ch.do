/*
*/

** Assemble data set
cd "C:\Users\..."


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
drop if _merge!=3
drop _merge

append using "temp_outcomes\dsh_women_a40_44_youngch"


********************************************************************************
** idep vars
********************************************************************************
merge m:1 czone year using temp\ds_rsh_1980_2015
drop if _merge!=3
drop _merge
label var rsh "share empl in routine intesive occ"
********************************************************************************
** merge ins
********************************************************************************
merge m:1 czone using "temp\inst1950"
tab year if _merge==1
tab czone if _merge==1
br if _merge==2
drop if _merge!=3
drop _merge


merge m:1 czone using "temp\inst1950_alternative"
tab year if _merge==2
tab czone if _merge==1
br if _merge==2
drop if _merge!=3
drop _merge
********************************************************************************
** merge ins from AD(13)
******************************************************************************
merge m:1 czone using temp\instAD
drop _merge
label var instAD "inst copied from AD(13) dataset"
********************************************************************************
** merge statefip
********************************************************************************
merge m:1 czone using raw\cw_czone_state
tab statefip if _merge==2 /* statefip 2 and 15 not present*/
drop if _merge!=3
drop _merge


********************************************************************************
** merge pop shares
********************************************************************************
merge m:1 czone year using "temp_controls\pop_share_1980_2015"
drop if _merge!=3
drop _merge

********************************************************************************
** merge controls
********************************************************************************
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


********************************************************************************
** construct other vars
********************************************************************************
xi i.statefip

foreach year in 1980 1990 2000 2005 2010 2015 {
gen inst1950_`year'=0
replace inst1950_`year'=inst1950 if year==`year'
}
** 
foreach year in 1980 1990 2000 2005 2010 2015 {
gen inst1950_alter_`year'=0
replace inst1950_alter_`year'=inst1950_alter if year==`year'
}
** 

foreach year in 1980 1990 2000 2005 2010 2015 {
gen instAD_`year'=0
replace instAD_`year'=instAD if year==`year'
}
** 
sum inst*

foreach year in 1980 1990 2000 2005 2010 2015 {
gen d_`year'=0
replace d_`year'=1 if year==`year'
}
**
label var age "women age group"
save "data\ds-shares-women-with-children", replace


use "data\ds-shares-women-with-children", clear
********************************************************************************
** merge outcomes by occ group
********************************************************************************
merge 1:1 czone year age using "temp_outcomes\dsh_women_occ_gr_atleastonech"
drop _merge

merge 1:1 czone year age using "temp_outcomes\dsh_women_occ_gr_atleasttwoch"
drop _merge

merge 1:1 czone year age using "temp_outcomes\dsh_women_occ_gr_atleastthreech"
drop _merge

merge 1:1 czone year age using "temp_outcomes\dsh_women_occ_gr_threeplch"
drop _merge

save, replace

use "data\ds-shares-women-with-children", clear
********************************************************************************
** merge alternatives to RSH
********************************************************************************
merge m:1 czone year using "temp\mrti_1980_2010"
drop _merge

merge m:1 czone year using "temp\ds_rsh_det_1980_2010"
drop _merge

merge m:1 czone year using "temp\ds_rsh_abs_1980_2010"
drop _merge

save, replace


