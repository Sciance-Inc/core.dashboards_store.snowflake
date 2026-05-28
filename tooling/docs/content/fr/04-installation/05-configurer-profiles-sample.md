---
title: Configurer profiles-sample
description: Créer le profil dbt local.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Configurer profiles-sample

Le fichier `profiles-sample.yml` est un exemple.

Il doit être copié vers le fichier `~/.dbt/profiles.yml`, puis adapté à votre compte Snowflake.

## Champs importants

- `account` : identifiant du compte Snowflake;
- `user` : nom d'utilisateur;
- `role` : rôle utilisé;
- `warehouse` : entrepôt de calcul;
- `database` : base cible;
- `schema` : schéma cible;
- `authenticator` : mode d'authentification.

## Deux modes possibles

Le projet documente deux modes :

- paire de clés;
- *SAML* ou *SSO* avec `authenticator: externalbrowser`.

## Point de contrôle

Après la configuration, lancer :

```bash
dbt debug
```

Résultat attendu : *dbt* trouve le profil et confirme la connexion.
