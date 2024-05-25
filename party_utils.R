
# 
# print(getwd())
# getwd()
# setwd("_site")

library(httr)
library(rvest)

custom <- F

here::i_am("wtm_gb.Rproj")

source(here::here("cntry.R"))

all_dat <- readRDS(here::here("data/all_dat.rds"))

# print("hello")

sets <- jsonlite::fromJSON(here::here("settings.json"))




options(scipen = 999)


# wtm_data %>% count(party,sort = T)

# sources("here::here(party_utils.R")
setColors <- function(df) {
  # Check if the 'color' column exists
  if (!"color" %in% names(df)) {
    df <- df %>% mutate(color = NA)
  }
  
  # Function to generate a random color
  generateRandomColor <- function() {
    sprintf("#%06X", sample(0:16777215, 1)) # Generates a random hex color
  }
  
  # Apply the function to each row
  df$color <- sapply(df$color, function(color) {
    if (is.na(color) || nchar(color) < 5) {
      return(generateRandomColor())
    } else {
      return(color)
    }
  })
  
  return(df)
}

country_codes <- c("AD", "AL", "AM", "AR", "AT", 
                   "AU", "BA", "BE", "BG", "BR", 
                   "CA", "CH", "CL", "CO", "CY", 
                   "CZ", "DE", "DK", "EC", "EE", 
                   "ES", "FI", "FR", "GB", "GR", 
                   "GT", "HR", "HU", "IE", "IN", 
                   "IS", "IT", "LI", "LT", "LU", 
                   "LV", "MD", "ME", "MK", "MT",
                   "MX", "NL", "NO", "NZ", "PL", 
                   "PT", "RO", "RS", "SE", "SI", 
                   "SK", "SM", "TR", "UA", "US", 
                   "VE", "ZA")


thedat <- vroom::vroom("data/1c162e28-c8ab-47dc-a1d6-19e36dce7742.csv.gzip") %>% 
  filter(entities_groups.group_name == "Main parties") %>% 
  filter(entities.short_name != "ZZZ") 


# if(!custom){
#   if(sets$cntry %in% country_codes & nrow(thedat)!=0){
    res <- GET(url = paste0("https://data-api.whotargets.me/entities?%24client%5BwithCountries%5D=true&countries.alpha2%5B%24in%5D%5B0%5D=", str_to_lower(sets$cntry)))
    color_dat <- content(res) %>% 
      flatten() %>% 
      map(compact)%>% 
      map_dfr(as_tibble) %>% 
      drop_na(id) %>% 
      distinct(name, .keep_all = T) %>% 
      ## this is a speccial UK thing
      rename(party = name) %>% 
      select(party, short_name, contains("color")) %>% 
      setColors() %>% 
      rename(colors = color) %>% 
      filter(!short_name %in% c("ConMain","MoL","HC", "Hou", "Bunce", "ZG", "ZZZ", "LabTop100", "McEwan", "Parker", "SH", "NI"))
    
  # } else {
  #   polsample <- readRDS(here::here("data/polsample.rds"))
  #   partycolorsdataset  <- readRDS(here::here("data/partycolorsdataset.rds"))
  #   
  #   color_dat <- polsample %>% 
  #     # count(cntry, partyfacts_id, sort = T) %>% View()
  #     filter(cntry == sets$cntry) %>%
  #     select(party = name_short, partyfacts_id) %>% 
  #     distinct(partyfacts_id, party) %>% 
  #     left_join(partycolorsdataset %>% mutate(partyfacts_id = as.character(partyfacts_id))) %>%
  #     select(party, color = hex)  %>% 
  #     setColors() %>% 
  #     rename(colors = color) %>% 
  #     drop_na(party)
  # }
  

  
  
  saveRDS(color_dat, here::here("data/color_dat.rds"))
# } 


# print("hello")


most_left_party <- color_dat$party[1]


scale_fill_parties <- function(...){
  ggplot2:::manual_scale(
    'fill',
    values = setNames(color_dat$colors, color_dat$party),
    ...
  )
}
scale_color_parties <- function(...){
  ggplot2:::manual_scale(
    'color',
    values = setNames(color_dat$colors, color_dat$party),
    ...
  )
}

