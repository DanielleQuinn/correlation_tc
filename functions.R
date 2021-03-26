rawTable <- function(results) {
  results$interest_over_time %>%
    select(date, keyword, hits) %>%
    complete(date, keyword, fill = list(hits = 0)) %>%
    mutate(date = date(date),
           hits = replace_na(as.numeric(hits), 0),
           keyword = str_replace_all(keyword, " ", "_")) %>%
    pivot_wider(names_from = keyword,
                values_from = hits) %>%
    View()
}

overtime <- function(results) {
  suppressWarnings({
    df <- results$interest_over_time %>%
      select(date, keyword, hits) %>%
      complete(date, keyword, fill = list(hits = 0)) %>%
      mutate(date = date(date),
             hits = replace_na(as.numeric(hits), 0),
             keyword = str_replace_all(keyword, " ", "_"))
  })
  return(ggplot(df, aes(x = date, y = hits, col = keyword)) +
           geom_point(size = 0.5) +
           geom_line() +
           xlab("Date") +
           ylab("Count") +
           theme_bw(12))
}

scaled_overtime <- function(results) {
  suppressWarnings({
    df <- results$interest_over_time %>%
      select(date, keyword, hits) %>%
      complete(date, keyword, fill = list(hits = 0)) %>%
      mutate(date = date(date),
             hits = replace_na(as.numeric(hits), 0),
             keyword = str_replace_all(keyword, " ", "_")) %>%
      group_by(keyword) %>%
      mutate(hits_scaled = scales::rescale(hits, to = c(0, 100)))
  })
  return(ggplot(df, aes(x = date, y = hits_scaled, col = keyword)) +
           geom_point(size = 0.5) +
           geom_line() +
           xlab("Date") +
           ylab("Count") +
           theme_bw(12))
}

compare <- function(results) {
  suppressWarnings({
    df <- results$interest_over_time %>%
      select(date, keyword, hits) %>%
      complete(date, keyword, fill = list(hits = 0)) %>%
      mutate(date = date(date),
             hits = replace_na(as.numeric(hits), 0),
             keyword = str_replace_all(keyword, " ", "_")) %>%
      pivot_wider(names_from = keyword,
                  values_from = hits)
  })
return(ggplot(df, aes_string(x = names(df)[2], y = names(df)[3])) +
        geom_point(alpha = 0.5, col = "purple") +
        geom_smooth(method = "lm", se = FALSE, col = "black") +
        xlab(myWords[1]) +
        ylab(myWords[2]) +
        theme_bw(12))
}

correlation <- function(results) {
  suppressWarnings({
  df <- results$interest_over_time %>%
    select(date, keyword, hits) %>%
    complete(date, keyword, fill = list(hits = 0)) %>%
    mutate(date = date(date),
           hits = replace_na(as.numeric(hits), 0),
           keyword = str_replace_all(keyword, " ", "_")) %>%
    pivot_wider(names_from = keyword,
                values_from = hits)
  cor(df[,2], df[,3])
  })
}
