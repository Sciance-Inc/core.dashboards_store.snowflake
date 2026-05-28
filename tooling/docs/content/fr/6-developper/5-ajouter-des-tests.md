---
title: Ajouter des tests
description: Vérifier les contrats de données.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Ajouter des tests

Les tests rendent les erreurs visibles plus tôt.

Ils protègent les contrats attendus par les tableaux de bord.

## Tests fréquents

- `not_null` : la colonne ne doit pas être vide;
- `unique` : chaque valeur doit être unique;
- valeurs acceptées : la colonne doit rester dans une liste connue;
- relations : la clé doit exister dans une autre table.

## Point de contrôle

Chaque table finale doit avoir au moins les tests qui protègent son grain et ses clés.
