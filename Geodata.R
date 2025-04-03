library(ggplot2)
library(dplyr)
library(readxl)
library(tidyr)

# compare to merediths dataset 
waar_data <- read_excel("WAAR+Project+Dataset+v1.0 (2).xlsx")
columns <- c("sideb", "sideb_full", "country_primary", "frontline", "location", "frontline_binary_2")
waar_data <- waar_data[, columns]
myanmar_waar <- waar_data[waar_data$country_primary == "Myanmar (Burma)", ]
# View(myanmar_waar)

# Filter out NA values and empty strings, split the locations by commas and unnest them
split_locations <- myanmar_waar %>%
  filter(location != "NA" & location != "") %>%
  separate_rows(location, sep = ", ") %>%
  mutate(location = trimws(location)) %>%  # Remove leading/trailing whitespaces
  distinct(location)
# Print unique regions to check
print(split_locations)

# Group by location and count the number of unique groups for each frontline status
grouped_data <- myanmar_waar %>%
  filter(location != "NA" & location != "") %>%
  separate_rows(location, sep = ", ") %>%
  mutate(location = trimws(location)) %>%  # Remove leading/trailing whitespaces
  distinct(sideb, location, frontline) %>%
  group_by(location, frontline) %>%
  summarise(num_groups = n_distinct(sideb)) %>%
  ungroup()

print(grouped_data)

# Summarize the data to get the total number of groups for each region, ignoring frontline status
total_groups <- grouped_data %>%
  group_by(location) %>%
  summarise(num_groups = sum(num_groups))

