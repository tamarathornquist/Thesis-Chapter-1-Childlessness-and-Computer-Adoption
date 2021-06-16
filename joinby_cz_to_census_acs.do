/*
2020-01-22
2020-01-27
2020-02-25
*/

** In this do file I joinby cz code to census 1950, 1960, 1980, 1990, 2000 and 
** acs 2005, 2010, 2015 and 2015. 
** cz code is from DD's abd Evan Roses data pages. 
cd "C:\Users\..."

********************************************************************************
** merge cz to census 1950 
********************************************************************************

** check the file 
use raw\cw_sea1950_czone, clear
sort sea1950
save, replace

use raw\census1950, clear
generate sea1950=sea 
sort sea1950
joinby sea1950 using raw\cw_sea1950_czone
save "temp_cz\census1950", replace


********************************************************************************
** merge cz to census 1960 
********************************************************************************
** check the files, comes from https://ekrose.github.io/resources
use raw\cz_puma1960_cw_direct.dta, clear 
sort  puma1960
egen cz_id=group(czone)
sum cz_id
save, replace

use raw\census1960, clear
gen puma1960=puma
sort puma1960
joinby puma1960 using raw\cz_puma1960_cw_direct.dta
save "temp_cz\census1960", replace

egen cz_id=group(czone)
sum cz_id
bysort cz_id: gen N=_N
sum N


********************************************************************************
** merge cz to census 1970 
********************************************************************************
** check the file 
use raw\cw_ctygrp1970_czone_corr.dta, clear
sum
sort cty_grp70
save, replace

use raw\census1970, clear
sum statefip cntygp97
gen cty_grp70=cntygp97
sort cty_grp70
joinby cty_grp70 using raw\cw_ctygrp1970_czone_corr.dta
save "temp_cz\census1970", replace


********************************************************************************
** merge cz to census 1980 +
********************************************************************************
** check the file 
use raw\cw_ctygrp1980_czone_corr.dta, clear
egen cz_id=group(czone)
sum cz_id
sum ctygrp1980
sort ctygrp1980
save, replace


use raw\census1980, clear
sum statefip cntygp98
sort cntygp98
** create var to merge with ctygrp1980 in Dorn's file raw\cw_ctygrp1980_czone_corr

