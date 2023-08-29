CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admited_at TIMESTAMP,
  patient_id INTEGER UNIQUE REFERENCES patients(id),
  email VARCHAR(120)
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(100),
  name VARCHAR(255)
);
