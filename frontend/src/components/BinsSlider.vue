<template>
  <div class="slider-wrapper">

    <input
      class="bins-slider"
      type="range"
      min="1"
      max="50"
      :value="modelValue"
      :style="trackStyle"
      @input="onInput"
    />

    <div class="slider-ticks">
      <span>1</span>
      <span>25</span>
      <span>50</span>
    </div>

  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({ modelValue: { type: Number, default: 30 } })
const emit = defineEmits(['update:modelValue'])

function onInput(e) {
  emit('update:modelValue', Number(e.target.value))
}

// Calcola la percentuale di completamento per colorare il track
const trackStyle = computed(() => {
  const pct = ((props.modelValue - 1) / (50 - 1)) * 100
  return {
    background: `linear-gradient(to right, #ebfbe4 ${pct}%, rgba(0,73,48,0.15) ${pct}%)`
  }
})
</script>