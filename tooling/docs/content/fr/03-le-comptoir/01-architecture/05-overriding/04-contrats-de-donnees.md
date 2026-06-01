---
title: Contrats de données
description: Stabiliser les sorties attendues malgré les personnalisations locales.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Contrats de données

Un contrat de données décrit ce qu'une table doit fournir.

Il protège les modèles suivants et les tableaux de bord, surtout lorsqu'un dépôt local personnalise le Store.

## Pourquoi les contrats sont nécessaires

Les *seeds*, les *adapters* et les *overrides* permettent de personnaliser le Store.

Cette personnalisation est utile, mais elle doit rester contrôlée.

Le contrat permet de dire:

```text
La règle locale peut changer.
La sortie attendue doit rester stable.
```

## Ce que le contrat doit préciser

Un contrat doit indiquer:

- le nom du modèle;
- le grain;
- les colonnes obligatoires;
- les types importants;
- les valeurs attendues si elles sont limitées;
- les tests;
- les modèles qui consomment la table;
- les tableaux de bord qui consomment la table.

## Exemple de contrat

```yaml
version: 2

models:
  - name: stg_eleves_reguliers
    description: >
      Élèves considérés réguliers pour le projet FP.
      Le grain est un élève par année scolaire et par programme.
    columns:
      - name: id_eleve
        description: Identifiant stable de l'élève.
        tests:
          - not_null
      - name: annee_scolaire
        description: Année scolaire de l'inscription.
        tests:
          - not_null
      - name: code_programme
        description: Code du programme de formation professionnelle.
        tests:
          - not_null
```

## Contrat et personnalisation

Un dépôt local peut changer la méthode de calcul.

Il ne doit pas retirer une colonne attendue.

Il ne doit pas changer le grain sans décision explicite.

Exemple:

```sql
-- Contrat attendu
select
    id_eleve,
    annee_scolaire,
    code_programme
from ...
```

Si le modèle local ajoute une colonne, les colonnes existantes doivent rester présentes.

```sql
-- Acceptable si les colonnes du contrat restent présentes
select
    id_eleve,
    annee_scolaire,
    code_programme,
    code_etablissement
from ...
```

Si le modèle local retire `code_programme`, il ne respecte plus le contrat.

## Tests minimaux

Exécuter les tests du modèle.

```bash
poetry run dbt test --select stg_eleves_reguliers
```

Exécuter aussi les modèles qui dépendent de lui.

```bash
poetry run dbt build --select stg_eleves_reguliers+
```

## Point de contrôle

Après une personnalisation locale, la question principale est: est-ce que les tableaux de bord et les modèles suivants peuvent encore lire la sortie sans changement?
