-- 1. Tabel: Arvutite tootja
CREATE TABLE Tootja (
                        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                        nimi VARCHAR(191) NOT NULL
);

-- 2. Tabel: Arvuti mudel
CREATE TABLE Mudel (
                       id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                       tootja_id INT UNSIGNED NOT NULL,
                       mudel VARCHAR(191) NOT NULL,
                       tootmisaasta YEAR NOT NULL,
                       FOREIGN KEY (tootja_id) REFERENCES Tootja(id) ON DELETE CASCADE
);

-- 3. Tabel: Arvuti komponentide tüüp (näiteks protsessor, RAM, graafikakaart jne)
CREATE TABLE KomponentideTüüp (
                                  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                                  nimi VARCHAR(191) NOT NULL
);

-- 4. Tabel: Arvuti komponent (nt protsessor, RAM, kõvaketas jne)
CREATE TABLE Komponent (
                           id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                           tüüp_id INT UNSIGNED NOT NULL,
                           nimi VARCHAR(191) NOT NULL,
                           mudel VARCHAR(191) NOT NULL,
                           hind DECIMAL(10, 2) NOT NULL,
                           FOREIGN KEY (tüüp_id) REFERENCES KomponentideTüüp(id) ON DELETE CASCADE
);

-- 5. Tabel: Kasutajad (kellele arvutid kuuluvad)
CREATE TABLE Kasutaja (
                          id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                          eesnimi VARCHAR(191) NOT NULL,
                          perenimi VARCHAR(191) NOT NULL,
                          email VARCHAR(191) NOT NULL UNIQUE,
                          telefon VARCHAR(20),
                          registreerimise_aeg TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Tabel: Kasutaja arvuti (millel on viide Kasutajale ja Mudelile)
CREATE TABLE KasutajaArvuti (
                                id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                                kasutaja_id INT UNSIGNED NOT NULL,
                                mudel_id INT UNSIGNED NOT NULL,
                                soetusaasta YEAR NOT NULL,
                                hind DECIMAL(10, 2),
                                FOREIGN KEY (kasutaja_id) REFERENCES Kasutaja(id) ON DELETE CASCADE,
                                FOREIGN KEY (mudel_id) REFERENCES Mudel(id) ON DELETE CASCADE
);

-- 7. Tabel: Arvuti hooldus (nt tarkvara uuendamine, riistvara remont)
CREATE TABLE Hooldus (
                         id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                         kasutaja_arvuti_id INT UNSIGNED NOT NULL,
                         hoolduse_kuupäev DATE NOT NULL,
                         hoolduse_kirjeldus TEXT,
                         hoolduse_kulud DECIMAL(10, 2),
                         FOREIGN KEY (kasutaja_arvuti_id) REFERENCES KasutajaArvuti(id) ON DELETE CASCADE
);

-- 8. Tabel: Arvuti tarkvara (nt operatsioonisüsteemid, kontoritarkvara jne)
CREATE TABLE Tarkvara (
                          id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                          nimi VARCHAR(191) NOT NULL,
                          versioon VARCHAR(50) NOT NULL
);

-- 9. Tabel: Arvuti tarkvara paigaldus (seob tarkvara ja arvuti)
CREATE TABLE ArvutiTarkvara (
                                id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                                kasutaja_arvuti_id INT UNSIGNED NOT NULL,
                                tarkvara_id INT UNSIGNED NOT NULL,
                                paigalduskuupäev DATE NOT NULL,
                                FOREIGN KEY (kasutaja_arvuti_id) REFERENCES KasutajaArvuti(id) ON DELETE CASCADE,
                                FOREIGN KEY (tarkvara_id) REFERENCES Tarkvara(id) ON DELETE CASCADE
);
