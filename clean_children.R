##install.packages("tidyverse")
library (tidyverse)
survey_october <- read_csv ("SurveyMonthly.2010_10.csv")
children_birthdays_october <- survey_october |>
  select(starts_with("ChildDOB", ignore.case = TRUE)) |>
  pivot_longer(
    cols = everything(),
    values_to = "DOB",
    names_to = "Child",
    values_drop_na = TRUE
  ) |>
  mutate (Child = str_remove(Child, "ChildDOB"))|>
  mutate (Child = str_remove (Child, ":")) |>  
  mutate (
    Family = cumsum(str_detect(Child, "Child1")))|>
  mutate(
    DOB = parse_date_time(
      DOB,
      orders = c("ymd", "dmy", "mdy", "Ymd", "dmY", "mdY")))|>
  mutate (
    Child = str_replace (Child, "Expecting", "0"))|>
  ## Expecting is coded as 0
  mutate (
    Child = str_remove_all(Child, "\\D")) |>
  select (Family, Child, DOB)
View(children_birthdays_october)