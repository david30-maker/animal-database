INSERT INTO animals (
	name,
	date_of_birth,
	escape_attempts,
	neutered,
	weight_kg
) VALUES
('Agumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8),
('Pikachu', '2021-01-07', 1, false, 15.04),
('Devimon', '2017-05-12', 5, true, 11),
('Charmander', '2020-02-08', 0, false, -11),
('Plantmon', '2021-11-15', 2, true, -5.7),
('Squirtle', '1993-04-02', 3, false, -12.13),
('Angemon', '2005-06-12', 1, true, -45),
('Boarmon', '2005-06-07', 7, true, 20.4),
('Blossom', '1998-10-13', 3, true, 17),
('Ditto', '2022-05-14', 4, true, 22);


-- Insert data into the owners table
INSERT INTO owners (full_name, age) VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name) VALUES
  ('Pokemon'),
  ('Digimon');

-- Modify inserted animals to include the species_id value
UPDATE animals
SET species_id = CASE
  WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
  ELSE (SELECT id FROM species WHERE name = 'Pokemon')
  END;

-- Modify inserted animals to include owner information (owner_id)
UPDATE animals AS a
SET owner_id = o.id
FROM owners AS o
WHERE a.owner_id IS NULL
  AND (
    (a.name = 'Agumon' AND o.full_name = 'Sam Smith') OR
    (a.name IN ('Gabumon', 'Pikachu') AND o.full_name = 'Jennifer Orwell') OR
    (a.name IN ('Devimon', 'Plantmon') AND o.full_name = 'Bob') OR
    (a.name IN ('Charmander', 'Squirtle', 'Blossom') AND o.full_name = 'Melody Pond') OR
    (a.name IN ('Angemon', 'Boarmon') AND o.full_name = 'Dean Winchester')
  );
  
  -- Insert data for vets
INSERT INTO vets (name, age, date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

-- Insert data for specializations
INSERT INTO specializations (vet_id, species) VALUES
  (1, 'Pokemon'),
  (3, 'Digimon'),
  (3, 'Pokemon'),
  (4, 'Digimon');

-- Insert data for visits
INSERT INTO visits (animal, vet_id, visit_date) VALUES
  ('Agumon', 1, '2020-05-24'),
  ('Agumon', 3, '2020-07-22'),
  ('Gabumon', 4, '2021-02-02'),
  ('Pikachu', 2, '2020-01-05'),
  ('Pikachu', 2, '2020-03-08'),
  ('Pikachu', 2, '2020-05-14'),
  ('Devimon', 3, '2021-05-04'),
  ('Charmander', 4, '2021-02-24'),
  ('Plantmon', 1, '2020-08-10'),
  ('Plantmon', 2, '2019-12-21'),
  ('Plantmon', 2, '2021-04-07'),
  ('Squirtle', 3, '2019-09-29'),
  ('Angemon', 4, '2020-10-03'),
  ('Angemon', 4, '2020-11-04'),
  ('Boarmon', 2, '2019-01-24'),
  ('Boarmon', 2, '2019-05-15'),
  ('Boarmon', 2, '2020-02-27'),
  ('Boarmon', 2, '2020-08-03'),
  ('Blossom', 3, '2020-05-24'),
  ('Blossom', 1, '2021-01-11');
