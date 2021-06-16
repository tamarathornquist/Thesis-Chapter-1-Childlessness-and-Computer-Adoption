/*
*/

** In this do file I create RSH for years 1980, 1990, 2000, 2005, 2010, 2015, 2018

cd "C:\Users\..."
foreach year in 1980 1990 2000 {
use "temp\census`year'", clear
** merge dummy var that identifies occ1990dd in top rti lswt `year'
merge m:1 occ1990dd using temp\dummy_rti_top
replace rti_top=0 if _merge==1
*tab rti_top
*tab rti_top occ3 
*tab rti_top occ10
** calculate RSH by cz `year'
collapse (sum) hourslastyear [pw=perwt*afactor], by(czone rti_top)
reshape wide hourslastyear, i(czone) j(rti_top)
** gen employment share in high rti by czone `year'
gen rsh=hourslastyear1/(hourslastyear0+hourslastyear1)
keep czone rsh
*sum
gen year=`year'
save temp\ds_rsh_`year', replace 
}
** 

foreach year in 2005 2010 2015 {
use "temp\acs`year'", clear
** merge dummy var that identifies occ1990dd in top rti lswt `year'
merge m:1 occ1990dd using temp\dummy_rti_top
replace rti_top=0 if _merge==1
*tab rti_top
*tab rti_top occ3 
*tab rti_top occ10
** calculate RSH by cz `year'
collapse (sum) hourslastyear [pw=perwt*afactor], by(czone rti_top)
reshape wide hourslastyear, i(czone) j(rti_top)
** gen employment share in high rti by czone `year'
gen rsh=hourslastyear1/(hourslastyear0+hourslastyear1)
keep czone rsh
*sum
gen year=`year'
save temp\ds_rsh_`year', replace 
}
** 

** append 
use temp\ds_rsh_1980, clear
foreach year in 1990 2000 2005 2010 2015 {
append using temp\ds_rsh_`year'
}
** 
sum 
tab year
save temp\ds_rsh_1980_2015, replace























