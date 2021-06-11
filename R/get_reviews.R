#' Get reviews
#' @export

get_reviews <- function() {
reviews <- jsonlite::fromJSON("publons.json")

reviewsdf <- reviews$review$per_journal

reviewdf <- reviewsdf %>%
  arrange(desc(count))
return(reviewdf)
}