#' Get memberships
#' @export

get_memberships <- function() {
membership <- rorcid::orcid_memberships("0000-0002-9583-8636")

currentFunction <- function(x) {
  if (!is.null(membership$`0000-0002-9583-8636`$`affiliation-group`$summaries[[x]]$`membership-summary.end-date`)) {
    "Current"
  } else {
    membership$`0000-0002-9583-8636`$`affiliation-group`$summaries[[x]]$`membership-summary.end-date.year.value`
  }
}

end_year <- vapply(seq(1, length(membership$`0000-0002-9583-8636`$`affiliation-group`$summaries), by = 1), currentFunction, "")

membership <- membership$`0000-0002-9583-8636`$`affiliation-group`$summaries

membership <- tibble(
  organization = purrr::map_chr(membership, "membership-summary.organization.name"),
  title = purrr::map_chr(membership, "membership-summary.role-title"),
  start = purrr::map_chr(membership, "membership-summary.start-date.year.value")
)

membership$time <- glue::glue("{membership$start} - {end_year}")
return(membership)
}