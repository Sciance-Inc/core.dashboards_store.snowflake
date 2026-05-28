# Documentation Store Snowflake

Bienvenue dans le site de documentation du Store Snowflake.

Ce dossier contient la source du site publié ici :

<https://docs-snowflake.dashboards-store.sciance.ca/>

Le site est la référence pour comprendre le projet, installer l'environnement, créer un dépôt local avec `poetry run spin_template`, travailler avec *dbt* et Snowflake, puis contribuer proprement.

## Démarrer le site en local

```bash
npm install
npm run dev
```

## Générer le site statique

```bash
npm run generate
```

## Contenu publié

Le site publie la documentation humaine ainsi que les fichiers utiles aux assistants IA :

- `/llms.txt`
- `/llms-full.txt`
- `/mcp/docs-mcp.json`

Pour modifier une règle de travail, une convention ou une procédure, mettre à jour les pages sous `content/fr/` plutôt que de dupliquer les explications dans les README.
