CREATE DATABASE  IF NOT EXISTS `gestionhabitooriginal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `gestionhabitooriginal`;
-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: gestionhabitooriginal
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aula`
--

DROP TABLE IF EXISTS `aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aula` (
  `id_aula` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_aula` varchar(100) DEFAULT NULL,
  `capacidad` int(11) NOT NULL,
  `Descripcion` varchar(500) DEFAULT NULL,
  `id_seccion` int(11) DEFAULT NULL,
  `id_grado` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_aula`),
  KEY `id_seccion` (`id_seccion`),
  KEY `id_grado` (`id_grado`),
  KEY `fk_aula_usuario` (`id_usuario`),
  CONSTRAINT `aula_ibfk_1` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id_seccion`),
  CONSTRAINT `aula_ibfk_2` FOREIGN KEY (`id_grado`) REFERENCES `grado` (`id_grado`),
  CONSTRAINT `fk_aula_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula`
--

LOCK TABLES `aula` WRITE;
/*!40000 ALTER TABLE `aula` DISABLE KEYS */;
INSERT INTO `aula` VALUES (1,'Aula 101',30,'Matutino',1,1,NULL),(2,'Aula 102',30,'Matutino',2,2,NULL),(3,'Aula 103',35,'Matutino',3,3,NULL),(4,'Aula 104',35,'Vespertino',4,4,NULL),(5,'Aula 105',40,'Vespertino',5,5,NULL),(6,'Aula 201',40,'Matutino',6,6,NULL),(7,'Aula 202',25,'Matutino',7,7,NULL),(8,'Aula 203',25,'Vespertino',8,8,NULL),(9,'Aula 204',30,'Vespertino',9,9,NULL),(10,'Aula 205',30,'Matutino',10,10,NULL);
/*!40000 ALTER TABLE `aula` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_aula_insert
AFTER INSERT ON aula
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'aula',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('id_aula=', NEW.id_aula, ', nombre_aula=', IFNULL(NEW.nombre_aula,''),
               ', capacidad=', NEW.capacidad, ', Descripcion=', IFNULL(NEW.Descripcion,''),
               ', id_seccion=', IFNULL(NEW.id_seccion,''), ', id_grado=', IFNULL(NEW.id_grado,''),
               ', id_usuario=', IFNULL(NEW.id_usuario,''))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_aula_update
AFTER UPDATE ON aula
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'aula',
        'UPDATE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_aula=', OLD.id_aula, ', nombre_aula=', IFNULL(OLD.nombre_aula,''),
               ', capacidad=', OLD.capacidad, ', Descripcion=', IFNULL(OLD.Descripcion,''),
               ', id_seccion=', IFNULL(OLD.id_seccion,''), ', id_grado=', IFNULL(OLD.id_grado,''),
               ', id_usuario=', IFNULL(OLD.id_usuario,'')),
        CONCAT('id_aula=', NEW.id_aula, ', nombre_aula=', IFNULL(NEW.nombre_aula,''),
               ', capacidad=', NEW.capacidad, ', Descripcion=', IFNULL(NEW.Descripcion,''),
               ', id_seccion=', IFNULL(NEW.id_seccion,''), ', id_grado=', IFNULL(NEW.id_grado,''),
               ', id_usuario=', IFNULL(NEW.id_usuario,''))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_aula_delete
BEFORE DELETE ON aula
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'aula',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_aula=', OLD.id_aula, ', nombre_aula=', IFNULL(OLD.nombre_aula,''),
               ', capacidad=', OLD.capacidad, ', Descripcion=', IFNULL(OLD.Descripcion,''),
               ', id_seccion=', IFNULL(OLD.id_seccion,''), ', id_grado=', IFNULL(OLD.id_grado,''),
               ', id_usuario=', IFNULL(OLD.id_usuario,'')),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitacora` (
  `id_bitacora` int(11) NOT NULL AUTO_INCREMENT,
  `tabla_afectada` varchar(50) NOT NULL,
  `accion` varchar(20) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `nombreusuario` varchar(50) DEFAULT NULL,
  `valor_anterior` text DEFAULT NULL,
  `valor_nuevo` text DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_bitacora`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `bitacora_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
INSERT INTO `bitacora` VALUES (1,'usuario','INSERT',1,'cluis',NULL,'id=18, nombres=maria jose, apellidos=lopez Ramirez, correo=maria12@gmail.com, nombreusuario=mariajose, rol=docente','2026-10-14 16:28:07'),(2,'usuario','UPDATE',1,'cluis','id=6, nombres=sixta lorena, apellidos=Pineda Ramirez, correo=sixtalorena@gmail.com, nombreusuario=sixtaPineda, rol=Docente','id=6, nombres=sixta lorena, apellidos=Pineda Ramirez, correo=sixtalorena@gmail.com, nombreusuario=sixtaPineda, rol=Admistrador','2026-10-14 16:29:26'),(3,'usuario','INSERT',NULL,NULL,NULL,'id=19, nombres=Andrés Felipe, apellidos=Torres Vega, correo=andres.torres@gmail.com, nombreusuario=andrest, rol=Administrador','2026-10-15 14:33:34'),(4,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=6, tipo_de_habito=Salud, nombre_de_habito=Beber Agua, unidad_de_medida=Litros, frecuencia=Diario','2026-10-15 14:35:08'),(5,'habitos','INSERT',11,'jhonfonseca',NULL,'id_habitos=7, tipo_de_habito=Salud, nombre_de_habito=Beber Agua, unidad_de_medida=7, frecuencia=Diario','2026-10-15 14:38:14'),(6,'habitos','DELETE',11,'jhonfonseca','id_habitos=7, tipo_de_habito=Salud, nombre_de_habito=Beber Agua, unidad_de_medida=2, frecuencia=Diario',NULL,'2026-10-15 15:05:04'),(7,'tutor','UPDATE',NULL,NULL,'id_tutor=1, nombres=Carlos Alberto, apellidos=González, correos=carlos.actualizado@gmail.com, telefono=88889999','id_tutor=1, nombres=Carlos Alberto, apellidos=González, correos=carlos.actualizado@gmail.com, telefono=88889999','2026-10-15 16:47:33'),(8,'estudiante','UPDATE',NULL,NULL,'codigo_estudiante=23808016, nombres=jhon, apellidos=fonseca, fecha_nacimiento=150499, genero=Masculino, id_tutor=1, id_grado=3, id_seccion=6','codigo_estudiante=23808016, nombres=jhon, apellidos=fonseca, fecha_nacimiento=150499, genero=Masculino, id_tutor=1, id_grado=3, id_seccion=8','2026-10-15 16:47:33'),(9,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=8, tipo_de_habito=descanso, nombre_de_habito=dormir, unidad_de_medida=2 horas, frecuencia=','2026-10-15 18:41:02'),(10,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=9, tipo_de_habito=adiccion, nombre_de_habito=fumar, unidad_de_medida=7 unidades, frecuencia=','2026-10-15 20:07:34'),(11,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=10, tipo_de_habito=hidratar, nombre_de_habito=comer, unidad_de_medida=4 platos, frecuencia=','2026-10-15 20:09:13'),(12,'habitos','DELETE',NULL,NULL,'id_habitos=10, tipo_de_habito=hidratar, nombre_de_habito=comer, unidad_de_medida=4 platos, frecuencia=',NULL,'2026-10-15 20:10:05'),(13,'habitos','INSERT',11,'jhonfonseca',NULL,'id_habitos=11, tipo_de_habito=Prueba, nombre_de_habito=Prueba, unidad_de_medida=1, frecuencia=Diario','2026-10-15 20:23:46'),(14,'habitos','DELETE',18,'mariajose','id_habitos=11, tipo_de_habito=Prueba, nombre_de_habito=Prueba, unidad_de_medida=1, frecuencia=Diario',NULL,'2026-10-15 20:25:22'),(15,'habitos','INSERT',11,'jhonfonseca',NULL,'id_habitos=12, tipo_de_habito=ejercicio, nombre_de_habito=pechadias, unidad_de_medida=20, frecuencia=','2026-10-15 20:26:48'),(16,'estudiantehabitos','INSERT',18,'mariajose',NULL,'id_registro=8, fecha=2026-11-12, cantidad=5.00, codigo_estudiante=23808016, id_habitos=6','2026-10-16 11:43:25'),(17,'estudiantehabitos','INSERT',18,'mariajose',NULL,'id_registro=9, fecha=2026-10-16, cantidad=1.00, codigo_estudiante=23808016, id_habitos=1','2026-10-16 12:06:33'),(18,'estudiantehabitos','DELETE',18,'mariajose','id_registro=9, fecha=2026-10-16, cantidad=1.00, codigo_estudiante=23808016, id_habitos=1',NULL,'2026-10-16 12:07:35'),(19,'grado','INSERT',11,'jhonfonseca',NULL,'id_grado=14, numero_grado=4','2026-10-16 12:32:29'),(20,'seccion','INSERT',11,'jhonfonseca',NULL,'id_seccion=13, letra_grupo=b','2026-10-16 12:32:29'),(21,'aula','INSERT',11,'jhonfonseca',NULL,'id_aula=9, nombre_aula=COredor, capacidad=20, Descripcion=Reparar ventana, id_seccion=13, id_grado=14, id_usuario=7','2026-10-16 12:32:29'),(22,'estudiantehabitos','INSERT',18,'mariajose',NULL,'id_registro=10, fecha=2026-10-16, cantidad=15.00, codigo_estudiante=23808016, id_habitos=5','2026-10-16 15:31:30'),(23,'estudiantehabitos','UPDATE',18,'mariajose','id_registro=7, fecha=2026-09-29, cantidad=2.50, codigo_estudiante=23808016, id_habitos=4','id_registro=7, fecha=2026-10-16, cantidad=2.00, codigo_estudiante=23808016, id_habitos=4','2026-10-16 15:31:59'),(24,'estudiantehabitos','INSERT',18,'mariajose',NULL,'id_registro=11, fecha=2026-10-16, cantidad=12.00, codigo_estudiante=23808016, id_habitos=1','2026-10-16 17:13:52'),(25,'grado','INSERT',11,'jhonfonseca',NULL,'id_grado=15, numero_grado=4','2026-10-17 09:50:02'),(26,'seccion','INSERT',11,'jhonfonseca',NULL,'id_seccion=14, letra_grupo=B','2026-10-17 09:50:02'),(27,'aula','INSERT',11,'jhonfonseca',NULL,'id_aula=10, nombre_aula=pasillo, capacidad=40, Descripcion=Matutino, id_seccion=14, id_grado=15, id_usuario=7','2026-10-17 09:50:02'),(28,'estudiantehabitos','INSERT',11,'jhonfonseca',NULL,'id_registro=12, fecha=2026-10-17, cantidad=20.00, codigo_estudiante=23808016, id_habitos=8','2026-10-17 09:51:33'),(29,'grado','INSERT',NULL,NULL,NULL,'id_grado=1, numero_grado=1','2026-10-19 20:30:55'),(30,'grado','INSERT',NULL,NULL,NULL,'id_grado=2, numero_grado=2','2026-10-19 20:30:55'),(31,'grado','INSERT',NULL,NULL,NULL,'id_grado=3, numero_grado=3','2026-10-19 20:30:55'),(32,'grado','INSERT',NULL,NULL,NULL,'id_grado=4, numero_grado=4','2026-10-19 20:30:55'),(33,'grado','INSERT',NULL,NULL,NULL,'id_grado=5, numero_grado=5','2026-10-19 20:30:55'),(34,'grado','INSERT',NULL,NULL,NULL,'id_grado=6, numero_grado=6','2026-10-19 20:30:55'),(35,'grado','INSERT',NULL,NULL,NULL,'id_grado=7, numero_grado=7','2026-10-19 20:30:55'),(36,'grado','INSERT',NULL,NULL,NULL,'id_grado=8, numero_grado=8','2026-10-19 20:30:55'),(37,'grado','INSERT',NULL,NULL,NULL,'id_grado=9, numero_grado=9','2026-10-19 20:30:55'),(38,'grado','INSERT',NULL,NULL,NULL,'id_grado=10, numero_grado=10','2026-10-19 20:30:55'),(39,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=1, letra_grupo=A','2026-10-19 20:30:55'),(40,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=2, letra_grupo=B','2026-10-19 20:30:55'),(41,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=3, letra_grupo=C','2026-10-19 20:30:55'),(42,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=4, letra_grupo=D','2026-10-19 20:30:55'),(43,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=5, letra_grupo=E','2026-10-19 20:30:55'),(44,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=6, letra_grupo=F','2026-10-19 20:30:55'),(45,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=7, letra_grupo=G','2026-10-19 20:30:55'),(46,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=8, letra_grupo=H','2026-10-19 20:30:55'),(47,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=9, letra_grupo=I','2026-10-19 20:30:55'),(48,'seccion','INSERT',NULL,NULL,NULL,'id_seccion=10, letra_grupo=J','2026-10-19 20:30:55'),(49,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=1, nombres=Carlos Alberto, apellidos=González Pérez, correos=carlos.gonzalez@gmail.com, telefono=88880001','2026-10-19 20:30:55'),(50,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=2, nombres=Nery José, apellidos=Luna Castillo, correos=nery.luna@gmail.com, telefono=88880002','2026-10-19 20:30:55'),(51,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=3, nombres=María Elena, apellidos=Rodríguez Silva, correos=maria.rodriguez@gmail.com, telefono=88880003','2026-10-19 20:30:55'),(52,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=4, nombres=Luis Fernando, apellidos=Martínez Ruiz, correos=luis.martinez@gmail.com, telefono=88880004','2026-10-19 20:30:55'),(53,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=5, nombres=Ana Patricia, apellidos=López Herrera, correos=ana.lopez@gmail.com, telefono=88880005','2026-10-19 20:30:55'),(54,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=6, nombres=José Manuel, apellidos=Ramírez Soto, correos=jose.ramirez@gmail.com, telefono=88880006','2026-10-19 20:30:55'),(55,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=7, nombres=Rosa Isabel, apellidos=Torres Vega, correos=rosa.torres@gmail.com, telefono=88880007','2026-10-19 20:30:55'),(56,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=8, nombres=Pedro Antonio, apellidos=Mendoza Díaz, correos=pedro.mendoza@gmail.com, telefono=88880008','2026-10-19 20:30:55'),(57,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=9, nombres=Lucía Carolina, apellidos=Flores Medina, correos=lucia.flores@gmail.com, telefono=88880009','2026-10-19 20:30:55'),(58,'tutor','INSERT',NULL,NULL,NULL,'id_tutor=10, nombres=Miguel Ángel, apellidos=Castro Morales, correos=miguel.castro@gmail.com, telefono=88880010','2026-10-19 20:30:55'),(59,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=1, tipo_de_habito=Salud, nombre_de_habito=Beber agua, unidad_de_medida=Litros, frecuencia=Diario','2026-10-19 20:30:55'),(60,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=2, tipo_de_habito=Ejercicio, nombre_de_habito=Correr, unidad_de_medida=Minutos, frecuencia=Diario','2026-10-19 20:30:55'),(61,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=3, tipo_de_habito=Descanso, nombre_de_habito=Dormir, unidad_de_medida=Horas, frecuencia=Diario','2026-10-19 20:30:55'),(62,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=4, tipo_de_habito=Alimentación, nombre_de_habito=Comer frutas, unidad_de_medida=Porciones, frecuencia=Diario','2026-10-19 20:30:55'),(63,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=5, tipo_de_habito=Ejercicio, nombre_de_habito=Abdominales, unidad_de_medida=Repeticiones, frecuencia=Diario','2026-10-19 20:30:55'),(64,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=6, tipo_de_habito=Higiene, nombre_de_habito=Cepillarse los dientes, unidad_de_medida=Veces, frecuencia=Diario','2026-10-19 20:30:55'),(65,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=7, tipo_de_habito=Bienestar, nombre_de_habito=Meditar, unidad_de_medida=Minutos, frecuencia=Diario','2026-10-19 20:30:55'),(66,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=8, tipo_de_habito=Estudio, nombre_de_habito=Leer, unidad_de_medida=Páginas, frecuencia=Diario','2026-10-19 20:30:55'),(67,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=9, tipo_de_habito=Ejercicio, nombre_de_habito=Caminar, unidad_de_medida=Pasos, frecuencia=Diario','2026-10-19 20:30:55'),(68,'habitos','INSERT',NULL,NULL,NULL,'id_habitos=10, tipo_de_habito=Alimentación, nombre_de_habito=Comer verduras, unidad_de_medida=Porciones, frecuencia=Diario','2026-10-19 20:30:55'),(69,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808001, nombres=Juan Carlos, apellidos=Pérez Gómez, fecha_nacimiento=150410, genero=Masculino, id_tutor=1, id_grado=1, id_seccion=1','2026-10-19 20:30:55'),(70,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808002, nombres=María Fernanda, apellidos=Gómez Rodríguez, fecha_nacimiento=70511, genero=Femenino, id_tutor=2, id_grado=2, id_seccion=2','2026-10-19 20:30:55'),(71,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808003, nombres=Jhon Kenneth, apellidos=Fonseca Pineda, fecha_nacimiento=150409, genero=Masculino, id_tutor=3, id_grado=3, id_seccion=3','2026-10-19 20:30:55'),(72,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808004, nombres=Ana Sofía, apellidos=López Martínez, fecha_nacimiento=220308, genero=Femenino, id_tutor=4, id_grado=4, id_seccion=4','2026-10-19 20:30:55'),(73,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808005, nombres=Luis Alberto, apellidos=Ramírez Soto, fecha_nacimiento=101107, genero=Masculino, id_tutor=5, id_grado=5, id_seccion=5','2026-10-19 20:30:55'),(74,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808006, nombres=Camila Andrea, apellidos=Torres Vega, fecha_nacimiento=300606, genero=Femenino, id_tutor=6, id_grado=6, id_seccion=6','2026-10-19 20:30:55'),(75,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808007, nombres=Diego Armando, apellidos=Mendoza Díaz, fecha_nacimiento=121205, genero=Masculino, id_tutor=7, id_grado=7, id_seccion=7','2026-10-19 20:30:55'),(76,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808008, nombres=Valeria Isabel, apellidos=Flores Medina, fecha_nacimiento=80904, genero=Femenino, id_tutor=8, id_grado=8, id_seccion=8','2026-10-19 20:30:55'),(77,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808009, nombres=Mateo Esteban, apellidos=Castro Morales, fecha_nacimiento=250103, genero=Masculino, id_tutor=9, id_grado=9, id_seccion=9','2026-10-19 20:30:55'),(78,'estudiante','INSERT',NULL,NULL,NULL,'codigo_estudiante=23808010, nombres=Daniela Paola, apellidos=Luna Castillo, fecha_nacimiento=180802, genero=Femenino, id_tutor=10, id_grado=10, id_seccion=10','2026-10-19 20:30:55'),(79,'aula','INSERT',NULL,NULL,NULL,'id_aula=1, nombre_aula=Aula 101, capacidad=30, Descripcion=Matutino, id_seccion=1, id_grado=1, id_usuario=','2026-10-19 20:30:55'),(80,'aula','INSERT',NULL,NULL,NULL,'id_aula=2, nombre_aula=Aula 102, capacidad=30, Descripcion=Matutino, id_seccion=2, id_grado=2, id_usuario=','2026-10-19 20:30:55'),(81,'aula','INSERT',NULL,NULL,NULL,'id_aula=3, nombre_aula=Aula 103, capacidad=35, Descripcion=Matutino, id_seccion=3, id_grado=3, id_usuario=','2026-10-19 20:30:55'),(82,'aula','INSERT',NULL,NULL,NULL,'id_aula=4, nombre_aula=Aula 104, capacidad=35, Descripcion=Vespertino, id_seccion=4, id_grado=4, id_usuario=','2026-10-19 20:30:55'),(83,'aula','INSERT',NULL,NULL,NULL,'id_aula=5, nombre_aula=Aula 105, capacidad=40, Descripcion=Vespertino, id_seccion=5, id_grado=5, id_usuario=','2026-10-19 20:30:55'),(84,'aula','INSERT',NULL,NULL,NULL,'id_aula=6, nombre_aula=Aula 201, capacidad=40, Descripcion=Matutino, id_seccion=6, id_grado=6, id_usuario=','2026-10-19 20:30:55'),(85,'aula','INSERT',NULL,NULL,NULL,'id_aula=7, nombre_aula=Aula 202, capacidad=25, Descripcion=Matutino, id_seccion=7, id_grado=7, id_usuario=','2026-10-19 20:30:55'),(86,'aula','INSERT',NULL,NULL,NULL,'id_aula=8, nombre_aula=Aula 203, capacidad=25, Descripcion=Vespertino, id_seccion=8, id_grado=8, id_usuario=','2026-10-19 20:30:55'),(87,'aula','INSERT',NULL,NULL,NULL,'id_aula=9, nombre_aula=Aula 204, capacidad=30, Descripcion=Vespertino, id_seccion=9, id_grado=9, id_usuario=','2026-10-19 20:30:55'),(88,'aula','INSERT',NULL,NULL,NULL,'id_aula=10, nombre_aula=Aula 205, capacidad=30, Descripcion=Matutino, id_seccion=10, id_grado=10, id_usuario=','2026-10-19 20:30:55'),(89,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=1, fecha=2026-10-12, cantidad=2.00, codigo_estudiante=23808001, id_habitos=1','2026-10-19 20:30:55'),(90,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=2, fecha=2026-10-13, cantidad=30.00, codigo_estudiante=23808002, id_habitos=2','2026-10-19 20:30:55'),(91,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=3, fecha=2026-10-14, cantidad=8.00, codigo_estudiante=23808003, id_habitos=3','2026-10-19 20:30:55'),(92,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=4, fecha=2026-10-15, cantidad=3.00, codigo_estudiante=23808004, id_habitos=4','2026-10-19 20:30:55'),(93,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=5, fecha=2026-10-16, cantidad=20.00, codigo_estudiante=23808005, id_habitos=5','2026-10-19 20:30:55'),(94,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=6, fecha=2026-10-16, cantidad=2.00, codigo_estudiante=23808006, id_habitos=6','2026-10-19 20:30:55'),(95,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=7, fecha=2026-10-17, cantidad=15.00, codigo_estudiante=23808007, id_habitos=7','2026-10-19 20:30:55'),(96,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=8, fecha=2026-10-17, cantidad=10.00, codigo_estudiante=23808008, id_habitos=8','2026-10-19 20:30:55'),(97,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=9, fecha=2026-10-18, cantidad=6000.00, codigo_estudiante=23808009, id_habitos=9','2026-10-19 20:30:55'),(98,'estudiantehabitos','INSERT',NULL,NULL,NULL,'id_registro=10, fecha=2026-10-19, cantidad=2.00, codigo_estudiante=23808010, id_habitos=10','2026-10-19 20:30:55'),(99,'estudiantehabitos','INSERT',11,'jhonfonseca',NULL,'id_registro=11, fecha=2026-10-19, cantidad=8.00, codigo_estudiante=23808001, id_habitos=3','2026-10-19 20:38:32'),(100,'estudiantehabitos','INSERT',11,'jhonfonseca',NULL,'id_registro=12, fecha=2026-10-23, cantidad=5.00, codigo_estudiante=23808003, id_habitos=1','2026-10-23 15:44:01');
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiante` (
  `codigo_estudiante` int(11) NOT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` int(11) NOT NULL,
  `genero` varchar(100) DEFAULT NULL,
  `id_tutor` int(11) DEFAULT NULL,
  `id_grado` int(11) DEFAULT NULL,
  `id_seccion` int(11) DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  PRIMARY KEY (`codigo_estudiante`),
  KEY `id_tutor` (`id_tutor`),
  KEY `id_grado` (`id_grado`),
  KEY `id_seccion` (`id_seccion`),
  CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`id_tutor`) REFERENCES `tutor` (`id_tutor`),
  CONSTRAINT `estudiante_ibfk_2` FOREIGN KEY (`id_grado`) REFERENCES `grado` (`id_grado`),
  CONSTRAINT `estudiante_ibfk_3` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id_seccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` VALUES (23808001,'Juan Carlos','Pérez Gómez',150410,'Masculino',1,1,1,'2026-10-19'),(23808002,'María Fernanda','Gómez Rodríguez',70511,'Femenino',2,2,2,'2026-10-19'),(23808003,'Jhon Kenneth','Fonseca Pineda',150409,'Masculino',3,3,3,'2026-10-19'),(23808004,'Ana Sofía','López Martínez',220308,'Femenino',4,4,4,'2026-10-19'),(23808005,'Luis Alberto','Ramírez Soto',101107,'Masculino',5,5,5,'2026-10-19'),(23808006,'Camila Andrea','Torres Vega',300606,'Femenino',6,6,6,'2026-10-19'),(23808007,'Diego Armando','Mendoza Díaz',121205,'Masculino',7,7,7,'2026-10-19'),(23808008,'Valeria Isabel','Flores Medina',80904,'Femenino',8,8,8,'2026-10-19'),(23808009,'Mateo Esteban','Castro Morales',250103,'Masculino',9,9,9,'2026-10-19'),(23808010,'Daniela Paola','Luna Castillo',180802,'Femenino',10,10,10,'2026-10-19');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_estudiante_insert
AFTER INSERT ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'estudiante',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('codigo_estudiante=', NEW.codigo_estudiante, ', nombres=', IFNULL(NEW.nombres,''),
               ', apellidos=', IFNULL(NEW.apellidos,''), ', fecha_nacimiento=', NEW.fecha_nacimiento,
               ', genero=', IFNULL(NEW.genero,''), ', id_tutor=', IFNULL(NEW.id_tutor,''),
               ', id_grado=', IFNULL(NEW.id_grado,''), ', id_seccion=', IFNULL(NEW.id_seccion,''))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_estudiante_update
AFTER UPDATE ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'estudiante',
        'UPDATE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('codigo_estudiante=', OLD.codigo_estudiante, ', nombres=', IFNULL(OLD.nombres,''),
               ', apellidos=', IFNULL(OLD.apellidos,''), ', fecha_nacimiento=', OLD.fecha_nacimiento,
               ', genero=', IFNULL(OLD.genero,''), ', id_tutor=', IFNULL(OLD.id_tutor,''),
               ', id_grado=', IFNULL(OLD.id_grado,''), ', id_seccion=', IFNULL(OLD.id_seccion,'')),
        CONCAT('codigo_estudiante=', NEW.codigo_estudiante, ', nombres=', IFNULL(NEW.nombres,''),
               ', apellidos=', IFNULL(NEW.apellidos,''), ', fecha_nacimiento=', NEW.fecha_nacimiento,
               ', genero=', IFNULL(NEW.genero,''), ', id_tutor=', IFNULL(NEW.id_tutor,''),
               ', id_grado=', IFNULL(NEW.id_grado,''), ', id_seccion=', IFNULL(NEW.id_seccion,''))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_estudiante_delete
BEFORE DELETE ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'estudiante',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('codigo_estudiante=', OLD.codigo_estudiante, ', nombres=', IFNULL(OLD.nombres,''),
               ', apellidos=', IFNULL(OLD.apellidos,''), ', fecha_nacimiento=', OLD.fecha_nacimiento,
               ', genero=', IFNULL(OLD.genero,''), ', id_tutor=', IFNULL(OLD.id_tutor,''),
               ', id_grado=', IFNULL(OLD.id_grado,''), ', id_seccion=', IFNULL(OLD.id_seccion,'')),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `estudiantehabitos`
--

DROP TABLE IF EXISTS `estudiantehabitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiantehabitos` (
  `id_registro` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `codigo_estudiante` int(11) NOT NULL,
  `id_habitos` int(11) NOT NULL,
  PRIMARY KEY (`id_registro`),
  KEY `codigo_estudiante` (`codigo_estudiante`),
  KEY `id_habitos` (`id_habitos`),
  CONSTRAINT `estudiantehabitos_ibfk_1` FOREIGN KEY (`codigo_estudiante`) REFERENCES `estudiante` (`codigo_estudiante`),
  CONSTRAINT `estudiantehabitos_ibfk_2` FOREIGN KEY (`id_habitos`) REFERENCES `habitos` (`id_habitos`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantehabitos`
--

LOCK TABLES `estudiantehabitos` WRITE;
/*!40000 ALTER TABLE `estudiantehabitos` DISABLE KEYS */;
INSERT INTO `estudiantehabitos` VALUES (1,'2026-10-12',2.00,23808001,1),(2,'2026-10-13',30.00,23808002,2),(3,'2026-10-14',8.00,23808003,3),(4,'2026-10-15',3.00,23808004,4),(5,'2026-10-16',20.00,23808005,5),(6,'2026-10-16',2.00,23808006,6),(7,'2026-10-17',15.00,23808007,7),(8,'2026-10-17',10.00,23808008,8),(9,'2026-10-18',6000.00,23808009,9),(10,'2026-10-19',2.00,23808010,10),(11,'2026-10-19',8.00,23808001,3),(12,'2026-10-23',5.00,23808003,1);
/*!40000 ALTER TABLE `estudiantehabitos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_estudiantehabitos_insert
AFTER INSERT ON estudiantehabitos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'estudiantehabitos',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('id_registro=', NEW.id_registro, ', fecha=', NEW.fecha,
               ', cantidad=', NEW.cantidad, ', codigo_estudiante=', NEW.codigo_estudiante,
               ', id_habitos=', NEW.id_habitos)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_estudiantehabitos_update
AFTER UPDATE ON estudiantehabitos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'estudiantehabitos',
        'UPDATE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_registro=', OLD.id_registro, ', fecha=', OLD.fecha,
               ', cantidad=', OLD.cantidad, ', codigo_estudiante=', OLD.codigo_estudiante,
               ', id_habitos=', OLD.id_habitos),
        CONCAT('id_registro=', NEW.id_registro, ', fecha=', NEW.fecha,
               ', cantidad=', NEW.cantidad, ', codigo_estudiante=', NEW.codigo_estudiante,
               ', id_habitos=', NEW.id_habitos)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_estudiantehabitos_delete
BEFORE DELETE ON estudiantehabitos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'estudiantehabitos',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_registro=', OLD.id_registro, ', fecha=', OLD.fecha,
               ', cantidad=', OLD.cantidad, ', codigo_estudiante=', OLD.codigo_estudiante,
               ', id_habitos=', OLD.id_habitos),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `grado`
--

DROP TABLE IF EXISTS `grado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grado` (
  `id_grado` int(11) NOT NULL AUTO_INCREMENT,
  `numero_grado` int(11) NOT NULL,
  PRIMARY KEY (`id_grado`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grado`
--

LOCK TABLES `grado` WRITE;
/*!40000 ALTER TABLE `grado` DISABLE KEYS */;
INSERT INTO `grado` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `grado` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_grado_insert
AFTER INSERT ON grado
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'grado',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('id_grado=', NEW.id_grado, ', numero_grado=', NEW.numero_grado)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_grado_update
AFTER UPDATE ON grado
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'grado',
        'UPDATE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_grado=', OLD.id_grado, ', numero_grado=', OLD.numero_grado),
        CONCAT('id_grado=', NEW.id_grado, ', numero_grado=', NEW.numero_grado)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_grado_delete
