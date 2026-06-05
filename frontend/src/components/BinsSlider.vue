<template>
  <div class="slider-container">
    <label for="bins-slider">
      Number of bins: <strong>{{ modelValue }}</strong>
    </label>
    <input
      id="bins-slider"
      type="range"
      :min="1"
      :max="50"
      :value="modelValue"
      @input="$emit('update:modelValue', Number($event.target.value))"
    />
  </div>
</template>

<script setup>
defineProps({
  modelValue: {
    type: Number,
    default: 30
  }
})

defineEmits(['update:modelValue'])
</script>