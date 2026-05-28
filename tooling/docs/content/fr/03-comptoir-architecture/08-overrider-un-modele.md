---
title: Overrider un modèle
description: Remplacer localement un modèle fourni par le core.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Overrider un modèle

Un *override* de modèle sert à remplacer un modèle du core par une version locale.

Il faut faire deux choses :

1. créer un modèle local avec le même nom;
2. désactiver le modèle du package commun.

## Avant de commencer

Repérer le modèle dans le core.

```text
core.dashboards_store.snowflake/
  models/
    marts/
      formation_professionnelle/
        staging/
          stg_eleves_reguliers.sql
```

Lire ensuite les fichiers voisins :

- le modèle SQL;
- le fichier `schema.yml`, s'il existe;
- les modèles qui font `ref("stg_eleves_reguliers")`;
- les tests associés.

Cette lecture sert à comprendre le contrat à respecter.

## Créer le modèle local

Dans le dépôt local, créer un fichier avec le même nom.

```text
cssxx.dashboards_store.snowflake/
  models/
    marts/
      formation_professionnelle/
        staging/
          stg_eleves_reguliers.sql
```

Exemple de modèle local :

```sql
-- cssxx.dashboards_store.snowflake/models/marts/formation_professionnelle/staging/stg_eleves_reguliers.sql

select distinct
    id_eleve,
    annee_scolaire,
    code_programme
from {{ ref("stg_inscriptions_fp") }}
where statut_inscription in ('REGULIER', 'ACTIF')
```

Le modèle local peut utiliser une règle différente. Il doit garder les colonnes attendues par les modèles suivants.

## Désactiver le modèle du core

Dans `dbt_project.yml`, désactiver le modèle du package commun.

La structure YAML doit suivre le chemin du modèle dans le dossier `models/`.

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

Le nom final est le nom du fichier sans `.sql`.

## Exemple observé dans le Store existant

Dans le Store existant, le core avait une interface `i_gpm_t_mat`.

```sql
-- core.dashboards_store/models/interfaces/gpi/i_gpm_t_mat.sql
select
    id_eco,
    mat,
    descr,
    descr_abreg,
    unites
from {{ var("database_gpi") }}.dbo.gpm_t_mat
```

CSSPI avait besoin de colonnes supplémentaires. Le dépôt local a donc fourni son propre modèle.

```sql
-- csspi.dashboards_store/models/interfaces/gpi/i_gpm_t_mat.sql
select
    id_eco,
    mat,
    mat_off,
    descr,
    descr_abreg,
    unites,
    cat_mat,
    classe,
    type_unites
from {{ var("database_gpi") }}.dbo.gpm_t_mat
```

Le dépôt local désactive ensuite le modèle du core.

```yaml
# csspi.dashboards_store/dbt_project.yml
models:
  core_dashboards_store:
    interfaces:
      gpi:
        i_gpm_t_mat:
          +enabled: false
```

Le principe est le même dans le Store Snowflake. Le nom du package devient `core_dashboards_store_snowflake`.

## Tester l'override

Exécuter le modèle local et ce qui en dépend.

```bash
poetry run dbt build --select stg_eleves_reguliers+
```

Si le modèle est consommé par un tableau de bord précis, tester aussi le tag du tableau de bord.

```bash
poetry run dbt build --select tag:formation_professionnelle
```

## Erreurs fréquentes

| Erreur | Effet |
| --- | --- |
| Le fichier local n'a pas le même nom. | *dbt* crée un nouveau modèle au lieu de remplacer le modèle attendu. |
| Le modèle du core n'est pas désactivé. | Deux modèles peuvent produire le même alias ou créer une ambiguïté. |
| Une colonne attendue disparaît. | Un modèle suivant ou un tableau de bord casse. |
| Le grain change sans être documenté. | Les mesures peuvent être doublées ou sous-estimées. |
| Le mauvais package est configuré. | La désactivation ne s'applique pas au modèle du core. |

## Point de contrôle

Un bon *override* doit pouvoir remplacer le modèle commun sans obliger les tableaux de bord à changer.
