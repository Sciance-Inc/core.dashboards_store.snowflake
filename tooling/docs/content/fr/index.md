---
title: Accueil
description: Point d'entrée de la documentation du Store Snowflake.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Store Snowflake

Cette documentation accompagne le projet commun Snowflake partagé entre CSSDM, CSSPI et CSSMV.

Le but est de créer un socle commun pour les tableaux de bord de formation professionnelle. Le dépôt commun contient les transformations partagées. Les dépôts locaux contiennent les règles propres à chaque organisation.

## Par ou commencer

1. Lire la section `Démarrage`.
2. Installer la machine de travail.
3. Configurer le profil *dbt*.
4. Exécuter le premier modèle de vérification.
5. Lire la section `Store Snowflake` avant de modifier une règle.

## Ce que le site explique

- pourquoi le projet utilise *dbt*, *Git*, *Snowflake*, *Poetry* et *WSL2*;
- comment configurer une machine;
- comment configurer Snowflake;
- comment exécuter *dbt*;
- comment contribuer avec une *Pull Request*;
- comment demander de l'aide à une IA sans partager de secret.

## Vérification attendue

À la fin du parcours d'installation, `dbt debug` doit réussir et le modèle `smoketest` doit pouvoir lire le *seed* `int_sequence_0_to_1000`.
