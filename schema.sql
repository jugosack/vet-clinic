/* Database schema to keep the structure of entire database. */
-- Creeate database
CREATE DATABASE vet_clinic;


-- Create table
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL DEFAULT 0,
    neutered BOOLEAN NOT NULL DEFAULT false,
    weight_kg FLOAT NOT NULL
);

-- Add column
ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

-- Create table owners
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Create table species
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)NOT NULL);

--Modify animals table:
ALTER TABLE animals DROP COLUMN species;  
--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT
CONSTRAINT fk_animals_species
REFERENCES species (id); 
--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INT
CONSTRAINT fk_animals_owners
REFERENCES owners (id);

--Create table vets
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL
);

--Create table specializations
CREATE TABLE specializations (
    vet_id INT NOT NULL,
    species_id INT NOT NULL,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_specializations_vets
        FOREIGN KEY (vet_id) REFERENCES vets (id),
    CONSTRAINT fk_specializations_species
        FOREIGN KEY (species_id) REFERENCES species (id)
);

--Create table visits
CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE NOT NULL,
    CONSTRAINT fk_visits_animals
        FOREIGN KEY (animal_id) REFERENCES animals (id),
    CONSTRAINT fk_visits_vets
        FOREIGN KEY (vet_id) REFERENCES vets (id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

