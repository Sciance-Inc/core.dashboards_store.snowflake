---
title: Authentification Snowflake et profils dbt
description: Configurer dbt avec Snowflake.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Authentification et profils dbt

Le projet documente deux modes de connexion.

Choisir le mode demandé par l'équipe TI.

## Connexion par paire de clés

Ce mode est adapté aux exécutions automatisées lorsque la politique TI l'autorise.

```yaml
snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <compte_snowflake>
      user: <utilisateur>
      private_key_path: ~/.ssh/snowflake_key.p8
      role: bvd_rw_role
      warehouse: WH_XSMALL
      database: store_dev
      schema: <schema_de_developpement>
      threads: 4
```

Ne jamais versionner la clé privée dans Git.

## Connexion SAML ou SSO

Ce mode est adapté aux postes utilisateurs avec authentification fédérée.

```yaml
snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <compte_snowflake>
      user: <courriel_utilisateur>
      authenticator: externalbrowser
      role: bvd_rw_role
      warehouse: WH_XSMALL
      database: store_dev
      schema: <schema_de_developpement>
      threads: 4
```

## Recommandation pour SAML ou SSO

Demander aux administrateurs Snowflake d'évaluer cette configuration :

```sql
ALTER ACCOUNT SET ALLOW_ID_TOKEN = TRUE;
```

Elle réduit les invites d'authentification répétées.

## Point de contrôle

Après avoir choisi un mode, lancer :

```bash
dbt debug --profiles-dir . --profile snowflake
```
