---
title: Exécution locale
description: Lancer dbt depuis un poste de travail.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Exécution locale

L'exécution locale sert au développement et à la validation.

## Commande de départ

```bash
dbt debug
```

Résultat attendu : la connexion est valide.

## Exécution ciblée

```bash
dbt build --select +smoketest
```

Résultat attendu : le modèle choisi et ses dépendances sont traités.

## Prudence

Ne pas lancer une exécution large si le *target* n'a pas été vérifié.

## Point de contrôle

Vérifier le dossier courant avec `pwd` avant une commande importante.
