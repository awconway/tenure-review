pubs <- rorcid::orcid_citations("0000-0002-9583-8636")
writeLines(pubs$citation, "publications.bib")