BEFORE DELETE ON grado
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'grado',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_grado=', OLD.id_grado, ', numero_grado=', OLD.numero_grado),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `habitos`
--

DROP TABLE IF EXISTS `habitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `habitos` (
  `id_habitos` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_de_habito` varchar(50) NOT NULL,
  `nombre_de_habito` varchar(100) NOT NULL,
  `unidad_de_medida` varchar(30) NOT NULL,
  `frecuencia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_habitos`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitos`
--

LOCK TABLES `habitos` WRITE;
/*!40000 ALTER TABLE `habitos` DISABLE KEYS */;
INSERT INTO `habitos` VALUES (1,'Salud','Beber agua','Litros','Diario'),(2,'Ejercicio','Correr','Minutos','Diario'),(3,'Descanso','Dormir','Horas','Diario'),(4,'Alimentación','Comer frutas','Porciones','Diario'),(5,'Ejercicio','Abdominales','Repeticiones','Diario'),(6,'Higiene','Cepillarse los dientes','Veces','Diario'),(7,'Bienestar','Meditar','Minutos','Diario'),(8,'Estudio','Leer','Páginas','Diario'),(9,'Ejercicio','Caminar','Pasos','Diario'),(10,'Alimentación','Comer verduras','Porciones','Diario');
/*!40000 ALTER TABLE `habitos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_habitos_insert
AFTER INSERT ON habitos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'habitos',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('id_habitos=', NEW.id_habitos, ', tipo_de_habito=', NEW.tipo_de_habito,
               ', nombre_de_habito=', NEW.nombre_de_habito, ', unidad_de_medida=', NEW.unidad_de_medida,
               ', frecuencia=', IFNULL(NEW.frecuencia,''))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_habitos_delete
