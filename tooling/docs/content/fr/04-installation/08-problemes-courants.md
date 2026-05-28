---
title: Problèmes courants
description: Diagnostiquer les erreurs fréquentes.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Problèmes courants

Une erreur d'installation est normale. Il faut lire le premier message utile.

## Profil introuvable

Vérifier que `profiles.yml` existe dans le dépôt local généré.

Vérifier aussi que le nom du *profile* correspond au nom dans `dbt_project.yml`.

## Rôle insuffisant

Si Snowflake refuse de créer une table, vérifier le rôle actif.

Le rôle d'écriture doit avoir les droits de création attendus.

## Invite SSO répétée

Si la connexion demande une authentification trop souvent, demander aux administrateurs Snowflake d'évaluer :

```sql
ALTER ACCOUNT SET ALLOW_ID_TOKEN = TRUE;
```

## Clé privée introuvable

Vérifier le chemin du fichier de clé dans `profiles.yml`.

Ne jamais versionner la clé privée dans Git.

## Point de contrôle

Après correction, relancer `dbt debug --profiles-dir . --profile snowflake`
avant de lancer un modèle.
