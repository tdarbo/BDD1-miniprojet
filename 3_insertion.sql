-- ==========================================================
-- SCRIPT D'INSERTION DE DONNÉES (MLD AÉRIEN)
-- ==========================================================

-- 1. PAYS
INSERT INTO pays (Code_pays, Nom_pays) VALUES
                                           ('FRA', 'France'), ('USA', 'États-Unis'), ('CAN', 'Canada'),
                                           ('GBR', 'Royaume-Uni'), ('DEU', 'Allemagne'), ('JPN', 'Japon'),
                                           ('ARE', 'Émirats Arabes Unis'), ('AUS', 'Australie'), ('BRA', 'Brésil'),
                                           ('CHN', 'Chine'), ('ITA', 'Italie'), ('ESP', 'Espagne');

-- 2. AÉROPORTS
INSERT INTO Aéroport (ICAO, IATA, Ville, Code_pays) VALUES
                                                        ('LFPG', 'CDG', 'Paris', 'FRA'), ('LFPO', 'ORY', 'Paris', 'FRA'),
                                                        ('KJFK', 'JFK', 'New York', 'USA'), ('KLAX', 'LAX', 'Los Angeles', 'USA'),
                                                        ('EGLL', 'LHR', 'Londres', 'GBR'), ('EDDF', 'FRA', 'Francfort', 'DEU'),
                                                        ('OMDB', 'DXB', 'Dubaï', 'ARE'), ('RJTT', 'HND', 'Tokyo', 'JPN'),
                                                        ('CYYZ', 'YYZ', 'Toronto', 'CAN'), ('LEMD', 'MAD', 'Madrid', 'ESP');

-- 3. COMPAGNIES AÉRIENNES
INSERT INTO Compagnie_aérienne (IATA, Nom, Date_création, Code_pays) VALUES
                                                                         ('AF', 'Air France', '1933-10-07', 'FRA'),
                                                                         ('AA', 'American Airlines', '1926-04-15', 'USA'),
                                                                         ('BA', 'British Airways', '1974-03-31', 'GBR'),
                                                                         ('LH', 'Lufthansa', '1953-01-06', 'DEU'),
                                                                         ('EK', 'Emirates', '1985-03-25', 'ARE'),
                                                                         ('JL', 'Japan Airlines', '1951-08-01', 'JPN');

-- 4. AVIONS
INSERT INTO Avion (ID_avion, _Code_avion, IATA, Code_pays) VALUES
                                                               ('F-GZCP', 'A330', 'AF', 'FRA'), ('F-GSQU', 'B777', 'AF', 'FRA'),
                                                               ('N123AA', 'B737', 'AA', 'USA'), ('N789AN', 'B787', 'AA', 'USA'),
                                                               ('G-XWBA', 'A350', 'BA', 'GBR'), ('D-AIMA', 'A380', 'LH', 'DEU'),
                                                               ('A6-EEQ', 'A380', 'EK', 'ARE'), ('JA801J', 'B787', 'JL', 'JPN');

-- 5. VOYAGEURS (Exemples variés)
INSERT INTO Voyageur (UUID_voyageur, Nom, Prénom, Date_naissance, Interdit_de_vol, Code_pays) VALUES
                                                                                                  (UUID(), 'Dupont', 'Jean', '1985-05-12', 0, 'FRA'),
                                                                                                  (UUID(), 'Smith', 'John', '1990-11-23', 0, 'USA'),
                                                                                                  (UUID(), 'Tanaka', 'Akira', '1978-02-15', 0, 'JPN'),
                                                                                                  (UUID(), 'Müller', 'Hans', '1965-07-30', 0, 'DEU'),
                                                                                                  (UUID(), 'Garcia', 'Maria', '1992-09-05', 0, 'ESP'),
                                                                                                  (UUID(), 'Doe', 'Jane', '1988-01-01', 1, 'CAN'), -- Interdit de vol
                                                                                                  (UUID(), 'Rousseau', 'Claire', '1995-03-14', 0, 'FRA');

-- 6. EMPLOYÉS (Pilotes, PNC, Sol)
INSERT INTO Employer (UUID_employer, Nom, Prénom, Date_naissance, Date_embauche, Role, Code_pays, IATA) VALUES
                                                                                                            (UUID(), 'Lemoine', 'Thomas', '1975-04-20', '2010-01-15', 'Pilote', 'FRA', 'AF'),
                                                                                                            (UUID(), 'Dubois', 'Julie', '1982-08-10', '2012-05-20', 'Cdb', 'FRA', 'AF'),
                                                                                                            (UUID(), 'Johnson', 'Robert', '1980-12-05', '2008-09-12', 'Pilote', 'USA', 'AA'),
                                                                                                            (UUID(), 'Williams', 'Sarah', '1990-03-22', '2015-06-01', 'Hôtesse', 'USA', 'AA'),
                                                                                                            (UUID(), 'Brown', 'David', '1985-11-30', '2011-03-10', 'Steward', 'GBR', 'BA');

-- 7. VOLS
-- Note : Remplacer les IDs d'avions par ceux créés plus haut
INSERT INTO Vol (UUID_vol, Code_vol, Date_départ_GMT_1_, Date_arrivé_GMT_1_, ID_avion) VALUES
                                                                                           ('v1-af-001', 'AF001', '2026-04-01 10:00:00', '2026-04-01 18:30:00', 'F-GZCP'),
                                                                                           ('v2-aa-120', 'AA120', '2026-04-01 12:00:00', '2026-04-01 20:00:00', 'N123AA'),
                                                                                           ('v3-ek-202', 'EK202', '2026-04-02 23:30:00', '2026-04-03 06:45:00', 'A6-EEQ'),
                                                                                           ('v4-lh-450', 'LH450', '2026-04-03 08:15:00', '2026-04-03 14:00:00', 'D-AIMA');

-- 8. RELATIONS (Tables de liaison)

-- Liaison Vol <-> Aéroport (Départ/Arrivée via la table Vol_Aéroport)
INSERT INTO Vol_Aéroport (ICAO, UUID_vol) VALUES
                                              ('LFPG', 'v1-af-001'), ('KJFK', 'v1-af-001'),
                                              ('KJFK', 'v2-aa-120'), ('KLAX', 'v2-aa-120'),
                                              ('OMDB', 'v3-ek-202'), ('RJTT', 'v3-ek-202');

-- Liaison Vol <-> Voyageurs (Manifeste passagers)
-- Utilise des sous-requêtes pour récupérer les UUID générés plus haut
INSERT INTO Vol_Voyageurs (UUID_vol, UUID_voyageur)
SELECT 'v1-af-001', UUID_voyageur FROM Voyageur WHERE Nom IN ('Dupont', 'Tanaka');
INSERT INTO Vol_Voyageurs (UUID_vol, UUID_voyageur)
SELECT 'v2-aa-120', UUID_voyageur FROM Voyageur WHERE Nom IN ('Smith', 'Müller');

-- Liaison Vol <-> Employés (Équipage)
INSERT INTO Vol_Employer (UUID_vol, UUID_employer)
SELECT 'v1-af-001', UUID_employer FROM Employer WHERE Nom IN ('Lemoine', 'Dubois');
INSERT INTO Vol_Employer (UUID_vol, UUID_employer)
SELECT 'v2-aa-120', UUID_employer FROM Employer WHERE Nom IN ('Johnson', 'Williams');

COMMIT;