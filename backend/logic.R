# logic.R — Logica semplice in R, indipendente da Shiny

get_histogram_data <- function(bins = 30) {
  x <- faithful$waiting
  
  # Calcola i breaks (linea 37 codice Shiny)
  breaks <- seq(min(x), max(x), length.out = bins + 1)
  
  # Calcola le frequenze con hist() ma senza disegnarle (plot = FALSE)
  h <- hist(x, breaks = breaks, plot = FALSE)
  
  # Restituisce una lista con tutti i dati che mi serviranno per Vue.js
  list(
    counts    = h$counts,       # altezza di ogni barra
    breaks    = h$breaks,       # bordi di ogni barra
    mids      = h$mids,         # centro di ogni barra
    xlab      = "Waiting time to next eruption (in mins)",
    title     = "Histogram of waiting times"
  )
}