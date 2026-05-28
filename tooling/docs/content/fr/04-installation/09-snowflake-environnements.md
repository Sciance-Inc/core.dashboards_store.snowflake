---
title: Environnements Snowflake
description: Séparer développement et production.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Environnements

Le projet doit séparer les objets de développement et les objets de production.

## Bases attendues

Exemple de bases :

```sql
create database if not exists store;
create database if not exists store_dev;
```

`store_dev` sert au développement et à la validation.

`store` sert à la production.

## Pourquoi séparer

La séparation évite de modifier les tables utilisées par les rapports publiés pendant le développement.

## Point de contrôle

Avant une exécution, vérifier le `target` *dbt* et la base Snowflake ciblée.
