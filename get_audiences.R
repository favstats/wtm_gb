source("utils.R")


# ?get_targeting
# get_targeting("41459763029", timeframe = "LAST_90_DAYS")
# debugonce(get_targeting)

library(httr)
library(tidyverse)
library(lubridate)
library(httr2)

inspck <- installed.packages() %>% 
  as_tibble() %>% 
  pull(Package)

if(!("metatargetr" %in% inspck)){
  remotes::install_github('favstats/metatargetr')
}

thecntry <- "GB"


thepkgs <-  installed.packages() %>% as_tibble() %>% pull(Package)


if(!("arrow" %in% thepkgs)){
  
  if (!(Sys.info()[["effective_user"]] %in% c("fabio", "favstats"))) {
    remove.packages("arrow")
  }
  
  Sys.setenv(LIBARROW_MINIMAL = "false")
  Sys.setenv("NOT_CRAN" = "true")
  
  print("##### please install arrow #####")
  
  options(
    HTTPUserAgent =
      sprintf(
        "R/%s R (%s)",
        getRversion(),
        paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])
      )
  )
  if (!(Sys.info()[["effective_user"]] %in% c("fabio", "favstats"))) {
    suppressMessages(
      suppressWarnings(
        install.packages(
          "arrow",
          repos = "https://packagemanager.rstudio.com/all/__linux__/focal/latest",
          quiet = TRUE
        )
      )
    )
    arrow::install_arrow(verbose = F) # verbose output to debug install errors
  }
  
}





# ips_targeting <- read_lines("ips-targeting.txt")



# get_proxy <- function(prxs) {
#   stringr::str_split_1(prxs[[1]][1], ":")
# }
# 
# get_proxy_user <- function(prxs) {
#   stringr::str_split_1(prxs[[1]][2], ":")
# }

# Define a function to get page insights


