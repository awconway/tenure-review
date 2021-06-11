#' Get employments
#' @export

get_distinctions <- function() {
distinctions <- rorcid::orcid_distinctions("0000-0002-9583-8636")
distinctions <- distinctions$`0000-0002-9583-8636`$`affiliation-group`$summaries
distinctions <- tibble(
  organization = purrr::map_chr(distinctions, "distinction-summary.organization.name"),
  title = purrr::map_chr(distinctions, "distinction-summary.role-title"),
  time = purrr::map_chr(distinctions, "distinction-summary.start-date.year.value")
)
return(distinctions)
}