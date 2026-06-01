---
title: Tables de filtres par grain
description: Synchroniser les filtres Power BI sans créer une table universelle confuse.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Tables de filtres par grain

Pour Power BI, la couche de *reporting* peut exposer des tables de filtres adaptées au grain du domaine ou du rapport.

Le principe est de créer des *filter spines* par grain plutôt qu'une table de filtres universelle qui mélange tous les domaines.

## Pourquoi ne pas utiliser une table universelle

Une seule table de filtres pour tous les rapports devient rapidement ambiguë.

Elle peut mélanger:

- des années scolaires;
- des établissements;
- des programmes;
- des matières;
- des corps d'emploi;
- des campagnes de sondage;
- des populations;
- des niveaux scolaires.

Ces colonnes ne vivent pas toujours au même grain. Les combinaisons peuvent donc devenir invalides ou difficiles à comprendre.

## Rôle d'une filter spine

Une table de filtres par grain sert à:

- synchroniser les filtres entre pages;
- éviter de répéter les mêmes colonnes de filtre dans toutes les tables;
- contrôler les combinaisons valides;
- réduire la complexité du modèle Power BI;
- rendre les relations plus lisibles.

## Exemples

```text
filter_ecole_annee
filter_sondage_theme_population
filter_resultat_matiere_niveau
filter_rh_ecole_corps_emploi
filter_programme_annee
filter_cohorte_statut
```

Chaque table correspond à un espace analytique cohérent.

## Lien avec les marts

Les tables de filtres ne doivent pas créer une nouvelle vérité métier.

Elles devraient être alimentées par des *marts* ou par des tables de reporting déjà gouvernées.

```text
Mart
  -> définit les concepts

Table de filtres
  -> expose les combinaisons utiles à Power BI
```

## Point de contrôle

Si une table de filtres commence à contenir des règles métier nouvelles, la règle doit être remontée vers un *mart*, un *seed*, un *adapter* ou un *override* documenté.
