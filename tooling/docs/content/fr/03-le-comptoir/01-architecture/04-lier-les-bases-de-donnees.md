---
title: Lier les bases de données
description: Indiquer au dépôt local où lire les sources Snowflake.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Lier les bases de données

Lier les bases de données consiste à indiquer au dépôt local où se trouvent les sources à lire.

Dans Snowflake, une table peut être référencée avec un nom pleinement qualifié.

```sql
select *
from database_name.schema_name.table_name
```

Le dépôt local doit transformer ces sources en *interfaces* stables pour le reste du Store.

## Deux niveaux à distinguer

Il y a deux niveaux de configuration.

| Niveau | Rôle |
| --- | --- |
| Profil *dbt* | Indique où *dbt* construit les objets du projet. |
| Interfaces | Indiquent où lire les sources et comment les normaliser. |

Le profil ne remplace pas les *interfaces*. Il donne la destination de travail. Les *interfaces* décrivent les entrées métier.

## Profil local

Le dépôt local utilise le profil `snowflake`.

```yaml
# profiles.yml
snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <compte_snowflake>
      user: <utilisateur>
      role: <role>
      warehouse: <entrepot_snowflake>
      database: <base_cible>
      schema: <schema_de_developpement>
```

Cette configuration dit à *dbt* où créer les modèles construits par le projet local.

## Sources locales

Les sources lues par le Store peuvent être dans d'autres bases ou d'autres schémas.

Exemples:

```text
GPI_RAW.PUBLIC.ELEVES
GRHPAIE_RAW.PUBLIC_EMPLOIS.AFFECTATIONS
JADE_RAW.RESULTATS.EXAMENS
```

Le dépôt local doit créer des *interfaces* qui lisent ces objets et exposent une forme stable.

```sql
-- cssxx.dashboards_store.snowflake/models/interfaces/gpi/i_eleves.sql

select
    fiche as id_eleve_source,
    code_perm,
    nom,
    prenom
from GPI_RAW.PUBLIC.ELEVES
```

Les modèles suivants ne devraient pas lire directement `GPI_RAW.PUBLIC.ELEVES`. Ils devraient lire l'interface.

```sql
select *
from {{ ref("i_eleves") }}
```

## Pourquoi passer par les interfaces

Les noms de bases, de schémas et de tables peuvent varier d'une organisation à l'autre.

Les *interfaces* servent à cacher cette variation au reste du Store.

Elles permettent de personnaliser:

- le nom réel de la base;
- le nom réel du schéma;
- le nom réel de la table;
- les colonnes disponibles;
- les conversions de types nécessaires;
- les renommages minimaux.

Le core peut ensuite travailler avec des noms stables, même si les sources locales ne sont pas identiques.

## Ce qui appartient à cette couche

Une interface peut:

- lire une source;
- sélectionner les colonnes nécessaires;
- renommer les colonnes;
- convertir un type;
- normaliser une valeur technique;
- documenter la provenance.

Une interface ne devrait pas porter une règle métier complexe. Si la règle explique une décision métier, elle appartient plutôt à un *mart*, à un *adapter*, à un *seed* ou à un *override*.

## Point de contrôle

Si un changement sert seulement à dire où se trouve la donnée ou comment s'appelle une colonne source, il appartient probablement aux *interfaces* du dépôt local. Si le changement modifie le sens métier d'une donnée, il doit être placé plus loin dans le flux.
