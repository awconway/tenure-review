library(targets)
library(tarchetypes)
library(dplyr)
Sys.getenv("ORCID_TOKEN")


tar_option_set(packages = c(
  "interimReview"
))
list(
  tar_target(papers, get_papers("publications.bib")|>
  mutate(URL = case_when(DOI == '10.1097/eja.0000000000001458' ~ "https://res.cloudinary.com/awconway/image/upload/v1623778311/conway_2021_hfno_n0ut8x.pdf", #hfno
  DOI == "10.1016/j.colegn.2019.10.003" ~ "https://res.cloudinary.com/awconway/image/upload/v1623777654/ralph_2020_vfnqtp.pdf",
  DOI == "10.1007/s10877-020-00543-6" ~ "https://rdcu.be/b4AoO", #costs IPH
  DOI == "10.1186/s13643-021-01617-5" ~ "https://rdcu.be/cgiCv", #midaz
  DOI == "10.1007/s10877-019-00391-z" ~ "https://rdcu.be/bSDxX", #pre-apneic
  DOI == "10.1186/s12909-019-1698-4" ~ "https://rdcu.be/bKVVd", #theory-based ebp
  DOI == "10.1177/0846537119899215" ~ "https://res.cloudinary.com/awconway/image/upload/v1623778097/mafeld_2020_ovr24f.pdf", #mafeld_2020
  DOI == "10.1007/s40140-020-00368-8" ~ "https://res.cloudinary.com/awconway/image/upload/v1623778153/sutherland_2020_pbuiid.pdf", #sutherland_2020
  DOI == "10.1016/j.aucc.2020.10.012" ~ "https://res.cloudinary.com/awconway/image/upload/v1623778210/corones_2020_p13rzk.pdf",
  TITLE == "Accuracy of the PHQ-2 Alone and in Combination With the PHQ-9 for Screening to Detect Major Depression" ~ "https://res.cloudinary.com/awconway/image/upload/v1623778400/levis_2020_vzab3f.pdf",
  TITLE == "Probability of Major Depression Classification Based on the SCID, CIDI, and MINI Diagnostic Interviews: A Synthesis of Three Individual Participant Data Meta-Analyses" ~ "https://res.cloudinary.com/awconway/image/upload/v1623778443/wu_2020_xevelh.pdf",
  TITLE == "Implementing a thermal care bundle for inadvertent perioperative hypothermia: A cost-effectiveness analysis" ~ "https://res.cloudinary.com/awconway/image/upload/v1623778521/conway_2019_thermal_cea_rjywht.pdf",
  TITLE == "Accuracy and precision of transcutaneous carbon dioxide monitoring: a systematic review and meta-analysis" ~ "https://res.cloudinary.com/awconway/image/upload/v1623778587/conway_2019_tcco2_ii896p.pdf",
  TRUE ~ URL))),
  tar_target(nur1027plot, create_nur1027plot()),
  tar_target(nur1127plot, create_nur1127plot()),
  tar_target(articles, papers |>
  filter(type == "article")),
  tar_target(editorials, papers |>
  filter(type == "editorial")),
  tar_target(letters, papers |>
  filter(type == "letter")),
  tar_target(protocols, papers |>
  filter(type == "protocol")),
  tar_target(preprints, papers |>
  filter(type == "preprint")),
  tar_target(uoftPapers, papers |>
  filter(
    YEAR > 2017, 
    DOI != "10.1111/jan.13707",
    DOI != "10.1097/eja.0000000000000851",
    DOI != "10.1136/eb-2018-102922",
    BIBTEXKEY != "Parker_2018",
    BIBTEXKEY != "Ward_2018",
    BIBTEXKEY != "Brown_2019",
    BIBTEXKEY != "Hudson_2019",
    BIBTEXKEY != "Spooner_2019"
  )),
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