---
title: Architecture du Store
description: Comprendre le socle commun et les points de personnalisation.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Architecture du Store

Le Store Snowflake est un socle commun de transformations *dbt*.

Il existe pour éviter que chaque centre de services scolaire réécrive les mêmes modèles, les mêmes conventions et les mêmes tables de sortie.

Il ne cherche pas à supprimer les différences locales. Au contraire, il organise ces différences dans des points de personnalisation clairs.

## Flux général

Le flux cible est:

```text
Sources
  ->
Interfaces et staging
  ->
Marts par vertical métier
  ->
Tables de reporting pour Power BI
  ->
Tableaux de bord
```

Chaque couche a un rôle précis.

| Couche | Rôle |
| --- | --- |
| Sources | Systèmes ou tables d'origine. |
| Interfaces | Connexion aux sources, renommage et normalisation minimale. |
| Marts | Définitions analytiques réutilisables. |
| Dashboards | Tables finales adaptées à Power BI. |
| Power BI | Visualisation, navigation et interaction. |

## Code commun

Le dépôt `core.dashboards_store.snowflake` contient ce qui peut être partagé.

Il définit:

- la structure du projet;
- les conventions de nommage;
- les modèles communs;
- les contrats attendus;
- les macros partagées;
- les tables finales communes;
- les points de personnalisation.

Une règle qui doit être identique pour tous les centres de services scolaires appartient au dépôt commun.

## Code local

Le dépôt local, par exemple `cssxx.dashboards_store.snowflake`, contient ce qui dépend de la réalité locale.

Il peut définir:

- les connexions aux bases et schémas locaux;
- les *interfaces* vers les sources réelles;
- les *seeds* de configuration;
- les *adapters* SQL;
- les *overrides* de modèles;
- les ajustements nécessaires à un tableau de bord local.

Le dépôt local déclare le dépôt commun comme package *dbt*. Les commandes *dbt* sont ensuite exécutées depuis le dépôt local.

```text
cssxx.dashboards_store.snowflake
  ->
installe core.dashboards_store.snowflake
  ->
personnalise les points prévus par le core
```

## La personnalisation est normale

Les centres de services scolaires n'ont pas toujours les mêmes sources, les mêmes codes, les mêmes règles de regroupement ou les mêmes définitions locales.

Le Store est donc conçu pour être personnalisé sans modifier directement le dépôt commun.

La personnalisation se fait principalement par:

| Mécanisme | Usage |
| --- | --- |
| Lier les bases de données | Indiquer où se trouvent les sources dans Snowflake. |
| Interfaces | Donner une forme stable aux sources locales. |
| Seeds | Encoder une petite liste de configuration. |
| Adapters | Fournir une requête SQL locale attendue par le core. |
| Overrides | Remplacer un modèle commun par une version locale. |

Cette séparation permet de mettre à jour le core sans perdre les règles locales.

## Principe directeur

Avant d'ajouter une règle, il faut décider où elle appartient.

```text
Règle commune
  -> core.dashboards_store.snowflake

Règle locale
  -> dépôt local

Liste de configuration
  -> seed

SQL local attendu par le core
  -> adapter

Remplacement d'une logique commune
  -> override
```

## Pages à lire ensuite

- [Lier les bases de données](/fr/03-le-comptoir/01-architecture/04-lier-les-bases-de-donnees)
- [Interfaces](/fr/03-le-comptoir/01-architecture/05-interfaces)
- [Marts](/fr/03-le-comptoir/01-architecture/06-marts)
- [Dashboards](/fr/03-le-comptoir/01-architecture/07-dashboards)
- [Overriding](/fr/03-le-comptoir/01-architecture/08-overriding)
- [Seeds de configuration](/fr/03-le-comptoir/01-architecture/10-seeds-de-configuration)
- [Adapters et points d'injection](/fr/03-le-comptoir/01-architecture/11-adapters-et-points-dinjection)

## Point de contrôle

Le bon réflexe est de ne pas modifier le core pour une réalité locale. Il faut d'abord vérifier si le besoin peut être traité par une connexion, une interface, un *seed*, un *adapter* ou un *override* dans le dépôt local.
