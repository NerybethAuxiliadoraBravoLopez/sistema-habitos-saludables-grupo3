Create database gestionHabitooriginal;
use gestionHabitooriginal;

# craciaon de tablas necesaria

CREATE TABLE seccion(
id_seccion INT PRIMARY KEY AUTO_INCREMENT,
letra_grupo varchar (50)
);

CREATE TABLE grado(
id_grado INT PRIMARY KEY AUTO_INCREMENT,
numero_grado INT NOT NULL);

CREATE TABLE aula(
id_aula INT PRIMARY KEY AUTO_INCREMENT,
nombre_aula varchar (100),
capacidad int not null,
Descripcion varchar (500),
id_seccion INT ,
id_grado  INT ,

FOREIGN KEY (id_seccion)  REFERENCES seccion(id_seccion),
FOREIGN KEY (id_grado) REFERENCES grado(id_grado)

);


CREATE TABLE tutor (
id_tutor INT PRIMARY KEY AUTO_INCREMENT,
nombres VARCHAR (100),
apellidos VARCHAR (100),
correos VARCHAR (100),
telefono INT NOT NULL
);

CREATE TABLE estudiante(
codigo_estudiante INT PRIMARY KEY ,
nombres VARCHAR (100),
apellidos VARCHAR (100),
fecha_nacimiento INT NOT NULL,
genero VARCHAR (100),
id_tutor INT ,
id_grado Int ,
id_seccion INT ,


FOREIGN  KEY(id_tutor) REFERENCES tutor(id_tutor),
FOREIGN  KEY(id_grado) REFERENCES grado(id_grado),
FOREIGN KEY (id_seccion) REFERENCES seccion(id_seccion) 
);

CREATE TABLE usuario(
    id_usuario INT PRIMARY KEY ,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    nombreusuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(30) NOT NULL
);


-- Tabla: Habitos

CREATE TABLE habitos(
    id_habitos INT PRIMARY KEY AUTO_INCREMENT,
    tipo_de_habito VARCHAR(50) NOT NULL,
    nombre_de_habito VARCHAR(100) NOT NULL,
    unidad_de_medida VARCHAR(30) NOT NULL,
    frecuencia varchar(50)
);

-- Tabla: EstudianteHabitos
-- (tabla intermedia: relación muchos a muchos entre
--  Estudiante y Habitos, con atributos propios)

CREATE TABLE estudiantehabitos(
    id_registro INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    codigo_estudiante INT NOT NULL,
    id_habitos INT NOT NULL,
    FOREIGN KEY (codigo_estudiante) REFERENCES estudiante(codigo_estudiante),
    FOREIGN KEY (id_habitos) REFERENCES habitos(id_habitos)
);

-- el select se utiliza para que podamos ver la informacion de la tabla seleccionada --
select*from usuario;

select*from aula;

select*from habitos;
select *from estudiante;

SELECT id_habitos, tipo_de_habito, nombre_de_habito, unidad_de_medida FROM habitos;

-- utilice describe para poder ver los atributos  y que tipo de datos utilice--
DESCRIBE estudiante;
-- drop table la use para eliminar una tabla que avia creado mal--
drop table habitos;

CREATE TABLE habitos(
    id_habitos INT PRIMARY KEY AUTO_INCREMENT,
    tipo_de_habito VARCHAR(50) NOT NULL,
    nombre_de_habito VARCHAR(100) NOT NULL,
    unidad_de_medida VARCHAR(30) NOT NULL,
    frecuencia varchar(50)
);

INSERT 

describe habitos;
select*from habitos;
select*from usuario;
describe usuario;
select*from aula;
describe aula;

ALTER TABLE aula ADD COLUMN id_usuario INT;
ALTER TABLE aula ADD CONSTRAINT fk_aula_usuario 
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);

SELECT 
    a.id_aula,
    a.nombre_aula,
    a.capacidad,
    a.Descripcion,
    g.numero_grado,
    s.letra_grupo,
    u.nombres AS nombre_docente,
    u.apellidos AS apellido_docente
