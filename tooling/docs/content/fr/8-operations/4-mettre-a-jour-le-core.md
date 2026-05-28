---
title: Mettre à jour le core
description: Recevoir les changements du dépôt commun.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Mettre à jour le core

Le dépôt local dépend du dépôt commun.

Quand le commun change, le dépôt local doit être validé.

## Étapes

1. Lire les notes du changement.
2. Mettre à jour la référence au dépôt commun.
3. Exécuter `dbt deps` si nécessaire.
4. Exécuter une sélection ciblée.
5. Exécuter les tests.
6. Vérifier les contrats touchés.

## Point de contrôle

Ne pas accepter une mise à jour du commun sans vérifier les rapports touchés.
