
<!-- README.md is generated from README.Rmd. Please update that file using devtools::build_readme()-->

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

### Create multi-procedure frequency table

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


remove_nonUS_trained(medicare) %>% 
  select(-contains("id"), -contains("dt")) %>%  # remove sensitive data
  head()
#>    val_yr_practice val_day_practice flg_assistant_surgeon flg_multi_surgeon
#> 1:              15             5186                     0                 1
#> 2:               7             2311                     0                 0
#> 3:               7             2311                     0                 0
#> 4:               7             2311                     0                 0
#> 5:              18             6269                     0                 0
#> 6:               5             1529                     0                 0
#>    flg_two_surgeon flg_surgical_team us_medschool fellowship_abs flg_male
#> 1:               0                 0         USMG          FALSE        0
#> 2:               0                 0         USMG          FALSE        0
#> 3:               0                 0         USMG          FALSE        0
#> 4:               0                 0         USMG          FALSE        0
#> 5:               0                 0         USMG           TRUE        0
#> 6:               0                 0         USMG           TRUE        0
#>    e_race_wbho age_at_admit e_ses_5grp AHRQ_score e_proc_grp
#> 1:           1           74         NA         10        153
#> 2:           1           80         NA         20        689
#> 3:           1           80         NA         20        167
#> 4:           1           80         NA         20         34
#> 5:           1           79         NA          8        553
#> 6:           1           70          5          2        507
#>                                                   e_proc_grp_lbl
#> 1:             Partial colectomy with anastomosis (laparoscopic)
#> 2:   Splenic flexure takedown (in addition to primary procedure)
#> 3:          Partial colectomy with cecostomy or colostomy (open)
#> 4:                                             Omental resection
#> 5:                             Creation of arteriovenous fistula
#> 6: Aorta/iliac artery/femoral artery thrombectomy/endarterectomy
#>    facility_clm_yr flg_multi_cpt cpt_cd cpt_mod e_admit_type
#> 1:            2007             0  44204           3_Elective
#> 2:            2007             1  44139          1_Emergency
#> 3:            2007             1  44144          1_Emergency
#> 4:            2007             1  49255          1_Emergency
#> 5:            2007             0  36830    79,    3_Elective
#> 6:            2007             1  35355  GC, 51   3_Elective
#>    flg_cmp_po_severe_not_poa flg_cmp_po_severe flg_death_30d flg_readmit_30d
#> 1:              N/A (no var)                 0             0               0
#> 2:              N/A (no var)                 1             1               0
#> 3:              N/A (no var)                 0             1               0
#> 4:              N/A (no var)                 1             1               0
#> 5:              N/A (no var)                 0             0               1
#> 6:              N/A (no var)                 0             0               0
#>    flg_cmp_po_any flg_cmp_po_any_not_poa val_los flg_util_reop
#> 1:              0           N/A (no var)       5             0
#> 2:              1           N/A (no var)      18             0
#> 3:              1           N/A (no var)      18             0
#> 4:              1           N/A (no var)      18             0
#> 5:              1           N/A (no var)       4             0
#> 6:              0           N/A (no var)       4             0
#>    flg_hosp_ICU_hosp flg_hosp_urban flg_hosp_urban_cbsa facility_prvnumgrp
#> 1:                 1             NA                   1             330273
#> 2:                 1             NA                   1             160028
#> 3:                 1             NA                   1             160028
#> 4:                 1             NA                   1             160028
#> 5:                 1             NA                   1             280060
#> 6:                 1             NA                   1             330101
#>    flg_hosp_teach_combined val_hosp_mcday2inptday_ratio e_hosp_beds_4grp
#> 1:                       0                         0.04                1
#> 2:                       0                         0.10                1
#> 3:                       0                         0.10                1
#> 4:                       0                         0.10                1
#> 5:                       1                         0.13                2
#> 6:                       1                         0.34                4
#>    val_hosp_rn2bed_ratio val_hosp_rn2inptday_ratio surgeon_volume
#> 1:                  1.84                      0.01            268
#> 2:                  1.52                      0.01            205
#> 3:                  1.52                      0.01            205
#> 4:                  1.52                      0.01            205
#> 5:                  1.99                      0.01           1611
#> 6:                  1.97                      0.01            992
#>    medicare_gs_suregon had_assist_surg
#> 1:                   1               1
#> 2:                   0               0
#> 3:                   0               0
#> 4:                   0               0
#> 5:                   0               0
#> 6:                   0               0
```

### apply all filters

``` r
medicare %>% 
  apply_all_filters(add_variables = "val_yr_practice") %>%
  select(-contains("id"), -contains("dt")) %>%  # remove sensitive data
  glimpse()
