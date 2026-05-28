---
title: Sélection, tags et dépendances
description: Exécuter une partie du projet avec dbt.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Sélection, tags et dépendances

Il n'est pas toujours nécessaire d'exécuter tout le projet.

*dbt* permet de choisir un modèle, un *tag* ou un groupe de dépendances.

## Sélectionner un modèle

```bash
dbt build --select smoketest
```

Résultat attendu : seul le modèle `smoketest` et les éléments requis sont traités selon la sélection.

## Sélectionner un tag

```bash
dbt build --select tag:si_apres_fp
```

Résultat attendu : les objets associés au tag `si_apres_fp` sont traités.

## Inclure les dépendances en amont

```bash
dbt build --select +tag:si_apres_fp
```

Le signe `+` demande à *dbt* d'inclure ce qui est nécessaire avant la sélection.

## Point de contrôle

Si une table source manque, relancer avec `+` devant la sélection.
