<script setup lang="ts">
defineProps<{
  cwd: string
  command: string
  result?: string
}>()
</script>

<template>
  <div class="border border-zinc-200 dark:border-zinc-800 rounded-md p-4 my-4">
    <p class="text-sm text-zinc-500 mb-2">Dossier : <code>{{ cwd }}</code></p>
    <pre class="text-sm overflow-x-auto"><code>{{ command }}</code></pre>
    <p v-if="result" class="text-sm mt-3 text-zinc-600 dark:text-zinc-300">
      Resultat attendu : {{ result }}
    </p>
  </div>
</template>
