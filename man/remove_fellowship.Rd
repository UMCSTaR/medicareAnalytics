% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/remove_fellowship.R
\name{remove_fellowship}
\alias{remove_fellowship}
\title{Remove Fellowship trained surgeons}
\usage{
remove_fellowship(
  data,
 
    fellowship_council_data_path = "/Volumes/George_Surgeon_Projects/Surgeon Profile data/fellowship_council/fellowship_npi_manual_linked.csv",
 
    medicare_gs_list_path = "/Volumes/George_Surgeon_Projects/Surgeon Profile data/medicare_specialty/all_gs_splty_medicare.rdata"
)
}
\arguments{
\item{data}{medicare data}

\item{fellowship_council_data_path}{path to fellowship council dt}

\item{medicare_gs_list_path}{assign value to NULL if you don't want use the
medicare specialty code criteria.}
}
\value{
medicare dataset that removed fellowship trained surgeons
}
\description{
Remove fellowship trained surgeons using ABS, fellowship council and medicare claim specialty code
}
