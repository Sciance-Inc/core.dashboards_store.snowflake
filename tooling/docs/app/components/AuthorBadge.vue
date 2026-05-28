<script setup lang="ts">
withDefaults(defineProps<{
  author?: string
}>(), {
  author: 'hugo.juhel@sciance.ca'
})
</script>

<template>
  <UBadge color="primary" variant="subtle">
    {{ author }}
  </UBadge>
</template>
