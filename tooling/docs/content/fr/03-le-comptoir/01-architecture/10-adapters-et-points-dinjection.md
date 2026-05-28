---
title: Adapters et points d'injection
description: Fournir localement le SQL attendu par le core.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Adapters et points d'injection

Dans le Store, un *adapter* est un point d'entrée SQL que le dépôt local doit fournir.

Le core connaît le contrat attendu. Le CSS connaît la règle locale.

## Pourquoi ce mécanisme existe

Certaines règles ne peuvent pas être écrites une seule fois pour tous les CSS.

Exemples :

- identifier les élèves réguliers;
- identifier les élèves dans un parcours adapté;
- regrouper des programmes locaux;
- exclure certains dossiers selon une règle interne;
- préparer une table qui dépend d'une source propre au CSS.

Dans ce cas, le core définit la forme attendue. Le dépôt local écrit la requête.

## Différence entre adapter et override

Un *override* remplace un modèle commun déjà écrit.

Un *adapter* remplit un point d'entrée prévu par le core.

| Besoin | Mécanisme |
| --- | --- |
| Le core fournit déjà une logique, mais elle ne convient pas. | *Override* |
| Le core ne peut pas connaître la règle locale. | *Adapter* |
| La règle est une simple liste. | *Seed* |

## Contrat d'un adapter

Le contrat doit dire :

- le nom du modèle à créer;
- les colonnes obligatoires;
- le grain attendu;
- les tests minimaux;
- les tags à utiliser;
- le schéma cible.

Exemple de contrat dans le core :

```yaml
version: 2

models:
  - name: stg_eleves_reguliers
    description: >
      Adapter local qui identifie les élèves réguliers en formation professionnelle.
      Le grain attendu est un élève par année scolaire et par programme.
    config:
      schema: formation_professionnelle_staging
      tags:
        - formation_professionnelle
        - adapter
    columns:
      - name: id_eleve
        tests:
          - not_null
      - name: annee_scolaire
        tests:
          - not_null
      - name: code_programme
        tests:
          - not_null
```

## Implémenter l'adapter dans le dépôt local

Créer le modèle local.

```text
cssxx.dashboards_store.snowflake/
  models/
    marts/
      formation_professionnelle/
        staging/
          stg_eleves_reguliers.sql
```

Exemple :

```sql
-- cssxx.dashboards_store.snowflake/models/marts/formation_professionnelle/staging/stg_eleves_reguliers.sql

{{ config(schema="formation_professionnelle_staging") }}

select distinct
    inscription.id_eleve,
    inscription.annee_scolaire,
    inscription.code_programme
from {{ ref("i_inscriptions_fp") }} as inscription
where inscription.statut_inscription in ('REGULIER', 'ACTIF')
```

Le core peut ensuite consommer ce modèle avec `ref()`.

```sql
select
    id_eleve,
    annee_scolaire,
    code_programme
from {{ ref("stg_eleves_reguliers") }}
```

## Exemple observé dans le Store existant

Le Store existant utilise des adapters de population.

Le core consomme cinq points d'entrée.

```sql
select code_perm, id_eco, annee, 'Prescolaire' as population
from {{ source_or_ref("populations", "stg_ele_prescolaire") }}
union
select code_perm, id_eco, annee, 'Primaire régulier' as population
from {{ source_or_ref("populations", "stg_ele_primaire_reg") }}
union
select code_perm, id_eco, annee, 'Secondaire régulier' as population
from {{ source_or_ref("populations", "stg_ele_secondaire_reg") }}
```

Chaque dépôt local fournit les modèles attendus, par exemple `stg_ele_primaire_reg.sql`.

Le contrat est documenté dans un fichier `adapters.yml`. Il précise les colonnes `code_perm`, `id_eco` et `annee`, ainsi que les tests attendus.

La même logique doit être utilisée dans le Store Snowflake : le core documente le contrat, le dépôt local fournit la requête.

## Flot complet dans un dépôt local

Le flot observé dans `csspi.dashboards_store` est le suivant.

Le dépôt local déclare le core comme package.

```yaml
# csspi.dashboards_store/packages.yml
packages:
  - git: git@github.com:Sciance-Inc/core.dashboards_store.git
    revision: v0.19.2+20251124
```

Le dépôt local indique ensuite qu'il est le contexte d'exécution.

```yaml
# csspi.dashboards_store/dbt_project.yml
vars:
  is_context_core: false
```

Quand le core appelle `source_or_ref("populations", "stg_ele_primaire_reg")`, la macro retourne donc :

```sql
{{ ref("stg_ele_primaire_reg") }}
```

Le modèle local `csspi.dashboards_store/models/.../stg_ele_primaire_reg.sql` devient le point d'entrée utilisé par le core.

Dans Snowflake, le même flot doit être conservé :

1. le dépôt local installe `core.dashboards_store.snowflake`;
2. le dépôt local garde `is_context_core: false`;
3. le core définit les contrats attendus;
4. le dépôt local fournit les modèles SQL attendus;
5. les commandes *dbt* sont exécutées depuis le dépôt local.

## Adapters au sens de dbt

Le mot *adapter* peut aussi désigner l'implémentation propre à l'entrepôt de données.

Dans ce cas, on parle de `adapter.dispatch`.

Le stamper Snowflake utilise ce mécanisme.

```sql
{% macro stamp_model(dashboard_name) %}
  {{
    return(
      adapter.dispatch("stamp_model", "core_dashboards_store_snowflake")(
        dashboard_name
      )
    )
  }}
{% endmacro %}
```

Puis le core fournit l'implémentation Snowflake.

```sql
{% macro snowflake__stamp_model(dashboard_name) %}
  -- implementation Snowflake
{% endmacro %}
```

Utiliser `adapter.dispatch` seulement lorsque la macro dépend de Snowflake ou d'un autre entrepôt. Pour une règle d'affaires locale, utiliser plutôt un modèle local ou un *seed*.

## Commandes utiles

Construire un adapter précis.

```bash
poetry run dbt build --select stg_eleves_reguliers
```

Construire l'adapter et les modèles qui en dépendent.

```bash
poetry run dbt build --select stg_eleves_reguliers+
```

Construire tous les adapters d'un périmètre si les tags sont configurés.

```bash
poetry run dbt build --select tag:adapter,tag:formation_professionnelle
```

## Point de contrôle

Un *adapter* est bon lorsque le core peut dire clairement ce qu'il attend, mais ne peut pas écrire la règle locale à la place du CSS.
