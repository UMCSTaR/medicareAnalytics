
<!-- README.md is generated from README.Rmd. Please edit that file -->

# medicareAnalytics

<!-- badges: start -->
<!-- badges: end -->

The goal of medicareAnalytics is to simplify the data processing and
modeling for medicare research projects. This project is based on the
medicare analytic file data structures, and used a lot variable names
specifically only for the medicare analytic file.

Since most of the medicare projects are using the same cohort filters
and models, this package can help the analysts and reseach fellows to
conduct analyses.

## Installation

You can install the development version of medicareAnalytics from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UMCSTaR/medicareAnalytics")
```

## Example

This is a basic example which shows you how to solve a common problem:

## Create multi-procedure frequency table

``` r
library(medicareAnalytics)
library(tidyverse)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
#> ✓ tibble  3.1.2     ✓ dplyr   1.0.6
#> ✓ tidyr   1.1.3     ✓ stringr 1.4.0
#> ✓ readr   1.4.0     ✓ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
## basic example code

# load medicare dt
medicare = data.table::fread("/Volumes/George_Surgeon_Projects/standardized_medicare_data_using_R/analysis_ready_data/ecs_primary_surgeon_medicare2018.csv", nrows = 5000)


multiple_procedures_table(medicare, project_sepcific_procedure_tax = "e_proc_grp_lbl")
#> # A tibble: 817 x 2
#>    proc_combo                                                   n_hosp_admission
#>    <chr>                                                                   <int>
#>  1 Ventral hernia repair (open), Ventral Hernia Repair W/Mesh                 27
#>  2 Angiogram, abdomen/pelvis/lower extremity artery, Angiograp…               25
#>  3 Partial colectomy with anastomosis (open), Splenic flexure …               12
#>  4 Transluminal balloon angioplasty, venous (percutaneous), An…               11
#>  5 Angiogram, abdomen/pelvis/lower extremity artery, Angiograp…               10
#>  6 Angiogram, ateriovenous shunt for dialysis, Transluminal ba…                9
#>  7 Angiogram, abdomen/pelvis/lower extremity artery, Translumi…                8
#>  8 Incarcerated/strangulated Ventral hernia repair (open), Ven…                8
#>  9 Infrarenal abdominal aortic aneurysm/dissection repair (end…                8
#> 10 Angiogram, abdomen/pelvis/lower extremity artery, Angiograp…                7
#> # … with 807 more rows
```

## Only keep US medschool graduates

``` r
# load medicare dt
medicare = data.table::fread("/Volumes/George_Surgeon_Projects/standardized_medicare_data_using_R/analysis_ready_data/ecs_primary_surgeon_medicare2018.csv", nrows = 5000)


