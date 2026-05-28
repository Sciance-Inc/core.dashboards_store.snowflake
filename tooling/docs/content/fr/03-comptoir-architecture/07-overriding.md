---
title: Overriding
description: Comprendre les mécanismes de surcharge locale du Store.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Overriding

L'*overriding* consiste à remplacer ou compléter une ressource du dépôt commun par une ressource du dépôt local.

Le besoin est simple : le dépôt commun fournit une base partagée, mais certaines règles doivent rester locales à un CSS.

## Le flot général

Le Store fonctionne avec deux dépôts.

- `core.dashboards_store.snowflake` contient le code commun.
- `cssxx.dashboards_store.snowflake` contient les choix locaux.

Le dépôt local déclare le dépôt commun comme package *dbt*.

```yaml
# cssxx.dashboards_store.snowflake/packages.yml
packages:
  - local: "../core.dashboards_store.snowflake"
```

Après `dbt deps`, *dbt* installe le package commun dans `dbt_packages/`. Le dépôt local peut alors référencer les macros et les modèles du core.

Le dépôt local garde ensuite ses modèles, ses *seeds* et ses macros dans ses propres dossiers.

```text
cssxx.dashboards_store.snowflake/
  dbt_project.yml
  models/
  seeds/
  macros/
  packages.yml
```

Les commandes *dbt* doivent être lancées depuis le dépôt local.

```bash
poetry run dbt deps
poetry run dbt build --select tag:formation_professionnelle
```

Le template Snowflake part d'une configuration prudente.

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
models:
  cssxx_dashboards_store_snowflake:
    +materialized: table

  core_dashboards_store_snowflake:
    +enabled: false

vars:
  is_context_core: false
```

Cette configuration dit deux choses :

- le dépôt local possède ses propres modèles;
- le code commun est activé seulement lorsqu'il est explicitement requis.

## Trois façons d'adapter le Store

Il y a trois mécanismes principaux.

| Mécanisme | Quand l'utiliser | Exemple |
| --- | --- | --- |
| *Override* de modèle | La logique commune ne convient pas au CSS. | Modifier la règle qui identifie les élèves réguliers. |
| *Seed* de configuration | La règle est une petite liste stable. | Inclure ou exclure certains codes de paiement. |
| *Adapter* local | Le core a besoin d'un point d'entrée SQL que chaque CSS doit fournir. | Produire une population locale avec `id_eleve`, `annee_scolaire` et `code_programme`. |

Ces mécanismes ne sont pas interchangeables.

Un *seed* est préférable lorsque la règle tient dans un fichier CSV clair. Un *adapter* est préférable lorsque la règle demande une requête SQL. Un *override* est préférable lorsque le modèle commun existe déjà, mais doit être remplacé localement.

## Exemple du Store existant

Dans le Store existant, le core définit des points d'entrée de population.

```sql
select code_perm, id_eco, annee, 'Primaire régulier' as population
from {{ source_or_ref("populations", "stg_ele_primaire_reg") }}
```

La macro `source_or_ref` change le comportement selon le contexte.

```sql
{% macro source_or_ref(namespace, table) %}
  {%- if var("is_context_core", False) %}
    {{- source(namespace, table) -}}
  {%- else %}
    {{- ref(table) -}}
  {%- endif -%}
{% endmacro %}
```

Dans le core seul, le modèle lit une *source*. Dans un dépôt local, `is_context_core` vaut `false`, donc le modèle lit un `ref()` local.

Le template Snowflake conserve cette intention :

```yaml
# cssxx.dashboards_store.snowflake/dbt_project.yml
vars:
  is_context_core: false
```

Cette variable ne doit pas être retirée. Elle indique que le projet est exécuté depuis un dépôt local.

## Règle importante

Un *override* peut changer le calcul. Il ne doit pas changer le contrat sans décision explicite.

Le contrat comprend :

- le nom du modèle;
- le grain de la table;
- les colonnes attendues;
- les types importants;
- les tests attendus;
- les tableaux de bord qui consomment la sortie.

## Pages à lire ensuite

- [Overrider un modèle](/fr/03-comptoir-architecture/08-overrider-un-modele)
- [Seeds de configuration](/fr/03-comptoir-architecture/09-seeds-de-configuration)
- [Adapters et points d'injection](/fr/03-comptoir-architecture/10-adapters-et-points-dinjection)
- [Contrats de données](/fr/03-comptoir-architecture/12-contrats-de-donnees)

## Point de contrôle

Avant de modifier le core, vérifier si le besoin peut être traité par un *override*, un *seed* ou un *adapter* dans le dépôt local.
