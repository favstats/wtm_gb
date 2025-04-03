# if (Sys.info()[["effective_user"]] == "favstats" | Sys.info()[["effective_user"]] == "favoo") {
source("get_audiences.R")
# } else {

# install.packages("pacman")
# }



pacman::p_load(knitr, tidyverse, openxlsx, rmarkdown, rvest, shinydashboard, tidytable)
# setwd("C:/Users/fabio/Dropbox/postdoc/microdashboards/wtm_iq/")
# setwd("..")
# print(getwd())
render_it <- function(...) {
  print(...)
  thefile <- str_remove(..., "_site/") %>% str_replace("qmd", "html")
  if(any(str_detect(..., "map"))){
    if(cntryy == "NL"){
      quarto::quarto_render(..., quiet = F)
    }
  } else {
    # print(thefile)
    quarto::quarto_render(..., quiet = F)
  }
  
}

render_it <- purrr::possibly(render_it, otherwise = NULL)
dir("_site", full.names = T) %>% keep(~str_detect(.x, "qmd")) %>% keep(~str_detect(.x, "qmd")) %>% walk(render_it)


if (Sys.info()[["effective_user"]] == "favstats" | Sys.info()[["effective_user"]] == "favoo") {
  # system("git pull")
  # gert::git_pull()
  # system("git add -A")
  # system('git commit -m "update"')
  # system("git push")
  gert::git_add(".")
  gert::git_commit("update")
  gert::git_push(force = T)
}

