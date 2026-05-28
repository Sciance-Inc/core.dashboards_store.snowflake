---
title: Rôle du stamper
description: Suivre les tables produites par dbt.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Rôle du stamper

Le *stamper* sert à garder une trace des tables produites.

Il aide à répondre à une question : quand cette table a-t-elle été mise à jour.

## Information attendue

- nom du tableau de bord;
- nom de la table;
- date de fin d'exécution.

## Utilité

Le *stamper* aide les équipes à vérifier qu'un rapport utilise des données récentes.

Il aide aussi à diagnostiquer une exécution incomplète.

## Point de contrôle

Après une exécution, vérifier que les tables finales attendues ont une trace récente.