get_page_insights <- function (pageid, timeframe = "LAST_30_DAYS", lang = "en-GB", 
                               iso2c = "US", include_info = c("page_info", "targeting_info"), 
                               join_info = T) 
{
  
  
  # prx <- sample(ips_targeting, 1)
  # prxs <- stringr::str_split(prx, "(?<=\\d)\\:", n = 2)
  
  # print(prxs)
  
  ua_list <- c("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3", 
               "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36", 
               "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36")
  ua <- sample(ua_list, 1)
  
  fetch_page_info <- ifelse("page_info" %in% include_info, 
                            "true", "false")
  
  
  
  resp <- httr2::request("https://www.facebook.com/api/graphql/") %>% 
    httr2::req_headers(`Accept-Language` = paste0(lang, 
                                                  ",", stringr::str_split(lang, "-") %>% unlist() %>% 
                                                    .[1], ";q=0.5"), `sec-fetch-site` = "same-origin", 
                       `user-agent` = ua) %>%
    # httr2::req_proxy(
    #   url = get_proxy(prxs)[1],
    #   port = as.numeric(get_proxy(prxs)[2]),
    #   username = get_proxy_user(prxs)[1],
    #   password = get_proxy_user(prxs)[2]
    # ) %>%
    httr2::req_body_raw(glue::glue("av=0&_aaid=0&user=0&a=1&req=3&hs=19797.BP%3ADEFAULT.2.0..0.0&dpr=1&ccg=EXCELLENT&rev=1012093869&s=sbbnic%3Awquopy%3A7r1j3c&hsi=7346737420686302672&dyn=7xe6Eiw_K9zo5ObwKBAgc9o2exu13wqojyUW3qi4EoxW4E7SewXwCwfW7oqx60Vo1upEK12wvk1bwbG78b87C2m3K2y11wBw5Zx62G3i1ywdl0Fw4Hwp8kwyx2cU8EmwoHwrUcUjwVw9O7bK2S2W2K4EG1Mxu16wciaw4JwJwSyES0gq0K-1LwqobU2cwmo6O1Fw44wt8&csr=&lsd=AVo6-wl7l1Q&jazoest=2881&spin_r=1012093869&spin_b=trunk&spin_t=1710545602&_jssesw=1&fb_api_caller_class=RelayModern&fb_api_req_friendly_name=AdLibraryMobileFocusedStateProviderQuery&variables=%7B%22adType%22%3A%22POLITICAL_AND_ISSUE_ADS%22%2C%22audienceTimeframe%22%3A%22{timeframe}%22%2C%22country%22%3A%22{iso2c}%22%2C%22viewAllPageID%22%3A%22{pageid}%22%2C%22fetchPageInfo%22%3A{fetch_page_info}%2C%22fetchSharedDisclaimers%22%3Atrue%2C%22active_status%22%3A%22ALL%22%2C%22ad_type%22%3A%22POLITICAL_AND_ISSUE_ADS%22%2C%22bylines%22%3A%5B%5D%2C%22collation_token%22%3A%227ca3912f-0148-43ce-83e4-9a68ef656e4d%22%2C%22content_languages%22%3A%5B%5D%2C%22count%22%3A30%2C%22countries%22%3A%5B%22{iso2c}%22%5D%2C%22excluded_ids%22%3A%5B%5D%2C%22full_text_search_field%22%3A%22ALL%22%2C%22group_by_modes%22%3A%5B%5D%2C%22image_id%22%3Anull%2C%22location%22%3Anull%2C%22media_type%22%3A%22ALL%22%2C%22page_ids%22%3A%5B%5D%2C%22pagination_mode%22%3Anull%2C%22potential_reach_input%22%3Anull%2C%22publisher_platforms%22%3A%5B%5D%2C%22query_string%22%3A%22%22%2C%22regions%22%3A%5B%5D%2C%22search_type%22%3A%22PAGE%22%2C%22session_id%22%3A%221678877b-700b-485a-abb0-60efcb6b4019%22%2C%22sort_data%22%3A%7B%22mode%22%3A%22SORT_BY_RELEVANCY_MONTHLY_GROUPED%22%2C%22direction%22%3A%22ASCENDING%22%7D%2C%22source%22%3Anull%2C%22start_date%22%3Anull%2C%22view_all_page_id%22%3A%22{pageid}%22%7D&server_timestamps=true&doc_id=7193625857423421"), 
                        "application/x-www-form-urlencoded") %>% 
    httr2::req_perform()
  out <- resp %>% httr2::resp_body_html() %>% rvest::html_element("p") %>% 
    rvest::html_text() %>% str_split_1("(?<=\\})\\s*(?=\\{)") %>% 
    map(jsonlite::fromJSON)
  if (!is.null(out[[1]][["errors"]][["description"]])) {
    message(out[[1]][["errors"]][["description"]])
    
    
    if (Sys.info()[["effective_user"]] %in% c("fabio", "favstats")) {
      beepr::beep(20)
      readline("Change VPN pls")
      out <- resp %>% httr2::resp_body_html() %>% rvest::html_element("p") %>%
        rvest::html_text() %>% str_split_1("(?<=\\})\\s*(?=\\{)") %>%
        map(jsonlite::fromJSON)
    }
    
    
    
  }
  if ("page_info" %in% include_info) {
    page_info1 <- out[[1]][["data"]][["ad_library_page_info"]][["page_info"]]
    if (is.null(page_info1)) {
      if ("page_info" %in% include_info & "targeting_info" %in% 
          include_info) {
        if (join_info) {
          return(tibble(page_id = pageid, no_data = T))
        }
        else {
          return(list(page_info = tibble(page_id = pageid, 
                                         no_data = T), targeting_info = tibble(page_id = pageid, 
                                                                               no_data = T)))
        }
      }
      else {
        return(tibble(page_id = pageid, no_data = T))
      }
    }
    my_dataframe <- as.data.frame(t(unlist(page_info1)), 
                                  stringsAsFactors = FALSE) %>% dplyr::mutate_all(as.character)
    page_info2_raw <- out[[2]][["data"]][["page"]][["shared_disclaimer_info"]][["shared_disclaimer_pages"]][["page_info"]]
    if (!is.null(page_info2_raw)) {
      page_info2 <- page_info2_raw %>% tibble::as_tibble() %>% 
        dplyr::mutate_all(as.character) %>% dplyr::mutate(shared_disclaimer_info = my_dataframe$page_id[1])
    }
    else {
      page_info2 <- tibble(no_shared_disclaimer = T)
    }
    creat_times <- out[[1]][["data"]][["page"]][["pages_transparency_info"]][["history_items"]] %>% 
      dplyr::mutate(event = paste0(item_type, ": ", as.POSIXct(event_time, 
                                                               origin = "1970-01-01", tz = "UTC"))) %>% dplyr::select(event) %>% 
      unlist() %>% t() %>% as.data.frame()
    about_text <- out[[1]][["data"]][["page"]][["about"]] %>% 
      purrr::set_names("about")
    address_raw <- out[[1]][["data"]][["page"]][["confirmed_page_owner"]][["information"]]
    if (!is.null(address_raw)) {
      address <- address_raw %>% purrr::flatten()
    }
    else {
      address <- tibble(no_address = T)
    }
    sdis_raw <- out[[2]][["data"]][["page"]][["shared_disclaimer_info"]][["shared_disclaimer_pages"]][["page_info"]]
    if (!is.null(sdis_raw)) {
      sdis <- sdis_raw %>% dplyr::mutate_all(as.character) %>% 
        dplyr::mutate(shared_disclaimer_page_id = pageid[1]) %>% 
        jsonlite::toJSON() %>% as.character()
    }
    else {
      sdis <- "[]"
    }
    page_info <- my_dataframe %>% dplyr::mutate(shared_disclaimer_info = sdis) %>% 
      dplyr::bind_cols(about_text) %>% dplyr::bind_cols(creat_times) %>% 
      dplyr::bind_cols(address)
  }
  if ("targeting_info" %in% include_info) {
    out_raw <- out[[1]][["data"]][["page"]][["ad_library_page_targeting_insight"]]
    summary_dat <- out_raw %>% purrr::pluck("ad_library_page_targeting_summary") %>% 
      dplyr::bind_rows()
    if (nrow(summary_dat) > 1) {
      summary_dat <- summary_dat %>% dplyr::slice(which(summary_dat$detailed_spend$currency == 
                                                          summary_dat$main_currency)) %>% dplyr::select(-detailed_spend)
    }
    targeting_details_raw <- out_raw[!(names(out_raw) %in% 
                                         c("ad_library_page_targeting_summary", "ad_library_page_has_siep_ads"))]
    targeting_info <- targeting_details_raw %>% purrr::discard(purrr::is_empty) %>% 
      purrr::imap_dfr(~{
        .x %>% dplyr::mutate(type = .y %>% stringr::str_remove("ad_library_page_targeting_"))
      }) %>% dplyr::bind_cols(summary_dat) %>% dplyr::mutate(page_id = pageid)
  }
  if ("page_info" %in% include_info & "targeting_info" %in% 
      include_info) {
    if (join_info) {
      fin <- page_info %>% left_join(targeting_info, by = "page_id")
    }
    else {
      fin <- list(page_info, targeting_info)
    }
  }
  else if ("page_info" %in% include_info) {
    return(page_info)
  }
  else if ("targeting_info" %in% include_info) {
    return(targeting_info)
  }
  return(fin)
}




