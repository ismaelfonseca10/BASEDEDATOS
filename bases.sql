CREATE TABLE VIAS (
    NOM_VIA VARCHAR2(10) PRIMARY KEY,
    TIPO VARCHAR2(10)
        CONSTRAINT via_tip_ck CHECK (TIPO IN ('AVENIDA', 'RONDA', 'CALLE', 'CAMINO'))
);

CREATE TABLE CONTENEDORES (
    NUM_INMUEBLE NUMBER(4),
    NOM_VIA VARCHAR2(10),
    CAPACIDAD NUMBER(3,2)
        CONSTRAINT con_cap_nn NOT NULL,
    TIPOS VARCHAR2(10) 
        CONSTRAINT cont_tips_ck CHECK (TIPOS IN ('PLASTICO','ORGANICO','PAPEL','CRISTAL','MIXTA')),
    
    CONSTRAINT con_via_fk FOREIGN KEY (NOM_VIA) REFERENCES VIAS ON DELETE CASCADE,
    CONSTRAINT cont_pk PRIMARY KEY (NUM_INMUEBLE,NOM_VIA)
);

CREATE TABLE BRIGADA (
    ID_BRIGADA NUMBER(4) PRIMARY KEY,
    DESCRIPCION VARCHAR2(20) 
        CONSTRAINT bri_des_nn NOT NULL
);
CREATE TABLE RUTA (
    ID_RUTA NUMBER(3) PRIMARY KEY,
    RECOGIDA VARCHAR2(10)
        CONSTRAINT rut_rec_ck CHECK (RECOGIDA IN ('DIURNA','NOCTURNA')),
   ID_BRIGADA NUMBER(4), 
        CONSTRAINT rut_bri_fk FOREIGN KEY (ID_BRIGADA) REFERENCES BRIGADA ON DELETE CASCADE
);

CREATE TABLE CAMIONES (
    MATRICULA VARCHAR2(7) PRIMARY KEY,
    CAPACIDAD VARCHAR2(4),
    ITV DATE 
        CONSTRAINT cam_itv_ck CHECK(ITV > TO_DATE('01/01/2020','DD/MM/YYYY')),
    ID_BRIGADA NUMBER(4), 
        CONSTRAINT cam_bri_fk FOREIGN KEY (ID_BRIGADA) REFERENCES BRIGADA ON DELETE CASCADE
);

CREATE TABLE EMPLEADO (
    NIF VARCHAR2(9) PRIMARY KEY,
    NOMBRE VARCHAR2(10) 
        CONSTRAINT emp_nom_nn NOT NULL,
    SEXO VARCHAR2(1) 
        CONSTRAINT emp_sex_ck CHECK (SEXO IN ('M','F')),
    F_NACIMIENTO DATE 
        CONSTRAINT emp_nac_nn NOT NULL,
    F_CONTRATACION DATE 
        CONSTRAINT emp_con_nn NOT NULL,
    MATRICULA VARCHAR2(7),
        CONSTRAINT emp_cam_fk FOREIGN KEY (MATRICULA) REFERENCES CAMIONES ON DELETE CASCADE
);

CREATE TABLE CONTIENE (
    NOM_VIA VARCHAR2(10),
    ID_RUTA NUMBER(3),
    ORDEN VARCHAR2(5) 
        CONSTRAINT con_ord_nn NOT NULL,
    CONSTRAINT con_pk PRIMARY KEY (NOM_VIA, ID_RUTA)
);

CREATE TABLE ASIGNADO(
    NIF VARCHAR2(9),
    ID_BRIGADA NUMBER(4),
    F_INICIO DATE,
    F_FIN DATE,
    CONSTRAINT asi_pk PRIMARY KEY (NIF,ID_BRIGADA,F_INICIO)
);

INSERT INTO VIAS VALUES ('NOALLA','CALLE');
INSERT INTO VIAS VALUES ('PIÑOR','RONDA');
INSERT INTO VIAS VALUES ('XINZO','AVENIDA');

INSERT INTO CONTENEDORES VALUES ('12','NOALLA','5','MIXTA');
INSERT INTO CONTENEDORES VALUES ('26','PIÑOR','5','MIXTA');
INSERT INTO CONTENEDORES VALUES ('17','NOALLA','5','PLASTICO');

INSERT INTO BRIGADA VALUES ('126','AEREA');
INSERT INTO BRIGADA VALUES ('854','FUEGO');
INSERT INTO BRIGADA VALUES ('961','TIERRA');

INSERT INTO RUTA VALUES ('7','DIURNA','126');
INSERT INTO RUTA VALUES ('48','NOCTURNA','961');
INSERT INTO RUTA VALUES ('19','DIURNA','854');

INSERT INTO CAMIONES VALUES ('5412CFV','2000','02/05/2021','854');
INSERT INTO CAMIONES VALUES ('7845FGJ','152','02/05/2020','854');
INSERT INTO CAMIONES (MATRICULA,CAPACIDAD,ID_BRIGADA) VALUES ('5432GFD','43','126');

INSERT INTO EMPLEADO VALUES ('78945612V','MANUEL','M','16/12/2000','12/12/2021','5412CFV');
INSERT INTO EMPLEADO VALUES ('12345678C','SARA','F','16/12/2010','12/12/2021','7845FGJ');
INSERT INTO EMPLEADO VALUES ('12547854C','PEPE','M','16/12/2010','12/12/2021','5432GFD');

INSERT INTO CONTIENE VALUES ('NOALLA','7','NORTE');
INSERT INTO CONTIENE VALUES ('XINZO','48','SUR');
INSERT INTO CONTIENE VALUES ('NOALLA','48','SUR');

INSERT INTO ASIGNADO VALUES ('78945612V','126','02/05/2015','06/05/2019');
INSERT INTO ASIGNADO VALUES ('12345678C','126','02/05/2005','06/05/2014');
INSERT INTO ASIGNADO VALUES ('78945612V','854','02/05/2016','06/05/2021');

/*
DELETE  FROM VIAS WHERE (NOM_VIA = 'NOALLA');

SELECT * FROM VIAS;
SELECT * FROM CONTENEDORES;


*/

/*

ELIMINAR TABLAS

DROP TABLE ASIGNADO;
DROP TABLE CONTIENE;
DROP TABLE EMPLEADO;
DROP TABLE CONTENEDORES;
DROP TABLE CAMIONES;
DROP TABLE RUTA;
DROP TABLE VIAS;
DROP TABLE BRIGADA;
*/



--SELECT * FROM CAMIONES;
