---
title: Présentation DBT
description: Comprendre le rôle de dbt.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Présentation de dbt

*dbt* est l'outil qui transforme les données dans Snowflake.

Il ne sert pas à saisir des données. Il ne sert pas à remplacer Snowflake. Il lit des sources, exécute des modèles *SQL*, puis crée des tables ou des vues.

## Les fichiers importants

- les fichiers `.sql` contiennent les requêtes;
- les fichiers `.yml` décrivent les modèles, les colonnes et les tests;
- les fichiers `.csv` des *seeds* contiennent de petites tables de référence.

## Ce que dbt apporte

*dbt* construit un graphe. Ce graphe indique quel modèle dépend de quel autre modèle.

Quand une commande est lancée, *dbt* utilise ce graphe pour exécuter les étapes dans le bon ordre.

## Point de contrôle

Après cette page, le lecteur doit comprendre qu'un modèle *dbt* est un fichier *SQL* suivi par le dépôt.
