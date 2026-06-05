<template>
  <div class="app">
    <h1>Hello Vue! <span>(migrato da Shiny)</span></h1>

    <BinsSlider v-model="bins" />

    <div v-if="loading" class="status">Caricamento...</div>
    <div v-else-if="error" class="status error">Errore: {{ error }}</div>
    
    <Histogram v-else-if="histData" :data="histData" />
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import BinsSlider from './components/BinsSlider.vue'
import Histogram from './components/Histogram.vue'
import { fetchHistogramData } from './services/api.js'

const bins = ref(30)
const histData = ref(null)
const loading = ref(false)
const error = ref(null)

async function loadData() {
  loading.value = true
  error.value = null
  try {
    histData.value = await fetchHistogramData(bins.value)
  } catch (e) {
    error.value = e.message
  } finally {
    loading.value = false
  }
}

// Carica i dati all'avvio
onMounted(loadData)

// Ricarica ogni volta che bins cambia
watch(bins, loadData)
</script>

<style>
body {
  font-family: sans-serif;
  background: #f5f5f5;
  margin: 0;
}

.app {
  max-width: 700px;
  margin: 40px auto;
  background: white;
  padding: 32px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.1);
}

h1 { color: #007bc2; }
h1 span { font-size: 0.6em; color: #999; font-weight: normal; }
h2 { font-size: 1em; color: #333; margin-bottom: 8px; }

.slider-container { margin: 24px 0; }
.slider-container label { display: block; margin-bottom: 8px; }
input[type="range"] { width: 100%; }

.chart-container svg { width: 100%; height: auto; }

.status { padding: 20px; text-align: center; color: #666; }
.error { color: #c00; }
</style>