SET search_path TO data, public;

DROP TABLE IF EXISTS companies CASCADE;
DROP TABLE IF EXISTS adresses CASCADE;
DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE IF NOT EXISTS companies (
	company VARCHAR (255) PRIMARY KEY,
	IČO CHAR (8));

INSERT INTO companies VALUES ('Giant Company', '12345678');
INSERT INTO companies VALUES ('Shipper Inc.', '84256842');
INSERT INTO companies VALUES ('Nut Business', '76842839');

CREATE TABLE IF NOT EXISTS adresses (
	office_id	SERIAL PRIMARY KEY,
	company VARCHAR (255)	REFERENCES companies(company),
	office_type CHAR (14)	CHECK (office_type IN ('headquarters', 'branch', 'foreign_branch')),
	country VARCHAR (255),
	city VARCHAR (255),
	street VARCHAR (255),
	descriptive_number CHAR (10),
	orientation_number CHAR (10),
	ZIP_code VARCHAR (10));

INSERT INTO adresses (company, office_type, country, city, street, descriptive_number, orientation_number, ZIP_code) VALUES
	('Giant Company', 'headquarters', 'Czech Republic', 'Prague', 'Přímá', '1956', '8', '16800'),
	('Giant Company', 'branch', 'Czech Republic', 'Brno', 'Vedlejší', '3452', '5', '60200'),
	('Giant Company', 'foreign_branch', 'Germany', 'Hamburg', 'Direkt Strasse', '1584', '3', '20095'),
	('Giant Company', 'foreign_branch', 'Australia', 'Canberra', 'Rainy Street', '8941', '2', '2601'),
	('Shipper Inc.', 'headquarters', 'Czech Republic', 'Prague', 'Radimova', '2561', '14', '36301'),
	('Shipper Inc.', 'branch', 'Czech Republic', 'Jihlava', 'Palackého', '2152', '51', '45610'),
	('Nut Business', 'headquarters', 'Czech Republic', 'Prague', 'Národní', '10010', '54', '1100');

CREATE TABLE IF NOT EXISTS employees (
	first_name VARCHAR (50),
	last_name VARCHAR (50),
	office_id int REFERENCES adresses(office_id),
	job_position VARCHAR (50) CHECK (job_position IN ('Agent', 'Director', 'Technical Staff',  'Economist', 'Receptionist')));
	
INSERT INTO employees VALUES ('Ctibor', 'Čejka', 1, 'Agent');
INSERT INTO employees VALUES ('Slavomír', 'Plášil', 1, 'Director');
INSERT INTO employees VALUES ('Kryštof', 'Štrobl', 1, 'Technical Staff');
INSERT INTO employees VALUES ('Hanuš', 'Bursík', 1, 'Economist');
INSERT INTO employees VALUES ('Julie', 'Šemberová', 1, 'Receptionist');
INSERT INTO employees VALUES ('Emílie', 'Rokosová', 1, 'Agent');
INSERT INTO employees VALUES ('Bronislav', 'Holek', 2, 'Technical Staff');
INSERT INTO employees VALUES ('Viktor', 'Kukačka', 2, 'Economist');
INSERT INTO employees VALUES ('Oto', 'Vydra', 3, 'Agent');
INSERT INTO employees VALUES ('Marián', 'Záhora', 3, 'Technical Staff');
INSERT INTO employees VALUES ('Alena', 'Šnajdrová', 4, 'Agent');
INSERT INTO employees VALUES ('Danuše', 'Wawrzyczková', 4, 'Receptionist');
INSERT INTO employees VALUES ('Vojtěch', 'Košmider', 4, 'Economist');
INSERT INTO employees VALUES ('Marie', 'Hynková', 5, 'Agent');
INSERT INTO employees VALUES ('Bronislav', 'Vrabec', 5, 'Economist');
INSERT INTO employees VALUES ('Jiří', 'Tanics', 6, 'Agent');
INSERT INTO employees VALUES ('Zuzana', 'Zídková', 6, 'Economist');
INSERT INTO employees VALUES ('Ladislav', 'Kudela', 6, 'Technical Staff');
INSERT INTO employees VALUES ('Alžbeta', 'Adamíková', 7, 'Agent');
INSERT INTO employees VALUES ('Libuše', 'Baroňová', 7, 'Economist');





