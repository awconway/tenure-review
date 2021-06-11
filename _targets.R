library(targets)
library(tarchetypes)
library(dplyr)
Sys.getenv("ORCID_TOKEN")


tar_option_set(packages = c(
  "interimReview"
))
list(
  tar_target(papers, get_papers("publications.bib")),
  tar_target(articles, papers %>%
    filter(type == "article")),
  tar_target(editorials, papers %>%
    filter(type == "editorial")),
  tar_target(letters, papers %>%
    filter(type == "letter")),
  tar_target(protocols, papers %>%
    filter(type == "protocol")),
  tar_target(preprints, papers %>%
    filter(type == "preprint")),
  tar_target(edu, get_edu()),
  tar_target(employ, get_employ()),
  tar_target(distinctions, get_distinctions()),
  tar_target(service, get_service()),
  tar_target(membership, get_memberships()),
  tar_target(funding, get_funding()),
  tar_target(reviews, get_reviews()),
  tar_target_raw(
    "bookdown",
    command = quote({
      bookdown::render_book(".")
    }),
    format = "file",
    deps = tar_knitr_deps(c("index.Rmd", "research.Rmd")),
    cue = tar_cue(mode = "always")
  )
)
