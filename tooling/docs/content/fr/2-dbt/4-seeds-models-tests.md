---
title: Seeds, models et tests
description: Comprendre les trois objets dbt les plus fréquents.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Seeds, models et tests

Ces trois objets reviennent souvent dans le projet.

## Seed

Un *seed* est un petit fichier `.csv` suivi dans Git.

Il sert à encoder une règle de référence. Exemple : une liste de paiements à inclure ou à exclure d'un indicateur.

## Model

Un *model* est un fichier `.sql`.

Il transforme des données et produit une table ou une vue.

## Test

Un *test* vérifie une condition.

Exemples : une colonne ne doit pas être vide, une clé doit être unique, une valeur doit être dans une liste permise.

## Point de contrôle

Avant de modifier une règle, déterminer si elle doit être un *seed*, un *model* ou un *test*.
