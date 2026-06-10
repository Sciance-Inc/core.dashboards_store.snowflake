select
    etablissement_id as id_etab,
    etablissement_code as code_etab,
    ecole_code_officiel code_eco_off,
    centre_fp_code_officiel as code_fp_off,
    centre_fga_code_officiel as code_fga_off,
    etablissement_nom as nom_etab,
    adresse,
    code_postal,
    directeur,
    transmissibilite_ind as ind_transm
from {{ var("database_dfondation") }}.affaires_scolaire_fgafp.dim_etablissement
where centre_fp_code_officiel <> '' or centre_fga_code_officiel <> ''