#' Get service
#' @export

get_service <- function() {
service <- rorcid::orcid_services("0000-0002-9583-8636")

currentFunction <- function(x) {
  if (!is.null(service$`0000-0002-9583-8636`$`affiliation-group`$summaries[[x]]$`service-summary.end-date`)) {
    "Current"
  } else {
    service$`0000-0002-9583-8636`$`affiliation-group`$summaries[[x]]$`service-summary.end-date.year.value`
  }
}

end_year <- vapply(seq(1, length(service$`0000-0002-9583-8636`$`affiliation-group`$summaries), by = 1), currentFunction, "")


service <- service$`0000-0002-9583-8636`$`affiliation-group`$summaries
service <- tibble(
  organization = purrr::map_chr(service, "service-summary.organization.name"),
  title = purrr::map_chr(service, "service-summary.role-title"),
  start = purrr::map_chr(service, "service-summary.start-date.year.value")
)

service$time <- glue::glue("{service$start} - {end_year}")

service$time <- glue::glue("{service$start} - {end_year}")
return(service)
}