BEFORE DELETE ON habitos
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'habitos',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_habitos=', OLD.id_habitos, ', tipo_de_habito=', OLD.tipo_de_habito,
               ', nombre_de_habito=', OLD.nombre_de_habito, ', unidad_de_medida=', OLD.unidad_de_medida,
               ', frecuencia=', IFNULL(OLD.frecuencia,'')),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `seccion`
--

DROP TABLE IF EXISTS `seccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seccion` (
  `id_seccion` int(11) NOT NULL AUTO_INCREMENT,
  `letra_grupo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_seccion`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seccion`
--

LOCK TABLES `seccion` WRITE;
/*!40000 ALTER TABLE `seccion` DISABLE KEYS */;
INSERT INTO `seccion` VALUES (1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'E'),(6,'F'),(7,'G'),(8,'H'),(9,'I'),(10,'J');
/*!40000 ALTER TABLE `seccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_seccion_insert
AFTER INSERT ON seccion
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'seccion',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('id_seccion=', NEW.id_seccion, ', letra_grupo=', IFNULL(NEW.letra_grupo,''))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_seccion_update
AFTER UPDATE ON seccion
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'seccion',
        'UPDATE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_seccion=', OLD.id_seccion, ', letra_grupo=', IFNULL(OLD.letra_grupo,'')),
        CONCAT('id_seccion=', NEW.id_seccion, ', letra_grupo=', IFNULL(NEW.letra_grupo,''))
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_seccion_delete
BEFORE DELETE ON seccion
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'seccion',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_seccion=', OLD.id_seccion, ', letra_grupo=', IFNULL(OLD.letra_grupo,'')),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tutor`
--

