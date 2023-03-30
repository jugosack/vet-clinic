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