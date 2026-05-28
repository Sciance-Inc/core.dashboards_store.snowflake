---
title: Commandes de base
description: Lancer les commandes dbt courantes.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Commandes de base

Les commandes *dbt* doivent être lancées depuis le dépôt local du CSS, sauf indication contraire.

## Vérifier la connexion

```bash
dbt debug
```

Résultat attendu : *dbt* confirme qu'il trouve le projet et qu'il peut se connecter à Snowflake.

## Charger les seeds

```bash
dbt seed
```

Résultat attendu : les fichiers `.csv` sont chargés comme tables.

## Exécuter les modèles

```bash
dbt run
```

Résultat attendu : les tables et vues demandées sont créées dans Snowflake.

## Tester

```bash
dbt test
```

Résultat attendu : les tests passent ou indiquent précisément ce qui ne respecte pas le contrat.

## Construire tout le périmètre

```bash
dbt build
```

Cette commande combine plusieurs étapes : chargement, exécution et tests.

## Point de contrôle

Une commande réussie doit afficher un statut de succès. Si une erreur apparaît, lire le premier message d'erreur avant de relancer autre chose.
