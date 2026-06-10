select
    table_nom as nom_table,
    description_code as code_descr,
    description as descr,
    description_courte as descr_ct
from {{ var("database_dfondation") }}.affaires_scolaire_fgafp.dim_description