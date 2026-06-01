---
title: Deux dépôts et responsabilités
description: Séparer le commun, le local et les points de personnalisation.
author: hugo.juhel@sciance.ca
updatedAt: 2026-06-01
---

::page-metadata
::

# Deux dépôts et responsabilités

Le Store Snowflake fonctionne avec deux types de dépôts.

Cette séparation est essentielle. Elle permet d'avoir un socle commun tout en laissant chaque organisation adapter le Store à ses sources et à ses règles.

## Dépôt commun

Le dépôt `core.dashboards_store.snowflake` contient les éléments partagés.

Il porte:

- les conventions;
- les macros communes;
- les modèles réutilisables;
- les contrats de données;
- les exemples de structure;
- les points d'entrée que le dépôt local doit fournir.

Le dépôt commun ne doit pas contenir une règle qui est vraie seulement pour une organisation.

## Dépôt local

Le dépôt local contient les choix propres à un centre de services scolaire.

Il porte:

- les sources réellement disponibles;
- les chemins vers les bases et schémas Snowflake;
- les règles locales;
- les *seeds* de configuration;
- les *adapters* SQL;
- les *overrides*;
- les validations locales.

Le dépôt local installe le core comme package *dbt*.

```yaml
# cssxx.dashboards_store.snowflake/packages.yml
packages:
  - local: "../core.dashboards_store.snowflake"
```

Après `dbt deps`, les modèles du core sont disponibles dans le projet local.

## Pourquoi cette séparation existe

Le Store doit répondre à deux besoins qui semblent opposés.

Il doit standardiser ce qui peut l'être:

```text
structure des dossiers
contrats de données
grains analytiques
tables finales attendues
macros communes
```

Il doit aussi permettre la personnalisation:

```text
noms de bases différents
schémas sources différents
codes locaux différents
règles de regroupement différentes
exceptions locales
```

Sans cette séparation, le core deviendrait soit trop rigide, soit rempli d'exceptions locales.

## Exemple de décision

Si tous les centres calculent un indicateur de la même façon, la règle appartient au core.

Si un centre doit exclure certains codes selon une règle interne, la règle appartient au dépôt local.

Si la règle locale est une liste de codes, utiliser un *seed*.

Si la règle locale demande une requête SQL, utiliser un *adapter*.

Si la règle commune existe déjà, mais ne convient pas, utiliser un *override*.

## Point de contrôle

Une *Pull Request* doit indiquer clairement si elle modifie le commun ou une personnalisation locale. Une règle locale ne devrait pas être ajoutée au core sans décision explicite.
