<script setup lang="ts">
const props = withDefaults(defineProps<{
  author?: string
  updatedAt?: string
}>(), {
  author: 'hugo.juhel@sciance.ca',
  updatedAt: '2026-05-28'
})

const formattedDate = computed(() => {
  const date = new Date(`${props.updatedAt}T12:00:00`)
  return new Intl.DateTimeFormat('fr-CA', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  }).format(date)
})
</script>

<template>
  <p class="page-metadata">
    Mis a jour le {{ formattedDate }} par {{ author }}.
  </p>
</template>
