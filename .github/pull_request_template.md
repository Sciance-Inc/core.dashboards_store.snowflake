# Objectif de la demande de fusion

Décrire le but de la demande de fusion. Quel problème est résolu, quelle règle est ajoutée ou quel comportement change.

# Ce qui est hors périmètre

Décrire ce qui n'est pas inclus dans cette demande de fusion et pourquoi. Ajouter les suites prévues si elles existent.

# Comment tester la demande de fusion

Fournir les commandes exactes à lancer pour réviser la demande de fusion.

Les commandes doivent fonctionner telles quelles après adaptation des noms de branche et de CSS. Si une commande *dbt* échoue, la demande de fusion devra être corrigée avant la revue.

```bash
# Depuis un dossier qui contient le core et le dépôt local CSS.
cd core.dashboards_store.snowflake
git checkout <branche>
git pull

# Requis si pyproject.toml ou poetry.lock changent.
poetry install

# Requis si les dépendances dbt changent.
poetry run dbt deps

cd ../<cssXX>.dashboards_store.snowflake
git checkout <branche>
git pull

dbt deps --profiles-dir .
dbt build --profiles-dir . --profile snowflake --select +tag:<tag_du_perimetre>+
```

# Liste de vérification

Lire chaque point avant de le cocher.

## Code

- [ ] Le code soumis à la revue fonctionne.
- [ ] Les conventions du site de documentation ont été respectées.
- [ ] Les modèles, seeds, macros ou adaptateurs ajoutés sont documentés dans les fichiers YAML appropriés.
- [ ] Les paramètres des macros ajoutées ou modifiées sont clairement documentés.
- [ ] Les tests *dbt* pertinents ont été ajoutés ou mis à jour.
- [ ] Le formatage SQL a été appliqué avec `sqlfmt .` ou une commande équivalente.
- [ ] Le code a été relancé après formatage.

## Données et tableaux de bord

- [ ] Les modèles finaux destinés aux rapports sont placés dans le dossier `reporting` approprié.
- [ ] Les nouveaux dashboards sont documentés dans `tooling/docs/content/fr/`.
- [ ] Si un dashboard est ajouté, le template dans `tooling/template/` a été mis à jour.
- [ ] Le gabarit Power BI est sauvegardé en `.pbit`, pas en `.pbix`, afin de ne pas versionner de données.

## Documentation

- [ ] Le README ou le site de documentation renvoie vers la bonne page de référence.
- [ ] Les changements de conventions sont expliqués dans le site de documentation.
- [ ] Les exemples de commandes utilisent le profil *dbt* `snowflake`.

## Pull request

- [ ] Le titre ou le message de merge utilise un préfixe de type `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `perf:` ou `style:`.
- [ ] Les commandes de test fournies plus haut ont été exécutées.
- [ ] Les fichiers inclus dans la demande de fusion ont été relus et sont tous intentionnels.
- [ ] Au moins une personne a été assignée à la revue.
