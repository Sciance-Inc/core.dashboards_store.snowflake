---
title: Bases, schémas et droits Snowflake
description: Accorder les permissions nécessaires.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Bases, schémas et droits

Les commandes suivantes doivent être validées par l'équipe TI avant exécution.

## Accès à l'entrepôt

```sql
grant usage on warehouse wh_xsmall to role bvd_r_role;
grant usage on warehouse wh_xsmall to role bvd_rw_role;
```

## Accès aux bases

```sql
grant usage on database store to role bvd_r_role;
grant usage on database store_dev to role bvd_r_role;
grant usage on database store to role bvd_rw_role;
grant usage on database store_dev to role bvd_rw_role;
```

## Droits de lecture

```sql
grant select on future tables in database store to role bvd_r_role;
grant select on future views in database store to role bvd_r_role;
grant select on future tables in database store_dev to role bvd_r_role;
grant select on future views in database store_dev to role bvd_r_role;
```

## Droits d'écriture

```sql
grant create schema on database store to role bvd_rw_role;
grant create schema on database store_dev to role bvd_rw_role;
grant insert, update, delete, truncate on future tables in database store to role bvd_rw_role;
grant insert, update, delete, truncate on future tables in database store_dev to role bvd_rw_role;
```

## Ajouter un utilisateur

```sql
grant role bvd_rw_role to user <vous>;
alter user <vous> set default_role = bvd_rw_role;
alter user <vous> set default_secondary_roles = ('all');
```

## Point de contrôle

L'utilisateur doit pouvoir créer un schéma et une table dans la base de développement.
