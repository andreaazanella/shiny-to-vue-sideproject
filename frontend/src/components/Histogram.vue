<template>
  <div class="histogram-wrap">
    <svg :viewBox="`0 0 ${W} ${H}`" preserveAspectRatio="xMidYMid meet">

      <defs>
        <linearGradient id="barGradient" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0%" stop-color="#097751" />
          <stop offset="100%" stop-color="#004930" />
        </linearGradient>
      </defs>

      <!-- Etichetta asse X -->
      <text
        :x="PADDING_LEFT + (W - PADDING_LEFT - PADDING_RIGHT) / 2"
        :y="H -2"
        text-anchor="middle"
        font-size="11"
        fill="#097751"
      >
        Tempo di attesa alla prossima eruzione (in min)
      </text>

      <!-- Etichetta asse Y verticale -->
      <text
        :x="12"
        :y="(H - PADDING_BOTTOM + PADDING_TOP + 16) / 2"
        text-anchor="middle"
        dominant-baseline="middle"
        font-size="11"
        fill="#097751"
        transform="rotate(-90, 12, 160)"
      >
        Frequenza
      </text>

      <!-- Barre -->
      <rect
        v-for="(count, i) in data.counts"
        :key="i"
        :x="xScale(data.breaks[i]) + 1"
        :y="yScale(count)"
        :width="barWidth(i) - 2"
        :height="H - PADDING_BOTTOM - yScale(count)"
        fill="url(#barGradient)"
      />

      <!-- Asse X — linea di base -->
      <line
        :x1="PADDING_LEFT"
        :y1="H - PADDING_BOTTOM"
        :x2="W - PADDING_RIGHT"
        :y2="H - PADDING_BOTTOM"
        stroke="#004930"
        stroke-opacity="0.15"
        stroke-width="1.5"
      />

      <!-- Etichette asse X -->
      <text
        v-for="(mid, i) in data.mids"
        :key="'xlabel-' + i"
        v-show="i % 5 === 0"
        :x="xScale(mid)"
        :y="H - PADDING_BOTTOM + 18"
        text-anchor="middle"
        font-size="11"
        font-family="'Playfair Display', serif"
        fill="#004930"
      >
        {{ Math.round(mid) }}
      </text>
      
      <!-- Asse Y — linea laterale -->
      <line
        :x1="PADDING_LEFT"
        :y1="PADDING_TOP"
        :x2="PADDING_LEFT"
        :y2="H - PADDING_BOTTOM"
        stroke="#004930"
        stroke-opacity="0.15"
        stroke-width="1.5"
      />

      <!-- Etichette asse Y + linee guida -->
      <g v-for="tick in yTicks" :key="'ytick-' + tick">

        <!-- Linea guida orizzontale -->
        <line
          :x1="PADDING_LEFT"
          :y1="yScale(tick)"
          :x2="W - PADDING_RIGHT"
          :y2="yScale(tick)"
          stroke="#004930"
          stroke-opacity="0.06"
          stroke-width="1"
        />

        <!-- Etichetta -->
        <text
          :x="PADDING_LEFT - 8"
          :y="yScale(tick)"
          text-anchor="end"
          dominant-baseline="middle"
          font-size="11"
          font-family="'Playfair Display', serif"
          fill="#004930"
        >
          {{ tick }}
        </text>

      </g>

    </svg>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({ data: { type: Object, required: true } })

const W = 600
const H = 325
const PADDING_LEFT = 45   // più spazio per le etichette Y
const PADDING_RIGHT = 20
const PADDING_BOTTOM = 48
const PADDING_TOP = 16

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

// Genera 5 tick sull'asse Y, da 0 a yMax arrotondati
const yTicks = computed(() => {
  const max = yMax.value
  const step = Math.ceil(max / 5)
  const ticks = []
  for (let i = 0; i <= 5; i++) {
    const val = i * step
    if (val <= max) ticks.push(val)
  }
  ticks.push(max)
  return [...new Set(ticks)].sort((a, b) => a - b)
})
</script>