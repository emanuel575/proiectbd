-- Generated by Oracle SQL Developer Data Modeler 18.4.0.339.1532
--   at:        2019-05-22 21:17:12 EEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



DROP TABLE employees CASCADE CONSTRAINTS;

DROP TABLE terrains CASCADE CONSTRAINTS;

DROP TABLE users CASCADE CONSTRAINTS;

DROP TABLE users_details CASCADE CONSTRAINTS;

DROP TABLE veh_emp_fk CASCADE CONSTRAINTS;

DROP TABLE vehicles CASCADE CONSTRAINTS;

CREATE TABLE employees (
    emp_id          NUMBER(3) NOT NULL,
    name            VARCHAR2(255) NOT NULL,
    salary          NUMBER(5) NOT NULL,
    users_user_id   NUMBER(3) NOT NULL
);

ALTER TABLE employees ADD CONSTRAINT employees_pk PRIMARY KEY ( emp_id );

ALTER TABLE employees ADD CONSTRAINT employees_emp_id_un UNIQUE ( emp_id );

CREATE TABLE terrains (
    terrain_id      NUMBER(3) NOT NULL,
    area            NUMBER(6),
    width           NUMBER(3) NOT NULL,
    tlength         NUMBER(3) NOT NULL,
    users_user_id   NUMBER(3) NOT NULL
);

ALTER TABLE terrains ADD CONSTRAINT terrains_pk PRIMARY KEY ( terrain_id );

ALTER TABLE terrains ADD CONSTRAINT terrains_terrain_id_un UNIQUE ( terrain_id );

CREATE TABLE users (
    user_id   NUMBER(3) NOT NULL,
    email     VARCHAR2(255) NOT NULL,
    pwd       VARCHAR2(255) NOT NULL
);

ALTER TABLE users ADD CONSTRAINT users_pk PRIMARY KEY ( user_id );

ALTER TABLE users ADD CONSTRAINT users_user_id_un UNIQUE ( user_id );

ALTER TABLE users ADD CONSTRAINT users_email_un UNIQUE ( email );

ALTER TABLE users ADD CONSTRAINT users_pwd_ck CHECK ( LENGTH(pwd) >= 6 );

CREATE TABLE users_details (
    first_name      VARCHAR2(255) NOT NULL,
    last_name       VARCHAR2(255) NOT NULL,
    phone           VARCHAR2(10),
    users_user_id   NUMBER(3) NOT NULL
);

CREATE UNIQUE INDEX users_details__idx ON
    users_details (
        users_user_id
    ASC );

ALTER TABLE users_details ADD CONSTRAINT usrdet_phone_CK CHECK ( LENGTH(phone) = 10 );

CREATE TABLE veh_emp_fk (
    vehicles_vehicle_id   NUMBER(3) NOT NULL,
    employees_emp_id      NUMBER(3) NOT NULL
);

ALTER TABLE veh_emp_fk ADD CONSTRAINT veh_emp_fk_pk PRIMARY KEY ( vehicles_vehicle_id,
                                                                  employees_emp_id );

CREATE TABLE vehicles (
    vehicle_id      NUMBER(3) NOT NULL,
    status          VARCHAR2(255) NOT NULL,
    vehicle_type    VARCHAR2(255) NOT NULL,
    users_user_id   NUMBER(3) NOT NULL
);

ALTER TABLE vehicles ADD CONSTRAINT vehicles_pk PRIMARY KEY ( vehicle_id );

ALTER TABLE vehicles ADD CONSTRAINT vehicles_vehicle_id_un UNIQUE ( vehicle_id );

ALTER TABLE vehicles ADD CONSTRAINT vehicles_status_ck CHECK (status in ("garage", "working", "service" ) );

ALTER TABLE employees
    ADD CONSTRAINT employees_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id );

ALTER TABLE terrains
    ADD CONSTRAINT terrains_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id );

ALTER TABLE users_details
    ADD CONSTRAINT users_details_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id );

ALTER TABLE veh_emp_fk
    ADD CONSTRAINT veh_emp_fk_employees_fk FOREIGN KEY ( employees_emp_id )
        REFERENCES employees ( emp_id );

ALTER TABLE veh_emp_fk
    ADD CONSTRAINT veh_emp_fk_vehicles_fk FOREIGN KEY ( vehicles_vehicle_id )
        REFERENCES vehicles ( vehicle_id );

ALTER TABLE vehicles
    ADD CONSTRAINT vehicles_users_fk FOREIGN KEY ( users_user_id )
        REFERENCES users ( user_id );

CREATE SEQUENCE employees_emp_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER employees_emp_id_trg BEFORE
    INSERT ON employees
    FOR EACH ROW
    WHEN ( new.emp_id IS NULL )
BEGIN
    :new.emp_id := employees_emp_id_seq.nextval;
END;
/

CREATE SEQUENCE terrains_terrain_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER terrains_terrain_id_trg BEFORE
    INSERT ON terrains
    FOR EACH ROW
    WHEN ( new.terrain_id IS NULL )
BEGIN
    :new.terrain_id := terrains_terrain_id_seq.nextval;
END;
/

CREATE SEQUENCE users_user_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER users_user_id_trg BEFORE
    INSERT ON users
    FOR EACH ROW
    WHEN ( new.user_id IS NULL )
BEGIN
    :new.user_id := users_user_id_seq.nextval;
END;
/

CREATE SEQUENCE vehicles_vehicle_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER vehicles_vehicle_id_trg BEFORE
    INSERT ON vehicles
    FOR EACH ROW
    WHEN ( new.vehicle_id IS NULL )
BEGIN
    :new.vehicle_id := vehicles_vehicle_id_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             1
-- ALTER TABLE                             16
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           4
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          4
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
