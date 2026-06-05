# Architettura del Progetto

## Punto di partenza: l'app Shiny

Il progetto nasce dall'analisi di un'applicazione R Shiny — il caso più semplice
possibile: uno slider che controlla il numero di barre di un istogramma.

In Shiny, tutte le responsabilità vivono in un unico file `app.R`:


# Dati, calcolo e visualizzazione (tutto insieme ed accorpato)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#007bc2")
  })
}

Questo approccio funziona per prototipi e analisi dati, ma presenta limiti
strutturali evidenti:

- la logica di calcolo non è riutilizzabile al di fuori di Shiny
- l'interfaccia utente non può essere modificata senza toccare il codice R
- l'applicazione non è accessibile da altri sistemi via HTTP

## Flusso di una interazione

1. L'utente muove lo slider nel browser
2. `BinsSlider.vue` emette un evento con il nuovo valore
3. `App.vue` riceve il valore e chiama `fetchHistogramData(bins)`
4. `api.js` esegue una richiesta `GET /histogram?bins=N` via Axios
5. Plumber riceve la richiesta e chiama `get_histogram_data(N)`
6. `logic.R` calcola breaks, counts e mids sui dati `faithful$waiting`
7. Plumber serializza il risultato in JSON e lo restituisce
8. `App.vue` aggiorna `histData` con i nuovi dati
9. `Histogram.vue` riceve i dati via prop e ridisegna l'SVG