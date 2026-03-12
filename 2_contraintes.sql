ALTER TABLE Aéroport
    ADD CONSTRAINT ck_icao_format CHECK ( ICAO REGEXP '^[A-Z]{4}$'),
    ADD CONSTRAINT ck_iata_format_aéroport CHECK ( IATA_aéroport REGEXP '^[A-Z]{3}$');

ALTER TABLE Compagnie_aérienne
    ADD CONSTRAINT ck_iata_format_compagnie CHECK ( IATA_compagnie REGEXP '^[A-Z]{2}$');

ALTER TABLE Vol
    ADD CONSTRAINT ck_vol_date CHECK ( Date_arrivé_GMT_1_ > Date_départ_GMT_1_ );

ALTER TABLE pays
    ADD CONSTRAINT uq_nom_pays UNIQUE (Nom_pays);

ALTER TABLE Vol
    ADD CONSTRAINT uq_code_vol_per_date UNIQUE (Code_vol,Date_départ_GMT_1_,Date_arrivé_GMT_1_);

ALTER TABLE Employer
    ADD CONSTRAINT ck_role_enum
    CHECK ( ROLE IN ('Pilote','Copilote','Cdb','Hôtesse','Steward') );

ALTER TABLE pays
    ADD CONSTRAINT ck_code_pays CHECK ( Code_pays REGEXP '^[A-Z]{3}$');

