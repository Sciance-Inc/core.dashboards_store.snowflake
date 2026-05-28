---
title: Commandes
description: Retrouver les commandes utiles.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Commandes

## Créer un dépôt local CSS

```bash
poetry run spin_template
```

Cette commande est la façon recommandée de créer un dépôt local à partir du
core Snowflake.

## Vérifier la connexion

```bash
dbt debug
```

## Charger les seeds

```bash
dbt seed
```

## Exécuter les modèles

```bash
dbt run
```

## Tester

```bash
dbt test
```

## Construire

```bash
dbt build
```

## Générer la documentation dbt

```bash
dbt docs generate
dbt docs serve
```

## Point de contrôle

Ajouter `--select` pour limiter l'exécution à un périmètre précis.
