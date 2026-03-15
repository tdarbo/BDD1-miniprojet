CREATE TABLE pays(
                     Code_pays VARCHAR(50),
                     Nom_pays VARCHAR(50),
                     PRIMARY KEY(Code_pays)
);

CREATE TABLE Aéroport(
                         ICAO CHAR(4),
                         IATA_aéroport CHAR(3) NOT NULL,
                         Ville VARCHAR(50),
                         Code_pays VARCHAR(50) NOT NULL,
                         PRIMARY KEY(ICAO),
                         FOREIGN KEY(Code_pays) REFERENCES pays(Code_pays)
);

CREATE TABLE Compagnie_aérienne(
                                   IATA_compagnie CHAR(2),
                                   Nom VARCHAR(50),
                                   Date_création DATE,
                                   Code_pays VARCHAR(50) NOT NULL,
                                   PRIMARY KEY(IATA_compagnie),
                                   FOREIGN KEY(Code_pays) REFERENCES pays(Code_pays)
);

CREATE TABLE Employer(
                         UUID_employer CHAR(36),
                         Nom VARCHAR(50),
                         Prénom VARCHAR(50),
                         Date_naissance VARCHAR(50),
                         Date_embauche VARCHAR(50),
                         Role_employer VARCHAR(50),
                         Code_pays VARCHAR(50) NOT NULL,
                         IATA_compagnie CHAR(2) NOT NULL,
                         PRIMARY KEY(UUID_employer),
                         FOREIGN KEY(Code_pays) REFERENCES pays(Code_pays),
                         FOREIGN KEY(IATA_compagnie) REFERENCES Compagnie_aérienne(IATA_compagnie)
);

CREATE TABLE Voyageur(
                         UUID_voyageur CHAR(36),
                         Nom VARCHAR(50),
                         Prénom VARCHAR(50),
                         Date_naissance DATE,
                         Interdit_de_vol BOOLEAN,
                         Code_pays VARCHAR(50) NOT NULL,
                         PRIMARY KEY(UUID_voyageur),
                         FOREIGN KEY(Code_pays) REFERENCES pays(Code_pays)
);

CREATE TABLE Avion(
                      ID_avion VARCHAR(15),
                      Code_avion VARCHAR(10),
                      IATA_compagnie CHAR(2) NOT NULL,
                      Code_pays VARCHAR(50) NOT NULL,
                      PRIMARY KEY(ID_avion),
                      FOREIGN KEY(IATA_compagnie) REFERENCES Compagnie_aérienne(IATA_compagnie),
                      FOREIGN KEY(Code_pays) REFERENCES pays(Code_pays)
);

CREATE TABLE Vol(
                    UUID_vol CHAR(36),
                    Code_vol VARCHAR(50) NOT NULL,
                    Date_départ_GMT_1_ DATETIME,
                    Date_arrivé_GMT_1_ DATETIME,
                    ID_avion VARCHAR(15) NOT NULL,
                    ICAO_départ CHAR(4),
                    ICAO_arrivé CHAR(4),
                    PRIMARY KEY(UUID_vol),
                    FOREIGN KEY(ID_avion) REFERENCES Avion(ID_avion),
                    FOREIGN KEY(ICAO_départ) REFERENCES Aéroport(ICAO),
                    FOREIGN KEY(ICAO_arrivé) REFERENCES Aéroport(ICAO)
);

CREATE TABLE Vol_Voyageur(
                              UUID_vol CHAR(36),
                              UUID_voyageur CHAR(36),
                              PRIMARY KEY(UUID_vol, UUID_voyageur),
                              FOREIGN KEY(UUID_vol) REFERENCES Vol(UUID_vol),
                              FOREIGN KEY(UUID_voyageur) REFERENCES Voyageur(UUID_voyageur)
);

CREATE TABLE Vol_Employer(
                             UUID_vol CHAR(36),
                             UUID_employer CHAR(36),
                             PRIMARY KEY(UUID_vol, UUID_employer),
                             FOREIGN KEY(UUID_vol) REFERENCES Vol(UUID_vol),
                             FOREIGN KEY(UUID_employer) REFERENCES Employer(UUID_employer)
);
