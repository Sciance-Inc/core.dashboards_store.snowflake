---
title: Documentation dbt et lineage
description: Générer la documentation du graphe dbt.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Documentation dbt et lineage

*dbt* peut générer une documentation technique du projet.

Cette documentation montre les modèles, les colonnes, les tests et les dépendances.

## Générer la documentation

```bash
dbt docs generate
```

Résultat attendu : *dbt* produit les fichiers de documentation technique.

## Lire localement

```bash
dbt docs serve
```

Résultat attendu : une page locale permet de consulter le graphe.

## Pourquoi le lineage aide

Le *lineage* montre d'où vient une table et ce qu'elle alimente.

Il aide à répondre à une question fréquente : si je modifie ce modèle, quelles tables seront touchées.

## Point de contrôle

Avant une modification importante, consulter le graphe pour repérer les dépendances.
