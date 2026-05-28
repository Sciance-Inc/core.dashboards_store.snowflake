{#
Dashboards Store - Helping students, one dashboard at a time.
Copyright (C) 2023  Sciance Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
#}
{# Macros declarations #}
{#
Documentation: see macros/introspection/schema.yml.
Usage: model pre-hook. Args: none.
#}
{% macro init_metadata_table() %}
    {{
        return(
            adapter.dispatch(
                "init_metadata_table", "core_dashboards_store_snowflake"
            )()
        )
    }}
{% endmacro %}

{#
Documentation: see macros/introspection/schema.yml.
Usage: model post-hook. Args: none.
#}
{% macro purge_metadata_table() %}
    {{
        return(
            adapter.dispatch(
                "purge_metadata_table", "core_dashboards_store_snowflake"
            )()
        )
    }}
{% endmacro %}

{#
Documentation: see macros/introspection/schema.yml.
Usage: reporting model post-hook. Args: dashboard_name.
#}
{% macro stamp_model(dashboard_name) %}
    {{
        return(
            adapter.dispatch("stamp_model", "core_dashboards_store_snowflake")(
                dashboard_name
            )
        )
    }}
{% endmacro %}


{# Snowflake helpers #}
{#
Documentation: see macros/introspection/schema.yml.
Usage: internal Snowflake helper. Args: schema_name.
#}
{% macro _snowflake_stamper_table_exists(schema_name) %}

    {% set query %}
    select count(*) as table_count
    from information_schema.tables
    where
        upper(table_schema) = upper('{{ schema_name }}')
        and upper(table_name) = 'STAMPER'
    {% endset %}

    {% set result = run_query(query) %}
    {% set table_count = result.columns[0].values()[0] | int %}

    {{ return(table_count > 0) }}

{% endmacro %}


{# Snowflake dispatch #}
{#
Documentation: see macros/introspection/schema.yml.
Usage: Snowflake implementation for init_metadata_table. Args: none.
#}
{% macro snowflake__init_metadata_table() %}

    {% if execute %}

        {% set schema_name = target.schema ~ "_metadata" %}
        {% set table_name = schema_name ~ ".stamper" %}

        {% set create_schema_query %}
        create schema if not exists {{ schema_name }}
        {% endset %}

        {% do run_query(create_schema_query) %}

        {% set create_table_query %}
        create table if not exists {{ table_name }} (
            dashboard_name varchar(128),
            table_name varchar(128),
            run_ended_at timestamp_ntz,
            idx varchar(36)
        )
        {% endset %}

        {% do run_query(create_table_query) %}

    {% endif %}

{% endmacro %}

{#
Documentation: see macros/introspection/schema.yml.
Usage: Snowflake implementation for purge_metadata_table. Args: none.
#}
{% macro snowflake__purge_metadata_table() %}

    {% if execute %}

        {% set schema_name = target.schema ~ "_metadata" %}
        {% set table_name = schema_name ~ ".stamper" %}

        {% if _snowflake_stamper_table_exists(schema_name) %}

            {% set query %}
            delete from {{ table_name }}
            where idx in (
                select src.idx
                from (
                    select
                        idx,
                        row_number() over (
                            partition by dashboard_name, table_name
                            order by run_ended_at desc
                        ) as seq_id
                    from {{ table_name }}
                ) as src
                where src.seq_id > 1
            )
            {% endset %}

            {% do run_query(query) %}

        {% endif %}

    {% endif %}

{% endmacro %}

{#
Documentation: see macros/introspection/schema.yml.
Usage: Snowflake implementation for stamp_model. Args: dashboard_name.
#}
{% macro snowflake__stamp_model(dashboard_name) %}

    {% if execute %}

        {% set schema_name = target.schema ~ "_metadata" %}
        {% set table_name = schema_name ~ ".stamper" %}
        {% set escaped_dashboard_name = dashboard_name | replace("'", "''") %}
        {% set escaped_table_name = this.name | replace("'", "''") %}

        {% if _snowflake_stamper_table_exists(schema_name) %}

            {% set query %}
            insert into {{ table_name }} (
                dashboard_name,
                table_name,
                run_ended_at,
                idx
            )
            values (
                '{{ escaped_dashboard_name }}',
                '{{ escaped_table_name }}',
                {{ dbt.current_timestamp() }}::timestamp_ntz,
                uuid_string()
            )
            {% endset %}

            {% do run_query(query) %}

        {% endif %}

    {% endif %}

{% endmacro %}
