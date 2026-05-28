---
title: Publication Power BI
description: Vérifier les points clés avant publication.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Publication Power BI

La publication d'un rapport doit être contrôlée.

Le rapport doit pointer vers le bon environnement.

## Points à vérifier

1. La table finale existe dans Snowflake.
2. Le rapport utilise la bonne base.
3. Les droits de lecture sont en place.
4. Les règles d'affaires ont été validées.
5. Les données ont été rafraîchies.

## Avant production

Comparer le rapport avec les résultats attendus dans l'environnement de validation.

## Point de contrôle

Ne pas publier si le rapport pointe vers une base de développement par erreur.
