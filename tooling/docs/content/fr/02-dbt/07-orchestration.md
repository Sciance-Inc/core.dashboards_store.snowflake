---
title: Orchestration
description: Comprendre ce qui lance les commandes dbt.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Orchestration

*dbt* exécute les transformations. Un orchestrateur décide quand les lancer.

En local, le lecteur lance les commandes lui-même. En production, une tâche planifiée peut lancer les commandes selon un horaire.

## Responsabilité de dbt

*dbt* sait quoi exécuter et dans quel ordre.

Il sait aussi tester les résultats.

## Responsabilité de l'orchestrateur

L'orchestrateur déclenche l'exécution.

Il doit utiliser le bon environnement, le bon rôle Snowflake et les bonnes commandes.

## Point de contrôle

Avant de planifier une exécution, vérifier que la même commande réussit manuellement dans l'environnement prévu.