# Plot the stacked bar chart
ggplot(total_groups, aes(x = location, y = num_groups)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(x = "Region", y = "Number of Groups", title = "Total Number of Groups in each Region") +
  scale_y_continuous(breaks = seq(0, max(total_groups$num_groups), by = 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Calculate the number of groups with women in each region
women_groups <- grouped_data %>%
  filter(frontline == 1) %>%
  select(location, num_groups)

# Merge total groups and women groups data
merged_data <- merge(total_groups, women_groups, by = "location", all.x = TRUE)

# Fill NA values with 0
merged_data[is.na(merged_data)] <- 0

# Plot the stacked bar chart
ggplot(merged_data, aes(x = location)) +
  geom_bar(aes(y = num_groups.x), stat = "identity", fill = "blue") +
  geom_bar(aes(y = num_groups.y), stat = "identity", fill = "pink") +
  labs(x = "Region", y = "Armed Groups", title = "Frontline Distribution") +
  scale_y_continuous(breaks = seq(0, max(merged_data$num_groups.x, merged_data$num_groups.y), by = 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("blue", "pink"), name = "Frontline Status", labels = c("No Women", "With Women"))

# plot binary_2
# Group by location and count the number of unique groups for each frontline_binary_2 status
grouped_data <- myanmar_waar %>%
  filter(location != "NA" & location != "") %>%
  separate_rows(location, sep = ", ") %>%
  mutate(location = trimws(location)) %>%
  distinct(sideb, location, frontline_binary_2) %>%
  group_by(location, frontline_binary_2) %>%
  summarise(num_groups = n_distinct(sideb)) %>%
  ungroup()
print(grouped_data)

# Summarize the data to get the total number of groups for each region, ignoring frontline_binary_2 status
total_groups <- grouped_data %>%
  group_by(location) %>%
  summarise(num_groups = sum(num_groups))

# Calculate the number of groups with frontline_binary_2 == 1 in each region
frontline_groups <- grouped_data %>%
  filter(frontline_binary_2 == 1) %>%
  select(location, num_groups)

# Merge total groups and frontline groups data
merged_data <- merge(total_groups, frontline_groups, by = "location", all.x = TRUE)
# Rename columns for clarity
colnames(merged_data) <- c("location", "total_groups", "frontline_groups")
# Fill NA values with 0
merged_data[is.na(merged_data)] <- 0

# Plot the stacked bar chart
ggplot(merged_data, aes(x = location)) +
  geom_bar(aes(y = total_groups), stat = "identity", fill = "blue") +
  geom_bar(aes(y = frontline_groups), stat = "identity", fill = "pink") +
  labs(x = "Region", y = "Number of Groups", title = "Total Number of Groups in each Region (Frontline Binary 2)") +
  scale_y_continuous(breaks = seq(0, max(merged_data$total_groups, merged_data$frontline_groups), by = 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("blue", "pink"), name = "Frontline Status", labels = c("Total Groups", "Groups with Frontline Binary 2 == 1"))


merged_data


waar_data <- read_excel("WAAR+Project+Dataset+v1.0 (2).xlsx")
# columns <- c("sideb", "sideb_full", "country_primary", "frontline", "location", "frontline_binary_2")
# waar_data <- waar_data[, columns]
myanmar_waar <- waar_data[waar_data$country_primary == "Myanmar (Burma)", ]

myanmar_waar %>% 
  janitor::clean_names() %>% 
  glimpse() %>% 
  select(sideb, sideb_full, frontline_binary_2, ethnic_group, location, alliances )  %>% 
  count(frontline_binary_2,
        ethnic_group) %>% 
  group_by(ethnic_group) %>% 
  mutate(perc = n/sum(n)) %>% 
  ungroup() %>% 
  mutate(ethnic_group = fct_reorder(ethnic_group, n, .fun = sum)) %>% 
  mutate(frontline_binary_2 = as.character(frontline_binary_2)) %>% 
  ggplot(aes(ethnic_group, n, fill = frontline_binary_2)) +
  geom_col(position = position_stack()) +
  coord_flip()



myanmar_waar %>% 
  janitor::clean_names() %>% 
  glimpse() %>% 
  select(sideb, sideb_full, frontline_prev_best, ethnic_group, location, alliances )  %>% 
  # group_by(ethnic_group) %>% 
  # mutate(frontline_prev_best = mean(frontline_prev_best, na.rm = T)) %>% 
  # ungroup() %>% View()
  # mutate(ethnic_group = fct_reorder(ethnic_group, frontline_prev_best)) %>% 
  ggplot(aes(ethnic_group, frontline_prev_best)) +
  geom_boxplot() +
  # geom_point() +
  ggrepel::geom_text_repel(aes(label = sideb)) +
  coord_flip()

myanmar_waar %>% 
  janitor::clean_names() %>% 
  # glimpse() %>% 
  separate_rows(alliances, sep = ",") %>% 
  mutate(alliances = str_trim(alliances)) %>% 
  widyr::pairwise_count(sideb, alliances) %>% 
  glimpse() %>% 
  ggplot(aes(item1, n)) +
  geom_col() +
  facet_wrap(~item2, scales = "free") +
  coord_flip()


myanmar_waar %>% 
  janitor::clean_names() %>% 
  glimpse() %>% 
  select(sideb, sideb_full, frontline_binary_2, location, location, alliances )  %>% 
  count(frontline_binary_2,
        location) %>% 
  group_by(frontline_binary_2) %>% 
  mutate(perc = n/sum(n)) %>% 
  mutate(frontline_binary_2 = as.character(frontline_binary_2)) %>% 
  mutate(location = fct_reorder(location, n, .fun = sum)) %>% 
  ggplot(aes(location, n, fill = frontline_binary_2)) +
  geom_col(position = position_stack()) +
  coord_flip()
  

myanmar_waar %>%
  filter(location != "NA" & location != "") %>%
  separate_rows(location, sep = ", ") %>%
  mutate(location = trimws(location)) %>%
  distinct(sideb, location, frontline_binary_2) %>%
  group_by(location, frontline_binary_2) %>%
  summarise(num_groups = n_distinct(sideb)) %>%
  ungroup()





