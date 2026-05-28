---
title: Marts
description: Comprendre la couche de factorisation.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Marts

Un *mart* contient du code utile à plusieurs tableaux de bord.

Il factorise les règles et les dimensions qui ne devraient pas être copiées partout.

## Exemple pour la formation professionnelle

Un *mart* peut préparer la population d'élèves, les inscriptions, les sanctions ou les paiements.

Si plusieurs tableaux de bord ont besoin de la même table, cette table est probablement un bon candidat pour un *mart*.

## Point de contrôle

Si une transformation sera utilisée par plus d'un tableau de bord, envisager de la placer dans un *mart*.
