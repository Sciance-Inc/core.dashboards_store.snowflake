---
title: Activer une ressource
description: Construire seulement les marts, dashboards et interfaces nécessaires.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Activer une ressource

Par défaut, le dépôt local généré désactive le package core.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
models:
  core_dashboards_store_snowflake:
    +enabled: false
```

Cette configuration est volontairement prudente.

Elle évite de matérialiser tout le Store lorsqu'un centre de services scolaire veut seulement construire un mart, un tableau de bord ou un périmètre de formation professionnelle.

## Pourquoi activer explicitement

Une ressource peut être:

- un mart complet;
- un tableau de bord;
- une table de reporting;
- une interface;
- un modèle SQL précis;
- un seed;
- un test.

Activer seulement les ressources nécessaires limite:

- le temps de build;
- les coûts Snowflake;
- les objets inutiles dans les schémas;
- les dépendances non configurées;
- les erreurs causées par des sources absentes localement.

## Comment activer une ressource

La configuration `+enabled: true|false` est le mécanisme *dbt* pour activer ou désactiver des ressources.

Dans *dbt*, la configuration la plus spécifique gagne sur la configuration plus générale. Le dépôt local peut donc garder le package core désactivé par défaut et activer seulement un sous-chemin.

## Activer un mart

Exemple pour activer le mart de formation professionnelle fourni par le core.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
models:
  core_dashboards_store_snowflake:
    +enabled: false

    marts:
      formation_professionnelle:
        +enabled: true
```

Le dépôt local doit aussi fournir les interfaces, seeds ou adapters requis par ce mart.

## Activer un dashboard

Exemple pour activer le dashboard `cohorts`.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
models:
  core_dashboards_store_snowflake:
    +enabled: false

    dashboards:
      formation_professionnelle:
        cohorts:
          +enabled: true
```

Le dashboard doit pouvoir lire les marts et les tables de reporting dont il dépend.

## Activer ou fournir une interface

Les interfaces locales vivent dans le dépôt local.

```text
cssxx.dashboards_store.snowflake/
  models/
    interfaces/
      gpi/
        i_eleves.sql
```

Le dépôt local peut laisser ces modèles activés par défaut, ou les contrôler explicitement.

```yaml
models:
  cssxx_dashboards_store_snowflake:
    interfaces:
      gpi:
        +enabled: true
```

Avant d'activer une interface, vérifier que la base source est accessible et que le modèle lit le bon objet Snowflake.

## Activer un seed

Le même principe s'applique aux *seeds*.

```yaml
seeds:
  cssxx_dashboards_store_snowflake:
    formation_professionnelle:
      paiements_fp:
        +enabled: true
```

Si le core fournit un *seed* par défaut, le dépôt local peut le désactiver et fournir son propre CSV.

```yaml
seeds:
  core_dashboards_store_snowflake:
    formation_professionnelle:
      paiements_fp:
        +enabled: false
```

## Dépendances des ressources

Une erreur fréquente consiste à activer un modèle sans activer ou fournir ses dépendances.

Pour un *mart*, cela signifie souvent:

- activer le mart;
- mais oublier une interface source;
- ou oublier un *seed*;
- ou oublier un *adapter*.

Pour un tableau de bord, cela signifie souvent:

- activer la table de reporting;
- mais oublier le mart qui l'alimente;
- ou oublier une table de filtres;
- ou oublier une règle locale requise.

## Commandes utiles

Construire une ressource précise:

```bash
poetry run dbt build --select stg_eleves_reguliers
```

Construire une ressource et ses dépendants:

```bash
poetry run dbt build --select stg_eleves_reguliers+
```

Construire un périmètre par tag:

```bash
poetry run dbt build --select tag:formation_professionnelle
```

## Point de contrôle

Activer une ressource n'est pas seulement passer `+enabled` à `true`. Il faut aussi vérifier que ses sources, ses interfaces, ses seeds, ses adapters et ses dépendances analytiques sont disponibles dans le dépôt local.
