---
title: Contrats de données
description: Stabiliser les sorties attendues.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Contrats de données

Un contrat de données décrit ce qu'une table doit fournir.

Il précise les colonnes, les types, le grain et les tests attendus.

## Pourquoi le contrat est important

Le dépôt local peut changer l'implémentation.

Il ne doit pas changer la forme attendue par les tableaux de bord sans décision explicite.

## Exemple

Si une table finale contient une colonne `id_eleve`, un *override* doit aussi produire `id_eleve`.

## Point de contrôle

Après une modification, vérifier que les colonnes attendues existent encore.
