#' Get education
#' @export

get_edu <- function() {
    edu <- rorcid::orcid_educations("0000-0002-9583-8636")
edu <- edu$`0000-0002-9583-8636`$`affiliation-group`$summaries

edu <- tibble(
  organization = purrr::map_chr(edu, "education-summary.organization.name"),
  title = purrr::map_chr(edu, "education-summary.role-title"),
  start = purrr::map_chr(edu, "education-summary.start-date.year.value"),
  end = purrr::map_chr(edu, "education-summary.end-date.year.value"),
  city = purrr::map_chr(edu, "education-summary.organization.address.city"),
  country = purrr::map_chr(edu, "education-summary.organization.address.country")
)

edu$time <- glue::glue("{edu$start} - {edu$end}")
edu$location <- glue::glue("{edu$city}, {edu$country}")
return(edu)
}