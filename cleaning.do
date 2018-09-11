********************************************
** BOILERPLATE & AUTOMATIC LOG GENERATION **
********************************************

capture log close
cd "C:\Users\delamb\data\nlsy97Subset02"
use nlsy97Depression.dta, clear

local cdt: display %td_CCYY_NN_DD date(c(current_date), "DMY")
local cdt = subinstr(trim("`cdt'"), " ", ".", .)
local cti = c(current_time)
local cti = subinstr("`cti'", ":", ".", .)
local logname = "log_"+"`cdt'"+"_"+"`cti'"+".txt"
cd logs
log using "`logname'", text
cd ..


********************************
** MENTAL HEALTH SCORE CODING **
********************************

* Recode depression/anxiety scales as 0=Lowest to 3=Highest
foreach var of varlist ysaq_282c_* ysaq_282e_* ysaq_282g_* {
    recode `var' (-5/-1 = .) (1 = 3) (3 = 1) (4 = 0)
    label values `var'
}

* Recode happiness/calmness scales as 0=Highest to 3=Lowest
foreach var of varlist ysaq_282d_* ysaq_282f_* {
    recode `var' (-5/-1 = .) (1 = 0) (2 = 1) (3 = 2) (4 = 3)
    label values `var'
}

* Sum all mental health scales. 0 = Lower depression/anxiety symptoms, 17 = Higher d/a symptoms
forvalues i = 2000(2)2008 {
    gen mhscore`i' = ysaq_282c_`i' + ysaq_282d_`i' + ysaq_282e_`i' + ysaq_282f_`i' + ysaq_282g_`i'
}
