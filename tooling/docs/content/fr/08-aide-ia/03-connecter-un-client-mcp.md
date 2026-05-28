---
title: Connecter un client MCP
description: Brancher un client IA sur la documentation.
author: hugo.juhel@sciance.ca
updatedAt: 2026-05-28
---

::page-metadata
::

# Connecter un client MCP

MCP est une méthode standard pour donner des ressources à un client IA.

Dans ce site, MCP doit servir seulement à lire la documentation.

## Configuration prête à copier

Le site publie un exemple de configuration :

```text
https://docs-snowflake.dashboards-store.sciance.ca/mcp/docs-mcp.json
```

Cette configuration branche un serveur de documentation sur :

```text
https://docs-snowflake.dashboards-store.sciance.ca/llms.txt
```

## Test de connexion

Après la connexion, demander à l'IA :

```text
Retrouve la page qui explique les profils dbt Snowflake et résume les deux modes de connexion.
```

Résultat attendu : l'IA parle de la paire de clés et de `authenticator: externalbrowser`.

## Sécurité

Ne pas connecter un MCP qui donne accès aux données, aux secrets ou aux systèmes Snowflake de production.

## Point de contrôle

Le MCP doit rester en lecture seule.
