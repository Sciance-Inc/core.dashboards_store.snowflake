---
title: Cloner les dépôts
description: Placer le dépôt commun et le dépôt local.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Cloner les dépôts

Le projet utilise un dépôt commun et un dépôt local.

Le dépôt commun contient le code partagé. Le dépôt local contient les adaptations d'un CSS.

## Action

Placer les deux dépôts dans un même dossier de travail.

Exemple :

```text
dashboards_store/
  core.dashboards_store.snowflake/
  cssxx.dashboards_store.snowflake/
```

Pour créer le dépôt local initial, utiliser la commande de référence depuis le
dépôt commun :

```bash
poetry run spin_template
```

## Ou lancer les commandes

Les commandes *dbt* doivent être lancées depuis le dépôt local du CSS lorsque celui-ci existe.

Le dépôt commun sert de dépendance et de référence.

## Point de contrôle

Avant de lancer *dbt*, vérifier le dossier courant avec :

```bash
pwd
```
