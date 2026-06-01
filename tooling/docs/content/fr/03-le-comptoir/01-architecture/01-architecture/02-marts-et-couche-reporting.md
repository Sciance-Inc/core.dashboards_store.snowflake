---
title: Marts et couche reporting
description: Distinguer la vérité analytique Kimball des tables Power BI pré-calculées.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Marts et couche reporting

Le Store ne demande pas à Power BI d'être l'entrepôt analytique.

La séparation est la suivante:

```text
Marts
  = vérité analytique gouvernée

Couche reporting
  = tables de service pour Power BI
```

Les deux couches peuvent être construites en SQL/dbt, mais elles n'ont pas le même rôle.

## Différence entre les deux couches

| Question | Mart | Reporting |
| --- | --- | --- |
| Rôle | Gouverner la vérité analytique. | Servir un ou plusieurs rapports Power BI. |
| Modèle | Kimball: faits, dimensions, grain explicite. | OBT, tables larges, sorties préagrégées. |
| Réutilisation | Pensé pour plusieurs usages. | Pensé pour un usage de restitution. |
| Grain | Strict et documenté. | Adapté au besoin du visuel ou du rapport. |
| Calculs | Définitions métier canoniques. | Calculs de restitution, statuts, variations, seuils. |
| Consommateur | Autres modèles dbt, autres tableaux de bord, analyses. | Power BI. |
| Risque à éviter | Trop de logique locale ou de colonnes de présentation. | Devenir une deuxième vérité métier. |

## Kimball et OBT ne s'opposent pas ici

Dans cette architecture, Kimball et OBT ne sont pas deux choix concurrents.

Ils répondent à deux moments différents du flux:

```text
Kimball en amont
  -> gouvernance, cohérence, réutilisation

OBT en aval
  -> simplicité Power BI, performance, lisibilité
```

Une OBT de *reporting* est acceptable lorsqu'elle est alimentée par des *marts* propres et qu'elle ne redéfinit pas silencieusement les concepts métier.

## Règle de promotion

Une information peut commencer dans la couche de *reporting* si elle sert un besoin local.

Elle doit être promue vers un *mart* lorsqu'elle devient réutilisée, stable ou structurante.

```text
Information utilisée par un seul dashboard
  -> reste dans reporting

Information utilisée par plusieurs dashboards
  -> candidat pour un mart

Information transversale, stratégique ou gouvernée
  -> doit être dans un mart
```

Cette règle évite que la couche de *reporting* devienne une deuxième vérité métier.

## Personnalisation locale

Un *mart* peut dépendre de règles locales. Dans ce cas, le core définit le contrat attendu et le dépôt local fournit la partie variable.

Exemples:

```text
Le core définit le besoin:
  "donner la population d'élèves réguliers"

Le dépôt local fournit la règle:
  "statuts REGULIER et ACTIF, sauf certains services exclus"
```

Cette personnalisation peut passer par un *seed*, un *adapter* ou un *override*.

## Doctrine

La doctrine peut se résumer ainsi:

> Les *marts* constituent la couche analytique canonique, organisée selon une modélisation Kimball par vertical métier. La couche Power BI ne porte pas la logique métier lourde. Elle consomme des tables de *reporting* dénormalisées, pré-calculées en SQL, et reliées à des tables de filtres par grain. Les métriques qui deviennent réutilisables ou structurantes sont progressivement promues vers les *marts* canoniques.

## Pages détaillées

- [Marts Kimball](/fr/03-le-comptoir/01-architecture/01-architecture/03-marts-kimball)
- [Couche reporting Power BI](/fr/03-le-comptoir/01-architecture/01-architecture/04-couche-reporting-power-bi)
- [Tables de filtres par grain](/fr/03-le-comptoir/01-architecture/01-architecture/05-tables-de-filtres-par-grain)
