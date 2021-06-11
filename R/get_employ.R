#' Get employments
#' @export

get_employ <- function() {
employ <- rorcid::orcid_employments("0000-0002-9583-8636")

currentFunction <- function(x) {
  if (!is.null(employ$`0000-0002-9583-8636`$`affiliation-group`$summaries[[x]]$`employment-summary.end-date`)) {
    "Current"
  } else {
    employ$`0000-0002-9583-8636`$`affiliation-group`$summaries[[x]]$`employment-summary.end-date.year.value`
  }
}

end_year <- vapply(seq(1, length(employ$`0000-0002-9583-8636`$`affiliation-group`$summaries), by = 1), currentFunction, "")

employ <- employ$`0000-0002-9583-8636`$`affiliation-group`$summaries

employ <- tibble(
  organization = purrr::map_chr(employ, "employment-summary.organization.name"),
  title = purrr::map_chr(employ, "employment-summary.role-title"),
  start = purrr::map_chr(employ, "employment-summary.start-date.year.value"),
  city = purrr::map_chr(employ, "employment-summary.organization.address.city"),
  country = purrr::map_chr(employ, "employment-summary.organization.address.country")
)

employ$time <- glue::glue("{employ$start} - {end_year}")
employ$location <- glue::glue("{employ$city}, {employ$country}")
return(employ)
}