FROM aula a
LEFT JOIN grado g ON a.id_grado = g.id_grado
LEFT JOIN seccion s ON a.id_seccion = s.id_seccion
LEFT JOIN usuario u ON a.id_usuario = u.id_usuario;


DESCRIBE aula;
-- CONSULTA--
select *from seccion;
SELECT id_seccion, letra_grupo FROM seccion;
SELECT id_aula, nombre_aula, id_usuario FROM aula ORDER BY id_aula DESC LIMIT 1;

describe grado;
DELETE FROM seccion WHERE id_seccion = 4;

select *from habitos;
select *from grado;
delete from grado;
DELETE FROM seccion WHERE id_seccion = 3;

ALTER TABLE tutor AUTO_INCREMENT = 1;

-- es para dar  todos los permisos--
SET SQL_SAFE_UPDATES = 1;

describe habitos;
describe estudiantehabitos;

show DATABASES;

ALTER TABLE usuario
ADD fecha_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP;

show tables from gestionhabitooriginal;

select * from usuario;
-- ----------------------------------------------CREAR ROL------------------------------------------------------------------------------------------------
CREATE ROLE IF NOT EXISTS 'rol_administrador';
CREATE ROLE IF NOT EXISTS 'rol_docente';

-- OTORGAR LOS PRIVILEGIOS DE LOS ROLES--
GRANT ALL PRIVILEGES ON gestionhabitooriginal.* To 'rol_administrador';
-- PRIVILEGIOS LIMNITADOS--
GRANT SELECT , INSERT, UPDATE ON gestionhabitooriginal.* TO 'rol_docente';

-- usuario con la contraseña--
CREATE USER IF NOT EXISTS 'jhonfonseca'@'localhost'
IDENTIFIED BY 'admin89113637!';

CREATE USER IF NOT EXISTS 'eduardog'@'localhost'
IDENTIFIED BY 'OtraContraseñaSegura456!';

CREATE USER IF NOT EXISTS 'juanperez'@'localhost'
IDENTIFIED BY 'ContraseñaDocente789!';

-- asignar los roles de administrador y docente--

GRANT 'rol_administrador' to 'jhonfonseca'@'localhost';
GRANT 'rol_administrador' to 'eduardog'@'localhost';
GRANT 'rol_docente' to 'juanperez'@'localhost';

-- Establecer los roles como predeterminados--

SET DEFAULT ROLE 'rol_administrador' for 'jhonfonseca'@'localhost'; /*se hace el cambio de for a to por  que no funciona */
SET DEFAULT ROLE 'rol_administrador' for 'eduardog'@'localhost';    /*pero for sale error pero si funciona y lo pase a to para queno salga linea en error*/
SET DEFAULT ROLE 'rol_docente' for 'juanperez'@'localhost';

-- podemos ver los roles asignados a cada usuario en general no solo a esta base de datos--
SELECT User, Host FROM mysql.user ORDER BY User;

SHOW GRANTS FOR 'jhonfonseca'@'localhost';
SHOW GRANTS FOR 'eduardog'@'localhost';
SHOW GRANTS FOR 'juanperez'@'localhost'; 

-- Nos permite ver que roles tienen estos usuarios creados.
SELECT User, Host, default_role FROM mysql.user WHERE User IN ('jhonfonseca','eduardog','juanperez');


SHOW GRANTS FOR 'rol_administrador';
SHOW GRANTS FOR 'rol_docente';

-- CREO TABLA PARA BIOTACORA --
CREATE TABLE bitacora_usuario(
id_bitacora INT PRIMARY KEY AUTO_INCREMENT,
accion VARCHAR (20),
id_usuario int,
fecha_creacion DATEtIME);

-- se agraga a la tabla bitacora usuario que tabla es la afectada--
ALTER TABLE bitacora_usuario 
  ADD COLUMN tabla_afectada VARCHAR(50),


