---
title: Overriding
description: Remplacer une ressource commune par une version locale.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Overriding

L'*overriding* consiste à remplacer une ressource du dépôt commun par une version locale.

Cette approche sert lorsque le contrat reste le même, mais que la règle locale diffère.

## Exemple

Un CSS peut identifier les élèves réguliers avec une règle différente.

Dans ce cas, le dépôt local peut fournir son propre modèle. Le modèle commun correspondant doit être désactivé pour éviter un conflit.

## Règle de prudence

Un *override* doit garder le même grain et les mêmes colonnes de sortie, sauf décision explicite.

## Point de contrôle

Après un *override*, exécuter les tests qui vérifient le contrat de sortie.
