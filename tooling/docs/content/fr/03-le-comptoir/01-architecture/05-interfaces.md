---
title: Interfaces
description: Normaliser les sources locales avant les transformations.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Interfaces

Une *interface* connecte une source locale au Store.

Elle stabilise les noms de colonnes, les types et la forme minimale utilisée par les modèles suivants.

## Rôle des interfaces

Les *interfaces* sont proches des sources.

Elles servent à:

- lire une source Snowflake;
- sélectionner les colonnes utiles;
- renommer les colonnes;
- convertir les types nécessaires;
- exposer une forme stable au reste du projet.

Elles permettent au Store de rester commun même si les sources locales ne sont pas identiques.

## Personnalisation locale

Chaque centre peut avoir:

- une base source différente;
- un schéma source différent;
- une table source différente;
- des colonnes nommées différemment;
- des valeurs techniques différentes.

Le dépôt local personnalise ces différences dans ses *interfaces*.

Exemple:

```sql
-- cssxx.dashboards_store.snowflake/models/interfaces/gpi/i_programmes.sql

select
    code_programme,
    description_programme,
    ordre_enseignement
from GPI_RAW.PARAMETRES.PROGRAMMES
```

Les modèles de *mart* peuvent ensuite référencer `i_programmes` sans connaître le nom réel de la table source.

## Ce qui ne devrait pas y être

Les règles métier importantes ne devraient pas être cachées dans une *interface*.

Exemples de règles à éviter dans une *interface*:

- définir quels élèves sont réguliers;
- définir quels paiements sont inclus dans un indicateur;
- regrouper des programmes pour un tableau de bord;
- calculer un statut analytique;
- appliquer une règle locale qui change le sens d'une métrique.

Ces règles doivent être placées dans un *mart*, un *seed*, un *adapter* ou un *override*.

## Différence avec un adapter

Une *interface* stabilise une source.

Un *adapter* fournit une règle locale attendue par le core.

```text
Interface
  -> où lire la donnée et comment la nommer

Adapter
  -> comment appliquer une règle locale attendue
```

## Point de contrôle

Si une requête sert surtout à lire une source et à stabiliser ses colonnes, c'est une *interface*. Si elle explique une décision métier propre à une organisation, ce n'est plus seulement une *interface*.
