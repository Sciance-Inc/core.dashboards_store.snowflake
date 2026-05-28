---
title: Coûts et contrôles Snowflake
description: Réduire les risques d'exécution Snowflake.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Coûts et contrôles

Snowflake facture le calcul utilisé.

Il faut donc limiter les exécutions inutiles.

## Contrôles minimaux

- utiliser un entrepôt de petite taille pour le développement;
- activer `AUTO_SUSPEND`;
- activer `AUTO_RESUME`;
- limiter le rôle d'écriture;
- séparer `store_dev` et `store`.

## Avant une exécution large

1. Vérifier le *target*.
2. Vérifier la base.
3. Vérifier le rôle.
4. Lancer d'abord une sélection ciblée.

## Point de contrôle

Une exécution de production doit être volontaire, documentée et relue.
