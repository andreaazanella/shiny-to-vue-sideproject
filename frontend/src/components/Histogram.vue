<template>
  <div class="chart-container">
    <h2>{{ data.title }}</h2>

    <svg :viewBox="`0 0 ${W} ${H}`" preserveAspectRatio="xMidYMid meet">

      <!-- Barre dell'istogramma -->
      <rect
        v-for="(count, i) in data.counts"
        :key="i"
        :x="xScale(data.breaks[i]) + 1"
        :y="yScale(count)"
        :width="barWidth(i) - 2"
        :height="H - PADDING_BOTTOM - yScale(count)"
        fill="#007bc2"
      />

      <!-- Asse X — linea di base -->
      <line
        :x1="PADDING_LEFT"
        :y1="H - PADDING_BOTTOM"
        :x2="W - PADDING_RIGHT"
        :y2="H - PADDING_BOTTOM"
        stroke="#333"
        stroke-width="1"
      />

      <!-- Etichette asse X (ogni 5 barre) -->
      <text
        v-for="(mid, i) in data.mids"
        :key="'label-' + i"
        v-show="i % 5 === 0"
        :x="xScale(mid)"
        :y="H - PADDING_BOTTOM + 18"
        text-anchor="middle"
        font-size="11"
        fill="#555"
      >
        {{ Math.round(mid) }}
      </text>

      <!-- Label asse X -->
      <text
        :x="W / 2"
        :y="H - 4"
        text-anchor="middle"
        font-size="12"
        fill="#333"
      >
        {{ data.xlab }}
      </text>

    </svg>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  data: {
    type: Object,
    required: true
  }
})

// Dimensioni SVG
const W = 600
const H = 380
const PADDING_LEFT = 40
const PADDING_RIGHT = 20
const PADDING_BOTTOM = 50
const PADDING_TOP = 20

// Scala X: mappa i valori reali (43–96) alle coordinate SVG
const xMin = computed(() => Math.min(...props.data.breaks))
const xMax = computed(() => Math.max(...props.data.breaks))
const yMax = computed(() => Math.max(...props.data.counts))

const xScale = computed(() => (value) => {
  const ratio = (value - xMin.value) / (xMax.value - xMin.value)
  return PADDING_LEFT + ratio * (W - PADDING_LEFT - PADDING_RIGHT)
})

const yScale = computed(() => (count) => {
  const ratio = count / yMax.value
  return PADDING_TOP + (1 - ratio) * (H - PADDING_TOP - PADDING_BOTTOM)
})

const barWidth = computed(() => (i) => {
  return xScale.value(props.data.breaks[i + 1]) - xScale.value(props.data.breaks[i])
})
</script>