<script setup lang="ts">
defineProps<{
  date: string
}>()
</script>

<template>
  <UBadge color="neutral" variant="subtle">
    Mis a jour le {{ date }}
  </UBadge>
</template>
