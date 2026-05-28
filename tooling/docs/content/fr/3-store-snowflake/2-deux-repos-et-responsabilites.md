---
title: Deux dépôts et responsabilités
description: Séparer le commun et le local.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Deux dépôts et responsabilités

Le projet fonctionne avec deux types de dépôts.

## Dépôt commun

Le dépôt `core.dashboards_store.snowflake` contient les modèles partagés.

Il définit la structure, les conventions, les contrats et les transformations communes.

## Dépôt local

Le dépôt local d'un CSS contient les adaptations propres à ce CSS.

Il peut contenir des *seeds*, des modèles d'adaptation et des *overrides*.

## Exemple

Si tous les CSS calculent un indicateur de la même façon, le code appartient au dépôt commun.

Si chaque CSS identifie les élèves réguliers selon une règle différente, la règle appartient au dépôt local.

## Point de contrôle

Une *Pull Request* doit indiquer clairement si elle modifie le commun ou le local.
