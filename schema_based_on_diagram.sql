-- Creating patients table
CREATE TABLE patients (
  id            SERIAL PRIMARY KEY,
  name          VARCHAR(255),
  date_of_birth DATE
);

-- Creating medical_histories table
CREATE TABLE medical_histories (
  id         SERIAL PRIMARY KEY,
  admited_at TIMESTAMP,
  patient_id INTEGER UNIQUE REFERENCES patients(id),
  email      VARCHAR(120)
);

-- Creating treatments table
CREATE TABLE treatments (
  id   SERIAL PRIMARY KEY,
  type VARCHAR(100),
  name VARCHAR(255)
);

-- Creating medical_history_treatments table
CREATE TABLE medical_history_treatments (
  medical_history_id INTEGER REFERENCES medical_histories(id),
  treatment_id       INTEGER REFERENCES treatments(id),
  PRIMARY KEY (medical_history_id, treatment_id)
);
CREATE INDEX idx_medical_history_treatments_medical_history_id ON medical_history_treatments (medical_history_id);
CREATE INDEX idx_medical_history_treatments_treatment_id ON medical_history_treatments (treatment_id);

-- Creating invoices table
CREATE TABLE invoices (
  id               SERIAL PRIMARY KEY,
  total_amount     DECIMAL,
  generated_at     TIMESTAMP,
  payed_at         TIMESTAMP,
  medical_history_id INTEGER UNIQUE REFERENCES medical_histories(id)
);

-- Creating invoice_items table
CREATE TABLE invoice_items (
  id           SERIAL PRIMARY KEY,
  unit_price   DECIMAL,
  quantity     INTEGER,
  total_price  DECIMAL,
  invoice_id   INTEGER REFERENCES invoices(id),
  treatment_id INTEGER REFERENCES treatments(id)
);
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items (treatment_id);
