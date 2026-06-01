---
title: Seeds de configuration
description: Utiliser des CSV versionnés pour encoder des règles simples.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Seeds de configuration

Un *seed* est un fichier CSV chargé par *dbt* dans Snowflake.

Il sert à encoder une petite table stable, versionnée et facile à relire en revue.

## Pourquoi les seeds sont importantes

Les *seeds* sont un mécanisme de personnalisation locale.

Elles permettent à un dépôt local de fournir une règle sans modifier le core.

Exemples:

- codes à inclure;
- codes à exclure;
- regroupements de programmes;
- libellés à afficher;
- seuils simples;
- listes de tableaux de bord;
- traductions de descriptions techniques.

Une règle locale peut ainsi rester visible dans un CSV plutôt que cachée dans une requête SQL.

## Quand utiliser un seed

Utiliser un *seed* lorsque la règle est une liste.

```text
La règle tient dans un tableau simple
  -> seed

La règle demande des jointures ou des calculs
  -> modèle SQL ou adapter

La règle remplace une logique commune
  -> override
```

## Exemple

Un centre veut décider quels codes de paiement doivent entrer dans un indicateur.

```csv
code_paiement,description,inclure
INSCRIPTION,Frais d'inscription,true
MATERIEL,Matériel scolaire,true
DEPOT_GARANTIE,Dépôt de garantie,false
```

Le fichier peut être placé dans le dépôt local.

```text
cssxx.dashboards_store.snowflake/
  seeds/
    formation_professionnelle/
      paiements_fp.csv
```

Un modèle SQL peut ensuite utiliser ce *seed*.

```sql
select
    paiement.id_eleve,
    paiement.annee_scolaire,
    paiement.montant
from {{ ref("stg_paiements_fp") }} as paiement
inner join {{ ref("paiements_fp") }} as config
    on paiement.code_paiement = config.code_paiement
where config.inclure
```

## Contrat du seed

Lorsque le core attend un *seed*, il doit documenter son contrat.

Le contrat doit préciser:

- le nom du *seed*;
- les colonnes attendues;
- les types importants;
- les tests minimaux;
- le rôle de chaque colonne.

Exemple:

```yaml
version: 2

seeds:
  - name: paiements_fp
    description: >
      Liste des codes de paiement à inclure ou exclure dans les indicateurs
      de formation professionnelle.
    columns:
      - name: code_paiement
        tests:
          - not_null
          - unique
      - name: description
      - name: inclure
        tests:
          - not_null
```

Le dépôt local doit respecter ces colonnes.

## Charger un seed

Charger un *seed* précis:

```bash
poetry run dbt seed --select paiements_fp
```

Charger le *seed* et reconstruire les modèles qui en dépendent:

```bash
poetry run dbt build --select paiements_fp+
```

## Remplacer un seed du core

Si le core fournit un *seed* par défaut, le dépôt local peut le remplacer.

Créer le CSV local avec le même nom, puis désactiver le *seed* du core.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
seeds:
  core_dashboards_store_snowflake:
    formation_professionnelle:
      paiements_fp:
        +enabled: false
```

## Point de contrôle

Si une règle locale peut être lue dans un CSV par une personne métier, le *seed* est souvent le meilleur mécanisme de personnalisation.
