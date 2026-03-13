select Nom,Prénom 
from (
select Nom,Prénom from Voyageur where UUID_voyageur in (select UUID_voyageur from Vol_voyageur join vol using (UUID_vol)) 
union all 
select Nom,Prénom from Employer where UUID_employer in (select UUID_employer from Vol_employer join vol using (UUID_vol))
) as a_sauver;

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
where UUID_employer in (select UUID_employer from vol_employer join vol using (UUID_vol));

alter table employer
add constraint ck_statut_employer check (statut_employer in ('actif','en congés'));

select UUID_employer, statut_employer from employer;