---
title: Configurer profiles.yml
description: Configurer le profil dbt local.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Configurer profiles.yml

Le fichier `profiles.yml` est généré par le template cookiecutter.

Il doit être adapté à votre compte Snowflake avant de lancer une commande qui se
connecte à Snowflake.

Dans un dépôt local généré par `poetry run spin_template`, le profil dbt
s'appelle `snowflake`. Ce nom doit correspondre au champ `profile` du
`dbt_project.yml`.

Le fichier est volontairement ignoré par Git dans le dépôt local généré, car il
peut contenir des informations propres à un compte ou à un poste.

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
dbt debug --profiles-dir . --profile snowflake
```

Résultat attendu : *dbt* trouve le profil et confirme la connexion.
