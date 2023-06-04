library("tidyverse")
library("lubridate")
library("gapminder")
library("highcharter")
library("glue")

gapminder_continents <- gapminder %>%
  group_by(year, continent) %>%
  summarise_if(is.numeric, funs(round(sum(as.numeric(.))))) %>%
  ungroup() %>%
  mutate(year = ymd(glue("{year}-12-31")))
  
highchart(type = "stock") %>%
  hc_add_series(data = gapminder_continents,
                type = "line",
                hcaes(x = year,
                      y = pop,
                      group = continent)) %>%
  hc_plotOptions(series = list(marker = list(enabled = TRUE))) %>%
  hc_tooltip(xDateFormat = "%Y") %>%
  hc_legend(enabled = TRUE, reverse = TRUE) %>%
  hc_title(text = "Mean continental population growth over time",
           subtitle = "Source: Gapminder") %>%
  hc_subtitle(text = "Source: Gapminder")