# test <- get_page_insights(pageid = "103875099042033")


# installed <- installed.packages() %>% 
#   as_tibble() %>% 
#   filter(Package == "metatargetr") %>% 
#   nrow()
# 
# if(installed == 0){
#   remotes::install_github("favstats/metatargetr", force = T)
# }
# 
# library(metatargetr)

if (Sys.info()[["effective_user"]] == "favstats" | Sys.info()[["effective_user"]] == "favoo") {
  ### CHANGE ME WHEN LOCAL!
  tf <- "30"
}

jb <- get_page_insights("103875099042033", timeframe = glue::glue("LAST_90_DAYS"), include_info = "targeting_info") %>% as_tibble()

new_ds <- jb %>% arrange(ds) %>% slice(1) %>% pull(ds)

latest_elex <- readRDS(paste0("data/election_dat", 30, ".rds"))

latest_ds <- latest_elex %>% arrange(ds) %>% slice(1) %>% pull(ds)






tstamp <- Sys.time()

write_lines(lubridate::as_date(tstamp), "tstamp.txt")

dir.create(paste0("historic/", new_ds), recursive = T)

prepp <- function(tf) {
  
  unlink(paste0("targeting/", tf), recursive = T, force = T)
  
  dir.create(paste0("targeting/", tf))
  
  write_lines("_", paste0("targeting/", tf, "/", "_"))
  
  # }
  
}
c(7, 30, 90) %>%
  walk(prepp)

# wtm_data <-
#   openxlsx::read.xlsx("data/Presidential candidates, last 30 days.xlsx", sheet = 2) %>% janitor::clean_names()


