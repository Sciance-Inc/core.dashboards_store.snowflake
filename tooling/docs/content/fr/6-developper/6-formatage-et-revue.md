---
title: Formatage et revue
description: Préparer un changement lisible.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Formatage et revue

Un changement doit être facile à relire.

Le formatage aide la revue. Les tests aident à vérifier le comportement.

## Commandes utiles

```bash
poetry run sqlfmt .
```

Résultat attendu : les fichiers *SQL* sont formatés.

```bash
dbt parse
```

Résultat attendu : *dbt* comprend le projet.

## Avant la revue

1. Décrire le changement.
2. Lister les tests lancés.
3. Expliquer l'impact métier.
4. Ouvrir une *Pull Request*.

## Point de contrôle

Une autre personne doit pouvoir comprendre le changement sans deviner l'intention.
