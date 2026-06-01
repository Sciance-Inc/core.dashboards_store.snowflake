---
title: Overrider un modèle
description: Remplacer localement une implémentation commune, avec un contrat stable.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Overrider un modèle

Un *override* remplace un modèle commun par une version locale.

Il sert lorsque le modèle du core a le bon rôle, mais que la règle doit être différente pour un CSS.

## Étapes minimales

1. Repérer le modèle dans `core.dashboards_store.snowflake/models`.
2. Lire son contrat dans le `schema.yml`.
3. Créer un modèle local avec le même nom.
4. Désactiver le modèle du core dans `dbt_project.yml`.
5. Garder le même grain et les colonnes attendues.
6. Exécuter `dbt build` sur le modèle et ses dépendants.

## Exemple

Modèle local :

```sql
-- cssxx.dashboards_store.snowflake/models/marts/formation_professionnelle/staging/stg_eleves_reguliers.sql

select distinct
    id_eleve,
    annee_scolaire,
    code_programme
from {{ ref("stg_inscriptions_fp") }}
where statut_inscription in ('REGULIER', 'ACTIF')
```

Désactivation du modèle commun :

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

Validation :

```bash
poetry run dbt build --select stg_eleves_reguliers+
```

## Documentation détaillée

La page [Overrider un modèle](/fr/03-le-comptoir/01-architecture/05-overriding/02-overrider-un-modele) décrit le mécanisme complet.

La page [Contrats de données](/fr/03-le-comptoir/01-architecture/05-overriding/04-contrats-de-donnees) décrit les vérifications à faire.

## Point de contrôle

La sortie locale doit pouvoir remplacer la sortie commune sans casser le tableau de bord.