** tostring vars
foreach var in statefip cntygp98 {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"
gen var00="00"

** put zeros so that statefip har 2 digits and cntygp98 has 3 digits
foreach var in statefip cntygp98 {
replace `var'_st=var00+`var'_st if `var'<10
replace `var'_st=var0+`var'_st if `var'<100 & `var'>9
}
** 
** gen var for merging 
egen ctygrp1980=concat(statefip_st cntygp98_st)
destring ctygrp1980, replace
sum ctygrp1980
sort ctygrp1980
joinby ctygrp1980 using raw\cw_ctygrp1980_czone_corr.dta
save "temp_cz\census1980", replace

** 741 cz
drop cz_id
egen cz_id=group(czone)
sum cz_id

bysort cz_id: gen N=_N
sum N


********************************************************************************
** merge cz to census 1990
********************************************************************************
** check the file 
use raw\cw_puma1990_czone.dta, clear
sort puma1990
save, replace

use raw\census1990, clear
sum statefip puma

** create gegraph codes for matchining. 
** tostring vars
foreach var in statefip puma {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"

** put zeros so that statefip har 2 digits and puma has 4 digits
foreach var in statefip  {
replace `var'_st=var0+`var'_st if `var'<10
}
** 
foreach var in puma {
replace `var'_st=var0+`var'_st if `var'<1000
}
** 
** gen var for merging 
egen puma1990=concat(statefip_st puma_st)
destring puma1990, replace
sum puma1990
sort puma1990
joinby puma1990 using raw\cw_puma1990_czone.dta
save "temp_cz\census1990", replace
** 741 cz
egen cz_id=group(czone)
sum cz_id

********************************************************************************
** merge cz to census 2000 
** same file cw_puma2000_czone for 2000 Census and
** 2005-2011 ACS Public Use Micro Areas to 1990 Commuting Zones
********************************************************************************
** check the file 
use raw\cw_puma2000_czone.dta, clear
sort puma2000
save, replace

use raw\census2000, clear
sum statefip puma

** create geogr codes for matchining. 
** tostring var
foreach var in statefip puma {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"

** put zeros so that statefip har 2 digits and puma has 4 digits
foreach var in statefip  {
replace `var'_st=var0+`var'_st if `var'<10
}
** 
foreach var in puma {
replace `var'_st=var0+`var'_st if `var'<1000
}
** 
** gen var for merging 
egen puma2000=concat(statefip_st puma_st)
destring puma2000, replace
sum puma2000
sort puma2000
joinby puma2000 using raw\cw_puma2000_czone.dta
save "temp_cz\census2000", replace
** 741 cz
egen cz_id=group(czone)
sum cz_id

bysort cz_id: gen N=_N
sum N

********************************************************************************
** merge cz to ACS 2005
** same file cw_puma2000_czone for 2000 Census and
** 2005-2011 ACS Public Use Micro Areas to 1990 Commuting Zones
********************************************************************************
** cross walk as above

use raw\acs2005, clear
sum statefip puma

foreach var in statefip puma {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"

** put zeros so that statefip har 2 digits and puma has 4 digits
foreach var in statefip  {
replace `var'_st=var0+`var'_st if `var'<10
}
** 
foreach var in puma {
replace `var'_st=var0+`var'_st if `var'<1000
}
** 
** gen var for merging 
egen puma2000=concat(statefip_st puma_st)
destring puma2000, replace
sum puma2000
sort puma2000
joinby puma2000 using raw\cw_puma2000_czone.dta
save "temp_cz\acs2005", replace
** 741 cz
egen cz_id=group(czone)
sum cz_id

********************************************************************************
** merge cz to ACS 2010 
** same file cw_puma2000_czone for 2000 Census and
** 2005-2011 ACS Public Use Micro Areas to 1990 Commuting Zones
********************************************************************************
** cross walk as above

use raw\acs2010, clear
*sum statefip puma
*tab statefip if puma==77777
** In the 2006-2011 ACS, persons living in Louisiana PUMAs 01801, 01802, and 01905 were all coded as living in Louisiana PUMA 77777. This is because these three PUMAs no longer had sufficient population to be included as separate entities due the effects of hurricane Katrina.
foreach var in statefip puma {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"

** put zeros so that statefip har 2 digits and puma has 4 digits
foreach var in statefip  {
replace `var'_st=var0+`var'_st if `var'<10
}
** 
foreach var in puma {
replace `var'_st=var0+`var'_st if `var'<1000
}
** 
** gen var for merging 
egen puma2000=concat(statefip_st puma_st)
destring puma2000, replace
sum puma2000
sort puma2000
joinby puma2000 using raw\cw_puma2000_czone.dta
*br if puma2000==2277777
save "temp_cz\acs2010", replace
** 741 cz
egen cz_id=group(czone)
sum cz_id
bysort cz_id: gen N=_N
sum N
********************************************************************************
** merge cz to ACS 2015
** same file cw_puma2000_czone for 2010 Census and 
** 2012-ongoing ACS Public Use Micro Areas to 1990 Commuting Zones
********************************************************************************
** check the file 
use raw\cw_puma2010_czone.dta, clear
sort puma2010
save, replace

use raw\acs2015, clear
sum statefip puma

foreach var in statefip puma {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"
gen var00="00"

** put zeros so that statefip har 2 digits and puma has 4 digits
foreach var in statefip  {
replace `var'_st=var0+`var'_st if `var'<10
}
** 
foreach var in puma {
replace `var'_st=var0+`var'_st if `var'>999 & `var'<10000
replace `var'_st=var00+`var'_st if `var'>99 & `var'<1000
}
** 
** gen var for merging 
egen puma2010=concat(statefip_st puma_st)
destring puma2010, replace
sum puma2010
sort puma2010
joinby puma2010 using raw\cw_puma2010_czone.dta
save "temp_cz\acs2015", replace
** 741 cz
egen cz_id=group(czone)
sum cz_id
bysort cz_id: gen N=_N
sum N
********************************************************************************
** merge cz to ACS 2018 
** same file cw_puma2000_czone for 2010 Census and 
** 2012-ongoing ACS Public Use Micro Areas to 1990 Commuting Zones
********************************************************************************
** cross walk same as above

use raw\acs2018, clear
sum statefip puma

foreach var in statefip puma {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"
gen var00="00"

** put zeros so that statefip har 2 digits and puma has 4 digits
foreach var in statefip  {
replace `var'_st=var0+`var'_st if `var'<10
}
** 
foreach var in puma {
replace `var'_st=var0+`var'_st if `var'>999 & `var'<10000
replace `var'_st=var00+`var'_st if `var'>99 & `var'<1000
}
** 
** gen var for merging 
egen puma2010=concat(statefip_st puma_st)
destring puma2010, replace
sum puma2010
sort puma2010
joinby puma2010 using raw\cw_puma2010_czone.dta
save "temp_cz\acs2018", replace
** 741 cz
egen cz_id=group(czone)
sum cz_id

bysort cz_id: gen N=_N
sum N

********************************************************************************
** merge cz to ACS 2017
** same file cw_puma2000_czone for 2010 Census and 
** 2012-ongoing ACS Public Use Micro Areas to 1990 Commuting Zones
********************************************************************************
** cross walk same as above

use raw\acs2017, clear
sum statefip puma

foreach var in statefip puma {
tostring(`var'), gen(`var'_st)
}
**
** gen zeros to put infront of the string vars
gen var0="0"
gen var00="00"

** put zeros so that statefip har 2 digits and puma has 4 digits
foreach var in statefip  {
replace `var'_st=var0+`var'_st if `var'<10
}
** 
foreach var in puma {
replace `var'_st=var0+`var'_st if `var'>999 & `var'<10000
replace `var'_st=var00+`var'_st if `var'>99 & `var'<1000
}
** 
** gen var for merging 
egen puma2010=concat(statefip_st puma_st)
destring puma2010, replace
sum puma2010
sort puma2010
joinby puma2010 using raw\cw_puma2010_czone.dta
save "temp_cz\acs2017", replace
** 741 cz
egen cz_id=group(czone)
sum cz_id

bysort cz_id: gen N=_N
sum N







