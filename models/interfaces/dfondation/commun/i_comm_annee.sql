select
    annee_scolaire_id as annee,
    annee_scolaire_description as annee_scolaire,
    annee_scolaire_debut_date as date_debut,
    annee_scolaire_fin_date as date_fin,
    annee_scolaire_courante_ind as is_annee_courante
from {{ var("database_dfondation") }}.affaires_dimensions_communes.dim_annee_scolaire