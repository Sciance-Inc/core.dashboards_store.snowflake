---
title: Exécution planifiée
description: Préparer une exécution automatisée.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Exécution planifiée

Une exécution planifiée lance *dbt* selon un horaire.

Elle doit utiliser un profil contrôlé.

## Ce qu'il faut définir

- la commande *dbt*;
- le *target*;
- le rôle Snowflake;
- la fréquence;
- les personnes à aviser en cas d'échec.

## Avant d'automatiser

La même commande doit réussir manuellement.

## Point de contrôle

Une exécution planifiée ne doit pas dépendre d'une session ouverte sur le poste d'une personne.
