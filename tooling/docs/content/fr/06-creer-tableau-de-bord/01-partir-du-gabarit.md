---
title: Partir du gabarit
description: Utiliser le gabarit de tableau de bord pour réduire le temps de déploiement.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Partir du gabarit

Le gabarit de tableau de bord est le point de départ recommandé pour créer un rapport.

Dans le dépôt, le fichier de départ est `reporting/gabarit.pbit`.

Il ne remplace pas les tables produites par *dbt*. Il réduit le travail nécessaire pour connecter, vérifier et publier un rapport.

## Pourquoi utiliser le gabarit

Le gabarit évite de repartir de zéro.

Il fournit déjà :

- une structure de rapport;
- des pages de départ;
- des conventions visuelles;
- des paramètres de connexion;
- une connexion naturelle au *stamper*;
- des éléments de contrôle pour afficher les données produites;
- une logique de pseudo-anonymisation.

## Pseudo-anonymisation

Le gabarit peut aider à limiter l'exposition directe de certains identifiants dans les vues de travail.

Ce point doit être compris correctement : la pseudo-anonymisation n'est pas une anonymisation complète. Elle ne remplace pas les droits d'accès, la sécurité Snowflake ou les règles de partage de données.

Avant de diffuser un rapport, vérifier que les champs sensibles sont traités selon les règles de l'organisation.

## Connexion au stamper

Le gabarit est prévu pour fonctionner avec le *stamper*.

Le *stamper* indique quelles tables ont été produites et quand elles ont été mises à jour. Le rapport peut donc afficher rapidement si les données attendues sont récentes.

Cette information aide à répondre à une question simple : le rapport montre-t-il les dernières données produites par *dbt*.

## Paramètres de connexion

Le gabarit centralise les paramètres de connexion.

L'objectif est d'éviter de modifier la connexion table par table. Les requêtes du rapport doivent réutiliser les mêmes paramètres pour joindre Snowflake.

Quand un environnement change, par exemple entre `dev` et `prod`, la correction doit se faire au même endroit pour toutes les tables.

Ce fonctionnement réduit le temps de déploiement et limite les erreurs de copie.

## Comment partir du gabarit

1. Ouvrir `reporting/gabarit.pbit`.
2. Enregistrer une copie pour le tableau de bord.
3. Renseigner les paramètres de connexion Snowflake.
4. Vérifier que les tables finales produites par *dbt* sont visibles.
5. Vérifier que le *stamper* affiche les traces attendues.
6. Adapter les pages, mesures et libellés au besoin du rapport.
7. Conserver la logique commune du gabarit sauf raison claire de la remplacer.

## Ce qui peut être modifié

Il est normal de modifier :

- les pages du rapport;
- les titres;
- les filtres;
- les mesures propres au tableau de bord;
- les libellés destinés aux utilisateurs.

## Ce qui doit rester stable

Il faut éviter de modifier sans raison :

- les paramètres de connexion;
- la logique commune de connexion aux tables;
- la connexion au *stamper*;
- les mécanismes de pseudo-anonymisation;
- les conventions communes qui facilitent la maintenance.

## Avant publication

Avant de publier une copie du gabarit, vérifier trois points.

1. Les paramètres pointent vers le bon environnement.
2. Les tables affichées correspondent aux tables produites par *dbt*.
3. Le *stamper* confirme une exécution récente.

## Point de contrôle

Si la connexion Snowflake doit être modifiée dans plusieurs requêtes séparées, le rapport s'éloigne du gabarit. Revenir aux paramètres communs avant de publier.