# print("hello")

if(Sys.info()[["user"]] != "fabio"){
  out <- sets$cntry %>% 
    map(~{
      .x %>% 
        paste0(c("-last_30_days"))
    }) %>% 
    unlist() %>% 
    # keep(~str_detect(.x, tf)) %>% 
    # .[100:120] %>% 
    map_dfr(~{
      the_assets <- httr::GET(paste0("https://github.com/favstats/meta_ad_targeting/releases/expanded_assets/", .x))
      
      the_assets %>% httr::content() %>% 
        rvest::html_elements(".Box-row") %>% 
        rvest::html_text()  %>%
        tibble(raw = .)   %>%
        # Split the raw column into separate lines
        mutate(raw = strsplit(as.character(raw), "\n")) %>%
        # Extract the relevant lines for filename, file size, and timestamp
        transmute(
          filename = sapply(raw, function(x) trimws(x[3])),
          file_size = sapply(raw, function(x) trimws(x[6])),
          timestamp = sapply(raw, function(x) trimws(x[7]))
        ) %>% 
        filter(filename != "Source code") %>% 
        mutate(release = .x) %>% 
        mutate_all(as.character)
    })
  
  thosearethere <- out %>% 
    rename(tag = release,
           file_name = filename) %>% 
    arrange(desc(tag)) %>% 
    separate(tag, into = c("cntry", "tframe"), remove = F, sep = "-") %>% 
    mutate(ds  = str_remove(file_name, "\\.rds|\\.zip|\\.parquet")) %>% 
    distinct(cntry, ds, tframe) %>% 
    drop_na(ds) %>% 
    arrange(desc(ds))
  
  # print(thosearethere)
  
  # try({
  election_dat30 <- arrow::read_parquet(paste0("https://github.com/favstats/meta_ad_targeting/releases/download/", sets$cntry, "-last_", 30,"_days/", thosearethere$ds[1], ".parquet")) %>% 
    select(-party) %>% 
    left_join(all_dat %>% select(page_id, party))
  # })
  
  # }
  
  # if(!exists("election_dat7")){
  out <- sets$cntry %>% 
    map(~{
      .x %>% 
        paste0(c("-last_7_days"))
    }) %>% 
    unlist() %>% 
    # keep(~str_detect(.x, tf)) %>% 
    # .[100:120] %>% 
    map_dfr(~{
      the_assets <- httr::GET(paste0("https://github.com/favstats/meta_ad_targeting/releases/expanded_assets/", .x))
      
      the_assets %>% httr::content() %>% 
        html_elements(".Box-row") %>% 
        html_text()  %>%
        tibble(raw = .)   %>%
        # Split the raw column into separate lines
        mutate(raw = strsplit(as.character(raw), "\n")) %>%
        # Extract the relevant lines for filename, file size, and timestamp
        transmute(
          filename = sapply(raw, function(x) trimws(x[3])),
          file_size = sapply(raw, function(x) trimws(x[6])),
          timestamp = sapply(raw, function(x) trimws(x[7]))
        ) %>% 
        filter(filename != "Source code") %>% 
        mutate(release = .x) %>% 
        mutate_all(as.character)
    })
  
  thosearethere <- out %>% 
    rename(tag = release,
           file_name = filename) %>% 
    arrange(desc(tag)) %>% 
    separate(tag, into = c("cntry", "tframe"), remove = F, sep = "-") %>% 
    mutate(ds  = str_remove(file_name, "\\.rds|\\.zip|\\.parquet")) %>% 
    distinct(cntry, ds, tframe) %>% 
    drop_na(ds) %>% 
    arrange(desc(ds))
  
  # try({
  election_dat7 <- arrow::read_parquet(paste0("https://github.com/favstats/meta_ad_targeting/releases/download/", sets$cntry, "-last_", 7,"_days/", thosearethere$ds[1], ".parquet"))  %>% 
    select(-party) %>% 
    left_join(all_dat %>% select(page_id, party))
}

if(!exists("election_dat30")){
  election_dat30 <- readRDS(here::here("data/election_dat30.rds")) 
}

if(!exists("election_dat7")){
  election_dat7 <- readRDS(here::here("data/election_dat7.rds"))
}
# print("hello2")


