-- liste des passagers

select Nom,Prénom,nom_pays
from (
select Nom,Prénom,Code_pays from Voyageur join Vol_voyageur using (UUID_voyageur) where UUID_vol='vol-0001-0001-0001-0001-000000000001'
union all 
select Nom,Prénom,Code_pays from Employer join Vol_employer using (UUID_employer) where UUID_vol='vol-0001-0001-0001-0001-000000000001'
) as a_sauver join pays using (code_pays) order by nom_pays,nom,prénom asc;

-- creation et changement du statut pour les avions

alter table avion
add column statut_avion varchar(50)
default 'actif';

update avion
set statut_avion = 'en maintenance'
where ID_avion in (select ID_avion from vol  where UUID_vol='vol-0001-0001-0001-0001-000000000001');

alter table avion
add constraint ck_statut_avion check (statut_avion in ('actif','en maintenance'));

select ID_avion, statut_avion from avion;

-- creation et changement du statut pour les employers

alter table employer
add column statut_employer varchar(50)
default 'actif';

update employer
set statut_employer = 'en congés'
where UUID_employer in (select UUID_employer from vol_employer where UUID_vol='vol-0001-0001-0001-0001-000000000001');

alter table employer
add constraint ck_statut_employer check (statut_employer in ('actif','en congés'));

select UUID_employer, statut_employer from employer;
