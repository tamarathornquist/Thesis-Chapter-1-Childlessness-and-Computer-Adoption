/*
*/
 
** This is a master file for chapter 1 childlessness. Cleaning, prerearing data, 
** constructing all vars, regressions, descriptives, tests. 

cd "C:\Users\..."

********************************************************************************
** Assigning czone identifiers, cleaning
********************************************************************************

** this do file joinby zs codes to census 1950, 1960, 1980, 1990, 2000 and 
** acs 2005, 2010, 2015 and 2018. It saves data samples with attached czone in
** the forlder temp_cz\. No data cleaing etc is made in these do files.
** It uses raw samples from folder raw\.
 do "do\joinby_cz_to_census_acs.do" 

********************************************************************************
** Cleaning, preparing
********************************************************************************

** This do file prepares temp_cz\census1950 raw file prepares for further analysis. 
** It attaches consistent occ and industry codes, creates hours worked.
** This do file saves the cleaned and prepared data set in temp\census1950. 
do "do\prepare_census1950.do"

** This do file prepares temp_cz\census1980 raw file for further analysis.
** See more details in decsription of "do\prepare_census1950" above.  
** analogous do files for census 1990 and 2000. 
do "do\prepare_census1980.do"

** This do file prepares temp_cz\acs2005 raw file prepares for further analysis.
** See more details in decsription of "do\prepare_census1950" above.  
** analogous do file for acs 2010, 2015, 2018. 
do "do\prepare_acs2005.do"

********************************************************************************
** Constructing instrument, independent vars
********************************************************************************

** In this do file I contruct a dummy var that identfifies a set of occs that are in the top 
** employment weighted third of routine task-intensity in 1980. This dummy is
** further used to create empl shares in routine intensive occ by czone and year, RSH. 
** This do file is saved in do_indep_var_inst\.
** This do file uses the data set temp_cz\census1980. All constructed vars are
** saved in the folder temp\.
do "do_indep_var_inst\create-dummy-top-rti-occ-1980.do"

** In this do file I contruct RSH for years 1980, 1990, 2000, 2005, 2010, 2015.
** I use a dummy var that identfifies a set of occs that are in the top 
** employment weighted third of routine task-intensity in 1980 created by 
** "do\create-dummy-top-rti-occ-1980" and prepared census and acs samples.
** This do file is saved in do_indep_var_inst\. All constructed vars are
** saved in the folder temp\ 
do "do_indep_var_inst\create-var-rsh.do"

** this do file creates an instrument for share employed in occupations with high 
** routine content by czone 1950.
do "do_indep_var_inst\create-instrument-1950-for-rsh"

********************************************************************************
** Constructing outcome vars.
********************************************************************************
** In these do files I contruct outcome vars in levels and decade differences
** by age group (2039, 2029, 3039), 
** czone, for years 1980, 1990, 2000, 2010, 2018. 
** Outcome vars are saved in the forlder temp_outcomes\. 
** Construct shares of women with at least one child 
do "do_outcomes\create-shares-women-with-atleastonech-czone.do"
** Construct shares of women with at least two children 
do "do_outcomes\create-shares-women-with-atleastwtoch-czone.do"
** Construct shares of women with at least three children
do "do_outcomes\create-shares-women-with-atleastthreech-czone.do"
** Construct shares of women with at least three plus children
do "do_outcomes\create-shares-women-with-atleastthreeplch-czone.do"

** In these do files I contruct outcome vars in levels and decade differences
** by age group (2039, 2029, 3039, 4044), 
** czone, for years 1980, 1990, 2000, 2010, 2018.
** Outcome vars are saved in the forlder temp_outcomes\. 
** Construct shares of women with a child under 5 child 
do "do_outcomes\create-shares-women-with-a-young-ch-czone.do"


********************************************************************************
** Constructing controls vars.
********************************************************************************
** In these do files I contruct controls vars in levels by czone, 
** for years 1980, 1990, 2000, 2010. These do files are saved in the folder 
** docontrols\ and use data sampels from
** the folders temp\ and temp_cz\. Outcome vars are saved in temp_controls\.

** create pop share, demographic controls, share in labor force and unempl rate by
** age group and college, mean education years and share with coll degree by
** gender and age group. 
do "do_controls\create-controls-czone.do" 

** create share employed bt three sectors and employment offshoring index by 
** gender and college degree. 
do "do_controls\create-controls-sh-empl-sectors-offsh-czone.do"


********************************************************************************
** Assembling
********************************************************************************
** This do file assembles independent vars, instruments, outcome vars and all controls. 
** This do file also contruct intercation terms, year and state fixed effects.
** This do file is saved in the folder do_assemble_dataset\. Assembled data set 
** is saved in the folder data\ds-shares-women-with-children.dta. 
do "do_assemble_dataset\assemble-shares-women-with-ch.do"

********************************************************************************
** Decsriptives
********************************************************************************
** This do file creates discriptive statistics for decade changes in and levels  
** off outcome vars by decade, age group and coll. Output is saved in the folder
** output_test\. 
do "do\do_descr_outcome_vars.do"
** create decriprives for control vars (levels) by year. Output is saved in the folder
** output_test\. 
do "do\do_descr_control_vars.do"


********************************************************************************
** Regress
********************************************************************************

** This do file runs regressions. All regression models include
** state feff, year feff and state by year fixed effects and a set of control 
** variables. Output is saved in the folder output_test\. 
do "do_regress\regress-main-analysis-all-feff.do"

** This do file runs robustness check regressions. All regression models include
** state feff, year feff and state by year fixed effects and a set of control 
** variables. Output is saved in the folder output_test\. 
do "do_regress\rob-check-all-feff.do"


