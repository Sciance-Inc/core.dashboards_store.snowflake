---
title: Exécuter un premier modèle
description: Vérifier que dbt et Snowflake fonctionnent.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Exécuter un premier modèle

Le premier modèle sert à vérifier la connexion et le chargement d'un *seed*.

## Vérifier la connexion

```bash
dbt debug
```

Résultat attendu : la connexion Snowflake réussit.

## Charger le seed de séquence

```bash
dbt seed --select int_sequence_0_to_1000
```

Résultat attendu : la table du *seed* est créée.

## Exécuter le modèle de vérification

```bash
dbt run --select smoketest
```

Résultat attendu : le modèle `smoketest` retourne les premières valeurs du *seed*.

## Tester le seed

```bash
dbt test --select int_sequence_0_to_1000
```

Résultat attendu : les tests `not_null` et `unique` passent.
