# {{ cookiecutter.css_short_name + '.dashboards_store.snowflake' }}

Bienvenue dans le dépôt local Snowflake généré pour `{{ cookiecutter.css_short_name }}`.

Ce dépôt contient les adaptations propres au CSS. Le code commun, les conventions partagées, les macros et le gabarit Power BI viennent du package `core.dashboards_store.snowflake`.

La documentation complète est ici :

<https://docs.dashboards-store-snowflake.sciance.ca>

## Par où commencer

1. Lire la documentation du Store Snowflake.
2. Vérifier que `packages.yml` pointe vers le bon chemin du core.
3. Copier le contenu de `profiles-sample.yml` dans le profil *dbt* `dev`.
4. Remplacer les valeurs Snowflake si elles sont encore des placeholders.
5. Lancer `dbt deps`, puis `dbt debug --profile dev`.

## Ce dépôt a été généré avec le bon chemin

Le dépôt local doit être créé depuis le core avec :

```bash
poetry run spin_template
```

C'est le *way to go*. La commande garde la bonne relation entre le dépôt commun et le dépôt local.

Structure attendue :

```text
dashboards_store/
  core.dashboards_store.snowflake/
  {{ cookiecutter.css_short_name + '.dashboards_store.snowflake' }}/
```

## Contenu généré

- `dbt_project.yml` avec le profil *dbt* `dev`;
- `profiles-sample.yml` avec des sorties Snowflake `dev` et `prod`;
- `packages.yml` pointant vers `{{ cookiecutter.core_package_path }}`;
- une arborescence minimale `models/interfaces`;
- le mart `formation_professionnelle`;
- le dashboard `formation_professionnelle/cohorts`;
- le gabarit Power BI commun sous `reporting/gabarit.pbit`.

## Structure dbt

Les modèles locaux vivent sous le namespace *dbt* :

```text
{{ cookiecutter.css_short_name + '_dashboards_store_snowflake' }}
```

Le package core est désactivé par défaut dans ce dépôt local :

```yaml
models:
  core_dashboards_store_snowflake:
    +enabled: false
```

Activer ou surcharger seulement les modèles dont le CSS a besoin.

## Gabarit Power BI

Le fichier `reporting/gabarit.pbit` est une copie du gabarit existant du core.
Il ne doit pas être régénéré à la main. Il sert de base au premier tableau de bord local.

## Convention du dashboard cohorts

Les futurs modèles SQL du dashboard `cohorts` devraient utiliser le préfixe `chrt_`, par exemple :

- `chrt_report_filters.sql`;
- `chrt_report_cohorts.sql`.

Les tables finales exposées au rapport doivent être placées dans :

```text
models/dashboards/formation_professionnelle/cohorts/reporting/
```
