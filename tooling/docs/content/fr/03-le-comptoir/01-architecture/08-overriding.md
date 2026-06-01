---
title: Overriding
description: Comprendre les mécanismes de surcharge locale du Store.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Overriding

L'*overriding* consiste à remplacer une ressource du dépôt commun par une ressource du dépôt local.

Le principe vient du guide `core.dashboards_store`: le core fournit une implémentation commune ou une implémentation par défaut, mais le dépôt local peut la remplacer lorsque la réalité locale l'exige.

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

L'*overriding* se fait dans le dépôt local.

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

Ces mécanismes ne sont pas interchangeables.

Un *seed* est préférable lorsqu'une personne peut relire la règle dans un CSV. Un *adapter* est préférable lorsque le core ne peut pas connaître la requête locale. Un *override* est préférable lorsque le modèle commun existe déjà, mais doit être remplacé.

## Comment remplacer un modèle

Pour remplacer un modèle du core:

1. créer un modèle local avec le même nom;
2. garder les colonnes attendues par les modèles suivants;
3. désactiver le modèle du package commun dans `dbt_project.yml`;
4. exécuter le modèle local et ses dépendants.

Exemple:

```text
core.dashboards_store.snowflake/
  models/marts/formation_professionnelle/staging/stg_eleves_reguliers.sql

cssxx.dashboards_store.snowflake/
  models/marts/formation_professionnelle/staging/stg_eleves_reguliers.sql
```

Désactivation du modèle du core:

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
models:
  core_dashboards_store_snowflake:
    marts:
      formation_professionnelle:
        staging:
          stg_eleves_reguliers:
            +enabled: false
```

## Ce qui ne doit pas changer sans décision

Un *override* peut changer le calcul.

Il ne doit pas changer le contrat sans décision explicite.

Le contrat comprend:

- le nom du modèle;
- le grain;
- les colonnes attendues;
- les types importants;
- les tests attendus;
- les tableaux de bord qui consomment la sortie.

## Pages à lire ensuite

- [Overrider un modèle](/fr/03-le-comptoir/01-architecture/09-overrider-un-modele)
- [Seeds de configuration](/fr/03-le-comptoir/01-architecture/10-seeds-de-configuration)
- [Adapters et points d'injection](/fr/03-le-comptoir/01-architecture/11-adapters-et-points-dinjection)
- [Contrats de données](/fr/03-le-comptoir/01-architecture/13-contrats-de-donnees)

## Point de contrôle

Avant de modifier le core, vérifier si le besoin peut être traité dans le dépôt local par un *seed*, un *adapter* ou un *override*.
