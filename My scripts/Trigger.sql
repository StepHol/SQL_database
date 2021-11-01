SET search_path TO data, public;
DROP TRIGGER IF EXISTS new_company ON companies;
DROP FUNCTION IF EXISTS set_hq_and_agent();

CREATE OR REPLACE FUNCTION set_hq_and_agent()
  RETURNS TRIGGER AS
$$
BEGIN
         INSERT INTO adresses (company, office_type, country,	city, street, descriptive_number, orientation_number, ZIP_code)
         VALUES(NEW.company, 'headquarters', 'Czech Republic', 'Prague', 'Nová ulice', '2000', '13', '16700');
		 INSERT INTO employees
		 VALUES ('Richard', 'King',(SELECT office_id FROM adresses WHERE company = NEW.company), 'Agent');
 
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER new_company
  AFTER INSERT
  ON  companies
  FOR EACH ROW
  EXECUTE PROCEDURE set_hq_and_agent();
 

-- INSERT INTO companies VALUES ('New company', '76442839');
-- SELECT * FROM adresses;
-- SELECT * FROM employees;
  
 


