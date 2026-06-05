<template>
  <div class="app">
  <img src="./assets/background.png" class="bg-texture" alt="" draggable="false" />
  
    <!-- DIV 1: Header centrale, senza bordi -->
    <header class="card-header">
      <h1>Hello Vue!</h1>
      <div class="subtitle">
        <span class="subtitle-text">migrato da</span>
        <span class="shiny-badge">
          <img src="./assets/shiny-logo.svg" alt="Shiny logo"/>
        </span>
      </div>
    </header>

    <!-- Riga inferiore: slider + istogramma -->
    <div class="bottom-row">

      <!-- DIV 2: Slider -->
      <div class="card card-slider">
        <p class="card-label">Numero di intervalli</p>
        <hr class="card-divider" />
        <p class="bins-number">{{ bins }}</p>

        <BinsSlider v-model="bins" />

        <div class="slider-note">
          <span class="material-symbols-outlined">info</span>
          <span>Aggiusta il numero di intervalli</span>
        </div>
      </div>

      <!-- DIV 3: Istogramma -->
      <div class="card card-histogram">
        <p class="card-label">Istogramma tempi di attesa</p>
        <hr class="card-divider" />

        <div v-if="error" class="status error">Errore: {{ error }}</div>
        <Histogram
          v-else-if="histData"
          :data="histData"
          :class="{ 'is-loading': loading }"
        />
</div>

    </div>
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

onMounted(loadData)
watch(bins, loadData)
</script>