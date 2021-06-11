#' Get funding
#' @export

get_funding <- function() {

funding <- rorcid::orcid_fundings("0000-0002-9583-8636")
pcodes <- vapply(funding[[1]]$group$`funding-summary`, "[[", 1, "put-code")
out <- lapply(pcodes, function(z) rorcid::orcid_fundings("0000-0002-9583-8636", put_code = z))
amount <- vapply(out, function(w) w[[1]]$amount$value, "")
amount <- str_replace_all(amount, "19000.0", "19000") 
amount <- str_replace_all(amount, "63500.0", "63500 plus ~$60000 equipment") 
amount <- str_replace_all(amount, "18356.0", "18356") 
amount <- paste("$", amount, sep = "")
funding <- funding$`0000-0002-9583-8636`$group$`funding-summary`
funding <- tibble(
  type = purrr::map_chr(funding, "type"),
  funder = purrr::map_chr(funding, "organization.name"),
  title = purrr::map_chr(funding, "title.title.value"),
  start = purrr::map_chr(funding, "start-date.year.value"),
  end = purrr::map_chr(funding, "end-date.year.value")
) %>%
  mutate(timeframe = glue::glue("{start} - {end}")) %>%
  select(type, funder, title, timeframe, end)
funding$type <- stringr::str_replace_all(funding$type, "SALARY_AWARD", "SALARY AWARD")
funding <- funding %>%
  mutate(Amount = amount) %>%
  arrange(desc(as.numeric(end))) %>%
  filter(end > 2012)
return(funding)

}