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
insert into visits(animal_id, vet_id, visit_date)
values (1, 1, '2020-5-24'),
(1, 3, '2020-7-22'),
(2, 4, '2021-2-2'),
(7, 2, '2020-1-5'),
(7, 2, '2020-3-8'),
(7, 2, '2020-5-14'),
(3, 3, '2021-5-4'),
(8, 4, '2021-2-24'),
(4, 2, '2019-12-21'),
(4, 1, '2020-8-10'),
(4, 2, '2021-4-7'),
(9, 3, '2019-9-29'),
(5, 4, '2020-10-3'),
(5, 4, '2020-11-4'),
(6, 2, '2019-1-24'),
(6, 2, '2019-5-15'),
(6, 2, '2020-2-27'),
(6, 2, '2020-8-3'),
(10, 3, '2020-5-24'),
(10, 1, '2021-1-11');
