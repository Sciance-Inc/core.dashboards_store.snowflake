select
    frequentation_id as id_freq,
    eleve_id as id_ele,
    etablissement_id as id_etab,
    programme_id as id_prog,
    code_permanent as code_perm,
    debut_date as date_debut,
    fin_date as date_fin,
    sifca_fin_date as date_fin_sifca
from {{ var("database_dfondation") }}.affaires_scolaire_fgafp.fait_denombrement