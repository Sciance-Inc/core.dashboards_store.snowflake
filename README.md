# Smokesting the Snowflake Data Cloud

## Python

Le projet requiert Python 3.10 minimum. Le plus simple est d'installer `pyenv` pour piloter la version locale de Python, et d'installer Poetry v2 pour gérer l'environnement et les dépendances.

Liens utiles :

- Poetry : https://python-poetry.org/docs/#installation
- Script d'installation Poetry : https://install.python-poetry.org/
- pyenv : https://github.com/pyenv/pyenv#installation

Exemple d'installation avec `pyenv` :

```bash
pyenv install 3.10.16
pyenv local 3.10.16
python --version
```

Une fois Python 3.10 installé localement dans le repo, installer Poetry v2 puis les dépendances du projet :

```bash
curl -sSL https://install.python-poetry.org | python3 -
poetry --version
eval $(poetry env activate)
poetry install
```

Si `poetry` n'est pas dans le `PATH` après installation, suivre la documentation officielle Poetry ci-dessus pour ajouter son dossier binaire à votre shell.

## WSL2

Si `dbt` avec `authenticator: externalbrowser` ouvre un navigateur Linux dans WSL au lieu du navigateur Windows par défaut, installer `wslview` pour rediriger les ouvertures d'URL vers Windows.

Liens utiles :

- WSL Utilities (`wslu`) : https://wslu.wedotstud.io/wslu/install.html
- Manuel `wslview` : https://wslu.wedotstud.io/wslu/man/wslview.html

Installation sur Ubuntu 22.04+ dans WSL :

```bash
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu
```

Une fois `wslview` installé, l'enregistrer comme navigateur par défaut côté WSL :

```bash
wslview -r
export BROWSER=wslview
python -m webbrowser "https://example.com"
```

La page doit s'ouvrir dans le navigateur Windows par défaut : GREAT SUCCESS !!!!

Pour rendre la variable persistante dans le shell :

```bash
echo 'export BROWSER=wslview' >> ~/.bashrc
source ~/.bashrc
```

### Unethical escape hatch
Si certains outils continuent malgré tout à ouvrir un navigateur Linux via `xdg-open`, utiliser cette solution de repli pour forcer `xdg-open` à passer par Windows :

```bash
sudo ln -sf "$(command -v wslview)" /usr/local/bin/xdg-open
xdg-open "https://example.com"
```

# TI / GRICS / Spinner un wharehouse de test:

Important de le mettre en auto_suspend pour éviter les coûts inutiles, et de le mettre en auto_resume pour ne pas devoir le démarrer manuellement à chaque fois.

```sql
CREATE WAREHOUSE IF NOT EXISTS WH_XSMALL
  WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;
```

## Creation des roles utilisés par le BVD et par les usagers

```sql
create role if not exists bvd_r_role;
create role if not exists bvd_rw_role;
```

## Création des DB store et store dev, et grant des permissions nécessaires aux roles bvd_r_role et bvd_rw_role

```sql
create database if not exists store;
create database if not exists store_dev;

grant usage on warehouse wh_xsmall to role bvd_r_role;
grant usage on warehouse wh_xsmall to role bvd_rw_role;

grant usage on database store to role bvd_r_role;
grant usage on database store_dev to role bvd_r_role;
grant usage on database store to role bvd_rw_role;
grant usage on database store_dev to role bvd_rw_role;

grant usage on all schemas in database store to role bvd_r_role;
grant usage on all schemas in database store_dev to role bvd_r_role;
grant usage on all schemas in database store to role bvd_rw_role;
grant usage on all schemas in database store_dev to role bvd_rw_role;

grant usage on future schemas in database store to role bvd_r_role;
grant usage on future schemas in database store_dev to role bvd_r_role;
grant usage on future schemas in database store to role bvd_rw_role;
grant usage on future schemas in database store_dev to role bvd_rw_role;

grant select on all tables in database store to role bvd_r_role;
grant select on all tables in database store_dev to role bvd_r_role;
grant select on all tables in database store to role bvd_rw_role;
grant select on all tables in database store_dev to role bvd_rw_role;

grant select on future tables in database store to role bvd_r_role;
grant select on future tables in database store_dev to role bvd_r_role;
grant select on future tables in database store to role bvd_rw_role;
grant select on future tables in database store_dev to role bvd_rw_role;

grant select on all views in database store to role bvd_r_role;
grant select on all views in database store_dev to role bvd_r_role;
grant select on all views in database store to role bvd_rw_role;
grant select on all views in database store_dev to role bvd_rw_role;

grant select on future views in database store to role bvd_r_role;
grant select on future views in database store_dev to role bvd_r_role;
grant select on future views in database store to role bvd_rw_role;
grant select on future views in database store_dev to role bvd_rw_role;

grant create schema on database store to role bvd_rw_role;
grant create schema on database store_dev to role bvd_rw_role;

grant create table on all schemas in database store to role bvd_rw_role;
grant create table on all schemas in database store_dev to role bvd_rw_role;
grant create table on future schemas in database store to role bvd_rw_role;
grant create table on future schemas in database store_dev to role bvd_rw_role;

grant create view on all schemas in database store to role bvd_rw_role;
grant create view on all schemas in database store_dev to role bvd_rw_role;
grant create view on future schemas in database store to role bvd_rw_role;
grant create view on future schemas in database store_dev to role bvd_rw_role;

grant create stage on all schemas in database store to role bvd_rw_role;
grant create stage on all schemas in database store_dev to role bvd_rw_role;
grant create stage on future schemas in database store to role bvd_rw_role;
grant create stage on future schemas in database store_dev to role bvd_rw_role;

grant insert, update, delete, truncate on all tables in database store to role bvd_rw_role;
grant insert, update, delete, truncate on all tables in database store_dev to role bvd_rw_role;
grant insert, update, delete, truncate on future tables in database store to role bvd_rw_role;
grant insert, update, delete, truncate on future tables in database store_dev to role bvd_rw_role;
```

## Ajout de <vous> au rôle bvd_rw_role pour pouvoir créer des tables et des vues dans les DB store et store_dev

```sql
grant role bvd_rw_role to user <vous>;
alter user <vous> set default_role = bvd_rw_role;
alter user <vous> set default_secondary_roles = ('all');
```
