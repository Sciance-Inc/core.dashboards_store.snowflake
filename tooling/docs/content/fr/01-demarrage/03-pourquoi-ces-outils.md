---
title: Pourquoi ces outils
description: Comprendre le rôle de chaque outil du projet.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Pourquoi ces outils

Le projet utilise plusieurs outils. Chaque outil a un rôle limité. Il n'est pas nécessaire de tout maîtriser avant de commencer.

## Ce que résout dbt

*dbt* exécute les transformations *SQL*. Il sait dans quel ordre les modèles doivent être exécutés.

Il sert aussi à tester les tables et à produire une documentation du graphe de dépendances.

À retenir : *dbt* transforme les données et vérifie une partie du résultat.

## Ce que résout Git

*Git* versionne les changements.

Il permet de travailler à plusieurs sans écraser le travail des autres. Il permet aussi de proposer une modification par *Pull Request* avant de l'intégrer.

À retenir : *Git* versionne le code et facilite la collaboration.

## Ce que résout Snowflake

*Snowflake* héberge les tables et exécute les requêtes.

Il permet de séparer les environnements, les rôles et les droits d'accès.

À retenir : *Snowflake* est l'endroit où les tables sont créées et consultées.

## Ce que résout Poetry

*Poetry* installe les bonnes versions de *dbt* et des dépendances Python.

Il réduit les écarts entre les postes de travail.

À retenir : *Poetry* rend l'environnement de travail plus stable.

## Ce que résout WSL2

*WSL2* fournit un environnement Linux sur Windows.

Les commandes de cette documentation sont écrites pour cet environnement.

À retenir : *WSL2* rend les commandes plus prévisibles sur les postes Windows.

## Point de contrôle

Si le lecteur ne sait plus quoi faire, il doit revenir à cette page et identifier l'outil concerné avant de continuer.
