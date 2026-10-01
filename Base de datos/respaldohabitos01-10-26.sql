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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula`
--

LOCK TABLES `aula` WRITE;
/*!40000 ALTER TABLE `aula` DISABLE KEYS */;
INSERT INTO `aula` VALUES (6,'Pasillo',20,'Mañana',6,6,5),(7,'fondo',10,'noche',7,7,5);
/*!40000 ALTER TABLE `aula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora_usuario`
--

DROP TABLE IF EXISTS `bitacora_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bitacora_usuario` (
  `id_bitacora` int(11) NOT NULL AUTO_INCREMENT,
  `accion` varchar(20) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `tabla_afectada` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_bitacora`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_usuario`
--

LOCK TABLES `bitacora_usuario` WRITE;
/*!40000 ALTER TABLE `bitacora_usuario` DISABLE KEYS */;
INSERT INTO `bitacora_usuario` VALUES (1,'INSERT',8,'2026-09-13 16:16:37','usuario'),(2,'INSERT',9,'2026-09-13 16:20:16','usuario'),(3,'DELETE',9,'2026-09-13 16:31:43','usuario');
/*!40000 ALTER TABLE `bitacora_usuario` ENABLE KEYS */;
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
INSERT INTO `estudiante` VALUES (2012038,'María Fernanda','Gómez Rodríguez',70501,'Femenino',1,3,1),(23808016,'jhon','fonseca',150499,'Masculino',1,3,6),(23808017,'heidy','luna',70506,'Femenino',2,3,1);
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantehabitos`
--

LOCK TABLES `estudiantehabitos` WRITE;
/*!40000 ALTER TABLE `estudiantehabitos` DISABLE KEYS */;
INSERT INTO `estudiantehabitos` VALUES (4,'2026-12-11',5.00,23808016,4),(5,'2026-12-11',5.00,23808016,4),(6,'2026-12-11',5.00,23808017,1),(7,'2026-09-29',2.50,23808016,4);
/*!40000 ALTER TABLE `estudiantehabitos` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grado`
--

LOCK TABLES `grado` WRITE;
/*!40000 ALTER TABLE `grado` DISABLE KEYS */;
INSERT INTO `grado` VALUES (1,1),(3,2),(4,3),(6,1),(7,2);
/*!40000 ALTER TABLE `grado` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitos`
--

LOCK TABLES `habitos` WRITE;
/*!40000 ALTER TABLE `habitos` DISABLE KEYS */;
INSERT INTO `habitos` VALUES (1,'ejercicio','agdominales','hora',NULL),(4,'ba;arse','higine','tiempo',NULL);
/*!40000 ALTER TABLE `habitos` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seccion`
--

LOCK TABLES `seccion` WRITE;
/*!40000 ALTER TABLE `seccion` DISABLE KEYS */;
INSERT INTO `seccion` VALUES (1,'b'),(6,'a'),(7,'c');
/*!40000 ALTER TABLE `seccion` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
INSERT INTO `tutor` VALUES (1,'sixta','pineda','sixtatreshijod@gmail.com',87998912),(2,'nery','luna','neryluna88@gmail.com',88888888);
/*!40000 ALTER TABLE `tutor` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'jhon kenneth','fonseca Pineda','jhonkenneth99@gmail.com','jhonfonseca','89113637','Administrador','2026-09-12 17:05:06'),(5,'juan manuel','perez','juanperez1@gmail.com','juanperez','89113637','Docente','2026-09-12 17:05:06'),(6,'sixta lorena','Pineda Ramirez','sixtalorena@gmail.com','sixtaPineda','sixta123456','Docente','2026-09-12 00:00:00'),(7,'Carlos Eduardo','Mendoza López','carlosmendoza@gmail.com','carlosMendoza','89113637','Docente','2026-09-12 00:00:00'),(8,'Laura Sofia','Gómez Ruiz','laura.gomez@gmail.com','laurag','Clave#2026','Docente','2026-09-13 16:16:37');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-01 15:21:28
