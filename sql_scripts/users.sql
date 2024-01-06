USE thesspitidb;

-- DROP USERS IN CASE THEY ALREADY EXIST
DROP USER IF EXISTS 'dbadmin'@'localhost';
DROP USER IF EXISTS 'developer'@'localhost';
DROP USER IF EXISTS 'guestuser'@'localhost';
DROP USER IF EXISTS 'guestuser'@'%';
DROP USER IF EXISTS 'registereduser'@'localhost';
DROP USER IF EXISTS 'registereduser'@'%';
DROP USER IF EXISTS 'manager'@'localhost';
DROP USER IF EXISTS 'manager'@'%';
DROP USER IF EXISTS 'serviceprovider'@'localhost';
DROP USER IF EXISTS 'serviceprovider'@'%';

-- THIS IS DATABASE ADMINISTRATOR
CREATE USER 'dbadmin'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON thesspitidb.* TO 'dbadmin'@'localhost';

# THIS IS DEVELOPER
CREATE USER 'developer'@'localhost' IDENTIFIED BY 'devpassword';
GRANT SELECT, INSERT, UPDATE, DELETE ON thesspitidb.* TO 'developer'@'localhost'; 

# THIS IS GUEST USER 
CREATE USER 'guestuser'@'%' IDENTIFIED BY 'guestpassword';
GRANT SELECT ON thesspitidb.advertisement TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.property TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.house TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.land TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.service_provider_details TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.service_provider_pricing TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.user_reviews_service_provider TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.manager TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.owner TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.real_estate_agency TO 'guestuser'@'%';
GRANT SELECT ON thesspitidb.user_reviews_manager TO 'guestuser'@'%';
GRANT SELECT(Username) ON thesspitidb.user TO 'guestuser'@'%'; # Privacy GDPR
GRANT SELECT ON thesspitidb.view1 TO 'guestuser'@'%'; 
GRANT SELECT ON thesspitidb.view2 TO 'guestuser'@'%'; 
GRANT SELECT ON thesspitidb.view3 TO 'guestuser'@'%'; 
GRANT SELECT ON thesspitidb.view4 TO 'guestuser'@'%'; 
GRANT SELECT ON thesspitidb.view5 TO 'guestuser'@'%'; 
/*
view6 was created as our users do not need to access location 
and distance but only the information regarding specific properties
*/
GRANT SELECT ON thesspitidb.view6 TO 'guestuser'@'%'; 

-- THIS IS REGISTERED USER
CREATE USER 'registereduser'@'%' IDENTIFIED BY 'userpassword';
GRANT SELECT ON thesspitidb.advertisement TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.property TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.house TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.land TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.service_provider_details TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.service_provider_pricing TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.manager TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.owner TO 'registereduser'@'%';
GRANT SELECT ON thesspitidb.real_estate_agency TO 'registereduser'@'%';
GRANT SELECT(Username) ON thesspitidb.user TO 'registereduser'@'%'; # Privacy GDPR
GRANT SELECT ON thesspitidb.view1 TO 'registereduser'@'%'; 
GRANT SELECT ON thesspitidb.view2 TO 'registereduser'@'%'; 
GRANT SELECT ON thesspitidb.view3 TO 'registereduser'@'%'; 
GRANT SELECT ON thesspitidb.view4 TO 'registereduser'@'%'; 
GRANT SELECT ON thesspitidb.view5 TO 'registereduser'@'%'; 
GRANT SELECT ON thesspitidb.view6 TO 'registereduser'@'%'; 
-- For Data Integrity we decided not to provide the Delete on reviews
GRANT SELECT, INSERT, UPDATE ON thesspitidb.user_reviews_service_provider TO 'registereduser'@'%';
GRANT SELECT, INSERT, UPDATE ON thesspitidb.user_reviews_manager TO 'registereduser'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON thesspitidb.advertisement_watched_by_user TO 'registereduser'@'%';

-- THIS IS MANAGER
CREATE USER 'manager'@'%' IDENTIFIED BY 'managerpassword';
GRANT SELECT ON thesspitidb.service_provider_details TO 'manager'@'%';
GRANT SELECT ON thesspitidb.service_provider_pricing TO 'manager'@'%';
GRANT SELECT(Username) ON thesspitidb.user TO 'manager'@'%'; # Privacy GDPR
GRANT SELECT ON thesspitidb.user_reviews_service_provider TO 'manager'@'%';
GRANT SELECT ON thesspitidb.user_reviews_manager TO 'manager'@'%';
GRANT SELECT ON thesspitidb.view1 TO 'manager'@'%'; 
GRANT SELECT ON thesspitidb.view2 TO 'manager'@'%'; 
GRANT SELECT ON thesspitidb.view3 TO 'manager'@'%'; 
GRANT SELECT ON thesspitidb.view4 TO 'manager'@'%'; 
GRANT SELECT ON thesspitidb.view5 TO 'manager'@'%'; 
GRANT SELECT ON thesspitidb.view6 TO 'manager'@'%'; 
-- Can see other managers and update his/her information
GRANT SELECT, UPDATE ON thesspitidb.manager TO 'manager'@'%';
GRANT SELECT, UPDATE ON thesspitidb.owner TO 'manager'@'%';
GRANT SELECT, UPDATE ON thesspitidb.real_estate_agency TO 'manager'@'%';
-- Priviledges related to managing his/her properties and their advertisements
GRANT SELECT, INSERT, UPDATE, DELETE ON thesspitidb.property TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON thesspitidb.house TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON thesspitidb.land TO 'manager'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON thesspitidb.advertisement TO 'manager'@'%';

-- THIS IS SERVICE PROVIDER
CREATE USER 'serviceprovider'@'%' IDENTIFIED BY 'serviceproviderpassword';
GRANT SELECT(Username) ON thesspitidb.user TO 'serviceprovider'@'%'; # Privacy GDPR
GRANT SELECT ON thesspitidb.user_reviews_service_provider TO 'serviceprovider'@'%';
GRANT SELECT ON thesspitidb.user_reviews_manager TO 'serviceprovider'@'%';
GRANT SELECT ON thesspitidb.property TO 'serviceprovider'@'%';
GRANT SELECT ON thesspitidb.house TO 'serviceprovider'@'%';
GRANT SELECT ON thesspitidb.land TO 'serviceprovider'@'%';
GRANT SELECT ON thesspitidb.advertisement TO 'serviceprovider'@'%';
GRANT SELECT ON thesspitidb.manager TO 'manager'@'%';
GRANT SELECT ON thesspitidb.owner TO 'manager'@'%';
GRANT SELECT ON thesspitidb.real_estate_agency TO 'manager'@'%';
GRANT SELECT ON thesspitidb.view1 TO 'serviceprovider'@'%'; 
GRANT SELECT ON thesspitidb.view2 TO 'serviceprovider'@'%'; 
GRANT SELECT ON thesspitidb.view3 TO 'serviceprovider'@'%'; 
GRANT SELECT ON thesspitidb.view4 TO 'serviceprovider'@'%'; 
GRANT SELECT ON thesspitidb.view5 TO 'serviceprovider'@'%'; 
GRANT SELECT ON thesspitidb.view6 TO 'serviceprovider'@'%'; 
GRANT SELECT, UPDATE ON thesspitidb.service_provider_details TO 'serviceprovider'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON thesspitidb.service_provider_pricing TO 'serviceprovider'@'%';

FLUSH PRIVILEGES;