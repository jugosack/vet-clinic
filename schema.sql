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