# if(sets$cntry %in% country_codes & nrow(thedat)!=0){
  
  
  
  
  election_dat30 <- election_dat30 %>%
    rename(internal_id = contains("page_id")) %>%
    filter(is.na(no_data)) %>% 
    drop_na(party) %>% 
    filter(party %in% color_dat$party)
  
  
  election_dat7 <- election_dat7 %>%
    rename(internal_id = contains("page_id")) %>%
    filter(is.na(no_data)) %>% 
    drop_na(party) %>% 
    filter(party %in% color_dat$party)
  
# } else if (custom){
#   
#   raw <- election_dat30 %>%
#     rename(internal_id = contains("page_id")) %>%
#     filter(is.na(no_data)) 
#   
#   if(nrow(raw)==0){
#     election_dat30 <- tibble()
#   } else {
#     election_dat30 <- raw %>% 
#       drop_na(party) %>% 
#       filter(party %in% color_dat$party)
#   }
#   
#   
#   
#   raw <- election_dat7 %>%
#     rename(internal_id = contains("page_id")) %>%
#     filter(is.na(no_data)) 
#   
#   if(nrow(raw)==0){
#     election_dat7 <- tibble()
#   } else {
#     election_dat7 <- raw %>% 
#       drop_na(party)  %>% 
#       filter(party %in% color_dat$party)
#   }
#   
# } else {
#   
#   raw <- election_dat30 %>%
#     rename(internal_id = contains("page_id")) %>%
#     filter(is.na(no_data)) %>% 
#     filter(sources == "wtm")
#   
#   if(nrow(raw)==0){
#     election_dat30 <- tibble()
#   } else {
#     election_dat30 <- raw %>% 
#       drop_na(party) %>% 
#       filter(party %in% color_dat$party)
#   }
#   
#   
#   
#   raw <- election_dat7 %>%
#     rename(internal_id = contains("page_id")) %>%
#     filter(is.na(no_data)) %>% 
#     filter(sources == "wtm")
#   
#   if(nrow(raw)==0){
#     election_dat7 <- tibble()
#   } else {
#     election_dat7 <- raw %>% 
#       drop_na(party)  %>% 
#       filter(party %in% color_dat$party)
#   }
#   
# }


# print(glimpse(election_dat30))


# election_dat30test <<- election_dat30

# saveRDS(election_dat30, "here::here(data/election_dat30.rds")
# saveRDS(election_dat7, "here::here(data/election_dat7.rds")

fin <- (as.Date(election_dat30$ds[1])-lubridate::days(1))
begin7 <- fin-lubridate::days(6)
begin30 <- fin-lubridate::days(29)

tibble(fin,
       begin7,
       begin30) %>% 
  write_csv(here::here("dates.csv"))



# Function to create Dutch date strings with suffixes
create_date <- function(x) {
  the_date <- format(x, "%e %b") # %e for day of the month without leading zeros, %B for full month name in Dutch
  # In Dutch, date suffixes are not commonly used so we can omit the 'append_date_suffix' part
  return(trimws(the_date)) # trimws to remove any leading or trailing whitespace which might be left after %e
}

last7days_string <- paste0(create_date(begin7), " - ", create_date(fin), " ", lubridate::year(fin)) 
last30days_string <- paste0(create_date(begin30), " - ", create_date(fin), " ", lubridate::year(fin)) 

# # Print the Dutch date range strings
# print(last7days_string)
# print(last30days_string)
# 
# # Reset locale back to the original if necessary
# Sys.setlocale("LC_TIME", "C")
# print("oo")

election_dat30 <- election_dat30 %>% 
  filter(party != "Dismissed")

election_dat7 <- election_dat7 %>% 
  filter(party != "Dismissed")

if(nrow(election_dat30)!=0){
  
  the_currency <- election_dat30 %>%
    count(main_currency, sort = T) %>%
    slice(1) %>%
    pull(main_currency)
  
  currency_symbol <- priceR::currency_info %>% 
    filter(iso_code == the_currency) %>% 
    pull(symbol)
  
  if(is.null(currency_symbol)){
    currency_symbol <- the_currency
  }
  
}





