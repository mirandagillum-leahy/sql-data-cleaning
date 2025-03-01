-- Data Cleaning with SQL
-- This script demonstrates various SQL techniques to clean and standardize messy datasets.

-- Creating a sample dataset with messy data
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    email TEXT,
    phone TEXT,
    city TEXT,
    signup_date TEXT  -- Stored as TEXT instead of DATE for cleaning demonstration
);

INSERT INTO customers (full_name, email, phone, city, signup_date) VALUES
('john doe', 'johndoe@email..com', '123-456-7890', 'new york', '12/31/2020'),
('JANE SMITH', 'janesmith@emailcom', '987.654.3210', 'Los Angeles', '2020-31-12'),
('ROBERT BROWN', 'robertbrown@email.com', '(555) 123-4567', 'San francisco', '31-12-2020');

-- Standardizing Name Format (Title Case)
SELECT id, 
       INITCAP(full_name) AS standardized_name
FROM customers;

-- Cleaning Email Addresses
SELECT id, 
       LOWER(TRIM(BOTH '.' FROM email)) AS cleaned_email
FROM customers;

-- Standardizing Phone Number Format
SELECT id, 
       REGEXP_REPLACE(phone, '[^0-9]', '', 'g') AS standardized_phone
FROM customers;

-- Standardizing City Names
SELECT id, 
       INITCAP(TRIM(city)) AS standardized_city
FROM customers;

-- Converting String Dates to Proper DATE Format
SELECT id, 
       CASE 
           WHEN signup_date LIKE '%/%/%' THEN TO_DATE(signup_date, 'MM/DD/YYYY')
           WHEN signup_date LIKE '%-%-%' THEN TO_DATE(signup_date, 'DD-MM-YYYY')
           ELSE NULL
       END AS formatted_signup_date
FROM customers;

-- Cleaning and Standardizing Data in a New Table
CREATE TABLE cleaned_customers AS
SELECT id,
       INITCAP(full_name) AS standardized_name,
       LOWER(TRIM(BOTH '.' FROM email)) AS cleaned_email,
       REGEXP_REPLACE(phone, '[^0-9]', '', 'g') AS standardized_phone,
       INITCAP(TRIM(city)) AS standardized_city,
       CASE 
           WHEN signup_date LIKE '%/%/%' THEN TO_DATE(signup_date, 'MM/DD/YYYY')
           WHEN signup_date LIKE '%-%-%' THEN TO_DATE(signup_date, 'DD-MM-YYYY')
           ELSE NULL
       END AS formatted_signup_date
FROM customers;

-- Selecting the cleaned data
SELECT * FROM cleaned_customers;
