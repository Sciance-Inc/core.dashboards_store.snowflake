---
title: Vue d'ensemble
description: Comprendre le flux du Store, le rôle du core et les points de personnalisation.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Architecture du Store

::alert{type="info"}
Le Store sépare la vérité analytique, portée par les *marts*, des tables de restitution consommées par Power BI.
::

![Architecture en oignon du Store](/using/onion-architecture.webp "architecture en oignon")

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
Marts Kimball par vertical métier
  ->
Couche reporting dénormalisée
  ->
Power BI
```

Cette architecture est volontairement hybride.

Les *marts* gardent une logique Kimball pour stabiliser les concepts métier. La couche de *reporting* prépare des tables larges, aplaties et pré-calculées pour simplifier Power BI.

## Rôle des couches

| Couche | Rôle principal |
| --- | --- |
| Sources | Systèmes ou tables d'origine. |
| Interfaces et staging | Lire les sources, sélectionner, renommer et normaliser les colonnes. |
| Marts | Stabiliser les faits, dimensions, grains et définitions métier réutilisables. |
| Reporting | Préparer les tables finales, souvent dénormalisées, attendues par les tableaux de bord. |
| Power BI | Présenter les données, filtrer, naviguer et interagir avec l'utilisateur. |

## Deux dépôts

Le Store fonctionne avec deux types de dépôts.

| Dépôt | Rôle |
| --- | --- |
| `core.dashboards_store.snowflake` | Porte le commun: conventions, macros, contrats, modèles partagés et gabarit Power BI. |
| `cssxx.dashboards_store.snowflake` | Porte le local: sources réelles, interfaces, règles locales, seeds, adapters et overrides. |

Le dépôt local installe le core comme package *dbt*.

```yaml
# cssxx.dashboards_store.snowflake/packages.yml
packages:
  - local: "../core.dashboards_store.snowflake"
```

Les commandes *dbt* sont ensuite exécutées depuis le dépôt local.

```text
cssxx.dashboards_store.snowflake
  ->
installe core.dashboards_store.snowflake
  ->
personnalise les points prévus par le core
```

## La personnalisation est utile

La personnalisation n'est pas une exception à cacher.

Elle est nécessaire parce que les centres de services scolaires n'ont pas toujours:

- les mêmes bases sources;
- les mêmes schémas Snowflake;
- les mêmes colonnes;
- les mêmes codes;
- les mêmes règles de regroupement;
- les mêmes seuils;
- les mêmes exceptions locales.

Le rôle du Store est de rendre ces différences explicites, testables et faciles à relire.

## Mécanismes de personnalisation

| Mécanisme | Usage |
| --- | --- |
| [Lier les bases de données](/fr/03-le-comptoir/01-architecture/02-lier-les-bases-de-donnees) | Indiquer où se trouvent les sources dans Snowflake. |
| Interfaces | Donner une forme stable aux sources locales. |
| [Seeds](/fr/03-le-comptoir/01-architecture/03-adapters-et-seeds/02-seeds-de-configuration) | Encoder une liste de configuration dans un CSV versionné. |
| [Adapters](/fr/03-le-comptoir/01-architecture/03-adapters-et-seeds/03-adapters-et-points-dinjection) | Fournir une requête SQL locale attendue par le core. |
| [Activation](/fr/03-le-comptoir/01-architecture/04-activer-une-ressource) | Construire seulement les ressources utiles au contexte local. |
| [Overrides](/fr/03-le-comptoir/01-architecture/05-overriding/01-concept) | Remplacer une implémentation commune par une version locale. |

Cette séparation permet de mettre à jour le core sans perdre les règles locales.

## Principe directeur

La logique métier lourde doit être calculée en SQL/dbt, dans une couche versionnée et testable. Power BI doit rester une couche de présentation.

```text
SQL/dbt calcule
Power BI présente
```

## Pages à lire

- [Marts et couche reporting](/fr/03-le-comptoir/01-architecture/01-architecture/02-marts-et-couche-reporting)
- [Marts Kimball](/fr/03-le-comptoir/01-architecture/01-architecture/03-marts-kimball)
- [Couche reporting Power BI](/fr/03-le-comptoir/01-architecture/01-architecture/04-couche-reporting-power-bi)
- [Tables de filtres par grain](/fr/03-le-comptoir/01-architecture/01-architecture/05-tables-de-filtres-par-grain)
- [Lier les bases de données](/fr/03-le-comptoir/01-architecture/02-lier-les-bases-de-donnees)
- [Adapters et seeds](/fr/03-le-comptoir/01-architecture/03-adapters-et-seeds/01-concept)
- [Activer une ressource](/fr/03-le-comptoir/01-architecture/04-activer-une-ressource)
- [Overriding](/fr/03-le-comptoir/01-architecture/05-overriding/01-concept)

## Point de contrôle

Le bon réflexe est de ne pas modifier le core pour une réalité locale. Il faut d'abord vérifier si le besoin peut être traité dans le dépôt local par une connexion, une interface, un *seed*, un *adapter*, une activation ciblée ou un *override*.
