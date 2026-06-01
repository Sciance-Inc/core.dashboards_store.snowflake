---
title: Concept
description: Choisir entre seed, adapter et override pour personnaliser localement.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Adapters et seeds

::alert{type="warning"}
Les *seeds* et les *adapters* sont des contrats définis par le core et implémentés par le dépôt local. S'ils sont requis par un mart ou un tableau de bord, ils doivent être fournis localement.
::

Les *marts* et les tableaux de bord peuvent utiliser des *adapters* et des *seeds* pour recevoir des règles propres à un centre de services scolaire.

Ces mécanismes servent à personnaliser le Store sans modifier directement `core.dashboards_store.snowflake`.

## Différence entre seed, adapter et override

| Besoin | Mécanisme |
| --- | --- |
| La règle est une liste simple. | [Seed](/fr/03-le-comptoir/01-architecture/03-adapters-et-seeds/02-seeds-de-configuration) |
| Le core attend une requête SQL locale. | [Adapter](/fr/03-le-comptoir/01-architecture/03-adapters-et-seeds/03-adapters-et-points-dinjection) |
| Le core fournit déjà une logique, mais elle ne convient pas. | [Override](/fr/03-le-comptoir/01-architecture/05-overriding/01-concept) |

Ces mécanismes servent tous la personnalisation, mais ils ne répondent pas au même besoin.

## Pourquoi ils existent

Certaines règles ne peuvent pas être écrites une seule fois pour toutes les organisations.

Exemples:

- identifier les élèves réguliers;
- identifier une population locale;
- regrouper des programmes;
- inclure ou exclure des codes;
- ajouter des libellés locaux;
- préparer une table qui dépend d'une source propre au centre.

Sans ces points d'injection, le core devrait contenir des branches propres à chaque organisation.

Avec ces mécanismes:

```text
core
  -> définit le besoin et le contrat

dépôt local
  -> fournit la règle réelle
```

Le core reste simple. Le dépôt local reste propriétaire de ses règles.

## Contrat à respecter

Un contrat doit dire:

- le nom de la ressource;
- le grain attendu;
- les colonnes obligatoires;
- les types importants;
- les tests minimaux;
- les modèles ou tableaux de bord qui consomment la sortie.

La règle locale peut changer. La sortie attendue doit rester stable.

## Point de contrôle

Utiliser un *seed* lorsque la règle tient dans un CSV. Utiliser un *adapter* lorsque le core attend une requête SQL locale. Utiliser un *override* lorsque la logique commune existe déjà mais doit être remplacée.
