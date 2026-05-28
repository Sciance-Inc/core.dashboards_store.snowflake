---
title: Template cookiecutter
description: Préparer la création d'un dépôt local minimal.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Template cookiecutter

Un template *cookiecutter* permet de créer rapidement un dépôt local minimal.

La commande de référence est `poetry run spin_template`. C'est le *way to go*
pour créer un dépôt local CSS à partir du core Snowflake.

## Ce que le template crée

- un `dbt_project.yml` local;
- un `profiles.yml`;
- un dossier `models`;
- un dossier `seeds`;
- un dossier `tests`;
- un dossier `reporting` avec le gabarit Power BI commun;
- une configuration de départ;
- une arborescence minimale `formation_professionnelle`.

## Créer un dépôt local

Depuis le dépôt `core.dashboards_store.snowflake` :

```bash
poetry run spin_template
```

La commande lance le template *cookiecutter* du core et crée par défaut le
dépôt généré dans le dossier parent du core. Cette sortie donne la structure
attendue :

```text
dashboards_store/
  core.dashboards_store.snowflake/
  cssxx.dashboards_store.snowflake/
```

Le projet généré utilise le profil dbt `snowflake`. Le fichier `profiles.yml`
généré contient un profil `snowflake` avec des sorties `dev` et `prod`.

Le fichier `profiles.yml` est généré pour faciliter le démarrage local, mais il
reste ignoré par Git dans le dépôt local généré.

Pour un test automatisé ou une génération sans questions interactives, il est
possible de passer les arguments de *cookiecutter* après la commande :

```bash
poetry run spin_template --no-input css_short_name=csspi
```

L'appel direct à `poetry run cookiecutter tooling/template` doit rester une
exception. Il est plus facile de créer un dépôt au mauvais endroit ou avec un
chemin de package incohérent.

## Pourquoi il est utile

Le template réduit les erreurs de structure.

Il permet à CSSDM, CSSPI et CSSMV de partir d'une base commune. Les différences locales restent alors plus faciles à repérer.

## Point de contrôle

Après génération, vérifier que `reporting/gabarit.pbit` est présent et que
`packages.yml` pointe vers le bon chemin du core Snowflake.
