---
title: Règles d'affaires locales
description: Documenter les différences entre CSS.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Règles d'affaires locales

Une règle d'affaires locale décrit une décision propre à une organisation.

Elle doit être visible. Elle ne doit pas être cachée dans une requête difficile à trouver.

## Exemples

Un CSS peut avoir une règle différente pour identifier les élèves réguliers.

Un CSS peut inclure ou exclure certains types de paiements.

Un CSS peut regrouper des programmes différemment pour répondre à sa réalité locale.

## Choisir le bon mécanisme

| Situation | Mécanisme recommandé |
| --- | --- |
| La règle est une liste de codes. | *Seed* |
| La règle demande une requête SQL locale. | *Adapter* |
| La règle remplace une logique commune existante. | *Override* |
| La règle devrait être identique pour tous les CSS. | Changement dans le core |

## Ce qui doit être documenté

Pour chaque règle locale importante, documenter :

- le besoin;
- la décision;
- la source de la règle;
- la date ou le contexte de validation;
- les impacts sur les indicateurs;
- les tests exécutés.

Exemple dans une *Pull Request* :

```md
Règle locale : élèves réguliers FP

Le CSS inclut les inscriptions avec statut REGULIER et ACTIF.
Les inscriptions avec un code de service exclu sont retirées par le seed
services_exclus_eleves_reguliers.

Impact attendu : le décompte des élèves réguliers peut différer du core.
Validation : dbt build --select stg_eleves_reguliers+
```

## Point de contrôle

Si une règle locale change un indicateur, elle doit être nommée, versionnée et relue.
