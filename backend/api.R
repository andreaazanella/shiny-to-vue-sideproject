# api.R — Endpoint Plumber, espone la logica via HTTP

library(plumber)
source("logic.R")

#* @apiTitle Mini-Project API
#* @apiDescription Shiny default app migrata a Plumber + Vue.js

#* Abilita CORS
#* @filter cors
function(req, res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
  res$setHeader("Access-Control-Allow-Headers", "Content-Type")
  
  if (req$REQUEST_METHOD == "OPTIONS") {
    res$status <- 200
    return(list())
  }
  
  plumber::forward()
}

#* Restituisce i dati per l'istogramma
#* @param bins Numero di colonne (default: 30)
#* @serializer json
#* @get /histogram
function(bins = 30) {
  bins <- as.integer(bins)
  
  # Validazione input
  if (is.na(bins) || bins < 1 || bins > 50) {
    stop("Il parametro 'bins' deve essere un valore intero compreso tra tra 1 e 50.")
  }
  
  get_histogram_data(bins)
}