try({
  
  library(httr)
  
  url <- "https://data-api.whotargets.me/advertisers-export-csv"
  
  token <- Sys.getenv("WHO")
  
  headers <- add_headers(
    accept = "application/json",
    `accept-language` = "en-US,en;q=0.9,de-DE;q=0.8,de;q=0.7,nl;q=0.6,it;q=0.5,sv;q=0.4,is;q=0.3",
    authorization = paste("Bearer", token),
    `content-type` = "application/json",
    priority = "u=1, i",
    `sec-ch-ua` = '"Chromium";v="134", "Not:A-Brand";v="24", "Google Chrome";v="134"',
    `sec-ch-ua-mobile` = "?0",
    `sec-ch-ua-platform` = '"macOS"',
    `sec-fetch-dest` = "empty",
    `sec-fetch-mode` = "cors",
    `sec-fetch-site` = "same-site"
  )
  
  body <- list(
    alpha2 = stringr::str_to_lower(thecntry),
    should_be_emailed = FALSE
  )
  
  response <- POST(url, headers, body = body, encode = "json")
  
  # library(tidyverse)
  
  # vroom::vroom(url(content(response, "parsed")$url))
  
  download.file(content(response, "parsed")$url, destfile = "wtmdata.csv")
  
  
})

uswtm <- readr::read_csv("wtmdata.csv") %>% 
  filter(entities_groups.group_name  == "Main parties")


# count(enti)

wtm_data <-
  uswtm %>% 
  # filter(entities.short_name %in% c("Harris", "Trump", "Dems", "DemPAC", "RepPAC", "Prog", "Con", "GOP")) %>%
  # mutate(entities.short_name = fct_relevel(entities.short_name, c("Harris", "Trump", "Dems", "DemPAC", "RepPAC", "Prog", "Con", "GOP"))) %>% 
  #   arrange(entities.short_name) %>% 
  # distinct(advertisers_platforms.advertiser_platform_ref, .keep_all = T) %>% 
  mutate(party = entities.short_name) %>% 
  # mutate(party = case_when(
  #   entities.short_name == "Dems" ~ "Democrats",
  #   entities.short_name == "GOP" ~ "Republicans",
  #   entities.short_name == "Harris" ~ "Kamala Harris",
  #   entities.short_name == "Trump" ~ "Donald Trump",
  #   T ~ entities.name
  #  )) %>% 
  #     mutate(affiliation = case_when(
  #       entities.short_name == "Harris" ~ "Democratic",
  #       entities.short_name == "Trump" ~ "Republican",
  #       T ~ "Other"
#     )) %>% 
mutate(page_id = advertisers_platforms.advertiser_platform_ref) %>% 
  # distinct(entities.color) %>% 
  mutate(color = entities.color) %>% 
  filter(platforms.name == "Meta") %>% 
  mutate(page_name = name)
# View()


# uswtm %>% count(entities.short_name, platforms.name, sort = T) %>% View()

# rommeta <- readr::read_csv("data/Romania 2024 - meta.csv") %>% 
#   select(page_id, party) %>% 
#   drop_na() %>% 
#   distinct(page_id, .keep_all = T)  %>%
#   mutate_all(as.character) %>% 
#   filter(party != "-") %>% 
#   left_join(wtm_data %>% mutate(party = entities.short_name) %>% select(party, entities.name))

# rommeta %>% count(party) %>% View()

all_dat <- bind_rows(wtm_data) %>%
  distinct(page_id, .keep_all = T) %>%
  add_count(page_name, sort  = T) %>%
  mutate(remove_em = n >= 2 & str_ends(page_id, "0")) %>%
  filter(!remove_em) %>%
  # filter(n >= 2) %>%
  # filter(n >= 2 & str_ends(page_id, "0", negate = T)) %>%
  select(-n)  %>%
  mutate_all(as.character)



# all_dat %>% count(party)

# wtm_data %>% 
#   filter(party == "Donald Trump") %>% View()
#   count(party)
# #   
#   uswtm %>% 
#     count(entities.short_name, sort = T) %>% View()

# all_dat %>% count(party, sort = T)
# all_dat %>% nrow

saveRDS(all_dat, "data/all_data.rds")

write_lines(all_dat %>% count(page_id, sort = T) %>% nrow, "n_advertisers.txt")




