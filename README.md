# core.dashboards_store.snowflake

Bienvenue dans le dépôt commun du Store Snowflake.

Ce dépôt contient le socle partagé qui permet de construire des marts et des tableaux de bord Snowflake de façon cohérente entre les CSS. Il porte les transformations *dbt* communes, les conventions de structure, les macros partagées, le gabarit Power BI et le template qui sert à créer les dépôts locaux.

Le README donne le chemin de départ. La documentation complète est sur le site :

<https://docs.dashboards-store-snowflake.sciance.ca>

## Le principe

Le projet sépare clairement deux responsabilités :

- le dépôt commun `core.dashboards_store.snowflake` contient ce qui est partagé;
- les dépôts locaux CSS contiennent les adaptations locales, les *seeds*, les surcharges et les règles propres à chaque organisation.

Quand une règle est commune, elle appartient au core. Quand elle dépend d'un CSS, elle appartient au dépôt local.

## La façon recommandée de démarrer

Le *way to go* pour créer un dépôt local CSS est :

```bash
poetry run spin_template
```

Cette commande lance le template *cookiecutter* du core et crée par défaut le dépôt local dans le dossier parent de `core.dashboards_store.snowflake`.

Structure attendue :

```text
dashboards_store/
  core.dashboards_store.snowflake/
  cssxx.dashboards_store.snowflake/
```

Le projet généré utilise le profil *dbt* `dev` et référence ce dépôt comme package local. Les commandes métier doivent ensuite être lancées depuis le dépôt local, pas depuis le core.

## Ce que tu trouveras ici

- `dbt_project.yml` : configuration *dbt* du package commun Snowflake.
- `models/` : modèles communs, marts et dashboards partagés.
- `macros/` : macros communes, incluant les macros de stamper adaptées à Snowflake.
- `reporting/gabarit.pbit` : gabarit Power BI commun.
- `tooling/template/` : template *cookiecutter* pour créer un dépôt local CSS.
- `tooling/docs/` : source du site de documentation.

## Documentation

Le site de documentation est la source de référence pour :

- installer l'environnement de travail;
- comprendre le rôle du core et des dépôts locaux;
- configurer Snowflake et *dbt*;
- créer un dépôt local avec `poetry run spin_template`;
- développer un mart, un dashboard ou une règle locale;
- publier et maintenir les tableaux de bord.

Pour lancer la documentation en local :

```bash
cd tooling/docs
npm install
npm run dev
```

Le site publie aussi les fichiers utiles aux assistants IA :

- `/llms.txt`
- `/llms-full.txt`
- `/mcp/docs-mcp.json`

## Commandes utiles

Installer les dépendances Python :

```bash
poetry install
```

Installer les dépendances *dbt* :

```bash
poetry run dbt deps
```

Créer un dépôt local CSS :

```bash
poetry run spin_template
```

## Contacts

Pour les questions fonctionnelles et de coordination CSSPI :

- CSSPI : <m-gomez-iglesias@csspi.gouv.qc.ca>

Pour les questions techniques, le socle Snowflake, *dbt*, le template ou la documentation :

- Sciance : <juhel.hugo@sciance.ca>
