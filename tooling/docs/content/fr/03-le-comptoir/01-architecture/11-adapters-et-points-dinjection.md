---
title: Adapters et points d'injection
description: Fournir localement le SQL attendu par le core.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Adapters et points d'injection

Dans le Store, un *adapter* est un modèle SQL local attendu par le core.

Le core connaît la forme nécessaire. Le dépôt local connaît la règle réelle.

## Pourquoi les adapters existent

Certaines règles ne peuvent pas être écrites une seule fois pour toutes les organisations.

Exemples:

- identifier les élèves réguliers;
- identifier une population locale;
- regrouper des programmes;
- exclure certains dossiers selon une règle interne;
- préparer une table qui dépend d'une source propre au centre;
- appliquer une règle trop complexe pour un *seed*.

Dans ces cas, le core définit le contrat. Le dépôt local écrit la requête.

## Différence entre seed, adapter et override

| Besoin | Mécanisme |
| --- | --- |
| La règle est une liste simple. | *Seed* |
| Le core attend une requête SQL locale. | *Adapter* |
| Le core fournit déjà une logique, mais elle ne convient pas. | *Override* |

Ces mécanismes servent tous la personnalisation, mais ils ne répondent pas au même besoin.

## Contrat d'un adapter

Le contrat doit dire:

- le nom du modèle à créer;
- les colonnes obligatoires;
- le grain attendu;
- les tests minimaux;
- les tags à utiliser;
- le schéma cible;
- les modèles ou dashboards qui consomment la sortie.

Exemple:

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

## Implémenter l'adapter local

Créer le modèle dans le dépôt local.

```text
cssxx.dashboards_store.snowflake/
  models/
    marts/
      formation_professionnelle/
        staging/
          stg_eleves_reguliers.sql
```

Exemple:

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

## Pourquoi ce mécanisme protège le core

Sans *adapter*, le core devrait contenir des branches propres à chaque organisation.

Avec un *adapter*:

```text
core
  -> définit le besoin et le contrat

dépôt local
  -> fournit la règle réelle
```

Le core reste simple. Le dépôt local reste propriétaire de sa règle.

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

Utiliser `adapter.dispatch` seulement lorsque la macro dépend de Snowflake ou d'un autre entrepôt. Pour une règle métier locale, utiliser plutôt un modèle local, un *seed* ou un *override*.

## Commandes utiles

Construire un adapter précis:

```bash
poetry run dbt build --select stg_eleves_reguliers
```

Construire l'adapter et les modèles qui en dépendent:

```bash
poetry run dbt build --select stg_eleves_reguliers+
```

Construire tous les adapters d'un périmètre si les tags sont configurés:

```bash
poetry run dbt build --select tag:adapter,tag:formation_professionnelle
```

## Point de contrôle

Un *adapter* est le bon mécanisme lorsque le core peut dire clairement ce qu'il attend, mais ne peut pas écrire la règle locale à la place du dépôt local.
