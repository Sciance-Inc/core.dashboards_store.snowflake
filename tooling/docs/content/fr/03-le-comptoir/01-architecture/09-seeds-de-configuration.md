---
title: Seeds de configuration
description: Utiliser des CSV versionnés pour encoder des règles simples.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Seeds de configuration

Un *seed* est un fichier CSV chargé par *dbt* dans Snowflake.

Il sert à encoder une petite table stable.

## Quand utiliser un seed

Utiliser un *seed* lorsque la règle est une liste.

Exemples :

- codes de paiement à inclure;
- codes de paiement à exclure;
- programmes de formation à regrouper;
- libellés à afficher dans un tableau de bord;
- liste de tableaux de bord publiés;
- traductions de descriptions techniques.

Ne pas utiliser un *seed* pour une règle complexe. Si la règle demande plusieurs jointures ou des calculs, utiliser plutôt un modèle SQL ou un *adapter*.

## Exemple simple

Un CSS veut décider quels paiements doivent entrer dans un indicateur.

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

Le modèle SQL peut ensuite utiliser le *seed*.

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

## Décrire le contrat du seed

Le core devrait documenter le *seed* attendu dans un `schema.yml`.

```yaml
version: 2

seeds:
  - name: paiements_fp
    description: >
      Liste des codes de paiement à inclure ou exclure dans les indicateurs
      de formation professionnelle.
    columns:
      - name: code_paiement
        description: Code de paiement dans le système source.
        tests:
          - not_null
          - unique
      - name: description
        description: Description lisible du code.
      - name: inclure
        description: Indique si le code doit être inclus.
        tests:
          - not_null
```

Le dépôt local doit respecter ces colonnes.

## Charger un seed

Charger un *seed* précis.

```bash
poetry run dbt seed --select paiements_fp
```

Charger le *seed* et reconstruire les modèles qui en dépendent.

```bash
poetry run dbt build --select paiements_fp+
```

## Overrider un seed du core

Si le core fournit un *seed* par défaut, le dépôt local peut le remplacer.

Créer le CSV local avec le même nom.

```text
cssxx.dashboards_store.snowflake/
  seeds/
    dashboards/
      formation_professionnelle/
        paiements_fp.csv
```

Désactiver le *seed* du core.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
seeds:
  core_dashboards_store_snowflake:
    dashboards:
      formation_professionnelle:
        paiements_fp:
          +enabled: false
```

## Exemples observés dans le Store existant

CSSPI utilise un *seed* `tableaux.csv` pour lister des tableaux de bord.

```csv
Nom_tableaux
emp_actif
absenteeism
res_scolaires
effectif_css
chronic_absenteism
suivi_resultats
```

CSSPI utilise aussi un *seed* `translate.csv` pour traduire des descriptions.

```csv
originel,traduction
The daily absence rate and number of active students.,Le taux d'absence quotidien et le nombre d'élèves actifs.
```

Ces exemples montrent le bon usage d'un *seed* : une liste claire, versionnée, relue en *Pull Request* et chargée par *dbt*.

## Point de contrôle

Si une règle locale peut être lue dans un CSV par une personne métier, le *seed* est souvent le bon mécanisme.
