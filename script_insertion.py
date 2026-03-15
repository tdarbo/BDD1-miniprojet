import uuid
import random
from datetime import datetime, timedelta

pays = [('FRA', 'France'), ('USA', 'Etats-Unis'), ('GBR', 'Royaume-Uni'), ('JPN', 'Japon'), ('CAN', 'Canada')]
aeroports = [('LFPG', 'CDG', 'Paris', 'FRA'), ('LFPO', 'ORY', 'Paris', 'FRA'), ('KJFK', 'JFK', 'New York', 'USA'),
             ('KLAX', 'LAX', 'Los Angeles', 'USA'), ('EGLL', 'LHR', 'Londres', 'GBR'), ('RJTT', 'HND', 'Tokyo', 'JPN')]
compagnies = [('AF', 'Air France', '1933-10-07', 'FRA'), ('AA', 'American Airlines', '1926-04-15', 'USA'),
              ('BA', 'British Airways', '1974-03-31', 'GBR')]
roles = ['Pilote', 'Copilote', 'Cdb', 'Hôtesse', 'Steward']
prenoms = ['Jean', 'Marie', 'Luc', 'Sophie', 'John', 'Emma', 'Kenji', 'Yui', 'Hugo', 'Léa']
noms = ['Dupont', 'Martin', 'Smith', 'Johnson', 'Watanabe', 'Tremblay', 'Gagnon', 'Roux', 'Petit', 'Garcia']

employes = []
for _ in range(50):
    comp = random.choice(compagnies)
    employes.append({
        'uuid': str(uuid.uuid4()), 'nom': random.choice(noms), 'prenom': random.choice(prenoms),
        'naissance': f"{random.randint(1970, 1999)}-0{random.randint(1,9)}-1{random.randint(0,9)}",
        'embauche': f"201{random.randint(0,9)}-0{random.randint(1,9)}-1{random.randint(0,9)}",
        'role': random.choice(roles), 'pays': comp[3], 'iata_comp': comp[0]
    })

voyageurs = []
for _ in range(350):
    voyageurs.append({
        'uuid': str(uuid.uuid4()), 'nom': random.choice(noms), 'prenom': random.choice(prenoms),
        'naissance': f"{random.randint(1950, 2010)}-0{random.randint(1,9)}-1{random.randint(0,9)}",
        'interdit': 1 if random.random() < 0.02 else 0, # 2% d'interdits
        'pays': random.choice(pays)[0]
    })

avions = []
for i in range(1, 11):
    comp = random.choice(compagnies)
    avions.append((f"ID-AV{i}", f"A3{random.randint(20,50)}", comp[0], comp[3]))


with open('./3_insert_data.sql', 'w', encoding='utf-8') as f:
    f.write("-- Fichier généré automatiquement\n\n")

    # Pays
    f.write("INSERT INTO pays (Code_pays, Nom_pays) VALUES\n")
    f.write(",\n".join([f"('{p[0]}', '{p[1]}')" for p in pays]) + ";\n\n")

    # Aéroports
    f.write("INSERT INTO Aéroport (ICAO, IATA_aéroport, Ville, Code_pays) VALUES\n")
    f.write(",\n".join([f"('{a[0]}', '{a[1]}', '{a[2]}', '{a[3]}')" for a in aeroports]) + ";\n\n")

    # Compagnies
    f.write("INSERT INTO Compagnie_aérienne (IATA_compagnie, Nom, Date_création, Code_pays) VALUES\n")
    f.write(",\n".join([f"('{c[0]}', '{c[1]}', '{c[2]}', '{c[3]}')" for c in compagnies]) + ";\n\n")

    # Avions
    f.write("INSERT INTO Avion (ID_avion, Code_avion, IATA_compagnie, Code_pays) VALUES\n")
    f.write(",\n".join([f"('{a[0]}', '{a[1]}', '{a[2]}', '{a[3]}')" for a in avions]) + ";\n\n")

    # Employés
    f.write("INSERT INTO Employer (UUID_employer, Nom, Prénom, Date_naissance, Date_embauche, Role_employer, Code_pays, IATA_compagnie) VALUES\n")
    f.write(",\n".join([f"('{e['uuid']}', '{e['nom']}', '{e['prenom']}', '{e['naissance']}', '{e['embauche']}', '{e['role']}', '{e['pays']}', '{e['iata_comp']}')" for e in employes]) + ";\n\n")

    # Voyageurs
    f.write("INSERT INTO Voyageur (UUID_voyageur, Nom, Prénom, Date_naissance, Interdit_de_vol, Code_pays) VALUES\n")
    f.write(",\n".join([f"('{v['uuid']}', '{v['nom']}', '{v['prenom']}', '{v['naissance']}', {v['interdit']}, '{v['pays']}')" for v in voyageurs]) + ";\n\n")

    # Vols et liaisons
    base_date = datetime(2026, 4, 1, 8, 0)
    vols_sql, vols_voyageurs_sql, vols_employes_sql, vols_aero_sql = [], [], [], []

    for i in range(1, 16): # 15 vols
        id_vol = str(uuid.uuid4())
        code_vol = f"VOL{i*100}"
        depart = base_date + timedelta(days=i, hours=random.randint(-4, 4))
        arrivee = depart + timedelta(hours=random.randint(2, 12))
        avion = random.choice(avions)
        aeros = random.sample(aeroports, 2)
        vols_sql.append(f"('{id_vol}', '{code_vol}', '{depart.strftime('%Y-%m-%d %H:%M:%S')}', '{arrivee.strftime('%Y-%m-%d %H:%M:%S')}', '{avion[0]}','{aeros[0][0]}','{aeros[1][0]}')")

        # ~20 Voyageurs (entre 18 et 23)
        passagers = random.sample(voyageurs, random.randint(18, 23))
        for p in passagers:
            vols_voyageurs_sql.append(f"('{id_vol}', '{p['uuid']}')")

        # 5 Employés par vol
        eq = random.sample(employes, 5)
        for e in eq:
            vols_employes_sql.append(f"('{id_vol}', '{e['uuid']}')")

    f.write("INSERT INTO Vol (UUID_vol, Code_vol, Date_départ_GMT_1_, Date_arrivé_GMT_1_, ID_avion, ICAO_départ, ICAO_arrivé) VALUES\n")
    f.write(",\n".join(vols_sql) + ";\n\n")

    f.write("INSERT INTO Vol_Employer (UUID_vol, UUID_employer) VALUES\n")
    f.write(",\n".join(vols_employes_sql) + ";\n\n")

    f.write("INSERT INTO Vol_Voyageur (UUID_vol, UUID_voyageur) VALUES\n")
    f.write(",\n".join(vols_voyageurs_sql) + ";\n")

print("Le script a généré le fichier '3_insert_data.sql' avec succès.")