CREATE DATABASE Facturacion;

USE Facturacion;

CREATE TABLE t_rol(
    id_rol      int(11) AUTO_INCREMENT NOT NULL,
    rol         VARCHAR(20) NOT NULL,
    CONSTRAINT  pk_rol  PRIMARY KEY(id_rol)
) ENGINE=InnoDB;

INSERT INTO t_rol (id_rol,rol) VALUES(NULL,"ADMINITRADOR"),(NULL,"SECRETARIO"),(NULL,"BODEGUERO");

CREATE TABLE t_usuario(
    id_usuario  int(11) AUTO_INCREMENT NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    apellido    VARCHAR(100) NOT NULL,
    correo      VARCHAR(100) NOT NULL,
    password    VARCHAR(100) NOT NULL,
    id_rol      int(11)     NOT NULL,
    CONSTRAINT  pk_usuario  PRIMARY KEY(id_usuario),
    CONSTRAINT  fk_rol      FOREIGN KEY(id_rol)  REFERENCES t_rol(id_rol)
)ENGINE=InnoDB;


CREATE TABLE t_ciudad( 
    id_ciudad   INT(11) AUTO_INCREMENT NOT NULL,
    ciudad    VARCHAR(100),
    CONSTRAINT pk_ciudad PRIMARY KEY(id_ciudad)
) ENGINE=InnoDB; 

INSERT INTO t_ciudad(id_ciudad,ciudad)VALUES (NULL,"Bogota");
INSERT INTO t_ciudad(id_ciudad,ciudad)VALUES (NULL,"Medellin");
INSERT INTO t_ciudad(id_ciudad,ciudad)VALUES (NULL,"Bucaramanga");

CREATE TABLE t_unidad( 
    id_unidad   INT(11) AUTO_INCREMENT NOT NULL, 
    unidad      VARCHAR(50),
    CONSTRAINT pk_unidad PRIMARY KEY(id_unidad)
) ENGINE=InnoDB; 

INSERT INTO t_unidad(id_unidad,unidad) VALUES (NULL,"UNIDAD");
INSERT INTO t_unidad(id_unidad,unidad) VALUES (NULL,"kILO");
INSERT INTO t_unidad(id_unidad,unidad) VALUES (NULL,"RESMA");

CREATE TABLE t_cliente (
    id_cliente      INT(11) AUTO_INCREMENT NOT NULL, 
    nombre_cliente  VARCHAR(100),
    direccion       VARCHAR(100),
    id_ciudad       INT(11),
    CONSTRAINT pk_cliente PRIMARY KEY(id_cliente),
    CONSTRAINT fk_ciudad FOREIGN KEY(id_ciudad) REFERENCES t_ciudad(id_ciudad)
) ENGINE=InnoDB;

CREATE TABLE t_producto (
    id_producto      INT(11) AUTO_INCREMENT NOT NULL,
    producto         VARCHAR(50),
    id_unidad        INT(11),
    valor_unitario   FLOAT(10,2),

    CONSTRAINT pk_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_unidad FOREIGN KEY (id_unidad) REFERENCES t_unidad(id_unidad)
) ENGINE=InnoDB;

CREATE TABLE t_factura( 
    id_factura       INT(11) AUTO_INCREMENT NOT NULL,
    id_cliente       INT(11),
    id_producto      INT(11),
    fecha            date,
    cantidad         INT(11),

    CONSTRAINT pk_factura PRIMARY KEY (id_factura),
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES t_cliente(id_cliente),
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES t_producto(id_producto)
)

-- factura 

SELECT FAC.id_factura,
FAC.fecha,
        FAC.id_usuario,
        USU.nombre,
        USU.apellido,
        FAC.id_cliente,
        Cli.nombre_cliente,
        Cli.direccion,
        FAC.id_producto,
        PRO.producto,
        PRO.valor_unitario,
        FAC.cantidad
       


FROM t_factura FAC
INNER JOIN t_usuario USU on USU.id_usuario = FAC.id_usuario
INNER JOIN t_cliente Cli on Cli.id_cliente = FAC.id_cliente
INNER JOIN t_producto PRO on PRO.id_producto = FAC.id_producto

-- REPITE ESTA LINIA 