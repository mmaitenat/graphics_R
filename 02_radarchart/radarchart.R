# Install if necessary
if(!require("NutrienTrackeR")) remotes::install_github("AndreaRMICL/NutrienTrackeR")
if(!require("radarchart")) remotes::install_github("MangoTheCat/radarchart")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("RColorBrewer")) install.packages("RColorBrewer")

library(tidyverse)
library(NutrienTrackeR)
library(radarchart)
library(RColorBrewer)

# We will be using BEDCA database, i.e. Spanish Food Composition Database
# Note that composition is presented per 100 g edible portion
BEDCA_dataset <- food_composition_data$BEDCA %>%
  as_tibble()
  
# Obtain data for some of the most common cereals
# Note that for obtaining the list of foods, it is recommended to check the list of available food names, e.g.
findFoodName(keywords = "Rice", food_database = "BEDCA")
# We obtain the exact foodnames with the search for the desired foods
cereals <- c("Wheat, whole, raw", "Rice", "Oat, raw", "Rye, raw", "Barley, raw", "Millet")
# See available nutrient names
getNutrientNames(food_database = "BEDCA")
nutrient_names <- c("Carbohydrate, by difference (g)", 
                    "Fiber, total dietary (g)", 
                    "Protein (g)", 
                    "Total lipid (fat) (g)", 
                    "Vitamin A, RAE (ug)", "Vitamin D (D2 + D3) (ug)", "Vitamin E (alpha-tocopherol) (mg)", "Folate, DFE (ug)", "Niacin (mg)", "Riboflavin (mg)", "Thiamin (mg)", "Vitamin B-12 (ug)", "Vitamin B-6 (mg)", "Vitamin C, total ascorbic acid (mg)", 
                    "Calcium, Ca (mg)", "Iron, Fe (mg)", "Potassium, K (mg)", "Magnesium, Mg (mg)", "Sodium, Na (mg)", "Phosphorus, P (mg)", "Iodine (ug)", "Selenium, Se (ug)", "Zinc, Zn (mg)")
cereal_dataset <- BEDCA_dataset %>%
  filter(food_name %in% cereals) %>%
  select(all_of(c("food_name", nutrient_names)))

# Tidy dataset: change types, clean name and normalize mass units.
# Composition lays on different scales for each macronutrient and thus plotting all in the same scale can mask some of the nutrients
# Hence we will normalize the values of each macronutrient by dividing by max nutrient value in the dataset

cereal_dataset %>%
  mutate_at(nutrient_names, as.numeric) %>%
  mutate_at(vars(contains("(mg)")), ~(.*10**(-3))) %>%
  mutate_at(vars(contains("(ug)")), ~(.*10**(-6))) %>%
  mutate(Vitamin = rowSums(.[6:15]),
         Mineral = rowSums(.[16:ncol(cereal_dataset)])) %>%
  rename(Carbohydrate = `Carbohydrate, by difference (g)`,
         Fiber = `Fiber, total dietary (g)`,
         Protein = `Protein (g)`,
         Lipid =  `Total lipid (fat) (g)`) %>%
  select(food_name, Carbohydrate, Fiber, Protein, Lipid, Vitamin, Mineral) %>%
  mutate_if(is.numeric, ~(./max(.))) -> tidy_cereal_dataset

# Plot
# For using the chartJSRadar we need to transpose the tibble
cereal_dataset_toplot <- t(select(tidy_cereal_dataset, -food_name))
cereal_dataset_toplot <- data.frame(rownames(cereal_dataset_toplot), cereal_dataset_toplot)
colnames(cereal_dataset_toplot) <- c("nutrient", tidy_cereal_dataset$food_name)

color_pal <- brewer.pal(length(cereals), "Set2")
chartJSRadar(scores = cereal_dataset_toplot,
             colMatrix = col2rgb(color_pal))




