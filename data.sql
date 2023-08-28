-- data.sql
-- Insertar datos existentes de animales
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES 
('Agumon', '2020-02-03', 10.23, TRUE, 0),
('Gabumon', '2018-11-15', 8, TRUE, 2),
('Pikachu', '2021-01-07', 15.04, FALSE, 1),
('Devimon', '2017-05-12', 11, TRUE, 5),
('Charmander', '2020-02-08', 11, FALSE, 0),
('Plantmon', '2021-11-15', 5.7, TRUE, 2),
('Squirtle', '1993-04-02', 12.13, FALSE, 3),
('Angemon', '2005-06-12', 45, TRUE, 1),  
('Boarmon', '2005-06-07', 20.4, TRUE, 7),
('Blossom', '1998-10-13', 17, TRUE, 3),
('Ditto', '2022-05-14', 22, TRUE, 4);

-- Insertar especies
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Insertar propietarios
INSERT INTO owners (full_name, age) VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Modificar datos de animales para incluir species_id y owner_id
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon' LIMIT 1) WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon' LIMIT 1 ) WHERE species_id IS NULL;

-- Asignar propietarios a animales
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith' LIMIT 1) WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' LIMIT 1) WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob' LIMIT 1) WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond' LIMIT 1) WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester' LIMIT 1) WHERE name IN ('Angemon', 'Boarmon');

-- Insertar datos para los veterinarios
INSERT INTO vets (name, age, date_of_graduation)
VALUES 
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Insertar datos para especializaciones
-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon'));

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon'));

-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

-- Insertar datos para visitas
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES 
((SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), (SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), '2020-05-24'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), '2020-07-22'),
((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Gabumon' LIMIT 1), '2021-02-02'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), '2020-01-05'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), '2020-03-08'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), '2020-05-14'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Devimon' LIMIT 1), '2021-05-04'),
((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Charmander' LIMIT 1), '2021-02-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), '2019-12-21'),
((SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), (SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), '2020-08-10'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), '2021-04-07'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Squirtle' LIMIT 1), '2019-09-29'),
((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), '2020-10-03'),
((SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), (SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), '2020-11-04'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2019-01-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2019-05-15'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2020-02-27'),
((SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), (SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), '2020-08-03'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), (SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), '2020-05-24'),
((SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), (SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), '2021-01-11');

