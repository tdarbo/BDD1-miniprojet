-- =========================
-- PAYS
-- =========================
INSERT INTO pays (Code_pays, Nom_pays) VALUES
('FRA','France'),
('USA','Etats-Unis'),
('DEU','Allemagne'),
('ESP','Espagne'),
('ITA','Italie');

-- =========================
-- AEROPORTS
-- =========================
INSERT INTO Aéroport (ICAO, IATA_aéroport, Ville, Code_pays) VALUES
('LFPG','CDG','Paris','FRA'),
('LFPO','ORY','Paris','FRA'),
('KJFK','JFK','New York','USA'),
('KLAX','LAX','Los Angeles','USA'),
('EDDF','FRA','Francfort','DEU'),
('LEMD','MAD','Madrid','ESP'),
('LIRF','FCO','Rome','ITA');

-- =========================
-- COMPAGNIES AERIENNES
-- =========================
INSERT INTO Compagnie_aérienne (IATA_compagnie, Nom, Date_création, Code_pays) VALUES
('AF','Air France','1933-10-07','FRA'),
('AA','American Airlines','1930-04-15','USA'),
('LH','Lufthansa','1953-01-06','DEU'),
('IB','Iberia','1927-06-28','ESP');

-- =========================
-- AVIONS
-- =========================
INSERT INTO Avion (ID_avion, Code_avion, IATA_compagnie, Code_pays) VALUES
('AF001','A320','AF','FRA'),
('AF002','A350','AF','FRA'),
('AA001','B737','AA','USA'),
('LH001','A321','LH','DEU'),
('IB001','A319','IB','ESP');

-- =========================
-- EMPLOYES
-- =========================
INSERT INTO Employer VALUES
('11111111-1111-1111-1111-111111111111','Dupont','Jean','1980-05-10','2010-03-01','Pilote','FRA','AF'),
('22222222-2222-2222-2222-222222222222','Martin','Claire','1985-07-12','2015-06-20','Copilote','FRA','AF'),
('33333333-3333-3333-3333-333333333333','Smith','John','1978-02-14','2008-09-15','Cdb','USA','AA'),
('44444444-4444-4444-4444-444444444444','Garcia','Maria','1990-11-05','2018-04-10','Hôtesse','ESP','IB'),
('55555555-5555-5555-5555-555555555555','Müller','Anna','1987-08-22','2016-01-12','Steward','DEU','LH');

-- =========================
-- VOYAGEURS
-- =========================
INSERT INTO Voyageur VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1','Durand','Paul','1995-04-02',FALSE,'FRA'),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2','Bernard','Luc','1988-06-11',FALSE,'FRA'),
('aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3','Johnson','Emily','1992-09-21',FALSE,'USA'),
('aaaaaaa4-aaaa-aaaa-aaaa-aaaaaaaaaaa4','Rossi','Marco','1985-01-30',FALSE,'ITA'),
('aaaaaaa5-aaaa-aaaa-aaaa-aaaaaaaaaaa5','Schmidt','Lena','1998-03-14',FALSE,'DEU');

-- =========================
-- VOLS
-- =========================
INSERT INTO Vol VALUES
('vol-0001-0001-0001-0001-000000000001','AF123','2026-04-01 10:00:00','2026-04-01 12:00:00','AF001'),
('vol-0002-0002-0002-0002-000000000002','AF456','2026-04-02 15:00:00','2026-04-02 18:00:00','AF002'),
('vol-0003-0003-0003-0003-000000000003','AA789','2026-04-03 08:00:00','2026-04-03 14:00:00','AA001'),
('vol-0004-0004-0004-0004-000000000004','LH111','2026-04-04 09:30:00','2026-04-04 11:30:00','LH001'),
('vol-0005-0005-0005-0005-000000000005','IB222','2026-04-05 16:00:00','2026-04-05 18:30:00','IB001');

-- =========================
-- VOL - VOYAGEURS
-- =========================
INSERT INTO Vol_Voyageur VALUES
('vol-0001-0001-0001-0001-000000000001','aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1'),
('vol-0001-0001-0001-0001-000000000001','aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2'),
('vol-0002-0002-0002-0002-000000000002','aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3'),
('vol-0003-0003-0003-0003-000000000003','aaaaaaa4-aaaa-aaaa-aaaa-aaaaaaaaaaa4'),
('vol-0004-0004-0004-0004-000000000004','aaaaaaa5-aaaa-aaaa-aaaa-aaaaaaaaaaa5');

-- =========================
-- VOL - EMPLOYER
-- =========================
INSERT INTO Vol_Employer VALUES
('vol-0001-0001-0001-0001-000000000001','11111111-1111-1111-1111-111111111111'),
('vol-0001-0001-0001-0001-000000000001','22222222-2222-2222-2222-222222222222'),
('vol-0003-0003-0003-0003-000000000003','33333333-3333-3333-3333-333333333333'),
('vol-0005-0005-0005-0005-000000000005','44444444-4444-4444-4444-444444444444'),
('vol-0004-0004-0004-0004-000000000004','55555555-5555-5555-5555-555555555555');

-- =========================
-- VOL - AEROPORT
-- =========================
INSERT INTO Vol_Aéroport VALUES
('LFPG','vol-0001-0001-0001-0001-000000000001'),
('KJFK','vol-0001-0001-0001-0001-000000000001'),
('LFPG','vol-0002-0002-0002-0002-000000000002'),
('KLAX','vol-0003-0003-0003-0003-000000000003'),
('EDDF','vol-0004-0004-0004-0004-000000000004'),
('LEMD','vol-0005-0005-0005-0005-000000000005');