#> Rows: 391
#> Columns: 41
#> $ val_yr_practice              <int> 26, 19, 16, 17, 12, 5, 11, 16, 26, 15, 31…
#> $ val_day_practice             <int> 9298, 6742, 5642, 5895, 4188, 1536, 3678,…
#> $ flg_assistant_surgeon        <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_multi_surgeon            <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_two_surgeon              <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_surgical_team            <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ us_medschool                 <chr> "USMG", "USMG", "USMG", "USMG", "USMG", "…
#> $ fellowship_abs               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
#> $ flg_male                     <int> 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1,…
#> $ e_race_wbho                  <int> 1, 4, 4, 3, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ age_at_admit                 <int> 77, 76, 68, 80, 83, 82, 78, 87, 83, 83, 8…
#> $ e_ses_5grp                   <int> 5, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5, 5, 5,…
#> $ AHRQ_score                   <int> 2, 12, 18, 18, 2, -1, 11, 8, -1, 0, 16, -…
#> $ e_proc_grp                   <int> 195, 195, 223, 249, 1, 195, 173, 195, 195…
#> $ e_proc_grp_lbl               <chr> "Lysis of adhesions (open)", "Lysis of ad…
#> $ facility_clm_yr              <int> 2007, 2007, 2007, 2007, 2007, 2007, 2007,…
#> $ flg_multi_cpt                <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ cpt_cd                       <int> 44005, 44005, 43632, 19307, 47562, 44005,…
#> $ cpt_mod                      <chr> "", "", "", "", "", "GC, ", "", "", "", "…
#> $ e_admit_type                 <chr> "1_Emergency", "1_Emergency", "1_Emergenc…
#> $ flg_cmp_po_severe_not_poa    <chr> "N/A (no var)", "N/A (no var)", "N/A (no …
#> $ flg_cmp_po_severe            <int> 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0,…
#> $ flg_death_30d                <int> 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,…
#> $ flg_readmit_30d              <int> 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_cmp_po_any               <int> 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0,…
#> $ flg_cmp_po_any_not_poa       <chr> "N/A (no var)", "N/A (no var)", "N/A (no …
#> $ val_los                      <int> 9, 7, 11, 3, 8, 16, 15, 9, 7, 42, 12, 2, …
#> $ flg_util_reop                <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ flg_hosp_ICU_hosp            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ flg_hosp_urban               <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, TRUE,…
#> $ flg_hosp_urban_cbsa          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ facility_prvnumgrp           <int> 330214, 330064, 330169, 330169, 330169, 3…
#> $ flg_hosp_teach_combined      <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ val_hosp_mcday2inptday_ratio <dbl> 0.10, 0.46, 0.34, 0.34, 0.34, 0.34, 0.08,…
#> $ e_hosp_beds_4grp             <int> 4, 1, 4, 4, 4, 4, 3, 4, 4, 4, 4, 4, 4, 4,…
#> $ val_hosp_rn2bed_ratio        <dbl> 1.57, 1.14, 1.27, 1.27, 1.27, 1.97, 3.54,…
#> $ val_hosp_rn2inptday_ratio    <dbl> 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01,…
#> $ surgeon_volume               <int> 339, 226, 160, 104, 548, 304, 718, 160, 3…
#> $ medicare_gs_suregon          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
#> $ had_assist_surg              <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ n_cpt_admission              <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
```
