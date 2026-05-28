---
title: Interfaces
description: Comprendre la couche de connexion aux sources.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Interfaces

Une *interface* connecte une source au Store.

Elle stabilise les noms de colonnes et les types utilisés par le reste du projet.

## Ce qui appartient aux interfaces

- lire une source;
- renommer les colonnes;
- convertir un type lorsque c'est nécessaire;
- garder une forme stable pour les modèles suivants.

## Ce qui ne devrait pas y être

Les règles d'affaires importantes ne devraient pas être placées dans les *interfaces*.

Elles doivent plutôt être placées dans les *marts* ou dans une adaptation locale.

## Point de contrôle

Si une règle explique une décision métier, elle ne doit pas être cachée dans une *interface*.
