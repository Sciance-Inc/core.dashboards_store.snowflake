---
title: Concept du Store
description: Comprendre le socle commun Snowflake.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Concept du Store

Le Store Snowflake est un socle commun de transformations.

Il existe pour éviter que chaque CSS réécrive les mêmes modèles et les mêmes règles partagées.

## Code commun

Le dépôt commun contient ce qui peut être partagé entre CSSDM, CSSPI et CSSMV.

Une règle commune doit y être placée.

## Code local

Le dépôt local contient ce qui dépend de la réalité locale.

Une règle qui diffère entre organisations doit y être placée ou documentée comme exception.

## Point de contrôle

Avant de modifier une règle, demander : est-ce une règle commune ou une règle locale.
