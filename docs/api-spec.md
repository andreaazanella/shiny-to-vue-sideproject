# API Specification

Base URL (sviluppo): `http://localhost:8000`

---

## GET /histogram

Restituisce i dati necessari per disegnare un istogramma dei tempi di attesa
del geyser Old Faithful (dataset `faithful` incluso in R).

### Esempio di richiesta

GET /histogram?bins=10

### Esempio di risposta

{
  "counts": [4, 3, 10, 15, 7, 4, 13, 26, 18, 8],
  "breaks": [43.0, 48.3, 53.6, 58.9, 64.2, 69.5, 74.8, 80.1, 85.4, 90.7, 96.0],
  "mids":   [45.65, 50.95, 56.25, 61.55, 66.85, 72.15, 77.45, 82.75, 88.05, 93.35],
  "xlab":   "Waiting time to next eruption (in mins)",
  "title":  "Histogram of waiting times"
}