DROP TABLE IF EXISTS `tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutor` (
  `id_tutor` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `correos` varchar(100) DEFAULT NULL,
  `telefono` int(11) NOT NULL,
  PRIMARY KEY (`id_tutor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
INSERT INTO `tutor` VALUES (1,'Carlos Alberto','González Pérez','carlos.gonzalez@gmail.com',88880001),(2,'Nery José','Luna Castillo','nery.luna@gmail.com',88880002),(3,'María Elena','Rodríguez Silva','maria.rodriguez@gmail.com',88880003),(4,'Luis Fernando','Martínez Ruiz','luis.martinez@gmail.com',88880004),(5,'Ana Patricia','López Herrera','ana.lopez@gmail.com',88880005),(6,'José Manuel','Ramírez Soto','jose.ramirez@gmail.com',88880006),(7,'Rosa Isabel','Torres Vega','rosa.torres@gmail.com',88880007),(8,'Pedro Antonio','Mendoza Díaz','pedro.mendoza@gmail.com',88880008),(9,'Lucía Carolina','Flores Medina','lucia.flores@gmail.com',88880009),(10,'Miguel Ángel','Castro Morales','miguel.castro@gmail.com',88880010);
/*!40000 ALTER TABLE `tutor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_tutor_insert
AFTER INSERT ON tutor
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'tutor',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('id_tutor=', NEW.id_tutor, ', nombres=', IFNULL(NEW.nombres,''),
               ', apellidos=', IFNULL(NEW.apellidos,''), ', correos=', IFNULL(NEW.correos,''),
               ', telefono=', NEW.telefono)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_tutor_update
AFTER UPDATE ON tutor
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'tutor',
        'UPDATE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_tutor=', OLD.id_tutor, ', nombres=', IFNULL(OLD.nombres,''),
               ', apellidos=', IFNULL(OLD.apellidos,''), ', correos=', IFNULL(OLD.correos,''),
               ', telefono=', OLD.telefono),
        CONCAT('id_tutor=', NEW.id_tutor, ', nombres=', IFNULL(NEW.nombres,''),
               ', apellidos=', IFNULL(NEW.apellidos,''), ', correos=', IFNULL(NEW.correos,''),
               ', telefono=', NEW.telefono)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_tutor_delete
BEFORE DELETE ON tutor
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'tutor',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id_tutor=', OLD.id_tutor, ', nombres=', IFNULL(OLD.nombres,''),
               ', apellidos=', IFNULL(OLD.apellidos,''), ', correos=', IFNULL(OLD.correos,''),
               ', telefono=', OLD.telefono),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `nombreusuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` varchar(30) NOT NULL,
  `fecha_ingreso` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombreusuario` (`nombreusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Carlos Luis','Mendoza Ruiz','carlos.mendoza@correo.com','cluis','123456','docente','2026-09-12 17:05:06'),(5,'juan manuel','perez','juanperez1@gmail.com','juanperez','89113637','Docente','2026-09-12 17:05:06'),(6,'sixta lorena','Pineda Ramirez','sixtalorena@gmail.com','sixtaPineda','sixta123456','Admistrador','2026-09-12 00:00:00'),(7,'Carlos Eduardo','Mendoza López','carlosmendoza@gmail.com','carlosMendoza','89113637','Docente','2026-09-12 00:00:00'),(8,'Laura Sofia','Gómez Ruiz','laura.gomez@gmail.com','laurag','Clave#2026','Docente','2026-09-13 16:16:37'),(11,'Jhon Kenneth','Fonseca Pinedad','jhonfonseca@gmail.com','jhonfonseca','admin89113637!','administrador','2026-10-03 14:03:03'),(12,'Carlos Manuel','fonseca Ruiz','carlos.fonseca@correo.com','fcalors','123456','admin','2026-10-14 14:13:51'),(18,'maria jose','lopez Ramirez','maria12@gmail.com','mariajose','maria123456','docente','2026-10-14 00:00:00'),(19,'Andrés Felipe','Torres Vega','andres.torres@gmail.com','andrest','Pass#2026','Administrador','2026-10-15 14:33:34');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_usuario_insert
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'usuario',
        'INSERT',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        NULL,
        CONCAT('id=', NEW.id_usuario, ', nombres=', NEW.nombres, ', apellidos=', NEW.apellidos,
               ', correo=', NEW.correo, ', nombreusuario=', NEW.nombreusuario,
               ', rol=', NEW.rol)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_usuario_update
AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'usuario',
        'UPDATE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id=', OLD.id_usuario, ', nombres=', OLD.nombres, ', apellidos=', OLD.apellidos,
               ', correo=', OLD.correo, ', nombreusuario=', OLD.nombreusuario,
               ', rol=', OLD.rol),
        CONCAT('id=', NEW.id_usuario, ', nombres=', NEW.nombres, ', apellidos=', NEW.apellidos,
               ', correo=', NEW.correo, ', nombreusuario=', NEW.nombreusuario,
               ', rol=', NEW.rol)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trg_usuario_delete
BEFORE DELETE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO bitacora
        (tabla_afectada, accion, id_usuario, nombreusuario, valor_anterior, valor_nuevo)
    VALUES (
        'usuario',
        'DELETE',
        @usuario_actual,
        (SELECT nombreusuario FROM usuario WHERE id_usuario = @usuario_actual),
        CONCAT('id=', OLD.id_usuario, ', nombres=', OLD.nombres, ', apellidos=', OLD.apellidos,
               ', correo=', OLD.correo, ', nombreusuario=', OLD.nombreusuario,
               ', rol=', OLD.rol),
        NULL
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'gestionhabitooriginal'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `eliminar_estudiantes_antiguos` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `eliminar_estudiantes_antiguos` ON SCHEDULE EVERY 1 DAY STARTS '2026-10-17 17:48:00' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM estudiante
    WHERE fecha_registro <= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'gestionhabitooriginal'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_estudiante`(
    IN p_codigo_estudiante INT,
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_fecha_nacimiento INT,
    IN p_genero VARCHAR(100),
    IN p_id_tutor INT,
    IN p_id_grado INT,
    IN p_id_seccion INT
)
BEGIN
    UPDATE estudiante
    SET nombres = p_nombres,
        apellidos = p_apellidos,
        fecha_nacimiento = p_fecha_nacimiento,
        genero = p_genero,
        id_tutor = p_id_tutor,
        id_grado = p_id_grado,
        id_seccion = p_id_seccion
    WHERE codigo_estudiante = p_codigo_estudiante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_grado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_grado`(
    IN p_id_grado INT,
    IN p_numero_grado INT
)
BEGIN
    UPDATE grado
    SET numero_grado = p_numero_grado
    WHERE id_grado = p_id_grado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Actualizar_habito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Actualizar_habito`(
    IN p_id_habitos INT,
    IN p_tipo_de_habito varchar(50),
    IN p_nombre_de_habito VARCHAR(100),
    IN p_unidad_de_medida VARCHAR(30),
    IN p_frecuencia VARCHAR(50)
)
BEGIN
    UPDATE habitos
    SET  id_habitos = p_id_habitos,
         tipo_de_habito = p_tipo_de_habito,
         nombre_de_habito= p_nombre_de_habito,
         unidad_de_medida = p_unidad_de_medida,
         frecuencia = p_frecuencia
    WHERE id_habitos = p_id_habitos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_seccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_seccion`(
    IN p_id_seccion INT,
    IN p_letra_grupo VARCHAR(50)
)
BEGIN
    UPDATE seccion
    SET letra_grupo = p_letra_grupo
    WHERE id_seccion = p_id_seccion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_tutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_tutor`(
    IN p_id_tutor INT,
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_correos VARCHAR(100),
    IN p_telefono INT
)
BEGIN
    UPDATE tutor
    SET nombres = p_nombres,
        apellidos = p_apellidos,
        correos = p_correos,
        telefono = p_telefono
    WHERE id_tutor = p_id_tutor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_usuario`(
    IN p_id_usuario INT,
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_nombreusuario VARCHAR(50),
    IN p_contrasena VARCHAR(255),
    IN p_rol VARCHAR(30)
)
BEGIN
    UPDATE usuario
    SET nombres = p_nombres,
        apellidos = p_apellidos,
        correo = p_correo,
        nombreusuario = p_nombreusuario,
        contrasena = p_contrasena,
        rol = p_rol
    WHERE id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_estudiante`(IN b_id INT)
BEGIN
 SELECT * FROM estudiante 
      where codigo_estudiante = b_id;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_estudianteh_codigo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_estudianteh_codigo`(
    IN p_codigo_estudiante INT
)
BEGIN
    SELECT * FROM estudiantehabitos
    WHERE codigo_estudiante = p_codigo_estudiante;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_estudiante_apellido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_estudiante_apellido`(IN b_apellido VARCHAR(100))
BEGIN
SELECT * from estudiante
where apellidos = b_apellido;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_grado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_grado`(IN p_id_grado INT)
BEGIN
    SELECT id_grado, numero_grado
    FROM grado
    WHERE id_grado = p_id_grado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_habito_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_habito_id`(
    IN p_id_habitos INT
)
BEGIN
    SELECT id_habitos, tipo_de_habito, nombre_de_habito, unidad_de_medida, frecuencia
    FROM habitos
    WHERE id_habitos = p_id_habitos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_seccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_seccion`(IN p_id_seccion INT)
BEGIN
    SELECT id_seccion, letra_grupo
    FROM seccion
    WHERE id_seccion = p_id_seccion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_usuario`(
    IN p_id_usuario INT
)
BEGIN
    SELECT 
        id_usuario, 
        nombres, 
        apellidos, 
        correo, 
        nombreusuario, 
        rol 
    FROM usuario 
    WHERE id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_estudiante`(IN p_codigo_estudiante INT)
BEGIN
    DELETE FROM estudiante
    WHERE codigo_estudiante = p_codigo_estudiante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_grado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_grado`(IN p_id_grado INT)
BEGIN
    DELETE FROM grado
    WHERE id_grado = p_id_grado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_habito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_habito`(IN p_id_habito INT
)
BEGIN
    DELETE FROM habitos 
    WHERE id_habitos = p_id_habito;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_seccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_seccion`(IN p_id_seccion INT)
BEGIN
    DELETE FROM seccion
    WHERE id_seccion = p_id_seccion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_tutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_tutor`(
    IN p_id_tutor INT
)
BEGIN
    DELETE FROM tutor
    WHERE id_tutor = p_id_tutor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_usuario`(
    IN p_id_usuario INT
)
BEGIN
    DELETE FROM usuario 
    WHERE id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_estudiante`(
 IN p_codigo_estudiante INT,
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_fecha_nacimiento INT,
    IN p_genero VARCHAR(100),
    IN p_id_tutor INT,
    IN p_id_grado INT,
    IN p_id_seccion INT
  )
BEGIN
  INSERT INTO estudiante (
        codigo_estudiante, nombres, apellidos, fecha_nacimiento,
        genero, id_tutor, id_grado, id_seccion
    )
    VALUES (
        p_codigo_estudiante, p_nombres, p_apellidos, p_fecha_nacimiento,
        p_genero, p_id_tutor, p_id_grado, p_id_seccion
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_estudianteh` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_estudianteh`(
    IN p_fecha DATE,
    IN p_cantidad DECIMAL(10,2),
    IN p_codigo_estudiante INT,
    IN p_id_habitos INT
)
BEGIN
    INSERT INTO estudiantehabitos (fecha, cantidad, codigo_estudiante, id_habitos)
    VALUES (p_fecha, p_cantidad, p_codigo_estudiante, p_id_habitos);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_grado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_grado`(IN p_numero_grado INT)
BEGIN
    INSERT INTO grado (numero_grado)
    VALUES (p_numero_grado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_habito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_habito`(
    IN p_tipo_de_habito VARCHAR(50),
    IN p_nombre_de_habito VARCHAR(100),
    IN p_unidad_de_medida VARCHAR(30),
    IN p_frecuencia VARCHAR(50)
)
BEGIN
    INSERT INTO habitos (tipo_de_habito, nombre_de_habito, unidad_de_medida, frecuencia)
    VALUES (p_tipo_de_habito, p_nombre_de_habito, p_unidad_de_medida, p_frecuencia);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_seccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_seccion`(IN p_letra_grupo VARCHAR(50))
BEGIN
    INSERT INTO seccion (letra_grupo)
    VALUES (p_letra_grupo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_usuario`(
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_nombreusuario VARCHAR(50),
    IN p_contrasena VARCHAR(255),
    IN p_rol VARCHAR(30)
)
BEGIN
    INSERT INTO usuario (
        nombres, 
        apellidos, 
        correo, 
        nombreusuario, 
        contraseNa, 
        rol
    ) 
    VALUES (
        p_nombres, 
        p_apellidos, 
        p_correo, 
        p_nombreusuario, 
        p_contraseña, 
        p_rol
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_tutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_tutor`(
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_correos VARCHAR(100),
    IN p_telefono INT
)
BEGIN
    INSERT INTO tutor (nombres, apellidos, correos, telefono)
    VALUES (p_nombres, p_apellidos, p_correos, p_telefono);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_bitacora` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_bitacora`()
BEGIN
SELECT id_bitacora, tabla_afectada,accion,id_usuario,nombreusuario,valor_anterior,valor_nuevo,fecha_creacion
FROM  bitacora
ORDER BY  id_bitacora;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_estudiante`()
BEGIN
SELECT codigo_estudiante, nombres, apellidos, fecha_nacimiento, genero, id_tutor, id_grado, id_seccion
FROM estudiante
ORDER BY codigo_estudiante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_estudiantehabito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_estudiantehabito`()
BEGIN
SELECT id_registro,fecha,cantidad,codigo_estudiante,id_habitos
 FROM estudiantehabitos
 ORDER BY id_registro;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_grados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_grados`()
BEGIN
    SELECT id_grado, numero_grado
    FROM grado
    ORDER BY numero_grado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_habito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_habito`()
BEGIN
    SELECT id_habitos, tipo_de_habito, nombre_de_habito, unidad_de_medida, frecuencia
    FROM habitos
    ORDER BY id_habitos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_secciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_secciones`()
BEGIN
    SELECT id_seccion, letra_grupo
    FROM seccion
    ORDER BY letra_grupo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_tutores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_tutores`()
BEGIN
    SELECT id_tutor, nombres, apellidos, correos, telefono
    FROM tutor
    ORDER BY id_tutor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_usuario`()
BEGIN
    SELECT 
        id_usuario, 
        nombres, 
        apellidos, 
        correo, 
        nombreusuario,
        contrasena,
        rol,
        fecha_ingreso
        
    FROM usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-30  9:14:12
