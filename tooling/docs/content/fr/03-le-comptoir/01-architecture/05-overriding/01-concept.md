---
title: Concept
description: Comprendre les mécanismes de surcharge locale du Store.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Overriding

L'*overriding* consiste à remplacer une ressource du dépôt commun par une ressource du dépôt local.

Le core fournit une implémentation commune ou une implémentation par défaut. Le dépôt local peut la remplacer lorsque la réalité locale l'exige.

## Pourquoi faire de l'overriding

Le Store est un socle commun, pas un cadre fermé.

Un centre de services scolaire peut devoir:

- ajouter une colonne source;
- modifier une règle de filtrage;
- remplacer une définition qui ne correspond pas à sa réalité;
- ajuster une table finale;
- désactiver une ressource du core pour fournir sa propre version.

La personnalisation doit se faire dans le dépôt local. Il ne faut pas modifier manuellement le code du core pour traiter une exception locale.

## Où se fait l'overriding

L'*overriding* se fait toujours dans le dépôt local.

```text
cssxx.dashboards_store.snowflake/
  models/
  seeds/
  macros/
  dbt_project.yml
```

Le dépôt local installe le core comme package.

```yaml
# cssxx.dashboards_store.snowflake/packages.yml
packages:
  - local: "../core.dashboards_store.snowflake"
```

Le template Snowflake part d'une configuration prudente.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
models:
  cssxx_dashboards_store_snowflake:
    +materialized: table

  core_dashboards_store_snowflake:
    +enabled: false

vars:
  is_context_core: false
```

Cette configuration rappelle que le dépôt local est le contexte d'exécution.

## Trois mécanismes de personnalisation

| Mécanisme | Quand l'utiliser |
| --- | --- |
| *Seed* | La règle est une petite liste stable. |
| *Adapter* | Le core attend une requête SQL locale. |
| *Override* | Le core fournit déjà une logique, mais elle doit être remplacée localement. |

Un *seed* est préférable lorsqu'une personne peut relire la règle dans un CSV. Un *adapter* est préférable lorsque le core ne peut pas connaître la requête locale. Un *override* est préférable lorsque le modèle commun existe déjà, mais doit être remplacé.

## Pages détaillées

- [Overrider un modèle](/fr/03-le-comptoir/01-architecture/05-overriding/02-overrider-un-modele)
- [Règles d'affaires locales](/fr/03-le-comptoir/01-architecture/05-overriding/03-regles-affaires-locales)
- [Contrats de données](/fr/03-le-comptoir/01-architecture/05-overriding/04-contrats-de-donnees)

## Point de contrôle

Avant de modifier le core, vérifier si le besoin peut être traité dans le dépôt local par un *seed*, un *adapter* ou un *override*.
