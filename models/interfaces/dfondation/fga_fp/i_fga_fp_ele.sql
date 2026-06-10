select
    eleve_id as id_ele,
    fiche,
    code_permanent as code_perm,
    nom,
    prenom,
    sexe_code as sexe,
    naissance_date as date_naiss,
    naissance_lieu_code as code_lieu_naiss,
    generation_statut_description as statut_generation_descr,
    langue_maison_code as lang_maison,
    langue_maternelle_code as lang_mater,
    provenance_ecole_code as code_eco_provenance
from {{ var("database_dfondation") }}.affaires_scolaire_fgafp.dim_eleve