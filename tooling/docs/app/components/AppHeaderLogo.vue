<template>
  <span class="app-header-logo">
    <!-- Light mode: dark-ink wordmark -->
    <img src="/logo.png" alt="Sciance" class="h-[29px] w-auto block dark:hidden">
    <!-- Dark mode: white wordmark -->
    <img src="/logo-dark.webp" alt="Sciance" class="h-[29px] w-auto hidden dark:block">
    <span class="text-zinc-400 font-medium">/ Store Snowflake</span>
  </span>
</template>

<style scoped>
.app-header-logo {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
}
</style>
