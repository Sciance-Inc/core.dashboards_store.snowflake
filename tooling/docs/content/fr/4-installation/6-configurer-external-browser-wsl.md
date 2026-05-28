---
title: Configurer externalbrowser dans WSL2
description: Ouvrir le navigateur Windows depuis WSL2.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Configurer externalbrowser dans WSL2

Avec `authenticator: externalbrowser`, Snowflake ouvre une page de connexion.

Dans *WSL2*, cette page peut s'ouvrir dans le mauvais navigateur. `wslview` permet d'ouvrir le navigateur Windows.

## Installer wslu

Dans Ubuntu :

```bash
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu
```

Résultat attendu : la commande `wslview` est disponible.

## Définir le navigateur

```bash
wslview -r
export BROWSER=wslview
python -m webbrowser "https://example.com"
```

Résultat attendu : la page s'ouvre dans le navigateur Windows.

## Rendre la configuration persistante

```bash
echo 'export BROWSER=wslview' >> ~/.bashrc
source ~/.bashrc
```

## Dépannage

Si un outil utilise encore `xdg-open`, demander d'abord à l'équipe TI si cette correction est acceptable :

```bash
sudo ln -sf "$(command -v wslview)" /usr/local/bin/xdg-open
xdg-open "https://example.com"
```

## Point de contrôle

Relancer `dbt debug`. La connexion Snowflake doit ouvrir la page d'authentification au bon endroit.
