---
title: Marts
description: Stabiliser les définitions analytiques réutilisables.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Marts

Les *marts* portent la vérité analytique réutilisable du Store.

Ils ne sont pas conçus pour une page Power BI précise. Ils servent à stabiliser des concepts qui peuvent être utilisés par plusieurs tableaux de bord ou plusieurs analyses.

## Rôle d'un mart

Un *mart* définit une information une fois, avec:

- un grain clair;
- des clés stables;
- des dimensions réutilisables;
- des règles métier visibles;
- des tests;
- une documentation lisible.

Il évite de recopier la même règle dans plusieurs tableaux de bord.

## Exemples

Un *mart* peut préparer:

- la population d'élèves;
- les inscriptions;
- les programmes;
- les résultats;
- les paiements;
- les absences;
- les dimensions d'établissement;
- les dimensions de date.

Si plusieurs tableaux de bord ont besoin de la même table ou de la même définition, cette table est probablement un bon candidat pour un *mart*.

## Différence avec les dashboards

| Question | Mart | Dashboard |
| --- | --- | --- |
| Rôle | Stabiliser une définition analytique. | Servir une restitution Power BI. |
| Réutilisation | Plusieurs usages. | Un rapport ou une famille de rapports. |
| Grain | Strict et documenté. | Adapté au visuel ou à la page. |
| Logique | Métier et réutilisable. | Présentation, statuts, seuils, variations. |
| Risque | Devenir trop local. | Devenir une deuxième vérité métier. |

## Personnalisation locale

Un *mart* peut dépendre de règles locales. Dans ce cas, la règle locale ne doit pas forcément être écrite dans le core.

Le core peut définir le contrat attendu, puis laisser le dépôt local fournir la partie variable.

Exemples:

```text
Le core définit le besoin:
  "donner la population d'élèves réguliers"

Le dépôt local fournit la règle:
  "statuts REGULIER et ACTIF, sauf certains services exclus"
```

Cette personnalisation peut passer par un *seed*, un *adapter* ou un *override*.

## Règle de promotion

Une information peut commencer dans une table de dashboard lorsqu'elle répond à un besoin local.

Elle doit être promue vers un *mart* lorsqu'elle devient réutilisée, stable ou structurante.

```text
Information utilisée par un seul dashboard
  -> reste dans dashboards

Information utilisée par plusieurs dashboards
  -> candidat pour un mart

Information commune ou gouvernée
  -> doit être dans un mart
```

## Point de contrôle

Avant de créer une table dans `dashboards`, vérifier si elle porte une définition qui sera utile ailleurs. Si oui, la placer dans un *mart* ou créer un point de personnalisation local autour du *mart*.