-- SE CREA EL TRIGGER----------------------------------------------------------------------

DELIMITER $$

CREATE TRIGGER trg_usuario_insert     #se crea el nombre del trigger
AFTER INSERT ON usuario               #se le determina la tabla que pondra el trigger
FOR EACH ROW
BEGIN                                                 

    INSERT INTO bitacora_usuario (accion, id_usuario, tabla_afectada, fecha_creacion)
    VALUES ('INSERT', COALESCE(@usuario_actual, 0), 'estudiante', NOW());
END$$

CREATE TRIGGER trg_estudiante_update
AFTER UPDATE ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_usuario (accion, id_usuario, tabla_afectada, fecha_creacion)
    VALUES ('UPDATE', COALESCE(@usuario_actual, 0), 'estudiante', NOW());
END$$

CREATE TRIGGER trg_estudiante_delete
AFTER DELETE ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_usuario (accion, id_usuario, tabla_afectada, fecha_creacion)
    VALUES ('DELETE', COALESCE(@usuario_actual, 0), 'estudiante', NOW());
END$$

DELIMITER ;

describe bitacora_usuario;

-- permite observar los roles  con sus privilegios de esta base de datos *gestion de habitos*--
SELECT GRANTEE, TABLE_SCHEMA, PRIVILEGE_TYPE
FROM information_schema.SCHEMA_PRIVILEGES
WHERE TABLE_SCHEMA = 'gestionhabitooriginal';

-- Podemos ver cuantos roles tenemos en esta base de datos --

SELECT DISTINCT GRANTEE 
FROM information_schema.SCHEMA_PRIVILEGES
WHERE TABLE_SCHEMA = 'gestionhabitooriginal';

-- permite observar los roles el nombre que tiene dicho rol--
SELECT DISTINCT TABLE_SCHEMA 
FROM information_schema.SCHEMA_PRIVILEGES
WHERE TABLE_SCHEMA LIKE '%gestion%';
SELECT 
    rm.User AS usuario,
    rm.Host AS host,
    rm.Role AS rol,
    sp.TABLE_SCHEMA AS base_de_datos
FROM mysql.roles_mapping rm
JOIN information_schema.SCHEMA_PRIVILEGES sp 
    ON sp.GRANTEE = CONCAT("'", rm.Role, "'@''")
WHERE sp.TABLE_SCHEMA = 'gestionhabitooriginal'
GROUP BY rm.User, rm.Host, rm.Role, sp.TABLE_SCHEMA
ORDER BY rm.User;

select * from bitacora_usuario;

DESCRIBE estudiante;
-- procesos almacenados-------------------------------------------------------------------
-- Eliminacion de algun dato almacenado--
DROP PROCEDURE IF EXISTS listar_estudiante;
-- crear datos almacenados con select que seria listar------------
DELIMITER //

CREATE PROCEDURE listar_estudiante()
BEGIN
SELECT codigo_estudiante, nombres, apellidos, fecha_nacimiento, genero, id_tutor, id_grado, id_seccion
FROM estudiante
ORDER BY codigo_estudiante;
END//
-- Prueba de listar estudiante con datos almacenados--------------------------
CALL listar_estudiante();

SHOW TABLES FROM gestionhabitooriginal;

SHOW PROCEDURE STATUS WHERE Db = 'gestionhabitooriginal';

-- Procesos alamacenados Nerybeth 
Use gestionHabitooriginal;

-- PARA GRADO
-- LISTAR
DROP PROCEDURE IF EXISTS insertar_grado;

DELIMITER //
CREATE PROCEDURE insertar_grado(IN p_numero_grado INT)
BEGIN
    INSERT INTO grado (numero_grado)
    VALUES (p_numero_grado);
END //
DELIMITER ;

-- Prueba
CALL insertar_grado(7);
CALL insertar_grado(8);
CALL insertar_grado(9);
 CALL listar_grados;