scraper <- function(.x, time = "7") {
  # print(paste0(.x$page_name,": ", round(which(internal_page_ids$page_id == .x$page_id)/nrow(internal_page_ids)*100, 2)))
  
  yo <-
    get_page_insights(.x$page_id, timeframe = glue::glue("LAST_{time}_DAYS"), include_info = "targeting_info") %>% 
    mutate(tstamp = tstamp)
  
  if (nrow(yo) != 0) {
    path <- paste0(glue::glue("targeting/{time}/"), .x$page_id, ".rds")
    # if(file.exists(path)){
    #   ol <- read_rds(path)
    #
    #   saveRDS(yo %>% bind_rows(ol), file = path)
    # } else {
    
    saveRDS(yo, file = path)
    # }
  }
  
  # print(nrow(yo))
  # })
  
}

scraper <- possibly(scraper, otherwise = NULL, quiet = F)


# if(F){
#     # dir("targeting/7", full.names
# }
# da30 <- readRDS("data/election_dat30.rds")
# da7 <- readRDS("data/election_dat7.rds")

### save seperately
# all_dat %>%
#   split(1:nrow(.)) %>%
#   walk_progress(scraper, 7)
# 
# all_dat %>%
#   split(1:nrow(.)) %>%
#   walk_progress(scraper, 30)
# 
# all_dat %>%
#   split(1:nrow(.)) %>%
#   walk_progress(scraper, 90)


library(rvest)

out <- thecntry %>%
  map( ~ {
    .x %>%
      paste0(c("-last_7_days", "-last_30_days",
               "-last_90_days"))
  }) %>%
  unlist() %>%
  # keep( ~ str_detect(.x, tf)) %>%
  # .[100:120] %>%
  map_dfr( ~ {
    the_assets <-
      httr::GET(
        paste0(
          "https://github.com/favstats/meta_ad_targeting/releases/expanded_assets/",
          .x
        )
      )
    
    the_assets %>% httr::content() %>%
      html_elements(".Box-row") %>%
      html_text()  %>%
      tibble(raw = .)   %>%
      # Split the raw column into separate lines
      mutate(raw = strsplit(as.character(raw), "\n")) %>%
      # Extract the relevant lines for filename, file size, and timestamp
      transmute(
        filename = sapply(raw, function(x)
          trimws(x[3])),
        file_size = sapply(raw, function(x)
          trimws(x[6])),
        timestamp = sapply(raw, function(x)
          trimws(x[7]))
      ) %>%
      filter(filename != "Source code") %>%
      mutate(release = .x) %>%
      mutate_all(as.character)
  })



print("################ CHECK LATEST REPORT ################")


try({
  out <- thecntry %>%
    map( ~ {
      .x %>%
        paste0(c(
          "-last_7_days",
          "-last_30_days",
          "-last_90_days"
        ))
    }) %>%
    unlist() %>%
    # .[str_detect(., "last_90_days")] %>%
    # .[100:120] %>%
    map_dfr( ~ {
      the_assets <-
        httr::GET(
          paste0(
            "https://github.com/favstats/meta_ad_targeting/releases/expanded_assets/",
            .x
          )
        )
      
      the_assets %>% httr::content() %>%
        html_elements(".Box-row") %>%
        html_text()  %>%
        tibble(raw = .)   %>%
        # Split the raw column into separate lines
        mutate(raw = strsplit(as.character(raw), "\n")) %>%
        # Extract the relevant lines for filename, file size, and timestamp
        transmute(
          filename = sapply(raw, function(x)
            trimws(x[3])),
          file_size = sapply(raw, function(x)
            trimws(x[6])),
          timestamp = sapply(raw, function(x)
            trimws(x[7]))
        ) %>%
        filter(filename != "Source code") %>%
        mutate(release = .x) %>%
        mutate_all(as.character)
    })
  
  
  latest <- out  %>%
    rename(tag = release,
           file_name = filename) %>%
    arrange(desc(tag)) %>%
    separate(
      tag,
      into = c("country", "timeframe"),
      remove = F,
      sep = "-"
    ) %>%
    filter(str_detect(file_name, "parquet")) %>%
    mutate(day  = str_remove(file_name, "\\.parquet|\\.rds|\\.zip|\\.parquet") %>% lubridate::ymd()) %>%
    group_by(timeframe) %>%
    arrange(desc(day)) %>%
    slice(1) %>%
    ungroup()
  
  
  # download.file(
  #   paste0(
  #     "https://github.com/favstats/meta_ad_targeting/releases/download/",
  #     thecntry,
  #     "-last_90_days/",
  #     latest$file_name
  #   ),
  #   destfile = "targeting.rds"
  # )
  
  # last7 <- readRDS("report.rds") %>%
  #   mutate(sources = "report") %>%
  #   mutate(party = "unknown")
  # 
  # file.remove("report.rds")
})

