/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-------------------------------------------------------------------------------

--update the animals table by setting the species column to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
--------------------------------------------------------------------------------
BEGIN;
--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;
---------------------------------------------------------------------------------
BEGIN;
--Inside a transaction delete all records in the animals table, then roll back the transaction.
DELETE FROM animals;

ROLLBACK;
---------------------------------------------------------------------------------
BEGIN;
--Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

--Create a savepoint for the transaction.
SAVEPOINT sp1;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg=weight_kg * -1;

--Rollback to the savepoint
ROLLBACK TO sp1;

--Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg=weight_kg * -1 WHERE weight_kg < 0;

--Commit transaction
COMMIT;
-------------------------------------------------------------------------------------
--How many animals are there?
SELECT COUNT(*) FROM animals;

--How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

--What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

--Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) as total_escape_attempts FROM animals
GROUP BY neutered ORDER BY total_escape_attempts DESC LIMIT 1;

--What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight FROM animals
GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as avg_escape_attempts FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

--------------------------------------------------------------------------------------
--What animals belong to Melody Pond?
SELECT full_name, name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond ';

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY full_name;

--How many animals are there per species?
SELECT species.name, COUNT(animals.name) FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name, animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name, animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

--Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) as total_animals FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY total_animals DESC LIMIT 1;









