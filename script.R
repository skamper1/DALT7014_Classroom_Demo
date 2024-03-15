source("require_packages.R")
require_packages(c(
  "xml2",
  "httr",
  "dplyr",
  "readr"
))


# HTTP GET Request
a <- GET("https://www.officialcharts.com/charts/uk-top-40-singles-chart/")

html_doc <- read_html(rawToChar(a$content))

top <- xml_find_all(html_doc, ".//div[@class=\"primis chart-item relative text-right\"]")

top39 <- xml_find_all(html_doc, ".//div[@class=\"chart-item relative text-right\"]")

top_spans <- xml_find_all(top, ".//span")

select_song_and_artist <- function(node){
  spans <- xml_find_all(node, ".//span")
  song <- xml_text(spans[4])
  artist <- xml_text(spans[5])
  return(tibble(song = song, artist = artist))
}

top_row <- select_song_and_artist(top)

top39_rows <- lapply(top39, select_song_and_artist)

top40 <- bind_rows(top_row, top39_rows) %>% mutate(position = 1:n()) %>% select(position, song, artist)


top40 |> write_csv(format(Sys.Date(), "%Y-Week-%V.csv"))

writeLines(format(Sys.time()), "timestamp.txt") # Added to make sure there is always a change to commit
