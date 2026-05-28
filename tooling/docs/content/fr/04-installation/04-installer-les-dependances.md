---
title: Installer les dépendances
description: Préparer les dépendances Python et dbt.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Installer les dépendances

Les dépendances permettent d'utiliser la même version de *dbt* sur chaque poste.

## Activer l'environnement

Depuis le dépôt du projet :

```bash
eval $(poetry env activate)
```

Résultat attendu : le terminal utilise l'environnement Python du projet.

## Installer

```bash
poetry install
```

Résultat attendu : les dépendances se terminent sans erreur.

## Installer les dépendances dbt

Si le projet contient un fichier `packages.yml`, lancer :

```bash
dbt deps
```

Résultat attendu : *dbt* télécharge les dépendances déclarées.

## Point de contrôle

Lancer :

```bash
dbt --version
```

La version affichée doit correspondre aux dépendances du projet.
