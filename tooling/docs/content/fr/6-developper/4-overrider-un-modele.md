---
title: Overrider un modèle
description: Remplacer localement une implémentation commune.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Overrider un modèle

Un *override* remplace un modèle commun par une version locale.

Il doit être utilisé avec prudence.

## Étapes

1. Copier le nom du modèle à remplacer.
2. Créer le modèle local.
3. Désactiver le modèle commun correspondant.
4. Garder le même grain.
5. Garder les colonnes attendues.
6. Exécuter les tests.

## Point de contrôle

La sortie locale doit pouvoir remplacer la sortie commune sans casser le tableau de bord.
