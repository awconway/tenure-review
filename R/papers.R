#' Format papers from bibtex
#' @export 
#' @importFrom bib2df bib2df
#' @importFrom dplyr group_by mutate ungroup arrange desc case_when
#' @importFrom stringr str_replace_all
get_papers <- function(bibtex) {

Sys.getenv("ORCID_TOKEN")

pubsdf <- bib2df::bib2df("publications.bib")

pubs <- pubsdf %>%
  dplyr::group_by(DOI) %>%
  dplyr::mutate(authors = paste(unlist(AUTHOR), collapse = " | ")) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(authors = ifelse(BIBTEXKEY == "Brown_2019",
  "Group author",
  authors)) %>%
  dplyr::arrange(dplyr::desc(YEAR)) %>%
dplyr::mutate(authors = stringr::str_replace_all(authors, "Aaron Conway", "<strong>Aaron Conway</strong>")) %>%
dplyr::mutate(TITLE = stringr::str_replace_all(TITLE, "\\{", "")) %>%
dplyr::mutate(TITLE = stringr::str_replace_all(TITLE, "\\}", "")) %>%
dplyr::mutate(JOURNAL = stringr::str_replace_all(JOURNAL, "\\{", "")) %>%
dplyr::mutate(JOURNAL = stringr::str_replace_all(JOURNAL, "\\}", "")) %>%
dplyr::mutate(authors = stringr::str_replace_all(authors, "\\{", "")) %>%
dplyr::mutate(authors = stringr::str_replace_all(authors, "\\}", "")) %>%
dplyr::mutate(authors = stringr::str_replace_all(authors, "~", " ")) %>%
dplyr::mutate(authors = stringr::str_replace_all(authors, "Thombs and", "Thombs")) %>%
dplyr::mutate(type = dplyr::case_when(JOURNAL == "Angiology" ~ "letter",
TITLE == "Reply to" ~ "letter",
TITLE == "Capnography for Moderate Sedation During Routine EGD and Colonoscopy" ~ "letter",
TITLE == "Utility of Dexmedetomidine in Sedation for Radiofrequency Ablation of Atrial Fibrillation" ~ "letter",
TITLE == "Is sedation by non-anaesthetists really safe?" ~ "letter",
TITLE == "Ensuring COVID-related innovation is sustained" ~ "editorial",
TITLE == "Nurses should inform patients of the possibility of awareness during bronchoscopy performed with procedural sedation" ~ "editorial",
TITLE == "Forced air warming to maintain normoTHERMIa during SEDation in the cardiac catheterization laboratory: protocol for the THERMISED pilot randomized controlled trial" ~ "protocol",
TITLE == "Capnography monitoring during procedural sedation and analgesia: a systematic review protocol" ~ "protocol",
TITLE == "Depth of anaesthesia monitoring during procedural sedation and analgesia: a systematic review protocol" ~ "protocol",
TITLE == "Predicting prolonged apnea during nurse-administered procedural sedation: a machine learning study (Preprint)" ~ "preprint",
TRUE ~ "article"))
}