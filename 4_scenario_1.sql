select Nom,Prénom,nom_pays
from (
select Nom,Prénom,Code_pays from Voyageur where UUID_voyageur in (select UUID_voyageur from Vol_voyageur join vol using (UUID_vol)) 
union all 
select Nom,Prénom,Code_pays from Employer where UUID_employer in (select UUID_employer from Vol_employer join vol using (UUID_vol))
) as a_sauver join pays using (code_pays) order by nom_pays,nom,prénom asc;

alter table avion
add column statut_avion varchar(50)
default 'actif';

update avion
set statut_avion = 'en maintenance'
where ID_avion='';

alter table avion
add constraint ck_statut_avion check (statut_avion in ('actif','en maintenance'));

select ID_avion, statut_avion from avion;

alter table employer
add column statut_employer varchar(50)
default 'actif';

update employer
set statut_employer = 'en congés'
where UUID_employer in (select UUID_employer from vol_employer join vol using (UUID_vol) where ID_avion='');

alter table employer
add constraint ck_statut_employer check (statut_employer in ('actif','en congés'));

select UUID_employer, statut_employer from employer;