---
title: Marts Kimball
description: Stabiliser les définitions analytiques réutilisables.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Marts Kimball

Les *marts* portent la vérité analytique réutilisable du Store.

Ils ne sont pas conçus pour une page Power BI précise. Ils servent à stabiliser des concepts qui peuvent être utilisés par plusieurs tableaux de bord ou plusieurs analyses.

## Rôle d'un mart

Un *mart* définit une information une fois, avec:

- un grain clair;
- des clés stables;
- des dimensions réutilisables;
- des règles métier visibles;
- des tests;
- une documentation lisible.

Il évite de recopier la même règle dans plusieurs tableaux de bord.

## Contenu typique

Un *mart* contient typiquement:

```text
faits au grain explicite
dimensions conformes
clés stables
définitions métier propres
historisation maîtrisée
indicateurs réutilisables
```

Exemples:

```text
fact_resultats_examens
dim_ecole
dim_date
dim_eleve
dim_matiere

fact_absences_personnel
dim_ecole
dim_date
dim_personnel
dim_corps_emploi

fact_sondages
dim_ecole
dim_campagne
dim_theme
dim_population
```

## Questions auxquelles répond un mart

Le *mart* répond à des questions comme:

```text
Quel est le grain officiel de cette donnée?
Quelle dimension école doit être utilisée?
Comment définit-on une absence?
Quelle est la définition stable du taux de réussite?
Cette métrique doit-elle être réutilisable par plusieurs rapports?
```

Le *mart* ne devrait pas contenir une table simplement parce qu'elle est pratique pour une page Power BI. Il doit porter les définitions qui méritent d'être gouvernées.

## Exemples de domaines

Un *mart* peut préparer:

- la population d'élèves;
- les inscriptions;
- les programmes;
- les résultats;
- les paiements;
- les absences;
- les dimensions d'établissement;
- les dimensions de date.

Si plusieurs tableaux de bord ont besoin de la même table ou de la même définition, cette table est probablement un bon candidat pour un *mart*.

## Personnalisation locale

Un *mart* peut dépendre de règles locales. Dans ce cas, la règle locale ne doit pas forcément être écrite dans le core.

Le core peut définir le contrat attendu, puis laisser le dépôt local fournir la partie variable.

Cette personnalisation peut passer par:

- un [seed](/fr/03-le-comptoir/01-architecture/03-adapters-et-seeds/02-seeds-de-configuration);
- un [adapter](/fr/03-le-comptoir/01-architecture/03-adapters-et-seeds/03-adapters-et-points-dinjection);
- un [override](/fr/03-le-comptoir/01-architecture/05-overriding/01-concept).

## Point de contrôle

Avant de créer une table dans la couche de reporting, vérifier si elle porte une définition qui sera utile ailleurs. Si oui, la placer dans un *mart* ou créer un point de personnalisation local autour du *mart*.