-- BUSCAR
DROP PROCEDURE IF EXISTS buscar_grado;

DELIMITER //
CREATE PROCEDURE buscar_grado(IN p_id_grado INT)
BEGIN
    SELECT id_grado, numero_grado
    FROM grado
    WHERE id_grado = p_id_grado;
END //
DELIMITER ;
 -- Prueba
 CALL buscar_grado(2);

--  INSERTAR
DROP PROCEDURE IF EXISTS insertar_grado;

DELIMITER //
CREATE PROCEDURE insertar_grado(IN p_numero_grado INT)
BEGIN
    INSERT INTO grado (numero_grado)
    VALUES (p_numero_grado);
END //
DELIMITER ;
 -- Prueba 
 CALL insertar_grado(9);
 
 CALL listar_grados;

-- ACTUALIZAR
DROP PROCEDURE IF EXISTS actualizar_grado;

DELIMITER //
CREATE PROCEDURE actualizar_grado(
    IN p_id_grado INT,
    IN p_numero_grado INT
)
BEGIN
    UPDATE grado
    SET numero_grado = p_numero_grado
    WHERE id_grado = p_id_grado;
END //
DELIMITER ;

-- Pruebaaaa
CALL actualizar_grado(1, 10);

CALL buscar_grado(1);


--  ELIMINAR
DROP PROCEDURE IF EXISTS eliminar_grado;

DELIMITER //
CREATE PROCEDURE eliminar_grado(IN p_id_grado INT)
BEGIN
    DELETE FROM grado
    WHERE id_grado = p_id_grado;
END //
DELIMITER ;

-- Prueba
CALL eliminar_grado(1);
CALL listar_grados;






-- PARA SECCIÓN
-- LISTAR
DROP PROCEDURE IF EXISTS listar_secciones;

DELIMITER //
CREATE PROCEDURE listar_secciones()
BEGIN
    SELECT id_seccion, letra_grupo
    FROM seccion
    ORDER BY letra_grupo;
END //
DELIMITER ;

-- PRUEBA
CALL listar_secciones;


-- BUSCAR
DROP PROCEDURE IF EXISTS buscar_seccion;

DELIMITER //
CREATE PROCEDURE buscar_seccion(IN p_id_seccion INT)
BEGIN
    SELECT id_seccion, letra_grupo
    FROM seccion
    WHERE id_seccion = p_id_seccion;
END //
DELIMITER ;

-- prueba 
CALL buscar_seccion(1);

--  INSERTAR
DROP PROCEDURE IF EXISTS insertar_seccion;

DELIMITER //
CREATE PROCEDURE insertar_seccion(IN p_letra_grupo VARCHAR(50))
BEGIN
    INSERT INTO seccion (letra_grupo)
    VALUES (p_letra_grupo);
END //
DELIMITER ;
-- PRUEBA
CALL insertar_seccion('A');
CALL insertar_seccion('B');
CALL insertar_seccion('C');


-- ACTUALIZAR
DROP PROCEDURE IF EXISTS actualizar_seccion;

DELIMITER //
CREATE PROCEDURE actualizar_seccion(
    IN p_id_seccion INT,
    IN p_letra_grupo VARCHAR(50)
)
BEGIN
    UPDATE seccion
    SET letra_grupo = p_letra_grupo
    WHERE id_seccion = p_id_seccion;
END //
DELIMITER ;

-- Pruebaaa

CALL actualizar_seccion(1, 'D');
CALL buscar_seccion(1);

-- ELIMINAR
DROP PROCEDURE IF EXISTS eliminar_seccion;

DELIMITER //
CREATE PROCEDURE eliminar_seccion(IN p_id_seccion INT)
BEGIN
    DELETE FROM seccion
    WHERE id_seccion = p_id_seccion;
END //
DELIMITER ;
 -- PRUEBA
CALL eliminar_seccion(1);
CALL listar_secciones;