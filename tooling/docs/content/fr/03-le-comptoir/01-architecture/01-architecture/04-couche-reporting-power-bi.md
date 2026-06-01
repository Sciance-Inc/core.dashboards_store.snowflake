---
title: Couche reporting Power BI
description: Préparer les tables finales consommées par Power BI.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Couche reporting Power BI

La couche de *reporting* prépare les tables finales consommées par Power BI.

Cette couche n'a pas le même rôle que les *marts*. Elle sert la restitution.

## Rôle de la couche reporting

Les tables de cette couche peuvent être volontairement larges, aplaties et pré-calculées.

Elles peuvent contenir:

- des valeurs calculées;
- des agrégations;
- des variations;
- des statuts;
- des libellés;
- des seuils;
- des rangs;
- des scores;
- des colonnes de tri;
- des colonnes utiles à l'affichage.

Le but est de simplifier Power BI.

## Power BI comme couche légère

La règle cible est:

```text
SQL/dbt calcule
Power BI présente
```

Power BI peut gérer l'affichage, les filtres, la navigation et l'interaction.

La logique métier lourde devrait rester dans SQL/dbt lorsqu'elle peut être versionnée, testée et relue.

## Différence avec les marts

Les *marts* définissent les concepts réutilisables.

La couche de *reporting* prépare les tables de service pour un rapport.

```text
Marts
  -> vérité analytique réutilisable

Reporting
  -> tables prêtes à consommer par Power BI
```

Une table de reporting peut être une *one-big-table* si cela rend le modèle Power BI plus simple.

Cette approche est acceptable si la table est alimentée par des *marts* propres et si elle ne redéfinit pas silencieusement les concepts métier.

## Personnalisation locale

La couche de *reporting* peut contenir des ajustements propres à un rapport local.

Exemples:

- renommer un statut pour un public précis;
- ajouter un seuil d'affichage;
- préparer une table de filtres;
- créer une table déjà agrégée pour une page;
- exposer une colonne de tri attendue par Power BI.

Si l'ajustement devient utile à plusieurs tableaux de bord, il doit être remonté vers un *mart*.

## Ce que Power BI ne devrait pas porter

Power BI ne devrait pas porter la logique métier lourde lorsque cette logique peut être calculée en SQL/dbt.

Cela limite:

```text
les définitions divergentes entre rapports
la logique cachée dans les mesures DAX
les calculs difficiles à tester
la dépendance au modèle sémantique Power BI
```

## Point de contrôle

Si une table sert seulement à rendre un rapport plus simple, elle peut rester dans la couche de *reporting*. Si elle devient une définition analytique commune, elle doit être déplacée ou factorisée dans un *mart*.
