# author: Dane Korver
# date: 06/26/2022
# purpose: Render nhlVignette.Rmd as a .md file called README.md for my repo.

rmarkdown::render(
  input="Finacial_Data_API.Rmd",
  output_format = "github_document",
  output_file = "index.md",
  runtime = "static",
  clean = TRUE,
  params = NULL,
  knit_meta = NULL,
  envir = parent.frame(),
  run_pandoc = TRUE,
  quiet = FALSE,
  encoding = "UTF-8"
)