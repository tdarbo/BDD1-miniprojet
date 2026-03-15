
-- Détéction vol malgé interdit de vols

SELECT
    v.Nom,
    v.Prénom,
    vol.Code_vol,
    c.Nom AS Compagnie_Responsable,
    vol.Date_départ_GMT_1_
FROM Voyageur v
         JOIN Vol_Voyageur vv ON v.UUID_voyageur = vv.UUID_voyageur
         JOIN Vol vol ON vv.UUID_vol = vol.UUID_vol
         JOIN Avion a ON vol.ID_avion = a.ID_avion
         JOIN Compagnie_aérienne c ON a.IATA_compagnie = c.IATA_compagnie
WHERE v.Interdit_de_vol = 1;


-- 2 Compagnie la moins sécure

SELECT
    c.Nom AS Compagnie,
    COUNT(v.UUID_voyageur) AS Nombre_Infractions
FROM Compagnie_aérienne c
         JOIN Avion a ON c.IATA_compagnie = a.IATA_compagnie
         JOIN Vol vol ON a.ID_avion = vol.ID_avion
         JOIN Vol_Voyageur vv ON vol.UUID_vol = vv.UUID_vol
         JOIN Voyageur v ON vv.UUID_voyageur = v.UUID_voyageur
WHERE v.Interdit_de_vol = TRUE
GROUP BY c.Nom
ORDER BY Nombre_Infractions DESC;

-- 3

SELECT
    p.Nom_pays,
    COUNT(v.UUID_voyageur) AS Total_Interdits,
    ROUND(AVG(v.Interdit_de_vol) * 100, 2) AS Pourcentage_Interdits
FROM pays p
         LEFT JOIN Voyageur v ON p.Code_pays = v.Code_pays
GROUP BY p.Nom_pays
HAVING Total_Interdits > 0
ORDER BY Pourcentage_Interdits DESC;


-- 4

SELECT
    v.Code_vol,
    COUNT(DISTINCT ve.UUID_employer) AS Nb_Equipage,
    COUNT(DISTINCT vv.UUID_voyageur) AS Nb_Passagers
FROM Vol v
         LEFT JOIN Vol_Employer ve ON v.UUID_vol = ve.UUID_vol
         LEFT JOIN Vol_Voyageur vv ON v.UUID_vol = vv.UUID_vol
GROUP BY v.UUID_vol
ORDER BY Nb_Passagers DESC;

