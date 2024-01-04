library(httr)

# URL for the request
url <- "https://ads-api.twitter.com/11/accounts/18ce54mmuxp/audience_estimate"

# Headers
headers <- c(
  `authority` = "ads-api.twitter.com",
  `accept` = "*/*",
  `accept-language` = "en-US,en;q=0.9,de-DE;q=0.8,de;q=0.7,nl;q=0.6",
  `authorization` = "Bearer AAAAAAAAAAAAAAAAAAAAANBSYwEAAAAAOlt9bKS2BoTpbL%^2FSNHNmN0ejfBc%^3DVFV0ENqnQ927hPgNRQsihKOMwPfpPeO8Ds9toqkIMqj6PIj8dn",
  `content-type` = "application/json; charset=UTF-8",
  `cookie` = "kdt=Cg6xJf0dORfZVAFf24VjwW3mBuEEq5e6eM45L95G; d_prefs=MToxLGNvbnNlbnRfdmVyc2lvbjoyLHRleHRfdmVyc2lvbjoxMDAw; guest_id_ads=v1%^3A169969500394127472; guest_id_marketing=v1%^3A169969500394127472; _ga=GA1.2.1647771903.1699704178; twtr_pixel_opt_in=Y; dnt=1; ads_prefs=^\"HBESAAA=^\"; auth_multi=^\"1410272146027433995:0a51e2017741c926ac7a39573b83e65d68d31b8c^\"; auth_token=8f1d872ff022e98369bb4f79586f35132ab40d11; twid=u%^3D513351911; personalization_id=^\"v1_AQAcnmtsMhDlagProOx9PQ==^\"; guest_id=v1%^3A170161405145688214; ct0=835c4264b1ca9caa004d55f3f50cbe31c483e81955f71ec5199c82792ea93789b3957ef102c00e116220a3def31378ebbd83735e139209c87b76c70475cfefbb4776a50be043bf1976f49dc8fe803436; external_referer=padhuUp37zjgzgv1mFWxJ12Ozwit7owX|0|8e8t2xd8A2w%^3D; _gid=GA1.2.1183446291.1702542797",
  `origin` = "https://ads.twitter.com",
  `referer` = "https://ads.twitter.com/",
  `sec-ch-ua` = "\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"120\", \"Google Chrome\";v=\"120\"",
  `sec-ch-ua-mobile` = "?0",
  `sec-ch-ua-platform` = "\"Windows\"",
  `sec-fetch-dest` = "empty",
  `sec-fetch-mode` = "cors",
  `sec-fetch-site` = "same-site",
  `user-agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
  `x-csrf-token` = "835c4264b1ca9caa004d55f3f50cbe31c483e81955f71ec5199c82792ea93789b3957ef102c00e116220a3def31378ebbd83735e139209c87b76c70475cfefbb4776a50be043bf1976f49dc8fe803436",
  `x-origin-environment` = "production"
)

# Data
data <- '{
    "targeting_criteria": [
        {"targeting_type": "BROAD_KEYWORD", "targeting_value": "white supremacy"}
    ]
}'

# Make the request
response <- httr::POST(url, httr::add_headers(.headers=headers), body = NULL, encode = "json")

# View the response
content(response)




library(httr)

# Define the URL
url <- "https://ads-api.twitter.com/11/accounts/18ce54mmuxp/audience_estimate"

# Set up headers
headers <- c(
  "accept" = "*/*",
  "accept-language" = "en-US,en;q=0.9,de-DE;q=0.8,de;q=0.7,nl;q=0.6",
  "authorization" = "Bearer AAAAAAAAAAAAAAAAAAAAANBSYwEAAAAAOlt9bKS2BoTpbL%2FSNHNmN0ejfBc%3DVFV0ENqnQ927hPgNRQsihKOMwPfpPeO8Ds9toqkIMqj6PIj8dn",
  "content-type" = "application/json; charset=UTF-8",
  "sec-ch-ua" = "\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"120\", \"Google Chrome\";v=\"120\"",
  "sec-ch-ua-mobile" = "?0",
  "sec-ch-ua-platform" = "\"Windows\"",
  "sec-fetch-dest" = "empty",
  "sec-fetch-mode" = "cors",
  "sec-fetch-site" = "same-site",
  `cookie` = "kdt=Cg6xJf0dORfZVAFf24VjwW3mBuEEq5e6eM45L95G; d_prefs=MToxLGNvbnNlbnRfdmVyc2lvbjoyLHRleHRfdmVyc2lvbjoxMDAw; guest_id_ads=v1%^3A169969500394127472; guest_id_marketing=v1%^3A169969500394127472; _ga=GA1.2.1647771903.1699704178; twtr_pixel_opt_in=Y; dnt=1; ads_prefs=^\"HBESAAA=^\"; auth_multi=^\"1410272146027433995:0a51e2017741c926ac7a39573b83e65d68d31b8c^\"; auth_token=8f1d872ff022e98369bb4f79586f35132ab40d11; twid=u%^3D513351911; personalization_id=^\"v1_AQAcnmtsMhDlagProOx9PQ==^\"; guest_id=v1%^3A170161405145688214; ct0=835c4264b1ca9caa004d55f3f50cbe31c483e81955f71ec5199c82792ea93789b3957ef102c00e116220a3def31378ebbd83735e139209c87b76c70475cfefbb4776a50be043bf1976f49dc8fe803436; external_referer=padhuUp37zjgzgv1mFWxJ12Ozwit7owX|0|8e8t2xd8A2w%^3D; _gid=GA1.2.1183446291.1702542797",
  "x-csrf-token" = "835c4264b1ca9caa004d55f3f50cbe31c483e81955f71ec5199c82792ea93789b3957ef102c00e116220a3def31378ebbd83735e139209c87b76c70475cfefbb4776a50be043bf1976f49dc8fe803436",
  "x-origin-environment" = "production"
)

# Define the body
body <- "{\"targeting_criteria\":[{\"targeting_type\":\"LOCATION\",\"targeting_value\":\"fdcd221ac44fa326\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white supremacy\",\"operator_type\": \"EQ\"}]}"
# body <- "{\"targeting_criteria\":[{\"targeting_type\":\"LOCATION\",\"targeting_value\":\"fdcd221ac44fa326\"}]}"

body

# Make the request
response <- POST(url, add_headers(.headers = headers), body = body, encode = "json")

# Check the response
content(response, "parsed")

res <- content(response, "parsed")










library(httr)
library(jsonlite)


get_cntries <- function(cntry) {
  
  # Base URL and endpoint
  base_url <- "https://api.twitter.com/graphql/pkE1MXvewwh5wjXrzqFdoQ/TargetingSearchQuery"
  
  # Parameters
  account_id <- "4503599674391581"
  domains <- c("Geo")
  search_query <- cntry  # Replace with your search query
  
  # Construct variables JSON
  variables <- toJSON(list(account_id = account_id, domains = domains, query = search_query), auto_unbox = TRUE)
  
  # Construct the complete URL
  url <- paste0(base_url, "?variables=", URLencode(variables))
  
  # Set up headers
  
  
  # Make the GET request
  response <- GET(url, add_headers(.headers = headers))
  
  # Check the response
  res <- content(response, "parsed")
  
  fin <- res %>% flatten_dfr() 
  
  return(fin)
  
}


cntrylist <- countrycode::codelist_panel %>% 
  distinct(country.name.en) %>% 
  pull(1)


get_cntries2 <- possibly(get_cntries, quiet = F, otherwise = NULL)

cntr_dat <- cntrylist %>% 
  map_dfr_progress(get_cntries2)


cntr_dat %>% 
  distinct(api_targeting_value, .keep_all = T) %>% View()


saveRDS(cntr_dat, "data/cntr_dat.rds")


get_audience_estimates <- function(dat, keywords = "white supremacy") {
  
  url <- "https://ads-api.twitter.com/11/accounts/18ce54mmuxp/audience_estimate"
  
  # Set up headers
  headers <- c(
    "accept" = "*/*",
    "accept-language" = "en-US,en;q=0.9,de-DE;q=0.8,de;q=0.7,nl;q=0.6",
    "authorization" = "Bearer AAAAAAAAAAAAAAAAAAAAANBSYwEAAAAAOlt9bKS2BoTpbL%2FSNHNmN0ejfBc%3DVFV0ENqnQ927hPgNRQsihKOMwPfpPeO8Ds9toqkIMqj6PIj8dn",
    "content-type" = "application/json; charset=UTF-8",
    "sec-ch-ua" = "\"Not_A Brand\";v=\"8\", \"Chromium\";v=\"120\", \"Google Chrome\";v=\"120\"",
    "sec-ch-ua-mobile" = "?0",
    "sec-ch-ua-platform" = "\"Windows\"",
    "sec-fetch-dest" = "empty",
    "sec-fetch-mode" = "cors",
    "sec-fetch-site" = "same-site",
    `cookie` = "kdt=Cg6xJf0dORfZVAFf24VjwW3mBuEEq5e6eM45L95G; d_prefs=MToxLGNvbnNlbnRfdmVyc2lvbjoyLHRleHRfdmVyc2lvbjoxMDAw; guest_id_ads=v1%^3A169969500394127472; guest_id_marketing=v1%^3A169969500394127472; _ga=GA1.2.1647771903.1699704178; twtr_pixel_opt_in=Y; dnt=1; ads_prefs=^\"HBESAAA=^\"; auth_multi=^\"1410272146027433995:0a51e2017741c926ac7a39573b83e65d68d31b8c^\"; auth_token=8f1d872ff022e98369bb4f79586f35132ab40d11; twid=u%^3D513351911; personalization_id=^\"v1_AQAcnmtsMhDlagProOx9PQ==^\"; guest_id=v1%^3A170161405145688214; ct0=835c4264b1ca9caa004d55f3f50cbe31c483e81955f71ec5199c82792ea93789b3957ef102c00e116220a3def31378ebbd83735e139209c87b76c70475cfefbb4776a50be043bf1976f49dc8fe803436; external_referer=padhuUp37zjgzgv1mFWxJ12Ozwit7owX|0|8e8t2xd8A2w%^3D; _gid=GA1.2.1183446291.1702542797",
    "x-csrf-token" = "835c4264b1ca9caa004d55f3f50cbe31c483e81955f71ec5199c82792ea93789b3957ef102c00e116220a3def31378ebbd83735e139209c87b76c70475cfefbb4776a50be043bf1976f49dc8fe803436",
    "x-origin-environment" = "production"
  )
  
  targeting_criteria <- list(
    list(targeting_type = "LOCATION", targeting_value = dat$api_targeting_value)
  )
  
  # Add broad keyword criteria
  for (kw in keywords) {
    targeting_criteria <- c(targeting_criteria, list(list(targeting_type = "BROAD_KEYWORD", targeting_value = kw, operator_type = "EQ")))
  }
  
  body <- toJSON(list(targeting_criteria = targeting_criteria), auto_unbox = TRUE, pretty = TRUE)
  
  
  # Define the body
  # body <- paste0("{\"targeting_criteria\":[{\"targeting_type\":\"LOCATION\",\"targeting_value\":\"", dat$api_targeting_value, "\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"", keyword, "\",\"operator_type\": \"EQ\"}]}")
  # body <- "{\"targeting_criteria\":[{\"targeting_type\":\"LOCATION\",\"targeting_value\":\"fdcd221ac44fa326\"}]}"
  # body <- paste0("{\"targeting_criteria\":[{\"targeting_type\":\"LOCATION\",\"targeting_value\":\"", dat$api_targeting_value, "\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white pride\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"alex jones\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"dancing israelis\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"kalergi plan\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"george soros\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"adrenochrome\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#georgesoros\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"send them back\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"ethnonationalism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race realism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race realist\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"nwo\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothschilds\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothchilds\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothschild\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"sendthemback\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"globalists\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#nwo\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rotschild\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#newworldorder\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"cabal\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"globalist\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothchild\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"globalism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#agenda2030\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"depopulation\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"agenda2030\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#globalists\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"soros\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#globalist\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"illuminati\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#racerealism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white supremacy\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"national socialism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"jared taylor\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"dysgenic\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"european race\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white race\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white genocide\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"flat earth\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"the great replacement\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white nationalism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white separatists\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"jewish supremacy\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race is real\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race determinism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"Fresh&Fit\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"stop immigration\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"transtrender\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"fuck jews\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"fuck gay people\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"no trannies\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"we wuz kingz\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"fuck gays\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"bilderberger\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"racial iq differences\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"pinochet\"}]}")

  # body <- paste0("{\"targeting_criteria\":[{\"targeting_type\":\"LOCATION\",\"targeting_value\":\"", dat$api_targeting_value, "\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white pride\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"alex jones\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"dancing israelis\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"kalergi plan\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"george soros\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"adrenochrome\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#georgesoros\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"send them back\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"ethnonationalism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race realism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race realist\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"nwo\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothschilds\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothchilds\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothschild\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"sendthemback\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"globalists\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#nwo\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rotschild\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#newworldorder\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"cabal\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"globalist\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"rothchild\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"globalism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#agenda2030\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"depopulation\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"agenda2030\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#globalists\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"soros\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#globalist\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"illuminati\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"#racerealism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white supremacy\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"national socialism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"jared taylor\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"dysgenic\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"european race\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white race\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white genocide\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"flat earth\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"the great replacement\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white nationalism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"white separatists\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"jewish supremacy\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race is real\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"race determinism\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"Fresh&Fit\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"stop immigration\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"transtrender\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"fuck jews\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"fuck gay people\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"no trannies\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"we wuz kingz\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"fuck gays\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"bilderberger\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"racial iq differences\"},{\"targeting_type\":\"BROAD_KEYWORD\",\"targeting_value\":\"pinochet\"]}")
  
  
  # body
  
  # Make the request
  response <- POST(url, add_headers(.headers = headers), body = body, encode = "json")
  
  # Check the response
  res <- content(response, "parsed")
  
  if(!is.null(res$errors)){
    return(tibble(error_message = res$errors[[1]]$code, cntry = dat$label))
  }
  
  
  
  fin <- res %>% pluck("data") %>% flatten_dfr() %>% mutate(cntry = dat$label)
  
  return(fin)
  
}

# debugonce(get_audience_estimates)

get_audience_estimates2 <- possibly(get_audience_estimates, quiet = F, otherwise = NULL)

cntr_dat <- readRDS("data/cntr_dat.rds")

wsdat <- cntr_dat %>% 
  filter(str_detect(rich_label, "Country")) %>% 
  distinct(api_targeting_value, .keep_all = T) %>% 
  # slice(10) %>% 
  # filter(str_detect(label, "United States")) %>% 
  split(1:nrow(.)) %>% 
  map_dfr_progress(get_audience_estimates2)


saveRDS(wsdat, "data/wsdat.rds")


wefdat <- cntr_dat %>% 
  filter(str_detect(rich_label, "Country")) %>% 
  distinct(api_targeting_value, .keep_all = T) %>% 
  # slice(10) %>% 
  # filter(str_detect(label, "United States")) %>%
  split(1:nrow(.)) %>% 
  map_dfr_progress(get_audience_estimates2, "WEF")


saveRDS(wefdat, "data/wefdat.rds")



library(rvest)
library(tidyverse)
this <- read_html("https://en.wikipedia.org/wiki/List_of_cities_and_towns_in_Germany") %>% 
  html_table() %>% 
  bind_rows()

glimpse(this)


german_cities <- read_html("https://en.wikipedia.org/wiki/List_of_cities_and_towns_in_Germany") %>% 
  html_nodes("table") %>% 
  html_children() %>% 
  html_children() %>% 
  html_children() %>% 
  html_children() %>% 
  .[str_detect(., "/wiki/")] %>% 
  html_children() %>% 
  html_text()


german_cities[10]

get_cntries2 <- possibly(get_cntries, quiet = F, otherwise = NULL)

city_dat <- german_cities %>% 
  .[1:10] %>% 
  map_dfr_progress(get_cntries2)



library(jsonlite)

# Example data
dat <- data.frame(api_targeting_value = "9ac7aa903ba29bd1")
keywords <- c("white pride", "alex jones", "dancing israelis", "kalergi plan", "white power",
              "george soros", "adrenochrome", "#georgesoros", "send them back", 
              "ethnonationalism", "race realism", "race realist", "nwo", "rothschilds", 
              "rothchilds", "rothschild", "sendthemback", "globalists", "#nwo", "rotschild", 
              "#newworldorder", "cabal", "globalist", "rothchild", "globalism", 
              "#agenda2030", "depopulation", "agenda2030", "#globalists", "soros", 
              "#globalist", "illuminati", "#racerealism", "white supremacy", 
              "national socialism", "jared taylor", "dysgenic", "european race",
              "white race", "white genocide", "flat earth", "the great replacement", 
              "white nationalism", "white separatists", "jewish supremacy", "race is real",
              "race determinism", "Fresh&Fit", "stop immigration", "transtrender",
              "fuck jews", "fuck gay people", "no trannies", "we wuz kingz", "fuck gays",
              "bilderberger", "racial iq differences", "pinochet")
# Creating the list
# Create the location targeting criteria

# Print the JSON string
cat(body)

cntr_dat



wsdat2 <- cntr_dat %>% 
  filter(str_detect(rich_label, "Country")) %>% 
  distinct(api_targeting_value, .keep_all = T) %>% 
  # slice(10) %>% 
  filter(str_detect(label, "United States")) %>%
  split(1:nrow(.)) %>% 
  map_dfr_progress(get_audience_estimates2)

get_cntries2 <- possibly(get_cntries, quiet = F, otherwise = NULL)

american_states <- c(
  "Alabama", "Alaska", "Arizona", "Arkansas", "California", 
  "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", 
  "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", 
  "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", 
  "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", 
  "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", 
  "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", 
  "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", 
  "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", 
  "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
)


states_dat <- american_states %>% 
  map_dfr_progress(get_cntries2)

state_audiences <- states_dat %>% 
  filter(str_detect(rich_label, "Region or state")) %>% 
  distinct(api_targeting_value, .keep_all = T)  %>% 
  # slice(10) %>% 
  # filter(str_detect(label, "United States")) %>%
  split(1:nrow(.)) %>% 
  map_dfr_progress(get_audience_estimates2, keywords)


radicals <- state_audiences %>% 
  left_join(states_dat %>% 
              filter(str_detect(rich_label, "Region or state")) %>% 
              distinct(api_targeting_value, .keep_all = T) %>% rename(cntry = label)) %>% 
  mutate(perc = max/audience_size*100)  %>% 
  mutate(perc = ifelse(is.na(perc), 0, perc)) 


read_csv("https://raw.githubusercontent.com/fivethirtyeight/election-results/main/election_results_presidential.csv") %>% 
  drop_na(state) %>% 
  filter(cycle == "2020") %>% 
  filter(candidate_name == "Donald Trump") %>% 
  filter(stage == "general") %>% 
  mutate(state = str_remove_all(state, " CD-*?")) %>% 
  mutate(state = str_remove_all(state, "-[:digit:]") %>% str_trim() %>% str_squish())  %>%
  distinct(state, .keep_all = T) %>% 
  group_by(state) %>%
  summarize(percent = mean(as.numeric(percent))) %>%
  ungroup() %>% 
  left_join(radicals %>% rename(state = cntry))%>% #View() 
  filter(perc != 0) %>% 
  ggplot(aes(percent, perc)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ggpubr::stat_cor(label.x.npc = "center") +
  labs(y = "share of radical people on X per state", x  = "Trump Vote Share 2020") +
  ggrepel::geom_text_repel(aes(label = state)) +
  theme_minimal()
  # View()
