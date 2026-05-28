---
title: Rôles et entrepôts
description: Créer les rôles et l'entrepôt Snowflake.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Rôles et entrepôts

Snowflake utilise des rôles pour contrôler les accès.

Un entrepôt fournit la puissance de calcul.

## Créer l'entrepôt

```sql
CREATE WAREHOUSE IF NOT EXISTS WH_XSMALL
  WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;
```

`AUTO_SUSPEND` limite les coûts lorsque l'entrepôt n'est pas utilisé.

## Créer les rôles

```sql
create role if not exists bvd_r_role;
create role if not exists bvd_rw_role;
```

`bvd_r_role` sert à lire.

`bvd_rw_role` sert à matérialiser les objets *dbt*.

## Point de contrôle

Vérifier que l'utilisateur de développement possède le rôle d'écriture avant d'exécuter *dbt*.
