CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(5,2),
    species_id INT REFERENCES species(id),
    owner_id INT REFERENCES owners(id)
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

-- Crear la tabla 'vets'
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);

-- Crear la tabla 'specializations' (join table para 'species' y 'vets')
CREATE TABLE specializations (
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

-- Crear la tabla 'visits' (join table para 'animals' y 'vets')
CREATE TABLE visits (
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    visit_date DATE,
    PRIMARY KEY (animal_id, vet_id, visit_date)
);