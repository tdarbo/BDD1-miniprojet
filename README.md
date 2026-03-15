# Analyse de la base de donné

Ce document présente l'analyse préliminaire pour la conception de la base de données de gestion des vols, du personnel et des passagers.

## 1. Règles de gestion déduites du modèle

Voici le fonctionnement de l'entreprise tel qu'il transparaît à travers le schéma de données :

* **Géographie :** Le système répertorie des pays, chacun identifié par un code unique et possédant un nom.
* **Aéroports :** Un aéroport est situé dans un pays spécifique et dans une ville donnée. Il est doublement identifié par un code ICAO (4 caractères) et un code IATA (3 caractères).
* **Compagnies aériennes :** Une compagnie est identifiée par son code IATA (2 caractères). Elle possède un nom, une date de création officielle et est rattachée à un pays.
* **Avions :** Un avion appartient à une compagnie aérienne et est lié à un pays. Il possède un identifiant interne et un code avion spécifique.
* **Employés :** Le personnel est identifié par un identifiant universel (UUID). On stocke son nom, prénom, date de naissance, date d'embauche et son rôle exact. Un employé est rattaché à une compagnie aérienne et possède une nationalité (pays).
* **Voyageurs :** Un voyageur est également identifié par un UUID. On enregistre son nom, prénom, date de naissance, sa nationalité (pays) et s'il est sous le coup d'une interdiction de vol.
* **Vols :** Un vol est identifié par un UUID et un code de vol. Il est effectué par un seul avion. On consigne sa date et heure de départ ainsi que sa date et heure d'arrivée (sur le fuseau horaire GMT+1).
* **Affectation des Vols (Associations) :**
  * Un vol transporte un ou plusieurs voyageurs (et un voyageur peut faire plusieurs vols).
  * Un vol mobilise un ou plusieurs employés pour former son équipage.
  * Un vol dessert un ou plusieurs aéroports (ce qui permet de gérer les départs, arrivées et potentielles escales avec la même logique).

---

## 2. Dictionnaire de données brutes

Voici la liste des données unitaires extraites du modèle. Les clés étrangères techniques ont été ignorées pour se concentrer sur la donnée brute métier. Les types définis dans le schéma relationnel ont été respectés.

| Signification de la donnée | Type | Taille |
| :--- | :--- | :--- |
| Code d'identification du pays | Alphanumérique | 50 |
| Nom complet du pays | Alphanumérique | 50 |
| Code ICAO de l'aéroport | Alphanumérique | 4 |
| Code IATA de l'aéroport | Alphanumérique | 3 |
| Ville d'implantation de l'aéroport | Alphanumérique | 50 |
| Code IATA de la compagnie aérienne | Alphanumérique | 2 |
| Nom de la compagnie aérienne | Alphanumérique | 50 |
| Date de création de la compagnie | Date/Heure | - |
| Identifiant unique (UUID) de l'employé | Alphanumérique | 36 |
| Nom de famille (Employé ou Voyageur) | Alphanumérique | 50 |
| Prénom (Employé ou Voyageur) | Alphanumérique | 50 |
| Date de naissance de l'employé | Alphanumérique | 50 |
| Date d'embauche de l'employé | Alphanumérique | 50 |
| Rôle ou fonction de l'employé | Alphanumérique | 50 |
| Identifiant unique (UUID) du voyageur | Alphanumérique | 36 |
| Date de naissance du voyageur | Date/Heure | - |
| Statut d'interdiction de vol du voyageur | Booléen (Logique) | 1 |
| Identifiant interne de l'avion | Alphanumérique | 15 |
| Code spécifique de l'avion | Alphanumérique | 10 |
| Identifiant unique (UUID) du vol | Alphanumérique | 36 |
| Code commercial ou opérationnel du vol | Alphanumérique | 50 |
| Date et heure de départ (GMT+1) | Date/Heure | - |
| Date et heure d'arrivée (GMT+1) | Date/Heure | - |

---

## 3.MLD correspondant

pays = (Code_pays VARCHAR(50), Nom_pays VARCHAR(50));\
Aéroport = (ICAO CHAR(4), IATA_aéroport CHAR(3), Ville VARCHAR(50), #Code_pays);\
Compagnie_aérienne = (IATA_compagnie CHAR(2), Nom VARCHAR(50), Date_création DATE, #Code_pays);\
Employer = (UUID_employer CHAR(36), Nom VARCHAR(50), Prénom VARCHAR(50), Date_naissance VARCHAR(50), Date_embauche VARCHAR(50), Role VARCHAR(50), #Code_pays, #IATA_compagnie);\
Voyageur = (UUID_voyageur CHAR(36), Nom VARCHAR(50), Prénom VARCHAR(50), Date_naissance DATE, Interdit_de_vol LOGICAL, #Code_pays);\
Avion = (ID_avion VARCHAR(15), Code_avion VARCHAR(10), #IATA_compagnie, #Code_pays);\
Vol = (UUID_vol CHAR(36), Code_vol VARCHAR(50), Date_départ_GMT_1_ DATETIME, Date_arrivé_GMT_1_ DATETIME, #ID_avion, #ICAO_départ, #ICAO_arrivé);\
Vol_Voyageurs = (#UUID_vol, #UUID_voyageur);\
Vol_Employer = (#UUID_vol, #UUID_employer);\
