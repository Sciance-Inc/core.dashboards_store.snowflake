---
title: Installer Python et Poetry
description: Préparer l'environnement dbt.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Installer Python et Poetry

Le projet demande *Python* 3.10 ou plus récent.

*Poetry* installe les dépendances du projet.

## Installer Python avec pyenv

```bash
pyenv install 3.10.16
pyenv local 3.10.16
python --version
```

Résultat attendu : la version affichée est `Python 3.10.16` ou une version compatible.

## Installer Poetry

```bash
curl -sSL https://install.python-poetry.org | python3 -
poetry --version
```

Résultat attendu : la commande affiche une version de *Poetry*.

## Installer les dépendances

Depuis le dépôt Snowflake :

```bash
poetry install
```

Résultat attendu : *Poetry* installe *dbt-core* et *dbt-snowflake*.

## Point de contrôle

Si `poetry` n'est pas trouvé, vérifier le `PATH` du terminal.
