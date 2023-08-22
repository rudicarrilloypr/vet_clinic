-- queries.sql
-- Queries proporcionadas anteriormente:
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Digimon' LIMIT 1) 
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon' LIMIT 1) 
WHERE species_id IS NULL;

-- Para verificar
SELECT * FROM animals;

COMMIT;
-- Eliminación y reversión de la transacción:
BEGIN;

DELETE FROM animals;

-- Para verificar
SELECT * FROM animals;

ROLLBACK;

-- Más transacciones:
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- Queries para responder preguntas:
-- ¿Cuántos animales hay?
SELECT COUNT(*) FROM animals;

-- ¿Cuántos animales nunca han intentado escapar?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- ¿Cuál es el peso promedio de los animales?
SELECT AVG(weight_kg) FROM animals;

-- ¿Quién escapa más, animales castrados o no castrados?
SELECT neutered, COUNT(*) FROM animals WHERE escape_attempts > 0 GROUP BY neutered;

-- ¿Cuál es el peso mínimo y máximo de cada tipo de animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- ¿Cuál es el número promedio de intentos de escape por tipo de animal de aquellos nacidos entre 1990 y 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- ¿Qué animales pertenecen a Melody Pond?
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

-- Lista de todos los animales que son Pokemon
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

-- Lista de todos los propietarios y sus animales (incluidos aquellos que no tienen ningún animal)
SELECT o.full_name, a.name AS animal_name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id;

-- ¿Cuántos animales hay por especie?
SELECT s.name AS species_name, COUNT(a.id) FROM species s LEFT JOIN animals a ON s.id = a.species_id GROUP BY s.name;

-- Lista de todos los Digimon propiedad de Jennifer Orwell
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id JOIN owners o ON a.owner_id = o.id WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

-- Lista de todos los animales propiedad de Dean Winchester que no han intentado escapar
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- ¿Quién tiene más animales?
SELECT o.full_name, COUNT(a.id) AS animal_count FROM owners o JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1)
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.id)
FROM animals a
JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1);

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, s.name AS species_name
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1)
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY COUNT(v.visit_date) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1)
ORDER BY v.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, v.name AS vet_name, vis.visit_date
FROM animals a
JOIN visits vis ON a.id = vis.animal_id
JOIN vets v ON vis.vet_id = v.id
ORDER BY vis.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits v
LEFT JOIN specializations sp ON v.vet_id = sp.vet_id
JOIN animals a ON v.animal_id = a.id
WHERE sp.species_id IS NULL OR sp.species_id != a.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS species_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN species s ON a.species_id = s.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1)
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;

