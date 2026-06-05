# shiny-to-vue

Dimostrazione pratica di migrazione da **R Shiny** a un'architettura disaccoppiata **R + Plumber + Vue.js**.

Realizzato come mini-progetto preliminare alla tesi triennale in Ingegneria Informatica presso l'Università di Padova (IN0508).

---

## Il problema

R Shiny è un framework potente per creare applicazioni data-driven, ma accoppia fortemente logica di calcolo e interfaccia utente nello stesso codice R. Questo rende difficile:

- modificare l'interfaccia senza toccare la logica
- esporre i dati ad altri sistemi
- adottare strumenti frontend moderni e personalizzabili

## La soluzione

Separare le responsabilità in livelli indipendenti:
Vue.js  ←→  Plumber (REST API)  ←→  Logica R  ←→  Dati

Il backend R si occupa esclusivamente del calcolo.
Il frontend Vue si occupa esclusivamente della visualizzazione.
Comunicano tramite HTTP con dati JSON.

## Struttura del repository

```txt
shiny-to-vue/
├── backend/
│   ├── .Rhistory    ← comandi per eseguire codice in R con RStudio
│   ├── app.R        ← app di partenza (https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/)
│   ├── logic.R      ← calcolo puro, indipendente da tutto
│   └── api.R        ← endpoint Plumber
├── frontend/
│   └── src/
│       ├── App.vue                  
│       ├── main.js                
│       ├── style.css  
│       ├── assets/         
│       │   ├── background.png       
│       │   └── shiny-logo.svg         
│       ├── components/
│       │   ├── BinsSlider.vue       ← slider interattivo
│       │   └── Histogram.vue        ← grafico SVG (senza usare librerie o pacchetti)
│       └── services/
│           └── api.js               ← chiamate HTTP
├── docs/
│   └── screenshots/
│       ├── s01.png  
│       └── s02.png  
├── architecture.md  ← spiegazione delle scelte architetturali
└── api-spec.md      ← documentazione degli endpoint
```

## Avvio in sviluppo

### Prerequisiti

- R + RStudio con pacchetto `plumber` installato
- Node.js

### Backend
Apri RStudio ed esegui nella console:

```r
install.packages("plumber")   # solo la prima volta

setwd("path/to/shiny-to-vue/backend")
library(plumber)
pr <- plumb("api.R")
pr$run(port = 8000)
```

### Frontend

```bash
cd frontend
npm install        # solo la prima volta
npm run dev
```

L'app è disponibile su `http://localhost:5173`.
Il backend deve essere in esecuzione su `http://localhost:8000`.
