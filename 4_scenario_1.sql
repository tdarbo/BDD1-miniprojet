-- liste des passagers

select Nom,Prénom,nom_pays
from (
	select Nom,Prénom,Code_pays from Voyageur join Vol_voyageur using (UUID_voyageur) where UUID_vol='vol-0001-0000-0000-0000-000000000001'
	union all 
	select Nom,Prénom,Code_pays from Employer join Vol_employer using (UUID_employer) where UUID_vol='vol-0001-0000-0000-0000-000000000001'
) as a_sauver join pays using (code_pays) order by nom_pays,nom,prénom asc;

-- creation et changement du statut pour les avions

alter table avion
add column statut_avion varchar(50)
default 'actif';

update avion
set statut_avion = 'en maintenance'
where ID_avion in (
	select ID_avion from vol  where UUID_vol='vol-0001-0000-0000-0000-000000000001');

alter table avion
add constraint ck_statut_avion check (statut_avion in ('actif','en maintenance'));

select ID_avion, statut_avion from avion;

-- creation et changement du statut pour les employers

alter table employer
add column statut_employer varchar(50)
default 'actif';

update employer
set statut_employer = 'en congés'
where UUID_employer in (
	select UUID_employer from vol_employer where UUID_vol='vol-0001-0000-0000-0000-000000000001');

alter table employer
add constraint ck_statut_employer check (statut_employer in ('actif','en congés'));

select UUID_employer, statut_employer from employer;

-- recherche du nombre de personne par vol

select UUID_vol,count(UUID_personne) as nb_passagers from(
	select UUID_voyageur as UUID_personne ,UUID_vol from Vol_voyageur
	union all 
	select UUID_employer as UUID_personne ,UUID_vol from Vol_employer
) as liste_personne_vol 
group by UUID_vol order by nb_passagers desc;

-- vérification de l'appartenance des employers présent à l'entreprise possédant l'avion concerné

select * 
from employer 
where UUID_employer in 
	(select UUID_employer from vol_employer where UUID_vol='vol-0001-0000-0000-0000-000000000001')
and IATA_compagnie!=(
	select IATA_compagnie 
	from avion 
	where ID_avion in (
		select ID_avion 
		from vol 
		where UUID_vol ='vol-0001-0000-0000-0000-000000000001'
	)
);

-- étude de l'expérience des employers

select UUID_employer,count(UUID_vol) 
from vol_employer 
where UUID_employer in 
	(select UUID_employer from vol_employer where UUID_vol='vol-0001-0000-0000-0000-000000000001') 
group by UUID_employer;

