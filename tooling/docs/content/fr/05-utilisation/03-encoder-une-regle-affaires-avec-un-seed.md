---
title: Encoder une règle avec un seed
description: Utiliser un fichier CSV pour une règle stable.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Encoder une règle avec un seed

Un *seed* est utile lorsqu'une règle peut être représentée par une petite table.

## Exemple

Une liste de paiements à inclure dans un indicateur peut être placée dans un fichier `.csv`.

Chaque ligne représente une valeur contrôlée.

## Étapes

1. Créer le fichier `.csv`.
2. Décrire le *seed* dans un fichier `.yml`.
3. Ajouter les tests `not_null` et `unique` si possible.
4. Lancer `dbt seed`.
5. Lancer `dbt test`.

## Point de contrôle

Le *seed* doit être lisible par une personne métier.