remove_nonUS_trained(medicare) %>% glimpse()
#> Rows: 3,604
#> Columns: 48
#> $ id                           <int> 1, 5, 6, 7, 8, 13, 14, 15, 16, 25, 26, 27…
#> $ id_physician_npi             <int> 1932180528, 1548310543, 1548310543, 15483…
#> $ val_yr_practice              <int> 15, 7, 7, 7, 18, 5, 5, 5, 5, 33, 33, 10, …
#> $ val_day_practice             <int> 5186, 2311, 2311, 2311, 6269, 1529, 1529,…
#> $ flg_assistant_surgeon        <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_multi_surgeon            <int> 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_two_surgeon              <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_surgical_team            <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ us_medschool                 <chr> "USMG", "USMG", "USMG", "USMG", "USMG", "…
#> $ dt_gs_comp                   <date> 1993-06-30, 2001-06-30, 2001-06-30, 2001…
#> $ fellowship_abs               <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, T…
#> $ flg_male                     <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,…
#> $ e_race_wbho                  <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1, 1,…
#> $ age_at_admit                 <int> 74, 80, 80, 80, 79, 70, 70, 70, 70, 88, 8…
#> $ e_ses_5grp                   <int> NA, NA, NA, NA, NA, 5, 5, 5, 5, 5, 5, 5, …
#> $ member_id                    <chr> "GGGGGGGkkFuVGTT", "GGGGGGGkkqTuVqB", "GG…
#> $ AHRQ_score                   <int> 10, 20, 20, 20, 8, 2, 2, 3, 3, 10, 10, 6,…
#> $ e_proc_grp                   <int> 153, 689, 167, 34, 553, 507, 515, 454, 74…
#> $ e_proc_grp_lbl               <chr> "Partial colectomy with anastomosis (lapa…
#> $ facility_clm_yr              <int> 2007, 2007, 2007, 2007, 2007, 2007, 2007,…
#> $ flg_multi_cpt                <int> 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1,…
#> $ cpt_cd                       <int> 44204, 44139, 44144, 49255, 36830, 35355,…
#> $ cpt_mod                      <chr> "", "", "", "", "79, ", "GC, 51", "GC, 51…
#> $ e_admit_type                 <chr> "3_Elective", "1_Emergency", "1_Emergency…
#> $ dt_facclm_adm                <date> 2007-09-11, 2007-10-28, 2007-10-28, 2007…
#> $ dt_facclm_dschg              <date> 2007-09-16, 2007-11-15, 2007-11-15, 2007…
#> $ dt_profsvc_start             <date> 2007-09-11, 2007-10-28, 2007-10-28, 2007…
#> $ dt_profsvc_end               <date> 2007-09-11, 2007-10-28, 2007-10-28, 2007…
#> $ flg_cmp_po_severe_not_poa    <chr> "N/A (no var)", "N/A (no var)", "N/A (no …
#> $ flg_cmp_po_severe            <int> 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_death_30d                <int> 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_readmit_30d              <int> 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1,…
#> $ flg_cmp_po_any               <int> 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_cmp_po_any_not_poa       <chr> "N/A (no var)", "N/A (no var)", "N/A (no …
#> $ val_los                      <int> 5, 18, 18, 18, 4, 4, 4, 1, 1, 3, 3, 5, 13…
#> $ flg_util_reop                <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_hosp_ICU_hosp            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ flg_hosp_urban               <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
#> $ flg_hosp_urban_cbsa          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ facility_prvnumgrp           <int> 330273, 160028, 160028, 160028, 280060, 3…
#> $ flg_hosp_teach_combined      <int> 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ val_hosp_mcday2inptday_ratio <dbl> 0.04, 0.10, 0.10, 0.10, 0.13, 0.34, 0.34,…
#> $ e_hosp_beds_4grp             <int> 1, 1, 1, 1, 2, 4, 4, 4, 4, 3, 3, 3, 4, 4,…
#> $ val_hosp_rn2bed_ratio        <dbl> 1.84, 1.52, 1.52, 1.52, 1.99, 1.97, 1.97,…
#> $ val_hosp_rn2inptday_ratio    <dbl> 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01,…
#> $ surgeon_volume               <int> 268, 205, 205, 205, 1611, 992, 992, 992, …
#> $ medicare_gs_suregon          <int> 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ had_assist_surg              <int> 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
```

## apply all filters

``` r
medicare %>% apply_all_filters(add_variables = "val_yr_practice")
#>        id id_physician_npi val_yr_practice val_day_practice
#>   1:   43       1306833231              26             9298
#>   2:   93       1609811231              19             6742
#>   3:  124       1346222304              16             5642
#>   4:  148       1457333569              17             5895
#>   5:  187       1700868163              12             4188
#>  ---                                                       
#> 387: 8180       1518069434              20             7067
#> 388: 8185       1962448506               3              873
#> 389: 8248       1962448506               3              873
#> 390: 8268       1447334966              18             6341
#> 391: 8298       1629059670              11             3763
#>      flg_assistant_surgeon flg_multi_surgeon flg_two_surgeon flg_surgical_team
#>   1:                     0                 0               0                 0
#>   2:                     0                 0               0                 0
#>   3:                     0                 0               0                 0
#>   4:                     0                 0               0                 0
#>   5:                     0                 0               0                 0
#>  ---                                                                          
#> 387:                     0                 1               0                 0
#> 388:                     0                 1               0                 0
#> 389:                     0                 1               0                 0
#> 390:                     0                 0               0                 0
#> 391:                     0                 1               0                 0
#>      us_medschool dt_gs_comp fellowship_abs flg_male e_race_wbho age_at_admit
#>   1:         USMG 1982-06-30          FALSE        0           1           77
#>   2:         USMG 1989-06-30          FALSE        1           4           76
#>   3:         USMG 1992-06-30          FALSE        1           4           68
#>   4:         USMG 1991-06-30          FALSE        0           3           80
#>   5:         USMG 1996-06-30          FALSE        0           1           83
#>  ---                                                                         
#> 387:         USMG 1988-06-30          FALSE        0           1           79
#> 388:         USMG 2005-06-30          FALSE        0           1           80
#> 389:         USMG 2005-06-30          FALSE        0           1           93
#> 390:         USMG 1990-06-30          FALSE        1           1           74
#> 391:         USMG 1997-06-30          FALSE        1           1           82
#>      e_ses_5grp       member_id AHRQ_score e_proc_grp
#>   1:          5 GGGGGGGGzoFFBuG          2        195
#>   2:          3 GGGGGGGGkTFoBoo         12        195
#>   3:          3 GGGGGGGGqkqVoTk         18        223
#>   4:          3 GGGGGGGGuVBVqkB         18        249
#>   5:          3 GGGGGGGkBGTkzkq          2          1
#>  ---                                                 
#> 387:          5 GGGGGGGGqFVBquu          7        255
#> 388:          5 GGGGGGGGqVuGoVq         23        236
#> 389:          5 GGGGGGGGzqouzVq         13        173
#> 390:          5 GGGGGGGGTBqTzuu         20         81
#> 391:          5 GGGGGGGGVFGGoVz          9          3
#>                                    e_proc_grp_lbl facility_clm_yr flg_multi_cpt
#>   1:                    Lysis of adhesions (open)            2007             0
#>   2:                    Lysis of adhesions (open)            2007             0
#>   3: Gastrectomy, partial, with gastrojejunostomy            2007             0
#>   4:                  Modified radical mastectomy            2007             0
#>   5:               Cholecystectomy (laparoscopic)            2007             0
#>  ---                                                                           
#> 387:                           Mastectomy, simple            2007             0
#> 388:          Gastrojejunostomy; without vagotomy            2007             0
#> 389:  Partial colectomy with ileocolostomy (open)            2007             0
#> 390:                                      Whipple            2007             0
#> 391:                       Cholecystectomy (open)            2007             0
#>      cpt_cd  cpt_mod e_admit_type dt_facclm_adm dt_facclm_dschg
#>   1:  44005           1_Emergency    2007-12-13      2007-12-22
#>   2:  44005           1_Emergency    2007-12-13      2007-12-20
#>   3:  43632           1_Emergency    2007-12-08      2007-12-19
#>   4:  19307            3_Elective    2007-08-20      2007-08-23
#>   5:  47562           1_Emergency    2007-12-13      2007-12-21
#>  ---                                                           
#> 387:  19303 RT, 79,      2_Urgent    2007-11-05      2007-11-07
#> 388:  43820           1_Emergency    2007-11-12      2007-11-28
#> 389:  44160              2_Urgent    2007-11-15      2007-11-26
#> 390:  48150     AQ,    3_Elective    2007-11-09      2007-11-27
#> 391:  47600           1_Emergency    2007-10-16      2007-11-21
#>      dt_profsvc_start dt_profsvc_end flg_cmp_po_severe_not_poa
#>   1:       2007-12-14     2007-12-14              N/A (no var)
#>   2:       2007-12-15     2007-12-15              N/A (no var)
#>   3:       2007-12-11     2007-12-11              N/A (no var)
#>   4:       2007-08-20     2007-08-20              N/A (no var)
#>   5:       2007-12-18     2007-12-18              N/A (no var)
#>  ---                                                          
#> 387:       2007-11-05     2007-11-05              N/A (no var)
#> 388:       2007-11-20     2007-11-20              N/A (no var)
#> 389:       2007-11-20     2007-11-20              N/A (no var)
#> 390:       2007-11-09     2007-11-09              N/A (no var)
#> 391:       2007-10-19     2007-10-19              N/A (no var)
#>      flg_cmp_po_severe flg_death_30d flg_readmit_30d flg_cmp_po_any
#>   1:                 0             0               0              0
#>   2:                 0             0               0              0
#>   3:                 0             0               0              1
#>   4:                 0             0               1              0
#>   5:                 0             0               1              0
#>  ---                                                               
#> 387:                 0             0               0              0
#> 388:                 0             0               0              0
#> 389:                 0             0               0              0
#> 390:                 0             0               0              0
#> 391:                 0             0               0              0
#>      flg_cmp_po_any_not_poa val_los flg_util_reop flg_hosp_ICU_hosp
#>   1:           N/A (no var)       9             0                 1
#>   2:           N/A (no var)       7             0                 1
#>   3:           N/A (no var)      11             0                 1
#>   4:           N/A (no var)       3             0                 1
#>   5:           N/A (no var)       8             0                 1
#>  ---                                                               
#> 387:           N/A (no var)       2             0                 1
#> 388:           N/A (no var)      16             0                 1
#> 389:           N/A (no var)      11             0                 1
#> 390:           N/A (no var)      18             0                 1
#> 391:           N/A (no var)      36             0                 1
#>      flg_hosp_urban flg_hosp_urban_cbsa facility_prvnumgrp
#>   1:             NA                   1             330214
#>   2:             NA                   1             330064
#>   3:             NA                   1             330169
#>   4:             NA                   1             330169
#>   5:             NA                   1             330169
#>  ---                                                      
#> 387:             NA                   1             330261
#> 388:             NA                   1             330261
#> 389:             NA                   1             330261
#> 390:             NA                   1             330101
#> 391:             NA                   1             330162
#>      flg_hosp_teach_combined val_hosp_mcday2inptday_ratio e_hosp_beds_4grp
#>   1:                       1                         0.10                4
#>   2:                       1                         0.46                1
#>   3:                       1                         0.34                4
#>   4:                       1                         0.34                4
#>   5:                       1                         0.34                4
#>  ---                                                                      
#> 387:                       0                         0.25                2
#> 388:                       0                         0.25                2
#> 389:                       0                         0.25                2
#> 390:                       1                         0.34                4
#> 391:                       0                         0.10                1
#>      val_hosp_rn2bed_ratio val_hosp_rn2inptday_ratio surgeon_volume
#>   1:                  1.57                      0.01            339
#>   2:                  1.14                      0.01            226
#>   3:                  1.27                      0.01            160
#>   4:                  1.27                      0.01            104
#>   5:                  1.27                      0.01            548
#>  ---                                                               
#> 387:                  0.92                      0.00            410
#> 388:                  0.92                      0.00            662
#> 389:                  0.92                      0.00            662
#> 390:                  1.97                      0.01           1143
#> 391:                  1.84                      0.01            680
#>      medicare_gs_suregon had_assist_surg n_cpt_admission
#>   1:                   1               0               1
#>   2:                   1               0               1
#>   3:                   1               0               1
#>   4:                   1               0               1
#>   5:                   1               0               1
#>  ---                                                    
#> 387:                   1               1               1
#> 388:                   1               1               1
#> 389:                   1               1               1
#> 390:                   1               0               1
#> 391:                   1               1               1
```
