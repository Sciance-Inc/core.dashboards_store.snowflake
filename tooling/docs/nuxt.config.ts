import { readdirSync, statSync } from 'node:fs'
import { join, relative, sep } from 'node:path'

const ignoredPrerenderRoutes = [
  new RegExp('^/__og-' + 'im' + 'age__/')
]

const contentRoot = join(process.cwd(), 'content', 'fr')

const collectMarkdownRoutes = (dir: string): string[] => {
  return readdirSync(dir).flatMap((entry) => {
    const path = join(dir, entry)
    const stats = statSync(path)

    if (stats.isDirectory()) {
      return collectMarkdownRoutes(path)
    }

    if (!entry.endsWith('.md')) {
      return []
    }

    const stem = relative(contentRoot, path)
      .split(sep)
      .join('/')
      .replace(/\.md$/, '')

    return stem === 'index' ? ['/raw/fr.md'] : [`/raw/fr/${stem}.md`]
  })
}

const rawPrerenderRoutes = collectMarkdownRoutes(contentRoot)

export default defineNuxtConfig({
  extends: ['docus'],

  modules: ['@nuxtjs/i18n'],

  site: {
    name: 'Store Snowflake',
    url: 'https://docs-snowflake.dashboards-store.sciance.ca'
  },

  i18n: {
    defaultLocale: 'fr',
    locales: [
      { code: 'fr', name: 'Francais' }
    ]
  },

  css: ['~/assets/css/main.css'],

  runtimeConfig: {
    public: {
      siteUrl: 'https://docs-snowflake.dashboards-store.sciance.ca'
    }
  },

  appConfig: {
    header: {
      title: 'Store Snowflake'
    },
    socials: {},
    github: {
      owner: 'Sciance-Inc',
      name: 'core.dashboards_store.snowflake',
      url: 'https://github.com/Sciance-Inc/core.dashboards_store.snowflake',
      branch: 'main',
      rootDir: 'tooling/docs/content/fr'
    },
    toc: {
      title: 'Sur cette page',
      bottom: {
        title: 'Communauté',
        links: [
          {
            label: 'Sciance',
            to: 'https://www.sciance.ca/',
            target: '_blank'
          },
          {
            label: 'GitHub',
            to: 'https://github.com/Sciance-Inc/core.dashboards_store.snowflake',
            target: '_blank'
          }
        ]
      }
    },
    ui: {
      colors: {
        primary: 'blue',
        neutral: 'zinc'
      }
    }
  },

  app: {
    head: {
      htmlAttrs: {
        lang: 'fr'
      },
      link: [
        { rel: 'icon', href: '/favicon.svg' },
        { rel: 'canonical', href: 'https://docs-snowflake.dashboards-store.sciance.ca' }
      ]
    }
  },

  llms: {
    domain: 'https://docs-snowflake.dashboards-store.sciance.ca',
    title: 'Documentation Store Snowflake',
    description: 'Documentation du Store Snowflake pour le projet FP.',
    full: {
      title: 'Documentation complete du Store Snowflake',
      description: 'Toutes les pages de documentation du Store Snowflake en format lisible par les assistants IA.'
    }
  },

  fonts: {
    provider: 'none'
  },

  vite: {
    build: {
      minify: false,
      reportCompressedSize: false,
      sourcemap: false
    }
  },

  nitro: {
    minify: false,
    sourceMap: false,
    prerender: {
      concurrency: 1,
      failOnError: false,
      ignore: ignoredPrerenderRoutes,
      routes: ['/fr', '/llms.txt', '/llms-full.txt', '/mcp/docs-mcp.json', ...rawPrerenderRoutes]
    }
  }
})
