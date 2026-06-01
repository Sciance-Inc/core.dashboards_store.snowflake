<script setup lang="ts">
import type { ContentNavigationItem } from '@nuxt/content'

const route = useRoute()
const docsNavigation = inject<Ref<ContentNavigationItem[]>>('navigation')

const flattenNavigation = (items: ContentNavigationItem[] = []): ContentNavigationItem[] => {
  return items.flatMap(item => [item, ...flattenNavigation(item.children)])
}

const docsLinks = computed(() => flattenNavigation(docsNavigation?.value))
const isDocs = computed(() => docsLinks.value.some(item => item.path === route.path))
</script>

<template>
  <AppHeader />
  <UMain>
    <slot v-if="!isDocs" />
    <UContainer v-else>
      <UPage>
        <template #left>
          <UPageAside>
            <DocsAsideLeftTop />

            <DocsAsideLeftBody />
          </UPageAside>
        </template>

        <slot />
      </UPage>
    </UContainer>
  </UMain>
  <AppFooter />
</template>
