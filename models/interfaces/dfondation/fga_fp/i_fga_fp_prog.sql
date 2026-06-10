select
    programme_id as id_prog,
    programme_code as code_prog,
    programme_description as descr_prog,
    formation_genre_code as genre_form,
    sanction_regime_code as reg_sanct,
    diplome_type_code as type_dipl,
    secteur_enseignement_code as sect_ens
from {{ var("database_dfondation") }}.affaires_scolaire_fgafp.dim_programme