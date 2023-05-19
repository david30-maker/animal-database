SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT *FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

-- Update all animals to have species as "unspecified"
UPDATE animals
SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals;

-- Roll back the change
ROLLBACK;

-- Verify the species column reverted to its previous state
SELECT * FROM animals;

BEGIN;

-- Update animals with names ending in "mon" to have species as "digimon"
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update animals without a species already set to have species as "pokemon"
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Verify the changes
SELECT * FROM animals;

COMMIT;

-- Verify the changes persist after the commit
SELECT * FROM animals;

-- Start the transaction
BEGIN TRANSACTION;

-- Delete all records in the animals table
DELETE FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Verify if all records in the animals table still exist
SELECT * FROM animals;

-- Start the transaction
BEGIN TRANSACTION;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS never_escaped_count
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;

SELECT neutered, COUNT(*) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT name, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY name;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';


SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';


SELECT o.full_name, COALESCE(a.name, 'No animal') AS animal
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;


SELECT s.name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;


SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester';


SELECT o.full_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- Query: Who was the last animal seen by William Tatcher?
SELECT animal
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY visit_date DESC
LIMIT 1;

-- Query: How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal)
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

-- Query: List all vets and their specialties, including vets with no specialties.
SELECT vets.name, specializations.species
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id;

-- Query: List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animal
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
  AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- Query: What animal has the most visits to vets?
SELECT animal, COUNT(*) AS visit_count
FROM visits
GROUP BY animal
ORDER BY visit_count DESC
LIMIT 1;

-- Query: Who was Maisy Smith's first visit?
SELECT vet_id, visit_date
FROM visits
WHERE animal = (SELECT animal FROM visits WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') ORDER BY visit_date LIMIT 1)
ORDER BY visit_date
LIMIT 1;

-- Query: Details for most recent visit: animal information, vet information, and date of visit.
-- Query: Details for most recent visit: animal information, vet information, and date of visit.
SELECT v.name AS vet_name, v.age AS vet_age, v.date_of_graduation AS vet_graduation_date,
       a.animal, vst.visit_date
FROM visits vst
JOIN vets v ON vst.vet_id = v.id
JOIN (SELECT animal, MAX(visit_date) AS max_date FROM visits GROUP BY animal) AS a
  ON vst.animal = a.animal AND vst.visit_date = a.max_date;


-- Query: How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits v
LEFT JOIN specializations s ON v.vet_id = s.vet_id AND v.animal = s.species
WHERE s.vet_id IS NULL;

-- Query: What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.species, COUNT(*) AS visit_count
FROM visits v
JOIN specializations s ON v.vet_id = s.vet_id
WHERE v.animal = (SELECT animal FROM visits WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') ORDER BY visit_date LIMIT 1)
GROUP BY s.species
ORDER BY visit_count DESC
LIMIT 1;