# last7 <- readRDS("targeting.rds") 


# out
fin <- latest %>%
  # rename(tag = release,
  #        file_name = filename) %>%
  arrange(desc(tag)) %>%
  separate(
    tag,
    into = c("cntry", "tframe"),
    remove = F,
    sep = "-"
  ) %>%
  mutate(ds  = str_remove(file_name, "\\.rds|\\.zip|\\.parquet")) %>%
  distinct(cntry, ds, tframe) %>%
  drop_na(ds) %>%
  arrange(desc(ds)) # %>% 

us_markers <- fin %>% 
  filter(ds != "latest") %>% 
  group_by(tframe) %>% 
  arrange(desc(ds)) %>% 
  slice(1) %>% 
  ungroup()

print("################ CHECK LATEST REPORT 2 ################")


try({
  out <- thecntry %>%
    map( ~ {
      .x %>%
        paste0(c(
          "-yesterday",
          "-last_7_days",
          "-last_30_days",
          "-last_90_days"
        ))
    }) %>%
    unlist() %>%
    .[str_detect(., "last_90_days")] %>%
    # .[100:120] %>%
    map_dfr( ~ {
      the_assets <-
        httr::GET(
          paste0(
            "https://github.com/favstats/meta_ad_reports/releases/expanded_assets/",
            .x
          )
        )
      
      the_assets %>% httr::content() %>%
        html_elements(".Box-row") %>%
        html_text()  %>%
        tibble(raw = .)   %>%
        # Split the raw column into separate lines
        mutate(raw = strsplit(as.character(raw), "\n")) %>%
        # Extract the relevant lines for filename, file size, and timestamp
        transmute(
          filename = sapply(raw, function(x)
            trimws(x[3])),
          file_size = sapply(raw, function(x)
            trimws(x[6])),
          timestamp = sapply(raw, function(x)
            trimws(x[7]))
        ) %>%
        filter(filename != "Source code") %>%
        mutate(release = .x) %>%
        mutate_all(as.character)
    })
  
  
  latest <- out  %>%
    rename(tag = release,
           file_name = filename) %>%
    arrange(desc(tag)) %>%
    separate(
      tag,
      into = c("country", "timeframe"),
      remove = F,
      sep = "-"
    ) %>%
    filter(str_detect(file_name, "rds")) %>%
    mutate(day  = str_remove(file_name, "\\.rds|\\.zip|\\.parquet") %>% lubridate::ymd()) %>%
    arrange(desc(day)) %>%
    group_by(country) %>%
    slice(1) %>%
    ungroup()
  
  
  download.file(
    paste0(
      "https://github.com/favstats/meta_ad_reports/releases/download/",
      thecntry,
      "-last_90_days/",
      latest$file_name
    ),
    destfile = "report.rds"
  )
  
  last7 <- readRDS("report.rds") %>%
    mutate(sources = "report") %>%
    mutate(party = "unknown")
  
  file.remove("report.rds")
})

if (!exists("last7")) {
  last7 <- tibble()
}

# da7 %>%  filter(page_id == "153080620724")
da30 <- metatargetr::get_targeting_db(thecntry, 30, us_markers$ds[1]) 
da7 <- metatargetr::get_targeting_db(thecntry, 7, us_markers$ds[1]) 


# saveRDS(da90, "data/election_dat90.rds")
saveRDS(da30, "data/election_dat30.rds")
saveRDS(da7, "data/election_dat7.rds")

# saveRDS(da90, paste0("historic/", new_ds, "/90.rds"))
saveRDS(da30, paste0("historic/", new_ds, "/30.rds"))
saveRDS(da7, paste0("historic/", new_ds, "/7.rds"))

# list(da7, da30, da90) %>%
#   walk(combine_em)
