---
title: Overrider un modèle
description: Remplacer localement un modèle fourni par le core.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Overrider un modèle

Un *override* de modèle sert à remplacer un modèle du core par une version locale.

C'est le mécanisme à utiliser lorsque le modèle commun existe déjà, mais que sa logique ne correspond pas à la réalité locale.

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

Lire ensuite les fichiers voisins:

- le modèle SQL;
- le fichier `schema.yml`, s'il existe;
- les modèles qui font `ref("stg_eleves_reguliers")`;
- les tests associés;
- les tableaux de bord qui dépendent du modèle.

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

Exemple de modèle local:

```sql
-- cssxx.dashboards_store.snowflake/models/marts/formation_professionnelle/staging/stg_eleves_reguliers.sql

select distinct
    id_eleve,
    annee_scolaire,
    code_programme
from {{ ref("stg_inscriptions_fp") }}
where statut_inscription in ('REGULIER', 'ACTIF')
```

Le modèle local peut utiliser une règle différente. Il doit garder les colonnes et le grain attendus par les modèles suivants.

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

## Exemple d'override d'interface

Le core peut fournir une interface minimale.

```sql
-- core.dashboards_store.snowflake/models/interfaces/formation_professionnelle/i_programmes.sql

select
    code_programme,
    description_programme
from FORMATION_PROFESSIONNELLE_RAW.PARAMETRES.PROGRAMMES
```

Un dépôt local peut avoir besoin d'une colonne supplémentaire.

```sql
-- cssxx.dashboards_store.snowflake/models/interfaces/formation_professionnelle/i_programmes.sql

select
    code_programme,
    description_programme,
    ordre_enseignement,
    secteur_local
from CSSXX_RAW.PARAMETRES.PROGRAMMES
```

Le dépôt local désactive ensuite le modèle du core.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
models:
  core_dashboards_store_snowflake:
    interfaces:
      formation_professionnelle:
        i_programmes:
          +enabled: false
```

Le reste du Store peut continuer à lire `ref("i_programmes")`.

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

Un bon *override* personnalise le calcul sans forcer les tableaux de bord à changer. Si le contrat doit changer, la décision doit être explicite.
