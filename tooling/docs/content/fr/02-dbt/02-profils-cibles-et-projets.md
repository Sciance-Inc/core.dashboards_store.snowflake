---
title: Profils, cibles et projets
description: Comprendre profiles.yml, profile et target.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Profils, cibles et projets

*dbt* doit savoir où se connecter. Cette information est dans `profiles.yml`.

Le fichier `dbt_project.yml` indique le nom du *profile* à utiliser. Le *target* indique l'environnement précis, par exemple `dev` ou `prod`.

## Profile

Le *profile* est le bloc de connexion. Il contient les sorties disponibles.

Dans les dépôts locaux générés par le template Snowflake, le *profile* s'appelle
`snowflake`.

## Target

Le *target* choisit une sortie dans le *profile*.

Exemple : `dev` peut pointer vers `store_dev`. `prod` peut pointer vers `store`.

## Deux modes de connexion

Le projet doit documenter deux configurations :

- la connexion par paire de clés;
- la connexion *SAML* ou *SSO* avec `authenticator: externalbrowser`.

Les exemples complets sont dans la page Snowflake sur l'authentification.

## Point de contrôle

Si `dbt debug` échoue, vérifier d'abord le nom du *profile*, le nom du *target* et le dossier où la commande est lancée.
