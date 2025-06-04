CREATE DATABASE  IF NOT EXISTS `fact` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fact`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: fact
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `apendice`
--

DROP TABLE IF EXISTS `apendice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apendice` (
  `ape_id` int NOT NULL AUTO_INCREMENT,
  `ape_fac_id` int DEFAULT NULL,
  `ape_campo` varchar(25) DEFAULT NULL,
  `ape_etiqueta` varchar(50) DEFAULT NULL,
  `ape_valor` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`ape_id`),
  KEY `fk_ape_fac_id` (`ape_fac_id`),
  CONSTRAINT `fk_ape_fac_id` FOREIGN KEY (`ape_fac_id`) REFERENCES `factura` (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apendice`
--

LOCK TABLES `apendice` WRITE;
/*!40000 ALTER TABLE `apendice` DISABLE KEYS */;
/*!40000 ALTER TABLE `apendice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aplicaciones_por_procesos`
--

DROP TABLE IF EXISTS `aplicaciones_por_procesos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aplicaciones_por_procesos` (
  `app_id` int NOT NULL AUTO_INCREMENT,
  `app_app` varchar(40) DEFAULT NULL COMMENT 'Nombre tecnico de la aplicacion',
  `app_proceso` varchar(100) DEFAULT NULL COMMENT 'Proceso que puede recuperar en la tabla catalogo_productos por el campo "cp_proceso"',
  PRIMARY KEY (`app_id`),
  UNIQUE KEY `app_app_UNIQUE` (`app_app`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicaciones_por_procesos`
--

LOCK TABLES `aplicaciones_por_procesos` WRITE;
/*!40000 ALTER TABLE `aplicaciones_por_procesos` DISABLE KEYS */;
INSERT INTO `aplicaciones_por_procesos` VALUES (1,'TICKETPARKING','PARQUEO'),(2,'CRONEXAMVISUALDTE','VISUAL'),(3,'FACTURAELEC','COPIAS'),(4,'PROINGDATOS','MANUAL'),(5,'CRONFINMES','MANUAL');
/*!40000 ALTER TABLE `aplicaciones_por_procesos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora`
--

DROP TABLE IF EXISTS `bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora` (
  `bit_no_fact` int NOT NULL,
  `bit_fecha_envio` datetime DEFAULT NULL,
  `bit_emisor` varchar(45) DEFAULT NULL,
  `bit_receptor` varchar(45) DEFAULT NULL,
  `bit_usuario_aplica` varchar(45) DEFAULT NULL,
  `bit_descripcion` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`bit_no_fact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora`
--

LOCK TABLES `bitacora` WRITE;
/*!40000 ALTER TABLE `bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora_declaracion_hacienda`
--

DROP TABLE IF EXISTS `bitacora_declaracion_hacienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora_declaracion_hacienda` (
  `idbitacora` int NOT NULL AUTO_INCREMENT,
  `nro_control` varchar(15) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `codigo_generacion` varchar(45) DEFAULT NULL,
  `observaciones` varchar(100) DEFAULT NULL,
  `json_doc` json DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  `usuario_ingreso` varchar(45) DEFAULT NULL,
  `fecha_respuesta` datetime DEFAULT NULL,
  `selloRecibido` varchar(100) DEFAULT NULL,
  `link` varchar(300) NOT NULL,
  `id_fac` int DEFAULT NULL,
  PRIMARY KEY (`idbitacora`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_declaracion_hacienda`
--

LOCK TABLES `bitacora_declaracion_hacienda` WRITE;
/*!40000 ALTER TABLE `bitacora_declaracion_hacienda` DISABLE KEYS */;
INSERT INTO `bitacora_declaracion_hacienda` VALUES (2,'4','PROCESADO','8B37F771-3B7E-11F0-8D8B-0242AC110003',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 395.0, \"referencia\": \"\"}], \"ivaRete1\": 0.0, \"subTotal\": 395.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 395.0, \"totalPagar\": 395.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"TRESCIENTOS NOVENTA Y CINCO CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 395.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 395.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"PEDRITO PEREZ\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR, SAN SALVADOR.\", \"departamento\": \"06\"}, \"codActividad\": \"68109\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-27\", \"horEmi\": \"22:45:13\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P000-000000000000008\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"8B37F771-3B7E-11F0-8D8B-0242AC110003\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 25, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 395.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-27 22:45:18','root@172.17.0.1','2025-05-27 22:45:18','20258083173D0CCE40E3801D13B5B899E8750E2Q','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=8B37F771-3B7E-11F0-8D8B-0242AC110003&fechaEmi=2025-05-27',4),(6,'14','PROCESADO','25B81991-3BD7-11F0-B223-FADAF9E6DC92',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 237.0, \"referencia\": \"\"}], \"ivaRete1\": 0.0, \"subTotal\": 237.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 237.0, \"totalPagar\": 237.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"DOSCIENTOS TREINTA Y SIETE CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 237.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 237.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"PEDRITO PEREZ\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR, SAN SALVADOR.\", \"departamento\": \"06\"}, \"codActividad\": \"68109\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-28\", \"horEmi\": \"09:19:28\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P001-000000000000013\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"25B81991-3BD7-11F0-B223-FADAF9E6DC92\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 15, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 237.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-28 09:19:33','root@172.17.0.1','2025-05-28 09:19:33','2025DAE7FBA64CF747FBA82EA9AEC2F28B347GUA','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=25B81991-3BD7-11F0-B223-FADAF9E6DC92&fechaEmi=2025-05-28',14),(7,'15','PROCESADO','CB817D19-3BD7-11F0-B223-FADAF9E6DC92',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 316.0, \"referencia\": \"\"}], \"ivaRete1\": 0.0, \"subTotal\": 316.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 316.0, \"totalPagar\": 316.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"TRESCIENTOS DIECISEIS CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 316.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 316.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"PEDRITO PEREZ\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR, SAN SALVADOR.\", \"departamento\": \"06\"}, \"codActividad\": \"68109\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-28\", \"horEmi\": \"09:24:06\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P001-000000000000014\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"CB817D19-3BD7-11F0-B223-FADAF9E6DC92\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 20, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 316.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-28 09:24:11','root@172.17.0.1','2025-05-28 09:24:11','2025D8546757864F4F05A25D83F70529F1B2TFXX','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=CB817D19-3BD7-11F0-B223-FADAF9E6DC92&fechaEmi=2025-05-28',15),(8,'16','PROCESADO','344F43CC-3BD8-11F0-B223-FADAF9E6DC92',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 158.0, \"referencia\": \"\"}], \"ivaRete1\": 0.0, \"subTotal\": 158.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 158.0, \"totalPagar\": 158.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 158.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 158.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"PEDRITO PEREZ\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR, SAN SALVADOR.\", \"departamento\": \"06\"}, \"codActividad\": \"68109\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-28\", \"horEmi\": \"09:27:02\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P001-000000000000015\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"344F43CC-3BD8-11F0-B223-FADAF9E6DC92\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 158.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-28 09:27:07','root@172.17.0.1','2025-05-28 09:27:07','20259EC6A7B2629C4F0A98A3D94E8FF5E5B99IER','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=344F43CC-3BD8-11F0-B223-FADAF9E6DC92&fechaEmi=2025-05-28',16),(9,'17','PROCESADO','B11C59B2-3BEA-11F0-B223-FADAF9E6DC92',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 1580.0, \"referencia\": \"\"}], \"ivaRete1\": 0.0, \"subTotal\": 1580.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 1580.0, \"totalPagar\": 1580.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"MIL QUINIENTOS OCHENTA CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 1580.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 1580.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"PEDRITO PEREZ\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR, SAN SALVADOR.\", \"departamento\": \"06\"}, \"codActividad\": \"68109\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-28\", \"horEmi\": \"11:39:22\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P001-000000000000016\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"B11C59B2-3BEA-11F0-B223-FADAF9E6DC92\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 100, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 1580.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-28 11:39:27','root@172.17.0.1','2025-05-28 11:39:27','2025388568F1E58B4671937554D8AE89F641DZVV','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=B11C59B2-3BEA-11F0-B223-FADAF9E6DC92&fechaEmi=2025-05-28',17),(10,'18','PROCESADO','5721E361-3CBC-11F0-A8B0-9A4A3E130EA2',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 158.0, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 158.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 158.0, \"totalPagar\": 158.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 158.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 158.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"PEDRITO PEREZ\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR, SAN SALVADOR.\", \"departamento\": \"06\"}, \"codActividad\": \"68109\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-29\", \"horEmi\": \"12:40:06\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P001-000000000000017\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"5721E361-3CBC-11F0-A8B0-9A4A3E130EA2\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 158.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-29 12:40:11','root@172.17.0.1','2025-05-29 12:40:11','2025C870F52A2DA042A6B77ED229648D2948V6CE','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=5721E361-3CBC-11F0-A8B0-9A4A3E130EA2&fechaEmi=2025-05-29',18),(11,'19','PROCESADO','582228DC-3CC6-11F0-8D36-66DEE5945C0E',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 250.0, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 250.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 250.0, \"totalPagar\": 250.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"DOSCIENTOS CINCUENTA CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 250.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 250.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"PEDRITO PEREZ\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR, SAN SALVADOR.\", \"departamento\": \"06\"}, \"codActividad\": \"68109\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-29\", \"horEmi\": \"13:51:42\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P001-000000000000018\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"582228DC-3CC6-11F0-8D36-66DEE5945C0E\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 25.0, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 250.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-29 13:51:47','root@172.17.0.1','2025-05-29 13:51:47','2025626D357D1B6F4BD7B72937E525791A2BKUNM','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=582228DC-3CC6-11F0-8D36-66DEE5945C0E&fechaEmi=2025-05-29',19),(12,'38','PROCESADO','8BF0D6D7-408A-11F0-A2E7-7AD83F5004C6',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 158.0, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 158.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 158.0, \"totalPagar\": 158.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 158.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 158.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"JUAN GUTIERREZ\", \"telefono\": \"22617300\", \"direccion\": {\"municipio\": \"15\", \"complemento\": \"1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR\", \"departamento\": \"06\"}, \"codActividad\": \"10005\", \"numDocumento\": \"00000000000008\", \"descActividad\": \"OTROS\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-06-03\", \"horEmi\": \"08:53:44\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P001-000000000000030\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"8BF0D6D7-408A-11F0-A2E7-7AD83F5004C6\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 158.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-06-03 08:53:49','root@172.17.0.1','2025-06-03 08:53:49','2025E0A0097F2E9043B4A1AB9812D7AC37CDRQ9I','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=8BF0D6D7-408A-11F0-A2E7-7AD83F5004C6&fechaEmi=2025-06-03',40),(14,'10','PROCESADO','4DE7D493-40B8-11F0-A2E7-7AD83F5004C6',NULL,'{\"emisor\": {\"nit\": \"06140203981013\", \"nrc\": \"1047582\", \"correo\": \"admin@gmail.com\", \"nombre\": \"asd asd asda sd\", \"telefono\": \"22336655\", \"direccion\": {\"municipio\": \"06\", \"complemento\": \"lsakjhals dkjhalsdkj hasd\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"94990\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": \"0000\", \"descActividad\": \"ACTIVIDADES DE ASOCIACIONES N.C.P.\", \"codPuntoVentaMH\": \"0000\", \"nombreComercial\": \"asdasd asd asd\", \"tipoEstablecimiento\": \"01\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 52.6, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 52.6, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 52.6, \"totalPagar\": 52.6, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CINCUENTA Y DOS CON SESENTA /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 52.6, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 52.6, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"NA\", \"telefono\": null, \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR \", \"departamento\": \"06\"}, \"codActividad\": \"10001\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"EMPLEADOS\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-06-03\", \"horEmi\": \"14:21:17\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P000-000000000000008\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"4DE7D493-40B8-11F0-A2E7-7AD83F5004C6\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"01\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 5.26, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 52.6, \"descripcion\": \"TEST_STC\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-06-03 14:21:21','root@172.17.0.1','2025-06-03 14:21:21','2025322418A3307841129F62D67DA2E5485FFWUZ','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=4DE7D493-40B8-11F0-A2E7-7AD83F5004C6&fechaEmi=2025-06-03',54),(19,'7','PROCESADO','CB1140A5-40BC-11F0-A2E7-7AD83F5004C6',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"asd asd asda sd\", \"telefono\": \"22336655\", \"direccion\": {\"municipio\": \"05\", \"complemento\": \"lsakjhals dkjhalsdkj hasd\", \"departamento\": \"05\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": \"0000\", \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": \"0000\", \"nombreComercial\": \"asdasd asd asd\", \"tipoEstablecimiento\": \"01\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 158.0, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 158.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 158.0, \"totalPagar\": 158.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 158.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 158.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"JUAN GUTIERREZ\", \"telefono\": \"22617300\", \"direccion\": {\"municipio\": \"15\", \"complemento\": \"1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR\", \"departamento\": \"06\"}, \"codActividad\": \"10005\", \"numDocumento\": \"00000000000008\", \"descActividad\": \"OTROS\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-06-03\", \"horEmi\": \"14:53:25\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-MISRP000-000000000000036\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"CB1140A5-40BC-11F0-A2E7-7AD83F5004C6\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 158.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-06-03 14:53:29','root@172.17.0.1','2025-06-03 14:53:29','2025493B784BC9214776B2D7AB0192488DF7I9YX','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=CB1140A5-40BC-11F0-A2E7-7AD83F5004C6&fechaEmi=2025-06-03',64),(20,'8','PROCESADO','E63E0D2D-40BC-11F0-A2E7-7AD83F5004C6',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"asd asd asda sd\", \"telefono\": \"22336655\", \"direccion\": {\"municipio\": \"05\", \"complemento\": \"lsakjhals dkjhalsdkj hasd\", \"departamento\": \"05\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": \"0000\", \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": \"0000\", \"nombreComercial\": \"asdasd asd asd\", \"tipoEstablecimiento\": \"01\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 158.0, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 158.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 158.0, \"totalPagar\": 158.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 158.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 158.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"JUAN GUTIERREZ\", \"telefono\": \"22617300\", \"direccion\": {\"municipio\": \"15\", \"complemento\": \"1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR\", \"departamento\": \"06\"}, \"codActividad\": \"10005\", \"numDocumento\": \"00000000000008\", \"descActividad\": \"OTROS\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-06-03\", \"horEmi\": \"14:54:10\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-MISRP000-000000000000037\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"E63E0D2D-40BC-11F0-A2E7-7AD83F5004C6\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 158.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-06-03 14:54:17','root@172.17.0.1','2025-06-03 14:54:17','2025A7A9888C494841BBB8614B0191F0270FXIWW','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=E63E0D2D-40BC-11F0-A2E7-7AD83F5004C6&fechaEmi=2025-06-03',65),(21,'11','PROCESADO','FA365ACD-40BC-11F0-A2E7-7AD83F5004C6',NULL,'{\"emisor\": {\"nit\": \"06140203981013\", \"nrc\": \"1047582\", \"correo\": \"admin@gmail.com\", \"nombre\": \"asd asd asda sd\", \"telefono\": \"22336655\", \"direccion\": {\"municipio\": \"06\", \"complemento\": \"lsakjhals dkjhalsdkj hasd\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"94990\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": \"0000\", \"descActividad\": \"ACTIVIDADES DE ASOCIACIONES N.C.P.\", \"codPuntoVentaMH\": \"0000\", \"nombreComercial\": \"asdasd asd asd\", \"tipoEstablecimiento\": \"01\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 52.6, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 52.6, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 52.6, \"totalPagar\": 52.6, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CINCUENTA Y DOS CON SESENTA /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 52.6, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 52.6, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"NA\", \"telefono\": null, \"direccion\": {\"municipio\": \"14\", \"complemento\": \"SAN SALVADOR \", \"departamento\": \"06\"}, \"codActividad\": \"10001\", \"numDocumento\": \"00000000000000\", \"descActividad\": \"EMPLEADOS\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-06-03\", \"horEmi\": \"14:54:44\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-S000P000-000000000000009\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"FA365ACD-40BC-11F0-A2E7-7AD83F5004C6\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"01\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 5.26, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 52.6, \"descripcion\": \"TEST_STC\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-06-03 14:54:49','root@172.17.0.1','2025-06-03 14:54:49','2025486D4368B6A54E3080FD86413AD2C3B8APQ6','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=FA365ACD-40BC-11F0-A2E7-7AD83F5004C6&fechaEmi=2025-06-03',66),(22,'11','PROCESADO','6CDF4FFE-40C8-11F0-A2E7-7AD83F5004C6',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"SERVICIOS N.C.P.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 178.54, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 158.0, \"tributos\": [{\"valor\": 20.54, \"codigo\": \"20\", \"descripcion\": \"Impuesto al Valor Agregado 13%\"}], \"ivaPerci1\": 0.0, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 0.0, \"totalPagar\": 178.54, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CIENTO SETENTA Y OCHO CON CINCUENTA Y CUATRO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 158.0, \"subTotalVentas\": 158.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 178.54, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nit\": \"06141603001014\", \"nrc\": \"1199782\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"G.S.I. El Salvador, S.A. de C.V. \", \"telefono\": \"22617300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"Calle Llama del Bosque Pte. Blvd. Luis Poma Local 204, Urbanizacion Madre Selva Edificio \", \"departamento\": \"06\"}, \"codActividad\": \"63110\", \"descActividad\": \"PROCESAMIENTO DE DATOS Y ACTIVIDADES RELACIONADAS\", \"nombreComercial\": \"G.S.I. El Salvador, S.A. de C.V. \"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-06-03\", \"horEmi\": \"16:16:41\", \"tipoDte\": \"03\", \"version\": 3, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-03-MISRP000-000000000000002\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"6CDF4FFE-40C8-11F0-A2E7-7AD83F5004C6\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": [\"20\"], \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 0.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 158.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-06-03 16:16:46','root@172.17.0.1','2025-06-03 16:16:46','2025CC4CF6F0056A415FA5AB209B9A8C75050D9W','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=6CDF4FFE-40C8-11F0-A2E7-7AD83F5004C6&fechaEmi=2025-06-03',69),(23,'15','PROCESADO','89EAF4CA-40DD-11F0-A2E7-7AD83F5004C6',NULL,'{\"emisor\": {\"nit\": \"06140203981013\", \"nrc\": \"1047582\", \"correo\": \"admin@gmail.com\", \"nombre\": \"asd asd asda sd\", \"telefono\": \"22336655\", \"direccion\": {\"municipio\": \"06\", \"complemento\": \"lsakjhals dkjhalsdkj hasd\", \"departamento\": \"06\"}, \"codEstable\": \"0000\", \"codActividad\": \"94990\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": \"0000\", \"descActividad\": \"ACTIVIDADES DE ASOCIACIONES N.C.P.\", \"codPuntoVentaMH\": \"0000\", \"nombreComercial\": \"asdasd asd asd\", \"tipoEstablecimiento\": \"01\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"01\", \"periodo\": null, \"montoPago\": 59.44, \"referencia\": null}], \"ivaRete1\": 0.0, \"subTotal\": 52.6, \"tributos\": [{\"valor\": 6.84, \"codigo\": \"20\", \"descripcion\": \"Impuesto al Valor Agregado 13%\"}], \"ivaPerci1\": 0.0, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 0.0, \"totalPagar\": 59.44, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"CINCUENTA Y NUEVE CON CUARENTA Y CUATRO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 52.6, \"subTotalVentas\": 52.6, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 59.44, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": null, \"direccion\": {\"municipio\": \"14\", \"complemento\": \"CERCA DE LA CUENCA DEL PUEBLO\", \"departamento\": \"06\"}, \"codActividad\": \"96092\", \"descActividad\": \"SERVICIOS N.C.P.\", \"nombreComercial\": \"MIGUEL ISAAC SANCHEZ RAMOS\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-06-03\", \"horEmi\": \"18:47:49\", \"tipoDte\": \"03\", \"version\": 3, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-03-S000P000-000000000000003\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"89EAF4CA-40DD-11F0-A2E7-7AD83F5004C6\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"01\", \"numItem\": 1, \"cantidad\": 10, \"tipoItem\": 1, \"tributos\": [\"20\"], \"noGravado\": 0.0, \"precioUni\": 5.26, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 0.0, \"descripcion\": \"TEST_STC\", \"ventaExenta\": 0.0, \"ventaGravada\": 52.6, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-06-03 18:48:37','root@172.17.0.1','2025-06-03 18:48:37','2025A9AAD737EAF74CD0BA6A3F01A6A822FDNQCE','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=89EAF4CA-40DD-11F0-A2E7-7AD83F5004C6&fechaEmi=2025-06-03',83);
/*!40000 ALTER TABLE `bitacora_declaracion_hacienda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buzon_encabezado`
--

DROP TABLE IF EXISTS `buzon_encabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buzon_encabezado` (
  `idbuzon` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `usuario` varchar(55) DEFAULT NULL,
  `aplicacion` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`idbuzon`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3 COMMENT='Se crea trabla que permitirá controlar el numero interno en el buzoncsv y evitar el proceso de ingreso manual, utilizado en fun_genera_numero_interno.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buzon_encabezado`
--

LOCK TABLES `buzon_encabezado` WRITE;
/*!40000 ALTER TABLE `buzon_encabezado` DISABLE KEYS */;
INSERT INTO `buzon_encabezado` VALUES (1,'2025-05-27 22:26:09','miguelsr1@gmail.com','PROINGDATOS'),(3,'2025-05-27 22:40:07','miguelsr1@gmail.com','PROINGDATOS'),(4,'2025-05-27 22:45:13','miguelsr1@gmail.com','PROINGDATOS'),(7,'2025-05-28 08:50:28','miguelsr1@gmail.com','PROINGDATOS'),(9,'2025-05-28 08:56:33','miguelsr1@gmail.com','PROINGDATOS'),(11,'2025-05-28 09:16:05','miguelsr1@gmail.com','PROINGDATOS'),(13,'2025-05-28 09:19:08','miguelsr1@gmail.com','PROINGDATOS'),(14,'2025-05-28 09:19:28','miguelsr1@gmail.com','PROINGDATOS'),(15,'2025-05-28 09:24:06','miguelsr1@gmail.com','PROINGDATOS'),(16,'2025-05-28 09:27:02','miguelsr1@gmail.com','PROINGDATOS'),(17,'2025-05-28 11:39:22','miguelsr1@gmail.com','PROINGDATOS'),(18,'2025-05-29 12:40:05','miguelsr1@gmail.com','PROINGDATOS'),(19,'2025-05-29 13:51:42','miguelsr1@gmail.com','PROINGDATOS'),(20,'2025-05-30 15:19:41','admin@gmail.com','PROINGDATOS'),(21,'2025-05-30 15:21:08','admin@gmail.com','PROINGDATOS'),(22,'2025-05-30 15:24:04','admin@gmail.com','PROINGDATOS'),(23,'2025-05-30 15:27:16','admin@gmail.com','PROINGDATOS'),(28,'2025-05-30 16:05:37','admin@gmail.com','PROINGDATOS'),(30,'2025-05-30 16:12:48','admin@gmail.com','PROINGDATOS'),(38,'2025-06-03 08:53:44','miguelsr1@gmail.com','PROINGDATOS');
/*!40000 ALTER TABLE `buzon_encabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buzoncsv`
--

DROP TABLE IF EXISTS `buzoncsv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buzoncsv` (
  `id_buzon` int NOT NULL AUTO_INCREMENT,
  `cod_factura` varchar(250) DEFAULT NULL,
  `cod_emisor` text,
  `tipodoc` text,
  `tipodocrec` int DEFAULT NULL,
  `nit` text,
  `nrc` int DEFAULT NULL,
  `nombrecliente` text,
  `correo` text,
  `telefono` text,
  `moneda` text,
  `tipocambio` int DEFAULT NULL,
  `depart` text,
  `municipio` int DEFAULT NULL,
  `complemento` text,
  `codactcom` text,
  `codigo` text,
  `detalle` text,
  `unidad_medida` int DEFAULT NULL,
  `tipo` int DEFAULT NULL,
  `cantidad` decimal(11,5) DEFAULT NULL,
  `precio_unitario` decimal(11,5) DEFAULT NULL,
  `descuento` decimal(11,5) DEFAULT NULL,
  `exento` text,
  `codigo_` int DEFAULT NULL,
  `porcentaje` int DEFAULT NULL,
  `valor` text,
  `condicionpago` int DEFAULT NULL,
  `mediopago` text,
  `monto` text,
  `referencia` text,
  `plazo` text,
  `periodo` text,
  `tipogeneracion` text,
  `tipodte` text,
  `numeroautorizacion` text,
  `fechahoraemision` text,
  `tipodocidreceptor` text,
  `bientitulo` text,
  `fecha_migrado` datetime DEFAULT CURRENT_TIMESTAMP,
  `factura_migrada` char(1) DEFAULT 'N',
  `buzoncsvcol` varchar(45) DEFAULT NULL,
  `tipo_item_expor` int DEFAULT NULL,
  `recinto_fiscal` varchar(2) DEFAULT NULL,
  `regimen` varchar(13) DEFAULT NULL,
  `codtributo` varchar(2) DEFAULT NULL COMMENT 'Se utiliza para el cuerpoDocumento.codTributo este será requerido cuando el campo "tipo item" (del cuerpoDocumento) sea la opción 4 de lo contrario sera "null".',
  `doc_relacionado` varchar(45) DEFAULT NULL,
  `tipo_doc_relacionado` varchar(2) DEFAULT NULL,
  `fecha_doc_relacionado` datetime DEFAULT NULL,
  `tipo_generacion_doc_rel` int DEFAULT NULL,
  `descripcion_retencion` varchar(100) DEFAULT NULL COMMENT 'Descripcion que se utilizara para la factura de retencion en el campo descripcion',
  `id_retencion` int DEFAULT NULL COMMENT 'Id de retencion en base al catalogo_retencion_iva_mh',
  `nombre_receptor` varchar(120) DEFAULT NULL,
  `cdc_id` int DEFAULT NULL,
  `id_factura` int DEFAULT NULL,
  `anulacion` varchar(1) DEFAULT NULL,
  `retencion_iva` decimal(11,5) DEFAULT NULL COMMENT 'Campo utilizado para la factura de Sujeto excluido, se imprime en el reporte al generar una factura.',
  `retencion_iva_porc` decimal(11,2) DEFAULT NULL,
  `impuesto_reten_retenido` decimal(11,5) DEFAULT NULL COMMENT 'Campo utilizado para la factura de Sujeto excluido, se imprime en el reporte al generar una factura.',
  `impuesto_reten_retenido_porc` decimal(11,2) DEFAULT NULL,
  `observaciones_detalles` varchar(100) DEFAULT NULL COMMENT 'Campo utilizado para la factura de Sujeto excluido, se imprime en el reporte al generar una factura con observaciones adicionales agregadas en los datelles de productos.',
  `id_usuario_ingreso` int DEFAULT NULL,
  `ulb_usuario_ingreso` int DEFAULT NULL,
  `idcat_prod` int DEFAULT NULL COMMENT 'Campo con el que se relaciona el producto con la tabla catalogo_productos',
  `id_empresa` int DEFAULT NULL,
  PRIMARY KEY (`id_buzon`),
  KEY `BUZ_ID_idx` (`id_buzon`) /*!80000 INVISIBLE */,
  KEY `BUZ_COD_idx` (`cod_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buzoncsv`
--

LOCK TABLES `buzoncsv` WRITE;
/*!40000 ALTER TABLE `buzoncsv` DISABLE KEYS */;
INSERT INTO `buzoncsv` VALUES (1,'1','06141204841181','01',36,'0000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,30.00000,15.80000,NULL,'No',20,13,'474.00',1,'01','474.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-27 22:26:09','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(3,'3','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,20.00000,15.80000,NULL,'No',20,13,'316.00',1,'01','316.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-27 22:40:07','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(4,'4','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,25.00000,15.80000,NULL,'No',20,13,'395.00',1,'01','395.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-27 22:45:13','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(7,'7','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,15.00000,15.80000,NULL,'No',20,13,'237.00',1,'01','237.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 08:50:37','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(9,'9','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 08:56:33','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(11,'11','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 09:16:05','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(13,'13','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 09:19:08','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(14,'14','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,15.00000,15.80000,NULL,'No',20,13,'237.00',1,'01','237.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 09:19:28','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(15,'15','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,20.00000,15.80000,NULL,'No',20,13,'316.00',1,'01','316.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 09:24:06','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(16,'16','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 09:27:02','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(17,'17','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,100.00000,15.80000,NULL,'No',20,13,'1580.00',1,'01','1580.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-28 11:39:22','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',1,NULL,NULL,NULL),(18,'18','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-29 12:40:06','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,NULL),(19,'19','06141204841181','01',36,'00000000000000',1047582,'SIN IDENTIFICACION ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'SAN SALVADOR ','10005','1','TEST 1',59,1,10.00000,25.00000,NULL,'No',20,13,'250.00',1,'01','250.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-29 13:51:42','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,NULL),(20,'20','06140203981013','01',13,'000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'NA','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-30 15:19:41','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,NULL),(21,'21','06140203981013','01',13,'000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'NA','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-30 15:21:20','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,NULL),(22,'22','06140203981013','01',13,'000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'NA','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-30 15:24:04','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,NULL),(23,'23','06140203981013','01',13,'00000000-0',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-30 15:27:16','N',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,NULL),(28,'28','06140203981013','01',13,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,20.00000,5.26000,NULL,'No',20,13,'105.20',1,'01','105.20',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-30 16:12:20','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(29,'29','06140203981013','01',13,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-30 16:12:48','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(30,'30','06140203981013','01',13,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 10:01:28','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(38,'38','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 08:53:44','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(43,'4','06140203981013','01',13,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 10:01:28','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(44,'5','06140203981013','01',13,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 10:01:28','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(47,'6','06140203981013','01',13,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 13:19:44','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(48,'7','06140203981013','01',13,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 13:21:57','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(49,'8','06140203981013','01',36,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 13:32:04','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(52,'9','06140203981013','01',36,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,20.00000,5.26000,NULL,'No',20,13,'105.20',1,'01','105.20',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:20:45','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(53,'10','06140203981013','01',36,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:21:17','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(54,'2','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:28:46','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(56,'3','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:36:14','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(58,'4','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:38:47','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(60,'5','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:46:34','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(62,'6','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:52:42','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(63,'7','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:53:25','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(64,'8','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'158.00',1,'01','158.00',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:54:10','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(65,'11','06140203981013','01',36,'00000000000000',NULL,'NA','miguelsr1@gmail.com','','USD',1,'06',14,'SAN SALVADOR ','10001','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'52.60',1,'01','52.60',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 14:54:44','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(67,'9','06141204841181','03',36,'06141603001014',1199782,'G.S.I. El Salvador, S.A. de C.V. ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'Calle Llama del Bosque Pte. Blvd. Luis Poma Local 204, Urbanizacion Madre Selva Edificio ','63110','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'178.5400',1,'01','178.5400',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 16:10:45','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(68,'10','06141204841181','03',36,'06141603001014',1199782,'G.S.I. El Salvador, S.A. de C.V. ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'Calle Llama del Bosque Pte. Blvd. Luis Poma Local 204, Urbanizacion Madre Selva Edificio ','63110','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'178.5400',1,'01','178.5400',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 16:12:18','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(69,'11','06141204841181','03',36,'06141603001014',1199782,'G.S.I. El Salvador, S.A. de C.V. ','miguelsr1@gmail.com','22617300','USD',1,'06',14,'Calle Llama del Bosque Pte. Blvd. Luis Poma Local 204, Urbanizacion Madre Selva Edificio ','63110','1','TEST 1',59,1,10.00000,15.80000,NULL,'No',20,13,'178.5400',1,'01','178.5400',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 16:16:41','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(70,'12','06141204841181','03',36,'06141204841181',1875310,'Miguel Isaac Sanchez Ramos','miguelsr1@gmail.com','22336655','USD',1,'06',14,'CERCA DEL PALO DE MANGO','96092','1','TEST 1',59,1,30.00000,15.80000,NULL,'No',20,13,'535.6200',1,'01','535.6200',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 16:42:20','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,1,NULL,NULL,1),(80,'12','06140203981013','03',36,'06141204841181',1875310,'MIGUEL ISAAC SANCHEZ RAMOS','miguelsr1@gmail.com','22617300','USD',1,'06',14,'CERCA DE LA CUENCA DEL PUEBLO','96092','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'59.4380',1,'01','59.4380',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 17:10:36','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(81,'13','06140203981013','03',36,'06141204841181',1875310,'MIGUEL ISAAC SANCHEZ RAMOS','miguelsr1@gmail.com','22617300','USD',1,'06',14,'CERCA DE LA CUENCA DEL PUEBLO','96092','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'59.4380',1,'01','59.4380',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 18:39:19','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(82,'14','06140203981013','03',36,'06141204841181',1875310,'MIGUEL ISAAC SANCHEZ RAMOS','miguelsr1@gmail.com','22617300','USD',1,'06',14,'CERCA DE LA CUENCA DEL PUEBLO','96092','01','TEST_STC',59,1,20.00000,5.26000,NULL,'No',20,13,'118.8760',1,'01','118.8760',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 18:41:25','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2),(84,'15','06140203981013','03',36,'06141204841181',1875310,'MIGUEL ISAAC SANCHEZ RAMOS','miguelsr1@gmail.com','22617300','USD',1,'06',14,'CERCA DE LA CUENCA DEL PUEBLO','96092','01','TEST_STC',59,1,10.00000,5.26000,NULL,'No',20,13,'59.4380',1,'01','59.4380',NULL,'01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-06-03 18:47:41','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,NULL,2,NULL,NULL,2);
/*!40000 ALTER TABLE `buzoncsv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_codigo_actividad_economica`
--

DROP TABLE IF EXISTS `catalogo_codigo_actividad_economica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_codigo_actividad_economica` (
  `ccae_codigo` varchar(6) NOT NULL,
  `ccae_valor` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ccae_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='CAT-019 Código de Actividad Económica';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_codigo_actividad_economica`
--

LOCK TABLES `catalogo_codigo_actividad_economica` WRITE;
/*!40000 ALTER TABLE `catalogo_codigo_actividad_economica` DISABLE KEYS */;
INSERT INTO `catalogo_codigo_actividad_economica` VALUES ('10001','EMPLEADOS'),('10002','PENSIONADO'),('10003','ESTUDIANTE'),('10004','DESEMPLEADO'),('10005','OTROS'),('10006','COMERCIANTE'),('10101','SERVICIO DE RASTROS Y MATADEROS DE BOVINOS Y PORCINOS'),('10102','MATANZA Y PROCESAMIENTO DE BOVINOS Y PORCINOS'),('10103','MATANZA Y PROCESAMIENTOS DE AVES DE CORRAL'),('10104','ELABORACIÓN Y CONSERVACIÓN DE EMBUTIDOS Y TRIPAS NATURALES'),('10105','SERVICIOS DE CONSERVACIÓN Y EMPAQUE DE CARNES'),('10106','ELABORACIÓN Y CONSERVACIÓN DE GRASAS Y ACEITES ANIMALES'),('10107','SERVICIOS DE MOLIENDA DE CARNE'),('10108','ELABORACIÓN DE PRODUCTOS DE CARNE NCP'),('10201','PROCESAMIENTO Y CONSERVACIÓN DE PESCADO, CRUSTÁCEOS Y MOLUSCOS'),('10209','FABRICACIÓN DE PRODUCTOS DE PESCADO NCP'),('10301','ELABORACIÓN DE JUGOS DE FRUTAS Y HORTALIZAS'),('10302','ELABORACIÓN Y ENVASE DE JALEAS, MERMELADAS Y FRUTAS DESHIDRATADAS'),('10309','ELABORACIÓN DE PRODUCTOS DE FRUTAS Y HORTALIZAS N.C.P.'),('10401','FABRICACIÓN DE ACEITES Y GRASAS VEGETALES Y ANIMALES COMESTIBLES'),('10402','FABRICACIÓN DE ACEITES Y GRASAS VEGETALES Y ANIMALES NO COMESTIBLES'),('10409','SERVICIO DE MAQUILADO DE ACEITES'),('10501','FABRICACIÓN DE PRODUCTOS LÁCTEOS EXCEPTO SORBETES Y QUESOS SUSTITUTOS'),('10502','FABRICACIÓN DE SORBETES Y HELADOS'),('10503','FABRICACIÓN DE QUESOS'),('10611','MOLIENDA DE CEREALES'),('10612','ELABORACIÓN DE CEREALES PARA EL DESAYUNO Y SIMILARES'),('10613','SERVICIOS DE BENEFICIADO DE PRODUCTOS AGRÍ­COLAS NCP (EXCLUYE BENEFICIO DE AZÚCAR RAMA 1072  Y BENEFICIO DE CAFÉ RAMA 0163)'),('10621','FABRICACIÓN DE ALMIDÓN'),('10628','SERVICIO DE MOLIENDA DE MAÍ­Z HÚMEDO MOLINO PARA NIXTAMAL'),('10711','ELABORACIÓN DE TORTILLAS'),('10712','FABRICACIÓN DE PAN, GALLETAS Y BARQUILLOS'),('10713','FABRICACIÓN DE REPOSTERÍ­A'),('10721','INGENIOS AZUCAREROS'),('10722','MOLIENDA DE CAÑA DE AZÚCAR PARA LA ELABORACIÓN DE DULCES'),('10723','ELABORACIÓN DE JARABES DE AZÚCAR Y OTROS SIMILARES'),('10724','MAQUILADO DE AZÚCAR DE CAÑA'),('10730','FABRICACIÓN DE CACAO, CHOCOLATES Y  PRODUCTOS DE CONFITERÍ­A'),('10740','ELABORACIÓN DE MACARRONES, FIDEOS, Y PRODUCTOS FARINÁCEOS SIMILARES'),('10750','ELABORACIÓN DE COMIDAS Y PLATOS PREPARADOS PARA LA REVENTA EN LOCALES Y/O  PARA EXPORTACIÓN'),('10791','ELABORACIÓN DE PRODUCTOS DE CAFÉ'),('10792','ELABORACIÓN DE ESPECIES, SAZONADORES Y CONDIMENTOS'),('10793','ELABORACIÓN DE SOPAS, CREMAS Y CONSOMÉ'),('10794','FABRICACIÓN DE BOCADILLOS TOSTADOS Y/O FRITOS'),('10799','ELABORACIÓN DE PRODUCTOS ALIMENTICIOS NCP'),('10800','ELABORACIÓN DE ALIMENTOS PREPARADOS PARA ANIMALES'),('11012','FABRICACIÓN DE AGUARDIENTE Y LICORES'),('11020','ELABORACIÓN DE VINOS'),('11030','FABRICACIÓN DE CERVEZA'),('11041','FABRICACIÓN DE AGUAS GASEOSAS'),('11042','FABRICACIÓN Y ENVASADO  DE AGUA'),('11043','ELABORACIÓN DE REFRESCOS'),('11048','MAQUILADO DE AGUAS GASEOSAS'),('11049','ELABORACIÓN DE BEBIDAS NO ALCOHÓLICAS'),('1111','CULTIVO DE CEREALES EXCEPTO ARROZ Y PARA FORRAJES'),('1112','CULTIVO DE LEGUMBRES'),('1113','CULTIVO DE SEMILLAS OLEAGINOSAS'),('1114','CULTIVO DE PLANTAS PARA LA PREPARACIÓN DE SEMILLAS'),('1119','CULTIVO DE OTROS CEREALES EXCEPTO ARROZ Y FORRAJEROS N.C.P.'),('1120','CULTIVO DE ARROZ'),('1131','CULTIVO DE RAÍ­CES Y TUBÉRCULOS'),('1132','CULTIVO DE BROTES, BULBOS, VEGETALES TUBÉRCULOS Y CULTIVOS SIMILARES'),('1133','CULTIVO HORTÍ­COLA DE FRUTO'),('1134','CULTIVO DE HORTALIZAS DE HOJA Y OTRAS HORTALIZAS NCP'),('1140','CULTIVO DE CAÑA DE AZÚCAR'),('1150','CULTIVO DE TABACO'),('1161','CULTIVO DE ALGODÓN'),('1162','CULTIVO DE FIBRAS VEGETALES EXCEPTO ALGODÓN'),('1191','CULTIVO DE PLANTAS NO PERENNES  PARA LA PRODUCCIÓN DE SEMILLAS Y FLORES'),('1192','CULTIVO DE CEREALES Y PASTOS PARA LA ALIMENTACIÓN ANIMAL'),('1199','PRODUCCIÓN DE CULTIVOS NO ESTACIONALES  NCP'),('12000','ELABORACIÓN DE PRODUCTOS DE TABACO'),('1220','CULTIVO DE FRUTAS TROPICALES'),('1230','CULTIVO DE CÍ­TRICOS'),('1240','CULTIVO DE FRUTAS DE PEPITA Y HUESO'),('1251','CULTIVO DE FRUTAS NCP'),('1252','CULTIVO DE OTROS FRUTOS  Y NUECES DE ÁRBOLES Y ARBUSTOS'),('1260','CULTIVO DE FRUTOS OLEAGINOSOS'),('1271','CULTIVO DE CAFÉ'),('1272','CULTIVO DE PLANTAS PARA LA ELABORACIÓN DE BEBIDAS EXCEPTO CAFÉ'),('1281','CULTIVO DE ESPECIAS Y AROMÁTICAS'),('1282','CULTIVO DE PLANTAS PARA LA OBTENCIÓN DE PRODUCTOS MEDICINALES Y FARMACÉUTICOS'),('1291','CULTIVO DE ÁRBOLES DE HULE (CAUCHO) PARA LA OBTENCIÓN DE LÁTEX'),('1292','CULTIVO DE PLANTAS PARA LA OBTENCIÓN DE PRODUCTOS QUÍ­MICOS Y COLORANTES'),('1299','PRODUCCIÓN DE CULTIVOS PERENNES NCP'),('1300','PROPAGACIÓN DE PLANTAS'),('1301','CULTIVO DE PLANTAS Y FLORES ORNAMENTALES'),('13111','PREPARACIÓN DE FIBRAS TEXTILES'),('13112','FABRICACIÓN DE HILADOS'),('13120','FABRICACIÓN DE TELAS'),('13130','ACABADO DE PRODUCTOS TEXTILES'),('13910','FABRICACIÓN DE TEJIDOS DE PUNTO Y  GANCHILLO'),('13921','FABRICACIÓN DE PRODUCTOS TEXTILES PARA EL HOGAR'),('13922','SACOS, BOLSAS Y OTROS ARTÍ­CULOS TEXTILES'),('13929','FABRICACIÓN DE ARTÍ­CULOS CONFECCIONADOS CON MATERIALES TEXTILES, EXCEPTO PRENDAS DE VESTIR N.C.P'),('13930','FABRICACIÓN DE TAPICES Y ALFOMBRAS'),('13941','FABRICACIÓN DE CUERDAS DE HENEQUÉN Y OTRAS FIBRAS NATURALES (LAZOS, PITAS)'),('13942','FABRICACIÓN DE REDES DE DIVERSOS MATERIALES'),('13948','MAQUILADO DE PRODUCTOS TRENZABLES DE CUALQUIER MATERIAL (PETATES, SILLAS, ETC.)'),('13991','FABRICACIÓN DE ADORNOS, ETIQUETAS Y OTROS ARTÍ­CULOS PARA PRENDAS DE VESTIR'),('13992','SERVICIO DE BORDADOS EN ARTÍ­CULOS Y PRENDAS DE TELA'),('13999','FABRICACIÓN DE PRODUCTOS TEXTILES NCP'),('1410','CRÍ­A Y ENGORDE DE GANADO BOVINO'),('14101','FABRICACIÓN DE ROPA  INTERIOR, PARA DORMIR Y SIMILARES'),('14102','FABRICACIÓN DE ROPA PARA NIÑOS'),('14103','FABRICACIÓN DE PRENDAS DE VESTIR PARA AMBOS SEXOS'),('14104','CONFECCIÓN DE PRENDAS A MEDIDA'),('14105','FABRICACIÓN DE PRENDAS DE VESTIR PARA DEPORTES'),('14106','ELABORACIÓN DE ARTESANÍ­AS DE USO PERSONAL CONFECCIONADAS ESPECIALMENTE DE MATERIALES TEXTILES'),('14108','MAQUILADO  DE PRENDAS DE VESTIR, ACCESORIOS Y OTROS'),('14109','FABRICACIÓN DE PRENDAS Y ACCESORIOS DE VESTIR N.C.P.'),('1420','CRÍ­A DE CABALLOS Y OTROS EQUINOS'),('14200','FABRICACIÓN DE ARTÍ­CULOS DE PIEL'),('14301','FABRICACIÓN DE CALCETINES, CALCETAS, MEDIAS (PANTY HOUSE) Y OTROS SIMILARES'),('14302','FABRICACIÓN DE ROPA INTERIOR DE TEJIDO DE PUNTO'),('14309','FABRICACIÓN DE PRENDAS DE VESTIR DE TEJIDO DE PUNTO NCP'),('1440','CRÍ­A DE OVEJAS Y CABRAS'),('1450','CRÍ­A DE CERDOS'),('1460','CRÍ­A DE AVES DE CORRAL Y PRODUCCIÓN DE HUEVOS'),('1491','CRÍ­A DE ABEJAS APICULTURA PARA LA OBTENCIÓN DE MIEL Y OTROS PRODUCTOS APÍ­COLAS'),('1492','CRÍ­A DE CONEJOS'),('1493','CRÍ­A DE IGUANAS Y GARROBOS'),('1494','CRÍ­A DE MARIPOSAS Y OTROS INSECTOS'),('1499','CRÍ­A Y OBTENCIÓN DE PRODUCTOS ANIMALES N.C.P.'),('1500','CULTIVO DE PRODUCTOS AGRÍ­COLAS EN COMBINACIÓN CON LA CRÍ­A DE ANIMALES'),('15110','CURTIDO Y ADOBO DE CUEROS; ADOBO Y TEÑIDO DE PIELES'),('15121','FABRICACIÓN DE MALETAS, BOLSOS DE MANO Y OTROS ARTÍ­CULOS DE MARROQUINERÍ­A'),('15122','FABRICACIÓN DE MONTURAS, ACCESORIOS Y VAINAS  TALABARTERÍ­A'),('15123','FABRICACIÓN  DE ARTESANÍ­AS PRINCIPALMENTE DE CUERO NATURAL Y SINTÉTICO'),('15128','MAQUILADO DE ARTÍ­CULOS DE CUERO NATURAL, SINTÉTICO Y DE OTROS MATERIALES'),('15201','FABRICACIÓN DE CALZADO'),('15202','FABRICACIÓN DE PARTES Y ACCESORIOS DE CALZADO'),('15208','MAQUILADO DE PARTES Y ACCESORIOS DE CALZADO'),('16100','ASERRADERO Y ACEPILLADURA DE MADERA'),('1611','SERVICIOS DE MAQUINARIA AGRÍ­COLA'),('1612','CONTROL DE PLAGAS'),('1613','SERVICIOS DE RIEGO'),('1614','SERVICIOS DE CONTRATACIÓN DE MANO DE OBRA PARA LA AGRICULTURA'),('1619','SERVICIOS AGRÍ­COLAS NCP'),('1621','ACTIVIDADES PARA MEJORAR LA REPRODUCCIÓN, EL CRECIMIENTO Y EL RENDIMIENTO DE LOS ANIMALES Y SUS PRODUCTOS'),('16210','FABRICACIÓN DE MADERA LAMINADA, TERCIADA, ENCHAPADA Y CONTRACHAPADA, PANELES PARA LA CONSTRUCCIÓN'),('1622','SERVICIOS DE MANO DE OBRA PECUARIA'),('16220','FABRICACIÓN DE PARTES Y PIEZAS DE CARPINTERÍ­A PARA EDIFICIOS Y CONSTRUCCIONES'),('16230','FABRICACIÓN DE ENVASES Y RECIPIENTES DE MADERA'),('1629','SERVICIOS PECUARIOS NCP'),('16292','FABRICACIÓN DE ARTESANÍ­AS DE MADERA, SEMILLAS,  MATERIALES TRENZABLES'),('16299','FABRICACIÓN DE PRODUCTOS DE MADERA, CORCHO, PAJA Y MATERIALES TRENZABLES NCP'),('1631','LABORES POST COSECHA DE PREPARACIÓN DE LOS PRODUCTOS AGRÍ­COLAS PARA SU COMERCIALIZACIÓN O PARA LA INDUSTRIA'),('1632','SERVICIO DE BENEFICIO DE CAFÉ'),('1633','SERVICIO DE BENEFICIADO DE PLANTAS TEXTILES (INCLUYE EL BENEFICIADO CUANDO ESTE ES REALIZADO EN LA MISMA EXPLOTACIÓN AGROPECUARIA)'),('1640','TRATAMIENTO DE SEMILLAS PARA LA PROPAGACIÓN'),('1700','CAZA ORDINARIA Y MEDIANTE TRAMPAS, REPOBLACIÓN DE ANIMALES DE CAZA Y SERVICIOS CONEXOS'),('17010','FABRICACIÓN DE PASTA DE MADERA, PAPEL Y CARTÓN'),('17020','FABRICACIÓN DE PAPEL Y CARTÓN ONDULADO Y ENVASES DE PAPEL Y CARTÓN'),('17091','FABRICACIÓN DE ARTÍ­CULOS DE PAPEL Y CARTÓN DE USO PERSONAL Y DOMÉSTICO'),('17092','FABRICACIÓN DE PRODUCTOS DE PAPEL NCP'),('18110','IMPRESIÓN'),('18120','SERVICIOS RELACIONADOS CON LA IMPRESIÓN'),('18200','REPRODUCCIÓN DE GRABACIONES'),('19100','FABRICACIÓN DE PRODUCTOS DE HORNOS DE COQUE'),('19201','FABRICACIÓN DE COMBUSTIBLE'),('19202','FABRICACIÓN DE ACEITES Y LUBRICANTES'),('20111','FABRICACIÓN DE MATERIAS PRIMAS PARA LA FABRICACIÓN DE COLORANTES'),('20112','FABRICACIÓN DE MATERIALES CURTIENTES'),('20113','FABRICACIÓN DE GASES INDUSTRIALES'),('20114','FABRICACIÓN DE ALCOHOL ETÍ­LICO'),('20119','FABRICACIÓN DE SUSTANCIAS QUÍ­MICAS BÁSICAS'),('20120','FABRICACIÓN DE ABONOS Y FERTILIZANTES'),('20130','FABRICACIÓN DE PLÁSTICO Y CAUCHO EN FORMAS PRIMARIAS'),('20210','FABRICACIÓN DE PLAGUICIDAS Y OTROS PRODUCTOS QUÍ­MICOS DE USO AGROPECUARIO'),('20220','FABRICACIÓN DE PINTURAS, BARNICES Y PRODUCTOS DE REVESTIMIENTO SIMILARES; TINTAS DE IMPRENTA Y MASILLAS'),('20231','FABRICACIÓN DE JABONES, DETERGENTES Y SIMILARES PARA LIMPIEZA'),('20232','FABRICACIÓN DE PERFUMES, COSMÉTICOS Y PRODUCTOS DE HIGIENE Y CUIDADO PERSONAL, INCLUYENDO TINTES, CHAMPÚ, ETC.'),('20291','FABRICACIÓN DE TINTAS Y COLORES PARA ESCRIBIR Y PINTAR; FABRICACIÓN DE CINTAS PARA IMPRESORAS'),('20292','FABRICACIÓN DE PRODUCTOS PIROTÉCNICOS, EXPLOSIVOS Y MUNICIONES'),('20299','FABRICACIÓN DE PRODUCTOS QUÍ­MICOS N.C.P.'),('20300','FABRICACIÓN DE FIBRAS ARTIFICIALES'),('2100','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES'),('21001','MANUFACTURA DE PRODUCTOS FARMACÉUTICOS, SUSTANCIAS QUÍ­MICAS Y PRODUCTOS BOTÁNICOS'),('21008','MAQUILADO DE MEDICAMENTOS'),('2200','EXTRACCIÓN DE MADERA'),('22110','FABRICACIÓN DE CUBIERTAS Y CÁMARAS; RENOVACIÓN Y RECAUCHUTADO DE CUBIERTAS'),('22190','FABRICACIÓN DE OTROS PRODUCTOS DE CAUCHO'),('22201','FABRICACIÓN DE ENVASES PLÁSTICOS'),('22202','FABRICACIÓN DE PRODUCTOS PLÁSTICOS PARA USO PERSONAL O DOMÉSTICO'),('22208','MAQUILA DE PLÁSTICOS'),('22209','FABRICACIÓN DE PRODUCTOS PLÁSTICOS N.C.P.'),('2300','RECOLECCIÓN DE PRODUCTOS DIFERENTES A LA MADERA'),('23101','FABRICACIÓN DE VIDRIO'),('23102','FABRICACIÓN DE RECIPIENTES Y ENVASES DE VIDRIO'),('23108','SERVICIO DE MAQUILADO'),('23109','FABRICACIÓN DE PRODUCTOS DE VIDRIO NCP'),('23910','FABRICACIÓN DE PRODUCTOS REFRACTARIOS'),('23920','FABRICACIÓN DE PRODUCTOS DE ARCILLA PARA LA CONSTRUCCIÓN'),('23931','FABRICACIÓN DE PRODUCTOS DE CERÁMICA Y PORCELANA NO REFRACTARIA'),('23932','FABRICACIÓN DE PRODUCTOS DE CERÁMICA Y PORCELANA NCP'),('23940','FABRICACIÓN DE CEMENTO, CAL Y YESO'),('23950','FABRICACIÓN DE ARTÍ­CULOS DE HORMIGÓN, CEMENTO Y YESO'),('23960','CORTE, TALLADO Y ACABADO DE LA PIEDRA'),('23990','FABRICACIÓN DE PRODUCTOS MINERALES NO METÁLICOS NCP'),('2400','SERVICIOS DE APOYO A LA SILVICULTURA'),('24100','INDUSTRIAS BÁSICAS DE HIERRO Y ACERO'),('24200','FABRICACIÓN DE PRODUCTOS PRIMARIOS DE METALES PRECIOSOS Y METALES NO FERROSOS'),('24310','FUNDICIÓN DE HIERRO Y ACERO'),('24320','FUNDICIÓN DE METALES NO FERROSOS'),('25111','FABRICACIÓN DE PRODUCTOS METÁLICOS PARA USO ESTRUCTURAL'),('25118','SERVICIO DE MAQUILA PARA LA FABRICACIÓN DE ESTRUCTURAS METÁLICAS'),('25120','FABRICACIÓN DE TANQUES, DEPÓSITOS Y RECIPIENTES DE METAL'),('25130','FABRICACIÓN DE GENERADORES DE VAPOR, EXCEPTO CALDERAS DE AGUA CALIENTE  PARA CALEFACCIÓN CENTRAL'),('25200','FABRICACIÓN DE ARMAS Y MUNICIONES'),('25910','FORJADO, PRENSADO, ESTAMPADO Y LAMINADO DE METALES; PULVIMETALURGIA'),('25920','TRATAMIENTO Y REVESTIMIENTO DE METALES'),('25930','FABRICACIÓN DE ARTÍ­CULOS DE CUCHILLERÍ­A, HERRAMIENTAS DE MANO Y ARTÍ­CULOS DE FERRETERÍ­A'),('25991','FABRICACIÓN DE ENVASES Y ARTÍ­CULOS CONEXOS DE METAL'),('25992','FABRICACIÓN DE ARTÍ­CULOS METÁLICOS DE USO PERSONAL Y/O DOMÉSTICO'),('25999','FABRICACIÓN DE PRODUCTOS ELABORADOS DE METAL NCP'),('26100','FABRICACIÓN DE COMPONENTES ELECTRÓNICOS'),('26200','FABRICACIÓN DE COMPUTADORAS Y EQUIPO CONEXO'),('26300','FABRICACIÓN DE EQUIPO DE COMUNICACIONES'),('26400','FABRICACIÓN DE APARATOS  ELECTRÓNICOS DE CONSUMO PARA AUDIO, VIDEO RADIO Y TELEVISIÓN'),('26510','FABRICACIÓN DE INSTRUMENTOS Y APARATOS PARA MEDIR, VERIFICAR, ENSAYAR, NAVEGAR Y DE CONTROL DE PROCESOS INDUSTRIALES'),('26520','FABRICACIÓN DE RELOJES Y PIEZAS DE RELOJES'),('26600','FABRICACIÓN DE EQUIPO MÉDICO DE IRRADIACIÓN Y EQUIPO ELECTRÓNICO DE USO MÉDICO Y TERAPÉUTICO'),('26700','FABRICACIÓN DE INSTRUMENTOS DE ÓPTICA Y EQUIPO FOTOGRÁFICO'),('26800','FABRICACIÓN DE MEDIOS MAGNÉTICOS Y ÓPTICOS'),('27100','FABRICACIÓN DE MOTORES, GENERADORES , TRANSFORMADORES ELÉCTRICOS, APARATOS DE DISTRIBUCIÓN Y CONTROL DE ELECTRICIDAD'),('27200','FABRICACIÓN DE PILAS, BATERÍ­AS Y ACUMULADORES'),('27310','FABRICACIÓN DE CABLES DE FIBRA ÓPTICA'),('27320','FABRICACIÓN DE OTROS  HILOS Y CABLES ELÉCTRICOS'),('27330','FABRICACIÓN DE DISPOSITIVOS DE CABLEADOS'),('27400','FABRICACIÓN DE EQUIPO ELÉCTRICO DE ILUMINACIÓN'),('27500','FABRICACIÓN DE APARATOS DE USO DOMÉSTICO'),('27900','FABRICACIÓN DE OTROS TIPOS DE EQUIPO ELÉCTRICO'),('28110','FABRICACIÓN DE MOTORES Y TURBINAS, EXCEPTO MOTORES PARA AERONAVES, VEHÍ­CULOS AUTOMOTORES Y MOTOCICLETAS'),('28120','FABRICACIÓN DE EQUIPO HIDRÁULICO'),('28130','FABRICACIÓN DE OTRAS BOMBAS, COMPRESORES, GRIFOS Y VÁLVULAS'),('28140','FABRICACIÓN DE COJINETES, ENGRANAJES, TRENES DE ENGRANAJES Y PIEZAS DE TRANSMISIÓN'),('28150','FABRICACIÓN DE HORNOS Y QUEMADORES'),('28160','FABRICACIÓN DE EQUIPO DE ELEVACIÓN Y MANIPULACIÓN'),('28170','FABRICACIÓN DE MAQUINARIA Y EQUIPO DE OFICINA'),('28180','FABRICACIÓN DE HERRAMIENTAS MANUALES'),('28190','FABRICACIÓN DE OTROS TIPOS DE MAQUINARIA DE USO GENERAL'),('28210','FABRICACIÓN DE MAQUINARIA AGROPECUARIA Y FORESTAL'),('28220','FABRICACIÓN DE MÁQUINAS PARA CONFORMAR METALES Y MAQUINARIA HERRAMIENTA'),('28230','FABRICACIÓN DE MAQUINARIA METALÚRGICA'),('28240','FABRICACIÓN DE MAQUINARIA PARA LA EXPLOTACIÓN DE MINAS Y CANTERAS Y PARA OBRAS DE CONSTRUCCIÓN'),('28250','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE ALIMENTOS, BEBIDAS Y TABACO'),('28260','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CUEROS'),('28291','FABRICACIÓN DE MÁQUINAS PARA IMPRENTA'),('28299','FABRICACIÓN DE MAQUINARIA DE USO ESPECIAL NCP'),('29100','FABRICACIÓN VEHÍ­CULOS AUTOMOTORES'),('29200','FABRICACIÓN DE CARROCERÍ­AS PARA VEHÍ­CULOS AUTOMOTORES; FABRICACIÓN DE REMOLQUES Y SEMIREMOLQUES'),('29300','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍ­CULOS AUTOMOTORES'),('30110','FABRICACIÓN DE BUQUES'),('30120','CONSTRUCCIÓN Y REPARACIÓN DE EMBARCACIONES DE RECREO'),('30200','FABRICACIÓN DE LOCOMOTORAS Y DE MATERIAL RODANTE'),('30300','FABRICACIÓN DE AERONAVES Y NAVES ESPACIALES'),('30400','FABRICACIÓN DE VEHÍ­CULOS MILITARES DE COMBATE'),('30910','FABRICACIÓN DE MOTOCICLETAS'),('30920','FABRICACIÓN DE BICICLETAS Y SILLONES DE RUEDAS PARA INVÁLIDOS'),('30990','FABRICACIÓN DE EQUIPO DE TRANSPORTE NCP'),('31001','FABRICACIÓN DE COLCHONES Y SOMIER'),('31002','FABRICACIÓN DE MUEBLES Y OTROS PRODUCTOS DE MADERA A MEDIDA'),('31008','SERVICIOS DE MAQUILADO DE MUEBLES'),('31009','FABRICACIÓN DE MUEBLES NCP'),('3110','PESCA MARÍ­TIMA DE ALTURA Y COSTERA'),('3120','PESCA DE AGUA DULCE'),('3210','ACUICULTURA MARÍ­TIMA'),('32110','FABRICACIÓN DE JOYAS PLATERÍ­AS Y JOYERÍ­AS'),('32120','FABRICACIÓN DE JOYAS DE IMITACIÓN (FANTASÍ­A) Y ARTÍ­CULOS CONEXOS'),('3220','ACUICULTURA DE AGUA DULCE'),('32200','FABRICACIÓN DE INSTRUMENTOS MUSICALES'),('32301','FABRICACIÓN DE ARTÍ­CULOS DE DEPORTE'),('32308','SERVICIO DE MAQUILA DE PRODUCTOS DEPORTIVOS'),('32401','FABRICACIÓN DE JUEGOS DE MESA Y DE SALÓN'),('32402','SERVICIO DE MAQUILADO DE JUGUETES Y JUEGOS'),('32409','FABRICACIÓN DE JUEGOS Y JUGUETES N.C.P.'),('32500','FABRICACIÓN DE INSTRUMENTOS Y MATERIALES MÉDICOS Y ODONTOLÓGICOS'),('32901','FABRICACIÓN DE LÁPICES, BOLÍ­GRAFOS, SELLOS Y ARTÍ­CULOS DE LIBRERÍ­A EN GENERAL'),('32902','FABRICACIÓN DE ESCOBAS, CEPILLOS, PINCELES Y SIMILARES'),('32903','FABRICACIÓN DE ARTESANÍ­AS DE MATERIALES DIVERSOS'),('32904','FABRICACIÓN DE ARTÍ­CULOS DE USO PERSONAL Y DOMÉSTICOS N.C.P.'),('32905','FABRICACIÓN DE ACCESORIOS PARA LAS CONFECCIONES Y LA MARROQUINERÍ­A N.C.P.'),('32908','SERVICIOS DE MAQUILA NCP'),('32909','FABRICACIÓN DE PRODUCTOS MANUFACTURADOS N.C.P.'),('3300','SERVICIOS DE APOYO A LA PESCA Y ACUICULTURA'),('33110','REPARACIÓN Y MANTENIMIENTO DE PRODUCTOS ELABORADOS DE METAL'),('33120','REPARACIÓN Y MANTENIMIENTO DE MAQUINARIA'),('33130','REPARACIÓN Y MANTENIMIENTO DE EQUIPO ELECTRÓNICO Y ÓPTICO'),('33140','REPARACIÓN Y MANTENIMIENTO  DE EQUIPO ELÉCTRICO'),('33150','REPARACIÓN Y MANTENIMIENTO DE EQUIPO DE TRANSPORTE, EXCEPTO VEHÍ­CULOS AUTOMOTORES'),('33190','REPARACIÓN Y MANTENIMIENTO DE EQUIPOS N.C.P.'),('33200','INSTALACIÓN DE MAQUINARIA Y EQUIPO INDUSTRIAL'),('35101','GENERACIÓN DE ENERGÍ­A ELÉCTRICA'),('35102','TRANSMISIÓN DE ENERGÍ­A ELÉCTRICA'),('35103','DISTRIBUCIÓN DE ENERGÍ­A ELÉCTRICA'),('35200','FABRICACIÓN DE GAS, DISTRIBUCIÓN DE COMBUSTIBLES GASEOSOS POR TUBERÍ­AS'),('35300','SUMINISTRO DE VAPOR Y AGUA CALIENTE'),('36000','CAPTACIÓN, TRATAMIENTO Y SUMINISTRO DE AGUA'),('37000','EVACUACIÓN DE AGUAS RESIDUALES (ALCANTARILLADO)'),('38110','RECOLECCIÓN Y TRANSPORTE DE DESECHOS SÓLIDOS PROVENIENTE DE HOGARES Y  SECTOR URBANO'),('38120','RECOLECCIÓN DE DESECHOS PELIGROSOS'),('38210','TRATAMIENTO Y ELIMINACIÓN DE DESECHOS INICUOS'),('38220','TRATAMIENTO Y ELIMINACIÓN DE DESECHOS PELIGROSOS'),('38301','RECICLAJE DE DESPERDICIOS Y DESECHOS TEXTILES'),('38302','RECICLAJE DE DESPERDICIOS Y DESECHOS DE PLÁSTICO Y CAUCHO'),('38303','RECICLAJE DE DESPERDICIOS Y DESECHOS DE VIDRIO'),('38304','RECICLAJE DE DESPERDICIOS Y DESECHOS DE PAPEL Y CARTÓN'),('38305','RECICLAJE DE DESPERDICIOS Y DESECHOS METÁLICOS'),('38309','RECICLAJE DE DESPERDICIOS Y DESECHOS NO METÁLICOS  N.C.P.'),('39000','ACTIVIDADES DE SANEAMIENTO Y OTROS SERVICIOS DE GESTIÓN DE DESECHOS'),('41001','CONSTRUCCIÓN DE EDIFICIOS RESIDENCIALES'),('41002','CONSTRUCCIÓN DE EDIFICIOS NO RESIDENCIALES'),('42100','CONSTRUCCIÓN DE CARRETERAS, CALLES Y CAMINOS'),('42200','CONSTRUCCIÓN DE PROYECTOS DE SERVICIO PÚBLICO'),('42900','CONSTRUCCIÓN DE OBRAS DE INGENIERÍ­A CIVIL N.C.P.'),('43110','DEMOLICIÓN'),('43120','PREPARACIÓN DE TERRENO'),('43210','INSTALACIONES ELÉCTRICAS'),('43220','INSTALACIÓN DE FONTANERÍ­A, CALEFACCIÓN Y AIRE ACONDICIONADO'),('43290','OTRAS INSTALACIONES PARA OBRAS DE CONSTRUCCIÓN'),('43300','TERMINACIÓN Y ACABADO DE EDIFICIOS'),('43900','OTRAS ACTIVIDADES ESPECIALIZADAS DE CONSTRUCCIÓN'),('43901','FABRICACIÓN DE TECHOS Y MATERIALES DIVERSOS'),('45100','VENTA DE VEHÍ­CULOS AUTOMOTORES'),('45201','REPARACIÓN MECÁNICA DE VEHÍ­CULOS AUTOMOTORES'),('45202','REPARACIONES ELÉCTRICAS DEL AUTOMOTOR Y RECARGA DE BATERÍ­AS'),('45203','ENDEREZADO Y PINTURA DE VEHÍ­CULOS AUTOMOTORES'),('45204','REPARACIONES DE RADIADORES, ESCAPES Y SILENCIADORES'),('45205','REPARACIÓN Y RECONSTRUCCIÓN DE VÍ­AS, STOP Y OTROS ARTÍ­CULOS DE FIBRA DE VIDRIO'),('45206','REPARACIÓN DE LLANTAS DE VEHÍ­CULOS AUTOMOTORES'),('45207','POLARIZADO DE VEHÍ­CULOS (MEDIANTE LA ADHESIÓN DE PAPEL ESPECIAL A LOS VIDRIOS)'),('45208','LAVADO Y PASTEADO DE VEHÍ­CULOS (CARWASH)'),('45209','REPARACIONES DE VEHÍ­CULOS N.C.P.'),('45211','REMOLQUE DE VEHÍ­CULOS AUTOMOTORES'),('45301','VENTA DE PARTES, PIEZAS Y ACCESORIOS NUEVOS PARA VEHÍ­CULOS AUTOMOTORES'),('45302','VENTA DE PARTES, PIEZAS Y ACCESORIOS USADOS PARA VEHÍ­CULOS AUTOMOTORES'),('45401','VENTA DE MOTOCICLETAS'),('45402','VENTA DE REPUESTOS, PIEZAS Y ACCESORIOS DE MOTOCICLETAS'),('45403','MANTENIMIENTO Y REPARACIÓN  DE MOTOCICLETAS'),('46100','VENTA AL POR MAYOR A CAMBIO DE RETRIBUCIÓN O POR CONTRATA'),('46201','VENTA AL POR MAYOR DE MATERIAS PRIMAS AGRÍ­COLAS'),('46202','VENTA AL POR MAYOR DE PRODUCTOS DE LA SILVICULTURA'),('46203','VENTA AL POR MAYOR DE PRODUCTOS PECUARIOS Y DE GRANJA'),('46211','VENTA DE PRODUCTOS PARA USO AGROPECUARIO'),('46291','VENTA AL POR MAYOR DE GRANOS BÁSICOS (CEREALES, LEGUMINOSAS)'),('46292','VENTA  AL POR MAYOR DE SEMILLAS MEJORADAS PARA CULTIVO'),('46293','VENTA  AL POR MAYOR DE CAFÉ ORO Y UVA'),('46294','VENTA  AL POR MAYOR DE CAÑA DE AZÚCAR'),('46295','VENTA AL POR MAYOR DE FLORES, PLANTAS  Y OTROS PRODUCTOS NATURALES'),('46296','VENTA AL POR MAYOR DE PRODUCTOS AGRÍ­COLAS'),('46297','VENTA  AL POR MAYOR DE GANADO BOVINO (VIVO)'),('46298','VENTA AL POR MAYOR DE ANIMALES PORCINOS, OVINOS, CAPRINO, CANÍ­CULAS, APÍ­COLAS, AVÍ­COLAS VIVOS'),('46299','VENTA DE OTRAS ESPECIES VIVAS DEL REINO ANIMAL'),('46301','VENTA AL POR MAYOR DE ALIMENTOS'),('46302','VENTA AL POR MAYOR DE BEBIDAS'),('46303','VENTA AL POR MAYOR DE TABACO'),('46371','VENTA AL POR MAYOR DE FRUTAS, HORTALIZAS (VERDURAS), LEGUMBRES Y TUBÉRCULOS'),('46372','VENTA AL POR MAYOR DE POLLOS, GALLINAS DESTAZADAS, PAVOS Y OTRAS AVES'),('46373','VENTA AL POR MAYOR DE CARNE BOVINA Y PORCINA, PRODUCTOS DE CARNE Y EMBUTIDOS'),('46374','VENTA  AL POR MAYOR DE HUEVOS'),('46375','VENTA AL POR MAYOR DE PRODUCTOS LÁCTEOS'),('46376','VENTA AL POR MAYOR DE PRODUCTOS FARINÁCEOS DE PANADERÍ­A (PAN DULCE, CAKES, RESPOSTERÍ­A, ETC.)'),('46377','VENTA AL POR MAYOR DE PASTAS ALIMENTICIAS, ACEITES Y GRASAS COMESTIBLES VEGETAL Y ANIMAL'),('46378','VENTA AL POR MAYOR DE SAL COMESTIBLE'),('46379','VENTA AL POR MAYOR DE AZÚCAR'),('46391','VENTA AL POR MAYOR DE ABARROTES (VINOS, LICORES, PRODUCTOS ALIMENTICIOS ENVASADOS, ETC.)'),('46392','VENTA AL POR MAYOR DE AGUAS GASEOSAS'),('46393','VENTA AL POR MAYOR DE AGUA PURIFICADA'),('46394','VENTA AL POR MAYOR DE REFRESCOS Y OTRAS BEBIDAS, LÍ­QUIDAS O EN POLVO'),('46395','VENTA AL POR MAYOR DE CERVEZA Y LICORES'),('46396','VENTA AL POR MAYOR DE HIELO'),('46411','VENTA AL POR MAYOR DE HILADOS, TEJIDOS Y PRODUCTOS TEXTILES DE MERCERÍ­A'),('46412','VENTA AL POR MAYOR DE ARTÍ­CULOS TEXTILES EXCEPTO CONFECCIONES PARA EL HOGAR'),('46413','VENTA AL POR MAYOR DE CONFECCIONES TEXTILES PARA EL HOGAR'),('46414','VENTA AL POR MAYOR DE PRENDAS DE VESTIR Y ACCESORIOS DE VESTIR'),('46415','VENTA AL POR MAYOR DE ROPA USADA'),('46416','VENTA AL POR MAYOR DE CALZADO'),('46417','VENTA AL POR MAYOR DE ARTÍ­CULOS DE MARROQUINERÍ­A Y TALABARTERÍ­A'),('46418','VENTA AL POR MAYOR DE ARTÍ­CULOS DE PELETERÍ­A'),('46419','VENTA AL POR MAYOR DE OTROS ARTÍ­CULOS TEXTILES N.C.P.'),('46471','VENTA AL POR MAYOR DE INSTRUMENTOS MUSICALES'),('46472','VENTA AL POR MAYOR DE COLCHONES, ALMOHADAS, COJINES, ETC.'),('46473','VENTA AL POR MAYOR DE ARTÍ­CULOS DE ALUMINIO PARA EL HOGAR Y PARA OTROS USOS'),('46474','VENTA AL POR MAYOR DE DEPÓSITOS Y OTROS ARTÍ­CULOS PLÁSTICOS PARA EL HOGAR Y OTROS USOS, INCLUYENDO LOS DESECHABLES DE DURAPAX  Y NO DESECHABLES'),('46475','VENTA AL POR MAYOR DE CÁMARAS FOTOGRÁFICAS, ACCESORIOS Y MATERIALES'),('46482','VENTA AL POR MAYOR DE MEDICAMENTOS, ARTÍ­CULOS Y OTROS PRODUCTOS DE USO VETERINARIO'),('46483','VENTA AL POR MAYOR DE PRODUCTOS Y ARTÍ­CULOS DE BELLEZA  Y DE  USO PERSONAL'),('46484','VENTA DE PRODUCTOS FARMACÉUTICOS Y MEDICINALES'),('46491','VENTA AL POR MAYOR DE PRODUCTOS MEDICINALES, COSMÉTICOS, PERFUMERÍ­A Y PRODUCTOS DE LIMPIEZA'),('46492','VENTA AL POR MAYOR DE RELOJES Y ARTÍ­CULOS DE JOYERÍ­A'),('46493','VENTA AL POR MAYOR DE ELECTRODOMÉSTICOS Y ARTÍ­CULOS DEL HOGAR EXCEPTO BAZAR;  ARTÍ­CULOS DE ILUMINACIÓN'),('46494','VENTA AL POR MAYOR DE ARTÍ­CULOS DE BAZAR Y SIMILARES'),('46495','VENTA AL POR MAYOR DE ARTÍ­CULOS DE ÓPTICA'),('46496','VENTA AL POR MAYOR DE REVISTAS, PERIÓDICOS, LIBROS, ARTÍ­CULOS DE LIBRERÍ­A Y ARTÍ­CULOS DE PAPEL Y CARTÓN EN GENERAL'),('46497','VENTA DE ARTÍ­CULOS DEPORTIVOS, JUGUETES Y RODADOS'),('46498','VENTA AL POR MAYOR DE PRODUCTOS USADOS PARA EL HOGAR O EL USO PERSONAL'),('46499','VENTA AL POR MAYOR DE ENSERES DOMÉSTICOS Y DE USO PERSONAL N.C.P.'),('46500','VENTA AL POR MAYOR DE BICICLETAS, PARTES, ACCESORIOS Y OTROS'),('46510','VENTA AL POR MAYOR DE COMPUTADORAS, EQUIPO PERIFÉRICO Y PROGRAMAS INFORMÁTICOS'),('46520','VENTA AL POR MAYOR DE EQUIPOS DE COMUNICACIÓN'),('46530','VENTA AL POR MAYOR DE MAQUINARIA Y EQUIPO AGROPECUARIO, ACCESORIOS, PARTES Y SUMINISTROS'),('46590','VENTA DE EQUIPOS E INSTRUMENTOS DE USO PROFESIONAL Y CIENTÍ­FICO Y APARATOS DE MEDIDA Y CONTROL'),('46591','VENTA AL POR MAYOR DE MAQUINARIA EQUIPO, ACCESORIOS Y MATERIALES PARA LA INDUSTRIA DE LA MADERA Y  SUS  PRODUCTOS'),('46592','VENTA AL POR MAYOR DE MAQUINARIA,  EQUIPO, ACCESORIOS Y MATERIALES PARA LAS INDUSTRIA GRÁFICA Y DEL PAPEL, CARTÓN Y PRODUCTOS DE PAPEL Y CARTÓN'),('46593','VENTA AL POR MAYOR DE MAQUINARIA, EQUIPO, ACCESORIOS Y MATERIALES PARA LA  INDUSTRIA DE  PRODUCTOS QUÍ­MICOS, PLÁSTICO Y CAUCHO'),('46594','VENTA AL POR MAYOR DE MAQUINARIA, EQUIPO, ACCESORIOS Y MATERIALES PARA LA INDUSTRIA METÁLICA Y DE SUS PRODUCTOS'),('46595','VENTA AL POR MAYOR DE EQUIPAMIENTO PARA USO MÉDICO, ODONTOLÓGICO, VETERINARIO Y SERVICIOS CONEXOS'),('46596','VENTA AL POR MAYOR DE MAQUINARIA, EQUIPO, ACCESORIOS Y PARTES PARA LA INDUSTRIA DE LA ALIMENTACIÓN'),('46597','VENTA AL POR MAYOR DE MAQUINARIA, EQUIPO, ACCESORIOS Y PARTES PARA LA INDUSTRIA TEXTIL, CONFECCIONES Y CUERO'),('46598','VENTA AL POR MAYOR DE MAQUINARIA, EQUIPO Y ACCESORIOS PARA LA CONSTRUCCIÓN Y EXPLOTACIÓN DE MINAS Y CANTERAS'),('46599','VENTA AL POR MAYOR DE OTRO TIPO DE MAQUINARIA Y EQUIPO CON SUS ACCESORIOS Y PARTES'),('46610','VENTA AL POR MAYOR  DE OTROS COMBUSTIBLES SÓLIDOS, LÍ­QUIDOS, GASEOSOS Y DE PRODUCTOS CONEXOS'),('46612','VENTA AL POR MAYOR DE COMBUSTIBLES PARA AUTOMOTORES, AVIONES, BARCOS, MAQUINARIA  Y OTROS'),('46613','VENTA AL POR MAYOR DE LUBRICANTES, GRASAS Y  OTROS ACEITES PARA AUTOMOTORES, MAQUINARIA  INDUSTRIAL, ETC.'),('46614','VENTA AL POR MAYOR DE GAS PROPANO'),('46615','VENTA AL  POR MAYOR DE LEÑA Y CARBÓN'),('46620','VENTA AL POR MAYOR DE METALES Y MINERALES METALÍ­FEROS'),('46631','VENTA AL POR MAYOR DE PUERTAS, VENTANAS, VITRINAS Y SIMILARES'),('46632','VENTA AL POR MAYOR DE ARTÍ­CULOS DE FERRETERÍ­A Y PINTURERÍ­AS'),('46633','VIDRIERÍ­AS'),('46634','VENTA AL POR MAYOR DE MADERAS'),('46639','VENTA AL POR MAYOR DE MATERIALES PARA LA CONSTRUCCIÓN N.C.P.'),('46691','VENTA AL POR MAYOR DE SAL INDUSTRIAL SIN YODAR'),('46692','VENTA AL POR MAYOR DE PRODUCTOS INTERMEDIOS Y DESECHOS DE ORIGEN TEXTIL'),('46693','VENTA AL POR MAYOR DE PRODUCTOS INTERMEDIOS Y DESECHOS DE ORIGEN METÁLICO'),('46694','VENTA AL POR MAYOR DE PRODUCTOS INTERMEDIOS Y DESECHOS DE PAPEL Y CARTÓN'),('46695','VENTA AL POR MAYOR FERTILIZANTES, ABONOS, AGROQUÍ­MICOS Y PRODUCTOS SIMILARES'),('46696','VENTA AL POR MAYOR DE PRODUCTOS INTERMEDIOS Y DESECHOS DE ORIGEN PLÁSTICO'),('46697','VENTA AL POR MAYOR DE TINTAS PARA IMPRENTA, PRODUCTOS CURTIENTES Y MATERIAS Y PRODUCTOS COLORANTES'),('46698','VENTA DE PRODUCTOS INTERMEDIOS Y DESECHOS DE ORIGEN QUÍ­MICO Y DE CAUCHO'),('46699','VENTA AL POR MAYOR DE PRODUCTOS INTERMEDIOS Y DESECHOS NCP'),('46701','VENTA DE ALGODÓN EN ORO'),('46900','VENTA AL POR MAYOR DE OTROS PRODUCTOS'),('46901','VENTA AL POR MAYOR DE COHETES Y OTROS PRODUCTOS PIROTÉCNICOS'),('46902','VENTA AL POR MAYOR DE ARTÍ­CULOS DIVERSOS PARA CONSUMO HUMANO'),('46903','VENTA AL POR MAYOR DE ARMAS DE FUEGO, MUNICIONES Y ACCESORIOS'),('46904','VENTA AL POR MAYOR DE TOLDOS Y TIENDAS DE CAMPAÑA DE CUALQUIER MATERIAL'),('46905','VENTA AL POR MAYOR DE EXHIBIDORES PUBLICITARIOS Y RÓTULOS'),('46906','VENTA AL POR MAYOR DE ARTÍ­CULOS PROMOCIONALES  DIVERSOS'),('47111','VENTA EN SUPERMERCADOS'),('47112','VENTA EN TIENDAS DE ARTÍ­CULOS DE PRIMERA NECESIDAD'),('47119','ALMACENES (VENTA DE DIVERSOS ARTÍ­CULOS)'),('47190','VENTA AL POR MENOR DE OTROS PRODUCTOS EN COMERCIOS NO ESPECIALIZADOS'),('47199','VENTA DE ESTABLECIMIENTOS NO ESPECIALIZADOS CON SURTIDO COMPUESTO PRINCIPALMENTE DE ALIMENTOS, BEBIDAS Y TABACO'),('47211','VENTA AL POR MENOR  DE FRUTAS Y HORTALIZAS'),('47212','VENTA AL POR MENOR DE CARNES, EMBUTIDOS Y PRODUCTOS DE GRANJA'),('47213','VENTA AL POR MENOR DE PESCADO Y MARISCOS'),('47214','VENTA AL POR MENOR DE PRODUCTOS  LÁCTEOS'),('47215','VENTA AL POR MENOR DE PRODUCTOS DE PANADERÍ­A, REPOSTERÍ­A Y GALLETAS'),('47216','VENTA AL POR MENOR DE HUEVOS'),('47217','VENTA AL POR MENOR DE CARNES Y PRODUCTOS CÁRNICOS'),('47218','VENTA AL POR MENOR  DE GRANOS BÁSICOS Y OTROS'),('47219','VENTA AL POR MENOR DE ALIMENTOS N.C.P.'),('47221','VENTA AL POR MENOR DE HIELO'),('47223','VENTA DE BEBIDAS NO ALCOHÓLICAS, PARA SU CONSUMO FUERA DEL ESTABLECIMIENTO'),('47224','VENTA DE BEBIDAS ALCOHÓLICAS, PARA SU CONSUMO FUERA DEL ESTABLECIMIENTO'),('47225','VENTA DE BEBIDAS ALCOHÓLICAS PARA SU CONSUMO DENTRO DEL ESTABLECIMIENTO'),('47230','VENTA AL POR MENOR DE TABACO'),('47300','VENTA DE COMBUSTIBLES, LUBRICANTES Y OTROS (GASOLINERAS)'),('47411','VENTA AL POR MENOR DE COMPUTADORAS Y EQUIPO PERIFÉRICO'),('47412','VENTA DE EQUIPO Y ACCESORIOS DE TELECOMUNICACIÓN'),('47420','VENTA AL POR MENOR DE EQUIPO DE AUDIO Y VIDEO'),('47510','VENTA AL POR MENOR DE HILADOS, TEJIDOS Y PRODUCTOS TEXTILES DE MERCERÍ­A; CONFECCIONES PARA EL HOGAR Y TEXTILES N.C.P.'),('47521','VENTA AL POR MENOR DE PRODUCTOS DE MADERA'),('47522','VENTA AL POR MENOR DE ARTÍ­CULOS DE FERRETERÍ­A'),('47523','VENTA AL POR MENOR DE PRODUCTOS DE PINTURERÍ­AS'),('47524','VENTA AL POR MENOR EN VIDRIERÍ­AS'),('47529','VENTA AL POR MENOR DE MATERIALES DE CONSTRUCCIÓN Y ARTÍ­CULOS CONEXOS'),('47530','VENTA AL POR MENOR DE TAPICES, ALFOMBRAS Y REVESTIMIENTOS DE PAREDES Y PISOS EN COMERCIOS  ESPECIALIZADOS'),('47591','VENTA AL POR MENOR DE MUEBLES'),('47592','VENTA AL POR MENOR DE ARTÍ­CULOS DE BAZAR'),('47593','VENTA AL POR MENOR DE APARATOS ELECTRODOMÉSTICOS, REPUESTOS Y ACCESORIOS'),('47594','VENTA AL POR MENOR DE ARTÍ­CULOS ELÉCTRICOS Y DE ILUMINACIÓN'),('47598','VENTA AL POR MENOR DE INSTRUMENTOS MUSICALES'),('47610','VENTA AL POR MENOR DE LIBROS, PERIÓDICOS Y ARTÍ­CULOS DE PAPELERÍ­A EN COMERCIOS ESPECIALIZADOS'),('47620','VENTA AL POR MENOR DE DISCOS LÁSER, CASSETTES, CINTAS DE VIDEO Y OTROS'),('47630','VENTA AL POR MENOR DE PRODUCTOS Y EQUIPOS DE DEPORTE'),('47631','VENTA AL POR MENOR DE BICICLETAS, ACCESORIOS Y REPUESTOS'),('47640','VENTA AL POR MENOR DE JUEGOS Y JUGUETES  EN COMERCIOS ESPECIALIZADOS'),('47711','VENTA AL POR MENOR DE PRENDAS DE VESTIR Y ACCESORIOS DE VESTIR'),('47712','VENTA AL POR MENOR DE CALZADO'),('47713','VENTA AL POR MENOR DE ARTÍ­CULOS DE PELETERÍ­A, MARROQUINERÍ­A Y TALABARTERÍ­A'),('47721','VENTA AL POR MENOR DE MEDICAMENTOS FARMACÉUTICOS Y OTROS MATERIALES Y ARTÍ­CULOS DE USO MÉDICO, ODONTOLÓGICO Y VETERINARIO'),('47722','VENTA AL POR MENOR DE PRODUCTOS COSMÉTICOS Y DE TOCADOR'),('47731','VENTA AL POR MENOR DE PRODUCTOS DE JOYERÍ­A, BISUTERÍ­A, ÓPTICA, RELOJERÍ­A'),('47732','VENTA AL POR MENOR DE PLANTAS, SEMILLAS, ANIMALES Y ARTÍ­CULOS CONEXOS'),('47733','VENTA AL POR MENOR DE COMBUSTIBLES DE USO DOMÉSTICO (GAS PROPANO Y GAS LICUADO)'),('47734','VENTA AL POR MENOR DE ARTESANÍ­AS, ARTÍ­CULOS CERÁMICOS Y RECUERDOS EN GENERAL'),('47735','VENTA AL POR MENOR DE ATAÚDES, LÁPIDAS Y CRUCES, TROFEOS, ARTÍ­CULOS RELIGIOSOS EN GENERAL'),('47736','VENTA AL POR MENOR DE ARMAS DE FUEGO, MUNICIONES Y ACCESORIOS'),('47737','VENTA AL POR MENOR DE ARTÍ­CULOS DE COHETERÍ­A Y PIROTÉCNICOS'),('47738','VENTA AL POR MENOR DE ARTÍ­CULOS DESECHABLES DE USO PERSONAL Y DOMÉSTICO (SERVILLETAS, PAPEL HIGIÉNICO, PAÑALES, TOALLAS SANITARIAS, ETC.)'),('47739','VENTA AL POR MENOR DE OTROS PRODUCTOS  N.C.P.'),('47741','VENTA AL POR MENOR DE ARTÍ­CULOS USADOS'),('47742','VENTA AL POR MENOR DE TEXTILES Y CONFECCIONES USADOS'),('47743','VENTA AL POR MENOR DE LIBROS, REVISTAS, PAPEL Y CARTÓN USADOS'),('47749','VENTA AL POR MENOR DE PRODUCTOS USADOS N.C.P.'),('47811','VENTA AL POR MENOR DE FRUTAS, VERDURAS Y HORTALIZAS'),('47814','VENTA AL POR MENOR DE PRODUCTOS LÁCTEOS'),('47815','VENTA AL POR MENOR DE PRODUCTOS DE PANADERÍ­A, GALLETAS Y SIMILARES'),('47816','VENTA AL POR MENOR DE BEBIDAS'),('47818','VENTA AL POR MENOR EN TIENDAS DE MERCADO Y PUESTOS'),('47821','VENTA AL POR MENOR DE HILADOS, TEJIDOS Y PRODUCTOS TEXTILES DE MERCERÍ­A EN PUESTOS DE MERCADOS Y FERIAS'),('47822','VENTA AL POR MENOR DE ARTÍ­CULOS TEXTILES EXCEPTO CONFECCIONES PARA EL HOGAR EN PUESTOS DE MERCADOS Y FERIAS'),('47823','VENTA AL POR MENOR DE CONFECCIONES TEXTILES PARA EL HOGAR EN PUESTOS DE MERCADOS Y FERIAS'),('47824','VENTA AL POR MENOR DE PRENDAS DE VESTIR, ACCESORIOS DE VESTIR Y SIMILARES EN PUESTOS DE MERCADOS Y FERIAS'),('47825','VENTA AL POR MENOR DE ROPA USADA'),('47826','VENTA AL POR MENOR DE CALZADO, ARTÍ­CULOS DE MARROQUINERÍ­A Y TALABARTERÍ­A EN PUESTOS DE MERCADOS Y FERIAS'),('47827','VENTA AL POR MENOR DE ARTÍ­CULOS DE MARROQUINERÍ­A Y TALABARTERÍ­A EN PUESTOS DE MERCADOS Y FERIAS'),('47829','VENTA AL POR MENOR DE ARTÍ­CULOS TEXTILES NCP EN PUESTOS DE MERCADOS Y FERIAS'),('47891','VENTA AL POR MENOR DE ANIMALES, FLORES Y PRODUCTOS CONEXOS EN PUESTOS DE FERIA Y MERCADOS'),('47892','VENTA AL POR MENOR DE PRODUCTOS MEDICINALES, COSMÉTICOS, DE TOCADOR Y DE LIMPIEZA EN PUESTOS DE FERIAS Y MERCADOS'),('47893','VENTA AL POR MENOR DE ARTÍ­CULOS DE BAZAR EN PUESTOS DE FERIAS Y MERCADOS'),('47894','VENTA AL POR MENOR DE ARTÍ­CULOS DE PAPEL, ENVASES, LIBROS, REVISTAS Y CONEXOS EN PUESTOS DE FERIA Y MERCADOS'),('47895','VENTA AL POR MENOR DE MATERIALES DE CONSTRUCCIÓN, ELECTRODOMÉSTICOS, ACCESORIOS PARA AUTOS Y SIMILARES EN PUESTOS DE FERIA Y MERCADOS'),('47896','VENTA AL POR MENOR DE EQUIPOS ACCESORIOS PARA LAS COMUNICACIONES EN PUESTOS DE FERIA Y MERCADOS'),('47899','VENTA AL POR MENOR EN PUESTOS DE FERIAS Y MERCADOS N.C.P.'),('47910','VENTA AL POR MENOR POR CORREO O INTERNET'),('47990','OTROS TIPOS DE VENTA AL POR MENOR NO REALIZADA, EN ALMACENES, PUESTOS DE VENTA O MERCADO'),('49110','TRANSPORTE INTERURBANO DE PASAJEROS  POR FERROCARRIL'),('49120','TRANSPORTE DE CARGA POR FERROCARRIL'),('49211','TRANSPORTE DE PASAJEROS URBANOS E INTERURBANO MEDIANTE BUSES'),('49212','TRANSPORTE DE PASAJEROS INTERDEPARTAMENTAL MEDIANTE MICROBUSES'),('49213','TRANSPORTE DE PASAJEROS URBANOS E INTERURBANO MEDIANTE MICROBUSES'),('49214','TRANSPORTE DE PASAJEROS INTERDEPARTAMENTAL MEDIANTE BUSES'),('49221','TRANSPORTE INTERNACIONAL DE PASAJEROS'),('49222','TRANSPORTE DE PASAJEROS MEDIANTE TAXIS Y AUTOS CON CHOFER'),('49223','TRANSPORTE ESCOLAR'),('49225','TRANSPORTE DE PASAJEROS PARA EXCURSIONES'),('49226','SERVICIOS DE TRANSPORTE DE PERSONAL'),('49229','TRANSPORTE DE PASAJEROS POR VÍ­A TERRESTRE NCP'),('49231','TRANSPORTE DE CARGA URBANO'),('49232','TRANSPORTE NACIONAL DE CARGA'),('49233','TRANSPORTE DE CARGA  INTERNACIONAL'),('49234','SERVICIOS DE  MUDANZA'),('49235','ALQUILER DE VEHÍ­CULOS DE CARGA CON CONDUCTOR'),('49300','TRANSPORTE POR OLEODUCTO O GASODUCTO'),('50110','TRANSPORTE DE PASAJEROS MARÍ­TIMO Y DE CABOTAJE'),('50120','TRANSPORTE DE CARGA MARÍ­TIMO Y DE CABOTAJE'),('50211','TRANSPORTE DE PASAJEROS POR VÍ­AS DE NAVEGACIÓN INTERIORES'),('50212','ALQUILER DE EQUIPO DE TRANSPORTE DE PASAJEROS POR VÍ­AS DE NAVEGACIÓN INTERIOR CON CONDUCTOR'),('50220','TRANSPORTE DE CARGA POR VÍ­AS DE NAVEGACIÓN INTERIORES'),('5100','EXTRACCIÓN DE HULLA'),('51100','TRANSPORTE AÉREO DE PASAJEROS'),('51201','TRANSPORTE DE CARGA POR VÍ­A AÉREA'),('51202','ALQUILER DE EQUIPO DE AEROTRANSPORTE  CON OPERADORES PARA EL PROPÓSITO DE TRANSPORTAR CARGA'),('5200','EXTRACCIÓN Y AGLOMERACIÓN DE LIGNITO'),('52101','ALQUILER DE INSTALACIONES DE ALMACENAMIENTO EN ZONAS FRANCAS'),('52102','ALQUILER DE SILOS PARA CONSERVACIÓN Y ALMACENAMIENTO DE GRANOS'),('52103','ALQUILER DE INSTALACIONES CON REFRIGERACIÓN PARA ALMACENAMIENTO Y CONSERVACIÓN DE ALIMENTOS Y OTROS PRODUCTOS'),('52109','ALQUILER DE BODEGAS PARA ALMACENAMIENTO Y DEPÓSITO N.C.P.'),('52211','SERVICIO DE GARAJE Y ESTACIONAMIENTO'),('52212','SERVICIOS DE TERMINALES PARA EL TRANSPORTE POR VÍ­A TERRESTRE'),('52219','SERVICIOS PARA EL TRANSPORTE POR VÍ­A TERRESTRE N.C.P.'),('52220','SERVICIOS PARA EL TRANSPORTE ACUÁTICO'),('52230','SERVICIOS PARA EL TRANSPORTE AÉREO'),('52240','MANIPULACIÓN DE CARGA'),('52290','SERVICIOS PARA EL TRANSPORTE NCP'),('52291','AGENCIAS DE TRAMITACIONES ADUANALES'),('53100','SERVICIOS DE  CORREO NACIONAL'),('53200','ACTIVIDADES DE CORREO DISTINTAS A LAS ACTIVIDADES POSTALES NACIONALES'),('53201','AGENCIA PRIVADA DE CORREO Y ENCOMIENDAS'),('55101','ACTIVIDADES DE ALOJAMIENTO PARA ESTANCIAS CORTAS'),('55102','HOTELES'),('55200','ACTIVIDADES DE CAMPAMENTOS, PARQUES DE VEHÍ­CULOS DE RECREO Y PARQUES DE CARAVANAS'),('55900','ALOJAMIENTO N.C.P.'),('56101','RESTAURANTES'),('56106','PUPUSERÍ­A'),('56107','ACTIVIDADES VARIAS DE RESTAURANTES'),('56108','COMEDORES'),('56109','MERENDEROS AMBULANTES'),('56210','PREPARACIÓN DE COMIDA PARA EVENTOS ESPECIALES'),('56291','SERVICIOS DE PROVISIÓN DE COMIDAS POR CONTRATO'),('56292','SERVICIOS DE CONCESIÓN DE CAFETINES Y CHALET EN EMPRESAS E INSTITUCIONES'),('56299','SERVICIOS DE PREPARACIÓN DE COMIDAS NCP'),('56301','SERVICIO DE EXPENDIO DE BEBIDAS EN SALONES Y BARES'),('56302','SERVICIO DE EXPENDIO DE BEBIDAS EN PUESTOS CALLEJEROS, MERCADOS Y FERIAS'),('58110','EDICIÓN DE LIBROS, FOLLETOS, PARTITURAS Y OTRAS EDICIONES DISTINTAS A ESTAS'),('58120','EDICIÓN DE DIRECTORIOS Y LISTAS DE CORREOS'),('58130','EDICIÓN DE PERIÓDICOS, REVISTAS Y OTRAS PUBLICACIONES PERIÓDICAS'),('58190','OTRAS ACTIVIDADES DE EDICIÓN'),('58200','EDICIÓN DE PROGRAMAS INFORMÁTICOS (SOFTWARE)'),('59110','ACTIVIDADES DE PRODUCCIÓN CINEMATOGRÁFICA'),('59120','ACTIVIDADES DE POST PRODUCCIÓN DE PELÍ­CULAS, VIDEOS Y PROGRAMAS  DE TELEVISIÓN'),('59130','ACTIVIDADES DE DISTRIBUCIÓN DE PELÍ­CULAS CINEMATOGRÁFICAS, VIDEOS Y PROGRAMAS DE TELEVISIÓN'),('59140','ACTIVIDADES DE EXHIBICIÓN DE PELÍ­CULAS CINEMATOGRÁFICAS Y CINTAS DE VÍ­DEO'),('59200','ACTIVIDADES DE EDICIÓN Y GRABACIÓN DE MÚSICA'),('60100','SERVICIOS DE DIFUSIONES DE RADIO'),('60201','ACTIVIDADES DE PROGRAMACIÓN Y DIFUSIÓN DE TELEVISIÓN ABIERTA'),('60202','ACTIVIDADES DE SUSCRIPCIÓN Y DIFUSIÓN DE TELEVISIÓN POR CABLE Y/O SUSCRIPCIÓN'),('60299','SERVICIOS DE TELEVISIÓN, INCLUYE TELEVISIÓN POR CABLE'),('60900','PROGRAMACIÓN Y TRANSMISIÓN DE RADIO Y TELEVISIÓN'),('6100','EXTRACCIÓN DE PETRÓLEO CRUDO'),('61101','SERVICIO DE TELEFONÍ­A'),('61102','SERVICIO DE INTERNET '),('61103','SERVICIO DE TELEFONÍ­A FIJA'),('61109','SERVICIO DE INTERNET N.C.P.'),('61201','SERVICIOS DE TELEFONÍ­A CELULAR'),('61202','SERVICIOS DE INTERNET INALÁMBRICO'),('61209','SERVICIOS DE TELECOMUNICACIONES INALÁMBRICO N.C.P.'),('61301','TELECOMUNICACIONES SATELITALES'),('61309','COMUNICACIÓN VÍ­A SATÉLITE N.C.P.'),('61900','ACTIVIDADES DE TELECOMUNICACIÓN N.C.P.'),('6200','EXTRACCIÓN DE GAS NATURAL'),('62010','PROGRAMACIÓN INFORMÁTICA'),('62020','CONSULTORÍ­AS Y GESTIÓN DE SERVICIOS INFORMÁTICOS'),('62090','OTRAS ACTIVIDADES DE TECNOLOGÍ­A DE INFORMACIÓN Y SERVICIOS DE COMPUTADORA'),('63110','PROCESAMIENTO DE DATOS Y ACTIVIDADES RELACIONADAS'),('63120','PORTALES WEB'),('63910','SERVICIOS DE AGENCIAS DE NOTICIAS'),('63990','OTROS SERVICIOS DE INFORMACIÓN  N.C.P.'),('64110','SERVICIOS PROVISTOS POR EL BANCO CENTRAL DE EL SALVADOR'),('64190','BANCOS'),('64192','ENTIDADES DEDICADAS AL ENVÍ­O DE REMESAS'),('64199','OTRAS ENTIDADES FINANCIERAS'),('64200','ACTIVIDADES DE SOCIEDADES DE CARTERA'),('64300','FIDEICOMISOS, FONDOS Y OTRAS FUENTES DE FINANCIAMIENTO'),('64910','ARRENDAMIENTO FINANCIEROS'),('64920','ASOCIACIONES COOPERATIVAS DE AHORRO Y CRÉDITO DEDICADAS A LA INTERMEDIACIÓN FINANCIERA'),('64921','INSTITUCIONES EMISORAS DE TARJETAS DE CRÉDITO Y OTROS'),('64922','TIPOS DE CRÉDITO NCP'),('64928','PRESTAMISTAS Y CASAS DE EMPEÑO'),('64990','ACTIVIDADES DE SERVICIOS FINANCIEROS, EXCEPTO LA FINANCIACIÓN DE PLANES DE SEGUROS Y DE PENSIONES N.C.P.'),('65110','PLANES DE SEGUROS DE VIDA'),('65120','PLANES DE SEGURO EXCEPTO DE VIDA'),('65199','SEGUROS GENERALES DE TODO TIPO'),('65200','PLANES SE SEGURO'),('65300','PLANES DE PENSIONES'),('66110','ADMINISTRACIÓN DE MERCADOS FINANCIEROS (BOLSA DE VALORES)'),('66120','ACTIVIDADES BURSÁTILES (CORREDORES DE BOLSA)'),('66190','ACTIVIDADES AUXILIARES DE LA INTERMEDIACIÓN FINANCIERA NCP'),('66210','EVALUACIÓN DE RIESGOS Y DAÑOS'),('66220','ACTIVIDADES DE AGENTES Y CORREDORES DE SEGUROS'),('66290','OTRAS ACTIVIDADES AUXILIARES DE SEGUROS Y FONDOS DE PENSIONES'),('66300','ACTIVIDADES DE ADMINISTRACIÓN DE FONDOS'),('68101','SERVICIO DE ALQUILER Y VENTA DE LOTES EN CEMENTERIOS'),('68109','ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS N.C.P.'),('68200','ACTIVIDADES INMOBILIARIAS REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATA'),('69100','ACTIVIDADES JURÍ­DICAS'),('69200','ACTIVIDADES DE CONTABILIDAD, TENEDURÍ­A DE LIBROS Y AUDITORÍ­A; ASESORAMIENTO EN MATERIA DE IMPUESTOS'),('70100','ACTIVIDADES DE OFICINAS CENTRALES DE SOCIEDADES DE CARTERA'),('70200','ACTIVIDADES DE CONSULTORÍ­A EN GESTIÓN EMPRESARIAL'),('7100','EXTRACCIÓN DE MINERALES  DE HIERRO'),('71101','SERVICIOS DE ARQUITECTURA Y PLANIFICACIÓN URBANA Y SERVICIOS CONEXOS'),('71102','SERVICIOS DE INGENIERÍ­A'),('71103','SERVICIOS DE AGRIMENSURA, TOPOGRAFÍ­A, CARTOGRAFÍ­A, PROSPECCIÓN Y GEOFÍ­SICA Y SERVICIOS CONEXOS'),('71200','ENSAYOS Y ANÁLISIS TÉCNICOS'),('7210','EXTRACCIÓN DE MINERALES DE URANIO Y TORIO'),('72100','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS NATURALES Y LA INGENIERÍ­A'),('72199','INVESTIGACIONES CIENTÍ­FICAS'),('72200','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS SOCIALES Y LAS HUMANIDADES CIENTÍ­FICA Y DESARROLLO'),('7290','EXTRACCIÓN DE MINERALES METALÍ­FEROS NO FERROSOS'),('73100','PUBLICIDAD'),('73200','INVESTIGACIÓN DE MERCADOS Y REALIZACIÓN DE ENCUESTAS DE OPINIÓN PÚBLICA'),('74100','ACTIVIDADES DE DISEÑO ESPECIALIZADO'),('74200','ACTIVIDADES DE FOTOGRAFÍ­A'),('74900','SERVICIOS PROFESIONALES Y CIENTÍ­FICOS NCP'),('75000','ACTIVIDADES VETERINARIAS'),('77101','ALQUILER DE EQUIPO DE TRANSPORTE TERRESTRE'),('77102','ALQUILER DE EQUIPO DE TRANSPORTE ACUÁTICO'),('77103','ALQUILER DE EQUIPO DE TRANSPORTE  POR VÍ­A AÉREA'),('77210','ALQUILER Y ARRENDAMIENTO DE EQUIPO DE RECREO Y DEPORTIVO'),('77220','ALQUILER DE CINTAS DE VIDEO Y DISCOS'),('77290','ALQUILER DE OTROS EFECTOS PERSONALES Y ENSERES DOMÉSTICOS'),('77300','ALQUILER DE MAQUINARIA Y EQUIPO'),('77400','ARRENDAMIENTO DE PRODUCTOS DE PROPIEDAD INTELECTUAL'),('78100','OBTENCIÓN Y DOTACIÓN DE PERSONAL'),('78200','ACTIVIDADES DE LAS AGENCIAS DE TRABAJO TEMPORAL'),('78300','DOTACIÓN DE RECURSOS HUMANOS Y GESTIÓN; GESTIÓN DE LAS FUNCIONES DE RECURSOS HUMANOS'),('79110','ACTIVIDADES DE AGENCIAS DE VIAJES Y ORGANIZADORES DE VIAJES; ACTIVIDADES DE ASISTENCIA A TURISTAS'),('79120','ACTIVIDADES DE LOS OPERADORES TURÍ­STICOS'),('79900','OTROS SERVICIOS DE RESERVAS Y ACTIVIDADES RELACIONADAS'),('80100','SERVICIOS DE SEGURIDAD PRIVADOS'),('80201','ACTIVIDADES DE SERVICIOS DE SISTEMAS DE SEGURIDAD'),('80202','ACTIVIDADES PARA LA PRESTACIÓN DE SISTEMAS DE SEGURIDAD'),('80300','ACTIVIDADES DE INVESTIGACIÓN'),('8100','EXTRACCIÓN DE PIEDRA, ARENA Y ARCILLA'),('81100','ACTIVIDADES COMBINADAS DE MANTENIMIENTO DE EDIFICIOS E INSTALACIONES'),('81210','LIMPIEZA GENERAL DE EDIFICIOS'),('81290','OTRAS ACTIVIDADES COMBINADAS DE MANTENIMIENTO DE EDIFICIOS E INSTALACIONES NCP'),('81300','SERVICIO DE JARDINERÍ­A'),('82110','SERVICIOS ADMINISTRATIVOS DE OFICINAS'),('82190','SERVICIO DE FOTOCOPIADO Y SIMILARES, EXCEPTO EN IMPRENTAS'),('82200','ACTIVIDADES DE LAS CENTRALES DE LLAMADAS (CALL CENTER)'),('82300','ORGANIZACIÓN DE CONVENCIONES Y FERIAS DE NEGOCIOS'),('82910','ACTIVIDADES DE AGENCIAS DE COBRO Y OFICINAS DE CRÉDITO'),('82921','SERVICIOS DE ENVASE Y EMPAQUE DE PRODUCTOS ALIMENTICIOS'),('82922','SERVICIOS DE ENVASE Y EMPAQUE DE PRODUCTOS MEDICINALES'),('82929','SERVICIO DE ENVASE Y EMPAQUE NCP'),('82990','ACTIVIDADES DE APOYO EMPRESARIALES NCP'),('84110','ACTIVIDADES DE LA ADMINISTRACIÓN PÚBLICA EN GENERAL'),('84111','ALCALDÍ­AS MUNICIPALES'),('84120','REGULACIÓN DE LAS ACTIVIDADES DE PRESTACIÓN DE SERVICIOS SANITARIOS, EDUCATIVOS, CULTURALES Y OTROS SERVICIOS SOCIALES, EXCEPTO SEGURIDAD SOCIAL'),('84130','REGULACIÓN Y FACILITACIÓN DE LA ACTIVIDAD ECONÓMICA'),('84210','ACTIVIDADES DE ADMINISTRACIÓN Y FUNCIONAMIENTO DEL MINISTERIO DE RELACIONES EXTERIORES'),('84220','ACTIVIDADES DE DEFENSA'),('84230','ACTIVIDADES DE MANTENIMIENTO DEL ORDEN PÚBLICO Y DE SEGURIDAD'),('84300','ACTIVIDADES DE PLANES DE SEGURIDAD SOCIAL DE AFILIACIÓN OBLIGATORIA'),('85101','GUARDERÍ­A EDUCATIVA'),('85102','ENSEÑANZA PREESCOLAR O PARVULARIA'),('85103','ENSEÑANZA PRIMARIA'),('85104','SERVICIO DE EDUCACIÓN PREESCOLAR Y PRIMARIA INTEGRADA'),('85211','ENSEÑANZA SECUNDARIA TERCER CICLO (7Â°, 8Â° Y 9Â° )'),('85212','ENSEÑANZA SECUNDARIA  DE FORMACIÓN GENERAL  BACHILLERATO'),('85221','ENSEÑANZA SECUNDARIA DE FORMACIÓN TÉCNICA Y PROFESIONAL'),('85222','ENSEÑANZA SECUNDARIA DE FORMACIÓN TÉCNICA Y PROFESIONAL INTEGRADA CON ENSEÑANZA PRIMARIA'),('85301','ENSEÑANZA SUPERIOR UNIVERSITARIA'),('85302','ENSEÑANZA SUPERIOR NO UNIVERSITARIA'),('85303','ENSEÑANZA SUPERIOR INTEGRADA A EDUCACIÓN SECUNDARIA Y/O PRIMARIA'),('85410','EDUCACIÓN DEPORTIVA Y RECREATIVA'),('85420','EDUCACIÓN CULTURAL'),('85490','OTROS TIPOS DE ENSEÑANZA N.C.P.'),('85499','ENSEÑANZA FORMAL'),('85500','SERVICIOS DE APOYO A LA ENSEÑANZA'),('86100','ACTIVIDADES DE HOSPITALES'),('86201','CLÍ­NICAS MÉDICAS'),('86202','SERVICIOS DE ODONTOLOGÍ­A'),('86203','SERVICIOS MÉDICOS'),('86901','SERVICIOS DE ANÁLISIS Y ESTUDIOS DE DIAGNÓSTICO'),('86902','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA'),('86909','OTROS SERVICIO RELACIONADOS CON LA SALUD NCP'),('87100','RESIDENCIAS DE ANCIANOS CON ATENCIÓN DE ENFERMERÍ­A'),('87200','INSTITUCIONES DEDICADAS AL TRATAMIENTO DEL RETRASO MENTAL, PROBLEMAS DE SALUD MENTAL Y EL USO INDEBIDO DE SUSTANCIAS NOCIVAS'),('87300','INSTITUCIONES DEDICADAS AL CUIDADO DE ANCIANOS Y DISCAPACITADOS'),('87900','ACTIVIDADES DE ASISTENCIA A NIÑOS Y JÓVENES'),('87901','OTRAS ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES'),('88100','ACTIVIDADES DE ASISTENCIA SOCIALES SIN ALOJAMIENTO PARA ANCIANOS Y DISCAPACITADOS'),('88900','SERVICIOS SOCIALES SIN ALOJAMIENTO NCP'),('8910','EXTRACCIÓN DE MINERALES PARA LA FABRICACIÓN DE ABONOS Y PRODUCTOS QUÍ­MICOS'),('8920','EXTRACCIÓN Y AGLOMERACIÓN DE TURBA'),('8930','EXTRACCIÓN DE SAL'),('8990','EXPLOTACIÓN DE OTRAS MINAS Y CANTERAS NCP'),('90000','ACTIVIDADES CREATIVAS ARTÍ­STICAS Y DE ESPARCIMIENTO'),('9100','ACTIVIDADES DE APOYO A LA EXTRACCIÓN DE PETRÓLEO Y GAS NATURAL'),('91010','ACTIVIDADES DE BIBLIOTECAS Y ARCHIVOS'),('91020','ACTIVIDADES DE MUSEOS Y PRESERVACIÓN DE LUGARES Y EDIFICIOS HISTÓRICOS'),('91030','ACTIVIDADES DE JARDINES BOTÁNICOS, ZOOLÓGICOS Y DE RESERVAS NATURALES'),('92000','ACTIVIDADES DE JUEGOS Y APUESTAS'),('93110','GESTIÓN DE INSTALACIONES DEPORTIVAS'),('93120','ACTIVIDADES DE CLUBES DEPORTIVOS'),('93190','OTRAS ACTIVIDADES DEPORTIVAS'),('93210','ACTIVIDADES DE PARQUES DE ATRACCIONES Y PARQUES TEMÁTICOS'),('93291','DISCOTECAS Y SALAS DE BAILE'),('93298','CENTROS VACACIONALES'),('93299','ACTIVIDADES DE ESPARCIMIENTO NCP'),('94110','ACTIVIDADES DE ORGANIZACIONES EMPRESARIALES Y DE EMPLEADORES'),('94120','ACTIVIDADES DE ORGANIZACIONES PROFESIONALES'),('94200','ACTIVIDADES DE SINDICATOS'),('94910','ACTIVIDADES DE ORGANIZACIONES RELIGIOSAS'),('94920','ACTIVIDADES DE ORGANIZACIONES POLÍ­TICAS'),('94990','ACTIVIDADES DE ASOCIACIONES N.C.P.'),('95110','REPARACIÓN DE COMPUTADORAS Y EQUIPO PERIFÉRICO'),('95120','REPARACIÓN DE EQUIPO DE COMUNICACIÓN'),('95210','REPARACIÓN DE APARATOS ELECTRÓNICOS DE CONSUMO'),('95220','REPARACIÓN DE APARATOS DOMÉSTICO Y EQUIPO DE HOGAR Y JARDÍ­N'),('95230','REPARACIÓN DE CALZADO Y ARTÍ­CULOS DE CUERO'),('95240','REPARACIÓN DE MUEBLES Y ACCESORIOS PARA EL HOGAR'),('95291','REPARACIÓN DE INSTRUMENTOS MUSICALES'),('95292','SERVICIOS DE CERRAJERÍ­A Y COPIADO DE LLAVES'),('95293','REPARACIÓN DE JOYAS Y RELOJES'),('95294','REPARACIÓN DE BICICLETAS, SILLAS DE RUEDAS Y RODADOS N.C.P.'),('95299','REPARACIONES DE ENSERES PERSONALES N.C.P.'),('96010','LAVADO Y LIMPIEZA DE PRENDAS DE TELA Y DE PIEL, INCLUSO LA LIMPIEZA EN SECO'),('96020','PELUQUERÍ­A Y OTROS TRATAMIENTOS DE BELLEZA'),('96030','POMPAS FÚNEBRES Y ACTIVIDADES CONEXAS'),('96091','SERVICIOS DE SAUNA Y OTROS SERVICIOS PARA LA ESTÉTICA CORPORAL N.C.P.'),('96092','SERVICIOS N.C.P.'),('97000','ACTIVIDAD DE LOS HOGARES EN CALIDAD DE EMPLEADORES DE PERSONAL DOMÉSTICO'),('98100','ACTIVIDADES INDIFERENCIADAS DE PRODUCCIÓN DE BIENES DE LOS HOGARES PRIVADOS PARA USO PROPIO'),('98200','ACTIVIDADES INDIFERENCIADAS DE PRODUCCIÓN DE SERVICIOS DE LOS HOGARES PRIVADOS PARA USO PROPIO'),('9900','ACTIVIDADES DE APOYO A LA EXPLOTACIÓN DE MINAS Y CANTERAS'),('99000','ACTIVIDADES DE ORGANIZACIONES Y ÓRGANOS EXTRATERRITORIALES');
/*!40000 ALTER TABLE `catalogo_codigo_actividad_economica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_condicion_operacion`
--

DROP TABLE IF EXISTS `catalogo_condicion_operacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_condicion_operacion` (
  `idcondicion_operacion` int NOT NULL AUTO_INCREMENT,
  `Valor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idcondicion_operacion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_condicion_operacion`
--

LOCK TABLES `catalogo_condicion_operacion` WRITE;
/*!40000 ALTER TABLE `catalogo_condicion_operacion` DISABLE KEYS */;
INSERT INTO `catalogo_condicion_operacion` VALUES (1,'Contado'),(2,'Crédito'),(3,'Otro');
/*!40000 ALTER TABLE `catalogo_condicion_operacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_empresas`
--

DROP TABLE IF EXISTS `catalogo_empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_empresas` (
  `ce_id` int NOT NULL AUTO_INCREMENT COMMENT 'Codigo de empresa generado por MYSQL',
  `ce_nombre_empresa` varchar(120) DEFAULT NULL,
  `ce_fecha_creacion` datetime DEFAULT NULL,
  `ce_usuario_creacion` varchar(30) DEFAULT NULL,
  `ce_fecha_modificacion` datetime DEFAULT NULL,
  `ce_usuario_modificacion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ce_id`),
  UNIQUE KEY `ce_id_UNIQUE` (`ce_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_empresas`
--

LOCK TABLES `catalogo_empresas` WRITE;
/*!40000 ALTER TABLE `catalogo_empresas` DISABLE KEYS */;
INSERT INTO `catalogo_empresas` VALUES (1,'Servicios de Transito Centroamericanos S.A. de C.V.','2024-08-02 13:37:07','MEGONZALEZ_ID',NULL,NULL),(2,'UDP S.A. DE C.V.','2024-08-02 13:37:07','MEGONZALEZ_ID',NULL,NULL);
/*!40000 ALTER TABLE `catalogo_empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_forma_pago`
--

DROP TABLE IF EXISTS `catalogo_forma_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_forma_pago` (
  `idforma_pago` int NOT NULL AUTO_INCREMENT,
  `codigo_mh` varchar(2) DEFAULT NULL,
  `valor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idforma_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_forma_pago`
--

LOCK TABLES `catalogo_forma_pago` WRITE;
/*!40000 ALTER TABLE `catalogo_forma_pago` DISABLE KEYS */;
INSERT INTO `catalogo_forma_pago` VALUES (1,'01','Billetes y monedas'),(2,'02','Tarjeta Débito'),(3,'03','Tarjeta Crédito'),(4,'04','Cheque'),(5,'05','Transferencia_ Depósito Bancario'),(6,'06','Vales o Cupones'),(7,'08','Dinero electrónico'),(8,'09','Monedero electrónico'),(9,'10','Certificado o tarjeta de regalo'),(10,'11','Bitcoin'),(11,'12','Otras Criptomonedas'),(12,'13','Cuentas por pagar del receptor'),(13,'14','Giro bancario'),(14,'99','Otros (se debe indicar el medio de pago)');
/*!40000 ALTER TABLE `catalogo_forma_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_incoterms`
--

DROP TABLE IF EXISTS `catalogo_incoterms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_incoterms` (
  `cinc_id` int NOT NULL AUTO_INCREMENT,
  `cinc_codigo` varchar(2) DEFAULT NULL,
  `cinc_valor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cinc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_incoterms`
--

LOCK TABLES `catalogo_incoterms` WRITE;
/*!40000 ALTER TABLE `catalogo_incoterms` DISABLE KEYS */;
INSERT INTO `catalogo_incoterms` VALUES (1,'01','EXW-En fabrica'),(2,'02','FCA-Libre transportista'),(3,'03','CPT-Transporte pagado hasta'),(4,'04','CIP-Transporte y seguro pagado hasta'),(5,'05','DAP-Entrega en el lugar'),(6,'06','DPU-Entregado en el lugar descargado'),(7,'07','DDP-Entrega con impuestos pagado'),(8,'08','FAS-Libre al costado del buque'),(9,'09','FOB-Libre a bordo'),(10,'10','CFR-Costo y flete'),(11,'11','CIF- Costo seguro y flete'),(12,'12','DAT-Entregado en terminal'),(13,'13','DAF-Entregada en frontera'),(14,'14','DES-Entregada sobre duque'),(15,'15','DEQ-Entregada en muelle'),(16,'16','DDU- Entregada derechos no pagados');
/*!40000 ALTER TABLE `catalogo_incoterms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_modelo_facturacion`
--

DROP TABLE IF EXISTS `catalogo_modelo_facturacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_modelo_facturacion` (
  `idmodelo_facturacion` int NOT NULL AUTO_INCREMENT,
  `Valor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idmodelo_facturacion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_modelo_facturacion`
--

LOCK TABLES `catalogo_modelo_facturacion` WRITE;
/*!40000 ALTER TABLE `catalogo_modelo_facturacion` DISABLE KEYS */;
INSERT INTO `catalogo_modelo_facturacion` VALUES (1,'Facturación previo'),(2,'Facturación diferido');
/*!40000 ALTER TABLE `catalogo_modelo_facturacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_origenes`
--

DROP TABLE IF EXISTS `catalogo_origenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_origenes` (
  `co_id` int NOT NULL AUTO_INCREMENT,
  `co_abreviatura` varchar(5) DEFAULT NULL,
  `co_descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`co_id`),
  UNIQUE KEY `co_id_UNIQUE` (`co_id`),
  UNIQUE KEY `co_abreviatura_UNIQUE` (`co_abreviatura`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_origenes`
--

LOCK TABLES `catalogo_origenes` WRITE;
/*!40000 ALTER TABLE `catalogo_origenes` DISABLE KEYS */;
INSERT INTO `catalogo_origenes` VALUES (1,'SS','SAN SALVADOR'),(2,'SA','SANTA ANA'),(3,'SM','SAN MIGUEL'),(4,'CS','CASCADAS'),(5,'PM','BLVD EJERCITO'),(6,'SH','PLAZA SOHO'),(7,'LD','LOURDES'),(8,'SO','SONSONATE');
/*!40000 ALTER TABLE `catalogo_origenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_pais`
--

DROP TABLE IF EXISTS `catalogo_pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_pais` (
  `cp_id_pais` int NOT NULL AUTO_INCREMENT COMMENT 'Creado en base a CAT-020 del catalogo del sistema de transmisión del MH',
  `cp_codigo` varchar(5) DEFAULT NULL COMMENT 'codigo en base a CAT-020 del catalogo del sistema de transmisión del MH',
  `cp_valor` varchar(50) DEFAULT NULL COMMENT 'valor en base a CAT-020 del catalogo del sistema de transmisión del MH',
  PRIMARY KEY (`cp_id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_pais`
--

LOCK TABLES `catalogo_pais` WRITE;
/*!40000 ALTER TABLE `catalogo_pais` DISABLE KEYS */;
INSERT INTO `catalogo_pais` VALUES (1,'9320','ANGUILA'),(2,'9539','ISLAS TURCAS Y CAICOS'),(3,'9565','LITUANIA'),(4,'9905','DAKOTA DEL SUR (USA)'),(5,'9999','No definido en migración');
/*!40000 ALTER TABLE `catalogo_pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_plazos`
--

DROP TABLE IF EXISTS `catalogo_plazos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_plazos` (
  `cpl_id` int NOT NULL AUTO_INCREMENT,
  `cpl_cod` varchar(45) DEFAULT NULL COMMENT 'En base al catalogo de sistema de transmision del MH CAT - 018 Plazo (Codigo)',
  `cpl_valor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='En base al catalogo de sistema de transmision del MH CAT - 018 Plazo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_plazos`
--

LOCK TABLES `catalogo_plazos` WRITE;
/*!40000 ALTER TABLE `catalogo_plazos` DISABLE KEYS */;
INSERT INTO `catalogo_plazos` VALUES (1,'01','Dias'),(2,'02','Meses'),(3,'03','Años');
/*!40000 ALTER TABLE `catalogo_plazos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_productos`
--

DROP TABLE IF EXISTS `catalogo_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_productos` (
  `idcat_prod` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(60) DEFAULT NULL,
  `valor_unitario` decimal(15,2) DEFAULT NULL,
  `codigo_prod` varchar(10) DEFAULT NULL,
  `um_codigo` int DEFAULT NULL,
  `cp_exento` varchar(1) DEFAULT NULL COMMENT 'Campo que indica si esta excento de renta o no',
  `cp_no_sujeto` varchar(1) DEFAULT NULL COMMENT 'Campo que indica si el producto va sujeto o no sujeto a IVA',
  `cp_activo` varchar(1) DEFAULT NULL,
  `cp_cit_id` int DEFAULT NULL,
  `cp_codigo_brilo` varchar(15) DEFAULT NULL,
  `cp_proceso` varchar(100) DEFAULT 'MANUAL',
  `id_empresa` int DEFAULT NULL,
  PRIMARY KEY (`idcat_prod`),
  KEY `PK_CIT_ID_idx` (`cp_cit_id`),
  KEY `FK_UNIDAD_MED_idx` (`um_codigo`),
  CONSTRAINT `FK_UNIDAD_MED` FOREIGN KEY (`um_codigo`) REFERENCES `unidades_medida` (`um_codigo`),
  CONSTRAINT `PK_CIT_ID` FOREIGN KEY (`cp_cit_id`) REFERENCES `catalogo_tipo_item` (`cit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_productos`
--

LOCK TABLES `catalogo_productos` WRITE;
/*!40000 ALTER TABLE `catalogo_productos` DISABLE KEYS */;
INSERT INTO `catalogo_productos` VALUES (63,'TEST 1',15.80,'1',59,'N',NULL,'S',1,NULL,'MANUAL',1),(64,'TEST_STC',5.26,'01',59,'N',NULL,'S',1,NULL,'MANUAL',2);
/*!40000 ALTER TABLE `catalogo_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_puestos_usuarios`
--

DROP TABLE IF EXISTS `catalogo_puestos_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_puestos_usuarios` (
  `cpu_id` int NOT NULL AUTO_INCREMENT,
  `cpu_descripcion` varchar(500) DEFAULT NULL,
  `cpu_puesto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cpu_id`),
  UNIQUE KEY `cpu_id_UNIQUE` (`cpu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_puestos_usuarios`
--

LOCK TABLES `catalogo_puestos_usuarios` WRITE;
/*!40000 ALTER TABLE `catalogo_puestos_usuarios` DISABLE KEYS */;
INSERT INTO `catalogo_puestos_usuarios` VALUES (1,'Acceso a todas las opciones del menú de facturacion electronica (mantenimientos y envios)','ADMINISTRADOR'),(2,'Usuarios con accesos al reporte de cierre (cuadres de operadores)','SUPERVISOR'),(3,'Acceso a Cobro de ticket, Perdida de ticket y Retiro por molestia (parqueo)','CAJERO'),(4,'Acceso a aplicativos de emision de ticket.','OPERADOR'),(5,'Permisos para autorizar ticket de cortesia en sistema DTE.','COLABORADOR');
/*!40000 ALTER TABLE `catalogo_puestos_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_recinto_fiscal`
--

DROP TABLE IF EXISTS `catalogo_recinto_fiscal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_recinto_fiscal` (
  `crf_id` int NOT NULL AUTO_INCREMENT,
  `crf_codigo` varchar(2) DEFAULT NULL,
  `crf_valor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`crf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COMMENT='En base a CAT-027 del manual del MH';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_recinto_fiscal`
--

LOCK TABLES `catalogo_recinto_fiscal` WRITE;
/*!40000 ALTER TABLE `catalogo_recinto_fiscal` DISABLE KEYS */;
INSERT INTO `catalogo_recinto_fiscal` VALUES (1,'01','Terrestre San Bartolo'),(2,'02','Marítima de Acajutla'),(3,'03','Aérea Monseñor Óscar Arnulfo Romero'),(4,'04','Terrestre Las Chinamas'),(5,'05','Terrestre La Hachadura'),(6,'06','Terrestre Santa Ana'),(7,'07','Terrestre San Cristóbal'),(8,'08','Terrestre Anguiatú'),(9,'09','Terrestre El Amatillo'),(10,'10','Marítima La Unión (Puerto Cutuco)'),(11,'11','Terrestre El Poy'),(12,'12','Aduana Terrestre Metalío'),(13,'15','Fardos Postales'),(14,'16','Z.F. San Marcos'),(15,'17','Z.F. El Pedregal'),(16,'18','Z.F. San Bartolo'),(17,'20','Z.F. Exportsalva'),(18,'21','Z.F. American Park'),(19,'23','Z.F. Internacional'),(20,'24','Z.F. Diez'),(21,'26','Z.F. Miramar'),(22,'27','Z.F. Santo Tomas'),(23,'28','Z.F. Santa Tecla'),(24,'29','Z.F. Santa Ana'),(25,'30','Z.F. La Concordia'),(26,'31','Aérea Ilopango'),(27,'32','Z.F. Pipil'),(28,'33','Puerto Barillas'),(29,'34','Z.F. Calvo Conservas'),(30,'35','Feria Internacional'),(31,'36','Delg. Aduana El Papalón'),(32,'37','Z.F. Parque Industrial Sam-Li'),(33,'38','Z.F. San José'),(34,'39','Z.F. Las Mercedes'),(35,'71','Almacenes De Desarrollo (Aldesa)'),(36,'72','Almac. Gral. Dep. Occidente (Agdosa)'),(37,'73','Bodega General De Depósito (Bodesa)'),(38,'76','DHL'),(39,'77','Transauto (Santa Elena)'),(40,'80','Almacenadora Nejapa, S.a. de C.V.'),(41,'81','Almacenadora Almaconsa S.A. De C.V.'),(42,'83','Alm.Gral. Depósito Occidente (Apopa)'),(43,'99','San Bartolo Envío Hn/Gt');
/*!40000 ALTER TABLE `catalogo_recinto_fiscal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_regimen`
--

DROP TABLE IF EXISTS `catalogo_regimen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_regimen` (
  `crg_id` int NOT NULL AUTO_INCREMENT,
  `crg_codigo` varchar(20) DEFAULT NULL,
  `crg_valor` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`crg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3 COMMENT='En base al catalogo CAT-028 del MH';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_regimen`
--

LOCK TABLES `catalogo_regimen` WRITE;
/*!40000 ALTER TABLE `catalogo_regimen` DISABLE KEYS */;
INSERT INTO `catalogo_regimen` VALUES (1,'EX-1.1000.000','Exportación Definitiva, Exportación Definitiva, Régimen Común'),(2,'EX-1.1040.000','Exportación Definitiva, Exportación Definitiva Sustitución de Mercancías, Régimen Común'),(3,'EX-1.1041.020','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Provisional, Franq. Presidenciales exento de DAI'),(4,'EX-1.1041.021','Exportación Definitiva, Exportación Definitiva Proveniente deFranquicia Provisional, Franq. Presidenciales exento de DAI e IVA'),(5,'EX-1.1048.025','Exportación Definitiva, Exportación Definitiva Proveniente deFranquicia Definitiva, Maquinaria y Equipo LZF. DPA'),(6,'EX-1.1048.031','Exportación Definitiva, Exportación Definitiva Proveniente deFranquicia Definitiva, Distribución Internacional'),(7,'EX-1.1048.032','Exportación Definitiva, Exportación Definitiva Proveniente. deFranquicia Definitiva, Operaciones Internacionales de Logística'),(8,'EX-1.1048.033','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Centro Internacional de llamadas (Call Center)'),(9,'EX-1.1048.034','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Tecnologías de Información LSI'),(10,'EX-1.1048.035','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Investigación y Desarrollo LSI'),(11,'EX-1.1048.036','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Reparación y Mantenimiento de Embarcaciones Marítimas LSI'),(12,'EX-1.1048.037','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Reparación y Mantenimiento de Aeronaves LSI'),(13,'EX-1.1048.038','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Procesos Empresariales LSI'),(14,'EX-1.1048.039','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Servicios Medico-Hospitalarios LSI'),(15,'EX-1.1048.040','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Servicios Financieros Internacionales LSI'),(16,'EX-1.1048.043','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Reparación y Mantenimiento de Contenedores LSI'),(17,'EX-1.1048.044','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Reparación de Equipos Tecnológicos LSI'),(18,'EX-1.1048.054','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Atención Ancianos y Convalecientes LSI'),(19,'EX-1.1048.055','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Telemedicina LSI'),(20,'EX-1.1048.056','Exportación Definitiva, Exportación Definitiva Proveniente de Franquicia Definitiva, Cinematografía LSI'),(21,'EX-1.1052.000','Exportación Definitiva, Exportación Definitiva de DPA con origen en Compras Locales, Régimen Común'),(22,'EX-1.1054.000','Exportación Definitiva, Exportación Definitiva de Zona Franca con origen en Compras Locales, Régimen Común'),(23,'EX-1.1100.000','Exportación Definitiva, Exportación Definitiva de Envíos de Socorro, Régimen Común'),(24,'EX-1.1200.000','Exportación Definitiva, Exportación Definitiva de Envíos Postales, Régimen Común'),(25,'EX-1.1300.000','Exportación Definitiva, Exportación Definitiva Envíos que requieren despacho urgente, Régimen Común'),(26,'EX-1.1400.000','Exportación Definitiva, Exportación Definitiva Courier, Régimen Común'),(27,'EX-1.1400.011','Exportación Definitiva, Exportación Definitiva Courier, Muestras Sin Valor Comercial'),(28,'EX-1.1400.012','Exportación Definitiva, Exportación Definitiva Courier, Material Publicitario'),(29,'EX-1.1400.017','Exportación Definitiva, Exportación Definitiva Courier, Declaración de Documentos'),(30,'EX-1.1500.000','Exportación Definitiva, Exportación Definitiva Menaje de casa, Régimen Común'),(31,'EX-2.2100.000','Exportación Temporal, Exportación Temporal para Perfeccionamiento Pasivo, Régimen Común'),(32,'EX-2.2200.000','Exportación Temporal, Exportación Temporal con Reimportación en el mismo estado, Régimen Común'),(33,'EX-3.3050.000','Re-Exportación, Reexportación Proveniente de Importación Temporal, Régimen Común'),(34,'EX-3.3051.000','Re-Exportación, Reexportación Proveniente de Tiendas Libres, Régimen Común'),(35,'EX-3.3052.000','Re-Exportación, Reexportación Proveniente de Admisión Temporal para Perfeccionamiento Activo, Régimen Común'),(36,'EX-3.3053.000','Re-Exportación, Reexportación Proveniente de Admisión Temporal, Régimen Común'),(37,'EX-3.3054.000','Re-Exportación, Reexportación Proveniente de Régimen de Zona Franca, Régimen Común'),(38,'EX-3.3055.000','Re-Exportación, Reexportación Proveniente de Admisión Temporal para Perfeccionamiento Activo con Garantía, Régimen Común'),(39,'EX-3.3056.000','Re-Exportación, Reexportación Proveniente de Admisión Temporal Distribución Internacional Parque de Servicios, Régimen Común'),(40,'EX-3.3056.057','Re-Exportación, Reexportación Proveniente de Admisión Temporal Distribución Internacional Parque de Servicios, Remisión entre Usuarios Directos del Mismo Parque de Servicios'),(41,'EX-3.3056.058','Re-Exportación, Reexportación Proveniente de Admisión Temporal Distribución Internacional Parque de Servicios, Remisión entre Usuarios Directos de Diferente Parque de Servicios'),(42,'EX-3.3056.072','Re-Exportación, Reexportación Proveniente de Admisión Temporal Distribución Internacional Parque de Servicios, Decreto 738 Eléctricos e Híbridos'),(43,'EX-3.3057.000','Re-Exportación, Reexportación Proveniente de Admisión Temporal Operaciones Internacional de Logística Parque de Servicios, Régimen Común'),(44,'EX-3.3057.057','Re-Exportación, Reexportación Proveniente de Admisión Temporal Operaciones Internacional de Logística Parque de Servicios, Remisión entre Usuarios Directos del Mismo Parque de Servicios'),(45,'EX-3.3057.058','Re-Exportación, Reexportación Proveniente de Admisión Temporal Operaciones Internacional de Logística Parque de Servicios, Remisión entre Usuarios Directos de Diferente Parque de Servicios'),(46,'EX-3.3058.033','Re-Exportación, Reexportación Proveniente de Admisión Temporal Centro Servicio LSI, Centro Internacional de llamadas (Call Center)'),(47,'EX-3.3058.036','Re-Exportación, Reexportación Proveniente de Admisión Temporal Centro Servicio LSI, Reparación y Mantenimiento de Embarcaciones Marítimas LSI'),(48,'EX-3.3058.037','Re-Exportación, Reexportación Proveniente de Admisión Temporal Centro Servicio LSI, Reparación y Mantenimiento de Aeronaves LSI'),(49,'EX-3.3058.043','Re-Exportación, Reexportación Proveniente de Admisión Temporal Centro Servicio LSI, Reparación y Mantenimiento de Contenedores LSI'),(50,'EX-3.3059.000','Re-Exportación, Reexportación Proveniente de Admisión Temporal Reparación de Equipo Tecnológico Parque de Servicios, Régimen Común'),(51,'EX-3.3059.057','Re-Exportación, Reexportación Proveniente de Admisión Temporal Reparación de Equipo Tecnológico Parque de Servicios, Remisión entre Usuarios Directos del Mismo Parque de Servicios'),(52,'EX-3.3059.058','Re-Exportación, Reexportación Proveniente de Admisión Temporal Reparación de Equipo Tecnológico Parque de Servicios, Remisión entre Usuarios Directos de Diferente Parque de Servicios'),(53,'EX-3.3070.000','Re-Exportación, Reexportación Proveniente de Depósito., Régimen Común'),(54,'EX-3.3070.072','Re-Exportación, Reexportación Proveniente de Depósito., Decreto 738 Eléctricos e Híbridos');
/*!40000 ALTER TABLE `catalogo_regimen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_retencion_iva_mh`
--

DROP TABLE IF EXISTS `catalogo_retencion_iva_mh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_retencion_iva_mh` (
  `cri_id` int NOT NULL AUTO_INCREMENT COMMENT 'Catalogo 006 Retencion IvA MH',
  `cri_codigo` varchar(5) DEFAULT NULL COMMENT 'Catalogo 006 Retencion IvA MH',
  `cri_valor` varchar(100) DEFAULT NULL COMMENT 'Catalogo 006 Retencion IvA MH',
  PRIMARY KEY (`cri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_retencion_iva_mh`
--

LOCK TABLES `catalogo_retencion_iva_mh` WRITE;
/*!40000 ALTER TABLE `catalogo_retencion_iva_mh` DISABLE KEYS */;
INSERT INTO `catalogo_retencion_iva_mh` VALUES (1,'22','Retención IVA 1%'),(2,'C4','Retención IVA 13%'),(3,'C9','Otras retenciones IVA casos especiales');
/*!40000 ALTER TABLE `catalogo_retencion_iva_mh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_contingencia`
--

DROP TABLE IF EXISTS `catalogo_tipo_contingencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_contingencia` (
  `ctc_id` int NOT NULL AUTO_INCREMENT,
  `ctc_valor` varchar(200) DEFAULT NULL COMMENT 'Creado según CAT-005 Tipo de contingencia del catalogo de sistema de transmisión',
  PRIMARY KEY (`ctc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_contingencia`
--

LOCK TABLES `catalogo_tipo_contingencia` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_contingencia` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_contingencia` VALUES (1,'No disponibilidad de sistema del MH'),(2,'No disponibilidad de sistema del emisor'),(3,'Falla en el suministro de servicio de Internet del Emisor'),(4,'Falla en el suministro de servicio de energía eléctrica del emisor que impida la transmisión de los DTE'),(5,'Otro (deberá digitar un máximo de 500 caracteres explicando el motivo)');
/*!40000 ALTER TABLE `catalogo_tipo_contingencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_de_persona`
--

DROP TABLE IF EXISTS `catalogo_tipo_de_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_de_persona` (
  `ctper_id` int NOT NULL AUTO_INCREMENT,
  `ctper_valor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ctper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_de_persona`
--

LOCK TABLES `catalogo_tipo_de_persona` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_de_persona` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_de_persona` VALUES (1,'Persona Natural'),(2,'Persona Jurídica');
/*!40000 ALTER TABLE `catalogo_tipo_de_persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_establecimiento`
--

DROP TABLE IF EXISTS `catalogo_tipo_establecimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_establecimiento` (
  `codigo` varchar(45) NOT NULL,
  `valor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_establecimiento`
--

LOCK TABLES `catalogo_tipo_establecimiento` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_establecimiento` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_establecimiento` VALUES ('01','Sucursal / Agencia'),('02','Casa matriz'),('04','Bodega'),('07','Predio y/o patio'),('20','Otro');
/*!40000 ALTER TABLE `catalogo_tipo_establecimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_generacion_documento`
--

DROP TABLE IF EXISTS `catalogo_tipo_generacion_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_generacion_documento` (
  `ctgd_id` int NOT NULL AUTO_INCREMENT,
  `ctgd_valor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ctgd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_generacion_documento`
--

LOCK TABLES `catalogo_tipo_generacion_documento` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_generacion_documento` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_generacion_documento` VALUES (1,'Físico'),(2,'Electrónico');
/*!40000 ALTER TABLE `catalogo_tipo_generacion_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_invalidacion`
--

DROP TABLE IF EXISTS `catalogo_tipo_invalidacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_invalidacion` (
  `cti_id` int NOT NULL AUTO_INCREMENT COMMENT 'En base al Catalogo CAT-024 Tipo de Invalidación',
  `cti_valor` varchar(100) DEFAULT NULL COMMENT 'En base al Catalogo CAT-024 Tipo de Invalidación',
  PRIMARY KEY (`cti_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_invalidacion`
--

LOCK TABLES `catalogo_tipo_invalidacion` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_invalidacion` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_invalidacion` VALUES (1,'Error en la Información del Documento Tributario Electrónico a invalidar.'),(2,'Rescindir de la operación realizada.'),(3,'Otro');
/*!40000 ALTER TABLE `catalogo_tipo_invalidacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_item`
--

DROP TABLE IF EXISTS `catalogo_tipo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_item` (
  `cit_id` int NOT NULL AUTO_INCREMENT,
  `valor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='En base al CAT-011 tipo item del MH';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_item`
--

LOCK TABLES `catalogo_tipo_item` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_item` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_item` VALUES (1,'Bienes'),(2,'Servicios'),(3,'Ambos (Bienes y Servicios, incluye los dos inherente a los Productos o servicios)'),(4,'Otros tributos por ítem');
/*!40000 ALTER TABLE `catalogo_tipo_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tipo_transmision`
--

DROP TABLE IF EXISTS `catalogo_tipo_transmision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipo_transmision` (
  `idtipo_transmision` int NOT NULL AUTO_INCREMENT,
  `valor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idtipo_transmision`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_transmision`
--

LOCK TABLES `catalogo_tipo_transmision` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_transmision` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_transmision` VALUES (1,'Transmisión normal'),(2,'Transmisión por contingencia');
/*!40000 ALTER TABLE `catalogo_tipo_transmision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_tributos`
--

DROP TABLE IF EXISTS `catalogo_tributos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tributos` (
  `idcatalogo_tributos` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(5) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`idcatalogo_tributos`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tributos`
--

LOCK TABLES `catalogo_tributos` WRITE;
/*!40000 ALTER TABLE `catalogo_tributos` DISABLE KEYS */;
INSERT INTO `catalogo_tributos` VALUES (1,'20','Impuesto al Valor Agregado 13%'),(2,'C3','Impuesto al Valor Agregado (exportaciones) 0%'),(3,'59','Turismo: por alojamiento (5%)'),(4,'71','Turismo: salida del país por vía aérea $7.00'),(5,'D1','FOVIAL ($0.20 Ctvs. por galón)'),(6,'C8','COTRANS ($0.10 Ctvs. por galón)'),(7,'D5','Otras tasas casos especiales'),(8,'D4','Otros impuestos casos especiales'),(9,'A8','Impuesto Especial al Combustible (0%, 0.5%, 1%)'),(10,'57','Impuesto industria de Cemento'),(11,'90','Impuesto especial a la primera matrícula'),(12,'A6','Impuesto ad- valorem, armas de fuego, municiones explosivas y artículos similares'),(13,'C5','Impuesto ad- valorem por diferencial de precios de bebidas alcohólicas (8%)'),(14,'C6','Impuesto ad- valorem por diferencial de precios al tabaco cigarrillos (39%)'),(15,'C7','Impuesto ad- valorem por diferencial de precios al tabaco cigarros (100%)'),(16,'19','Fabricante de Bebidas Gaseosas, Isotónicas, Deportivas, Fortificantes, Energizante o Estimulante'),(17,'28','Importador de Bebidas Gaseosas, Isotónicas, Deportivas, Fortificantes, Energizante o Estimulante'),(18,'31','Detallistas o Expendedores de Bebidas Alcohólicas'),(19,'32','Fabricante de Cerveza'),(20,'33','Importador de Cerveza'),(21,'34','Fabricante de Productos de Tabaco'),(22,'35','Importador de Productos de Tabaco'),(23,'36','Fabricante de Armas de Fuego, Municiones y Artículos Similares'),(24,'37','Importador de Arma de Fuego, Munición y Artículos. Similares'),(25,'38','Fabricante de Explosivos'),(26,'39','Importador de Explosivos'),(27,'42','Fabricante de Productos Pirotécnicos'),(28,'43','Importador de Productos Pirotécnicos'),(29,'44','Productor de Tabaco'),(30,'50','Distribuidor de Bebidas Gaseosas, Isotónicas, Deportivas, Fortificantes, Energizante o Estimulante'),(31,'51','Bebidas Alcohólicas'),(32,'52','Cerveza'),(33,'53','Productos del Tabaco'),(34,'54','Bebidas Carbonatadas o Gaseosas Simples o Endulzadas'),(35,'55','Otros Específicos'),(36,'58','Alcohol'),(37,'77','Importador de Jugos, Néctares, Bebidas con Jugo y Refrescos'),(38,'78','Distribuidor de Jugos, Néctares, Bebidas con Jugo y Refrescos'),(39,'79','Sobre Llamadas Telefónicas Provenientes del Ext'),(40,'85','Detallista de Jugos, Néctares, Bebidas con Jugo y Refrescos'),(41,'86','Fabricante de Preparaciones Concentradas o en Polvo para la Elaboración de Bebidas'),(42,'91','Fabricante de Jugos, Néctares, Bebidas con Jugo y Refrescos'),(43,'92','Importador de Preparaciones Concentradas o en Polvo para la Elaboración de Bebidas'),(44,'A1','Específicos y Ad-Valorem'),(45,'A5','Bebidas Gaseosas, Isotónicas, Deportivas, Fortificantes, Energizantes o Estimulantes'),(46,'A7','Alcohol Etílico'),(47,'A9','Sacos Sintéticos');
/*!40000 ALTER TABLE `catalogo_tributos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contribuyentes`
--

DROP TABLE IF EXISTS `contribuyentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribuyentes` (
  `ruc_id` int NOT NULL AUTO_INCREMENT,
  `ruc_nit_contribuyente` varchar(45) NOT NULL,
  `ruc_nombre_razonsocial` varchar(120) DEFAULT NULL,
  `ruc_apellidos_paterno` varchar(60) DEFAULT NULL,
  `ruc_apellidos_materno` varchar(60) DEFAULT NULL,
  `ruc_domicilio` varchar(200) NOT NULL,
  `ruc_telefono_personal` varchar(30) DEFAULT NULL,
  `ruc_telefono_trabajo` varchar(15) DEFAULT NULL,
  `ruc_email_contribuyente` varchar(100) NOT NULL,
  `ruc_dui_contribuyente` varchar(10) DEFAULT NULL,
  `ruc_estado_contribuyente` varchar(10) DEFAULT NULL,
  `ruc_fecha_vencimientodui` datetime DEFAULT NULL,
  `ruc_codigo_departamento` varchar(4) NOT NULL,
  `ruc_codigo_municipio` varchar(4) NOT NULL,
  `ruc_tipo_contribuyente` varchar(15) DEFAULT NULL,
  `ruc_id_geografico` int DEFAULT NULL,
  `ruc_codigo_mh` varchar(4) DEFAULT NULL,
  `ruc_nrc` varchar(45) DEFAULT NULL,
  `ruc_codactividad` varchar(6) NOT NULL,
  `ruc_desactividad` varchar(150) DEFAULT NULL,
  `ruc_tipoestablecimiento` varchar(4) DEFAULT NULL,
  `ruc_cod_punto_venta_mh` varchar(4) DEFAULT NULL,
  `ruc_cod_punto_venta` varchar(15) DEFAULT NULL,
  `ruc_cod_establecimiento` varchar(5) DEFAULT NULL,
  `ruc_tipo_doc_id` int DEFAULT NULL,
  `ruc_nombre_comercial` varchar(120) DEFAULT NULL,
  `ruc_tipo_item_expor` int DEFAULT NULL COMMENT 'Campo requerido unicamente para la factura FEXE segun el CAT-011',
  `ruc_recinto_fiscal` varchar(2) DEFAULT NULL COMMENT 'Campo requerido unicamente para la factura FEXE segun el CAT-027',
  `ruc_regimen` varchar(13) DEFAULT NULL COMMENT 'Campo requerido unicamente para la factura FEXE segun el CAT-028',
  `ruc_cp_id_pais` int DEFAULT NULL COMMENT 'Creado en base a CAT-020 del catalogo del sistema de transmisión del MH -- Relacionado a la tabla catalogo_pais',
  `ruc_ctper_id` int DEFAULT NULL,
  `id_empresa` int DEFAULT NULL COMMENT 'Relacion con la tabla "catalogo de empresa" por ID para hacer unico cada contribuyente según la empresa que tenga relacionada el usuario (tabla usuarios)',
  `inscrito_iva` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ruc_id`),
  KEY `PK_PAIS_idx` (`ruc_cp_id_pais`),
  KEY `PK_TIPO_PERSON_idx` (`ruc_ctper_id`),
  KEY `PK_NIT_idx` (`ruc_nit_contribuyente`),
  CONSTRAINT `PK_PAIS` FOREIGN KEY (`ruc_cp_id_pais`) REFERENCES `catalogo_pais` (`cp_id_pais`),
  CONSTRAINT `PK_TIPO_PERSON` FOREIGN KEY (`ruc_ctper_id`) REFERENCES `catalogo_tipo_de_persona` (`ctper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contribuyentes`
--

LOCK TABLES `contribuyentes` WRITE;
/*!40000 ALTER TABLE `contribuyentes` DISABLE KEYS */;
INSERT INTO `contribuyentes` VALUES (1,'06141204841181','MIGUEL ISAAC SANCHEZ RAMOS','SANCHEZ','RAMOS','COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1','2261-7300','2261-7300','miguelsr1@gmail.com','007589275',NULL,NULL,'06','14','EMISOR',NULL,'0000','1875310','96092','Actividades de asociaciones n.c.p.','02',NULL,'S000P001','0000',1,'MIGUEL SANCHEZ',NULL,NULL,NULL,NULL,2,NULL,1),(2,'06140203981013','Servicios de Transito Centroamericanos S.A. de C.V.',NULL,NULL,'Blvd tutunichapa y av legazpi #11 urb siglo xxi','2261-7300','2261-7300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','EMISOR',NULL,'0000','1047582','94990','Actividades de asociaciones n.c.p.','02',NULL,'S000P000','0000',1,'SERTRACEN, S.A. DE C.V.',NULL,NULL,NULL,2,2,1,1),(3,'06141603001014','G.S.I. El Salvador, S.A. de C.V. ','G.S.I. El Salvador, S.A. de C.V. ','G.S.I. El Salvador, S.A. de C.V. ','Calle Llama del Bosque Pte. Blvd. Luis Poma Local 204, Urbanizacion Madre Selva Edificio ','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'1199782','63110','Actividades de asociaciones n.c.p.',NULL,NULL,'',NULL,1,NULL,NULL,NULL,NULL,NULL,2,1,1),(4,'06141810841054','pruebas update nombre razon social',NULL,NULL,'Domicilio update pruebas','22445588','22445588','miguelsr1@gmail.com',NULL,NULL,NULL,'06','03','EMISOR',NULL,NULL,'456123','94990',NULL,NULL,NULL,NULL,NULL,NULL,'pruebas update nombre comercial',NULL,NULL,NULL,NULL,NULL,NULL,0),(5,'00000000000000','SIN IDENTIFICACION ',NULL,NULL,'SAN SALVADOR ','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','EMISOR',NULL,NULL,'1047582','10005',NULL,NULL,NULL,NULL,NULL,1,'SIN IDENTIFICACION ',NULL,NULL,NULL,NULL,NULL,NULL,0),(6,'00000000000003','SIN IDENTIFICACION ',NULL,NULL,'SAN SALVADOR','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'1047582','10005',NULL,NULL,NULL,NULL,NULL,1,'SIN IDENTIFICACION ',NULL,NULL,NULL,NULL,NULL,NULL,0),(8,'022862818','prueba creacion emisor',NULL,NULL,'Pruebas creacion de emisor','22822136','22822136','miguelsr1@gmail.com',NULL,NULL,NULL,'06','03','EMISOR',NULL,NULL,'1567894','56107',NULL,NULL,NULL,NULL,NULL,1,'Prueba creacion emisor',NULL,NULL,NULL,NULL,NULL,NULL,0),(9,'0228628186','prueba creacion receptor',NULL,NULL,'Pruebas domicilio nuevo receptor','72725063','72725063','miguelsr1@gmail.com',NULL,NULL,NULL,'06','08','RECEPTOR',NULL,NULL,'16546818','1150',NULL,NULL,NULL,NULL,NULL,1,'prueba creacion receptor',NULL,NULL,NULL,NULL,NULL,NULL,0),(291,'00000000000001','PRUEBAS NRC NULL',NULL,NULL,'pruebas insert nrc null','22822136','22822136','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'94990','Actividades de asociaciones n.c.p.',NULL,NULL,NULL,NULL,1,'PRUEBAS NRC NULL',NULL,NULL,NULL,NULL,2,NULL,0),(292,'00000000000002','PRUEBAS STC FACTURACION ',NULL,NULL,'PRUEBAS STC FACTURACION ','22558899','22558899','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'11048','Maquilado de aguas gaseosas',NULL,NULL,NULL,NULL,1,'PRUEBAS',NULL,NULL,NULL,NULL,NULL,NULL,0),(293,'00000000000000','PEDRITO PEREZ',NULL,NULL,'SAN SALVADOR, SAN SALVADOR.','2261-7300','2261-7300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'68109','Actividades inmobiliarias realizadas con bienes propios o arrendados n.c.p.',NULL,NULL,NULL,NULL,1,'PEDRITO PEREZ',NULL,NULL,NULL,NULL,NULL,NULL,0),(294,'00000000000008','JUAN GUTIERREZ',NULL,NULL,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','15','RECEPTOR',NULL,NULL,NULL,'10005','Otros',NULL,NULL,NULL,NULL,1,'JUAN GUTIERREZ',NULL,NULL,NULL,NULL,NULL,1,0),(295,'06081208901020','SR PRUEBA FSE',NULL,NULL,'SAN SALVADOR, SAN SALVADOR.','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'10005','Otros',NULL,NULL,NULL,NULL,1,'SR PRUEBA FSE',NULL,NULL,NULL,NULL,NULL,NULL,0),(306,'022862817','prueba receptor s.a. de c.v.',NULL,NULL,'pruebas domicilio',NULL,'72725063','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'18108410','62090',NULL,NULL,NULL,NULL,NULL,1,'prueba receptor s.a. de c.v.',NULL,NULL,NULL,NULL,NULL,NULL,0),(307,'00000000000000','NA',NULL,NULL,'SAN SALVADOR ',NULL,'','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'10001',NULL,NULL,NULL,NULL,NULL,1,'NA',NULL,NULL,NULL,NULL,NULL,2,0),(308,'06141204841181','Miguel Isaac Sanchez Ramos',NULL,NULL,'CERCA DEL PALO DE MANGO',NULL,'22336655','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'1875310','96092',NULL,NULL,NULL,NULL,NULL,1,'Miguel Isaac Sanchez Ramos',NULL,NULL,NULL,NULL,NULL,1,1),(309,'06141204841181','MIGUEL ISAAC SANCHEZ RAMOS',NULL,NULL,'CERCA DE LA CUENCA DEL PUEBLO',NULL,'22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'1875310','96092',NULL,NULL,NULL,NULL,NULL,1,'MIGUEL ISAAC SANCHEZ RAMOS',NULL,NULL,NULL,NULL,NULL,2,1);
/*!40000 ALTER TABLE `contribuyentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamentos` (
  `iddepto` int NOT NULL AUTO_INCREMENT,
  `valor` varchar(100) NOT NULL,
  `cod_mh` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddepto`),
  KEY `fk_id_depto_idx` (`iddepto`),
  CONSTRAINT `fk_iddto` FOREIGN KEY (`iddepto`) REFERENCES `ubicaciones_geograficas` (`ugb_iddepto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

LOCK TABLES `departamentos` WRITE;
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
INSERT INTO `departamentos` VALUES (1,'Ahuachapán','01'),(2,'Santa Ana','02'),(3,'Sonsonate','03'),(4,'Chalatenango','04'),(5,'La Libertad','05'),(6,'San Salvador','06'),(7,'Cuscatlán','07'),(8,'La Paz','08'),(9,'Cabañas','09'),(10,'San Vicente','10'),(11,'Usulutan','11'),(12,'San Miguel','12'),(13,'Morazán','13'),(14,'La Unión','14');
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_anulaciones`
--

DROP TABLE IF EXISTS `detalle_anulaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_anulaciones` (
  `da_id` int NOT NULL AUTO_INCREMENT,
  `da_motivo` varchar(200) DEFAULT NULL,
  `da_codigo_generacionr` varchar(36) DEFAULT NULL,
  `da_fac_id` int DEFAULT NULL,
  `da_cti_id` int DEFAULT NULL,
  `da_nuevo_codigo_generacion` varchar(45) DEFAULT NULL,
  `da_fecha_ingreso` datetime DEFAULT CURRENT_TIMESTAMP,
  `da_ce_empresa` int DEFAULT NULL,
  PRIMARY KEY (`da_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_anulaciones`
--

LOCK TABLES `detalle_anulaciones` WRITE;
/*!40000 ALTER TABLE `detalle_anulaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_anulaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_relacionados`
--

DROP TABLE IF EXISTS `documentos_relacionados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentos_relacionados` (
  `doc_id` int NOT NULL AUTO_INCREMENT,
  `doc_tipo_doc` varchar(2) DEFAULT NULL,
  `doc_fecha` datetime DEFAULT NULL,
  `doc_num` varchar(45) DEFAULT NULL,
  `doc_tipo_gen` int DEFAULT NULL,
  `doc_fac_id` int DEFAULT NULL,
  `doc_ce_empresas` int DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `FAC_PK_idx` (`doc_fac_id`),
  CONSTRAINT `FAC_PK` FOREIGN KEY (`doc_fac_id`) REFERENCES `factura` (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_relacionados`
--

LOCK TABLES `documentos_relacionados` WRITE;
/*!40000 ALTER TABLE `documentos_relacionados` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentos_relacionados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `codigo_actividad` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nit` varchar(17) NOT NULL,
  `nrc` varchar(8) NOT NULL,
  `nombre_comercial` varchar(300) NOT NULL,
  `razon_social` varchar(300) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `correo` varchar(250) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `direccion` varchar(500) NOT NULL,
  `codigo_municipio` varchar(2) CHARACTER SET big5 COLLATE big5_chinese_ci NOT NULL,
  `codigo_establecimiento` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `usuario` varchar(250) NOT NULL,
  `codigo_departamento` varchar(2) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `estable_pv` varchar(8) DEFAULT NULL,
  `codigo_estable` varchar(4) DEFAULT NULL,
  `codigo_estable_mh` varchar(4) DEFAULT NULL,
  `codigo_puntoventa` varchar(4) DEFAULT NULL,
  `codigo_puntoventa_mh` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id_empresa`),
  KEY `empresa_fk` (`usuario`),
  KEY `municipio_empresa_fk` (`codigo_municipio`),
  KEY `act_eco_emp_fk` (`codigo_actividad`),
  KEY `tipo_establecimiento_empresa_fk` (`codigo_establecimiento`),
  CONSTRAINT `act_eco_emp_fk` FOREIGN KEY (`codigo_actividad`) REFERENCES `catalogo_codigo_actividad_economica` (`ccae_codigo`),
  CONSTRAINT `empresa_fk` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`correo_electronico`),
  CONSTRAINT `tipo_establecimiento_empresa_fk` FOREIGN KEY (`codigo_establecimiento`) REFERENCES `catalogo_tipo_establecimiento` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'96092','06141204841181','1875310','asdasd asd asd','asd asd asda sd','22336655','miguelsr1@gmail.com',1,'lsakjhals dkjhalsdkj hasd','05','01',1,'miguelsr1@gmail.com','05','2025-05-22 17:10:07','MISRP000','0000','0000','0000','0000'),(2,'94990','06140203981013','1047582','asdasd asd asd','asd asd asda sd','22336655','admin@gmail.com',1,'lsakjhals dkjhalsdkj hasd','06','01',1,'admin@gmail.com','06','2025-05-30 00:00:00','S000P000','0000','0000','0000','0000');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `establecimiento`
--

DROP TABLE IF EXISTS `establecimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `establecimiento` (
  `id_establecimiento` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `nombre_sucursal` varchar(150) NOT NULL,
  `codigo_estable` varchar(4) DEFAULT NULL,
  `codigo_estable_mh` varchar(4) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `tipo_establecimiento` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id_establecimiento`),
  KEY `contribuyente_establecimiento_fk` (`id_empresa`),
  CONSTRAINT `contribuyente_establecimiento_fk` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `establecimiento`
--

LOCK TABLES `establecimiento` WRITE;
/*!40000 ALTER TABLE `establecimiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `establecimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `est_id` int NOT NULL AUTO_INCREMENT,
  `est_estado` int DEFAULT NULL,
  `est_estado_descrip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`est_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,1,'PENDIENTE'),(2,2,'PROCESADO'),(3,3,'RECHAZADO'),(4,4,'ANULADA');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extensiones_facturas`
--

DROP TABLE IF EXISTS `extensiones_facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extensiones_facturas` (
  `ef_idextension` int NOT NULL AUTO_INCREMENT,
  `ef_nombentrega` varchar(100) DEFAULT NULL,
  `ef_docuentrega` varchar(45) DEFAULT NULL,
  `ef_nombrecibe` varchar(45) DEFAULT NULL,
  `ef_docurecibe` varchar(45) DEFAULT NULL,
  `ef_observaciones` varchar(45) DEFAULT NULL,
  `ef_placaVehiculo` varchar(45) DEFAULT NULL,
  `ef_ruc_id` int DEFAULT NULL,
  PRIMARY KEY (`ef_idextension`),
  KEY `FK_EXTENSIONES_idx` (`ef_ruc_id`),
  CONSTRAINT `FK_EXTENSIONES` FOREIGN KEY (`ef_ruc_id`) REFERENCES `contribuyentes` (`ruc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extensiones_facturas`
--

LOCK TABLES `extensiones_facturas` WRITE;
/*!40000 ALTER TABLE `extensiones_facturas` DISABLE KEYS */;
INSERT INTO `extensiones_facturas` VALUES (1,'JUAN JOSÉ SANDOVAL VIDES','00102913-8',NULL,NULL,NULL,NULL,1),(2,'Concepción Guadalupe Ventura Sanchez','02265105-5',NULL,NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `extensiones_facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `fac_id` int NOT NULL AUTO_INCREMENT,
  `fac_nro_factura` varchar(15) DEFAULT NULL,
  `fac_fecha_emision` datetime DEFAULT NULL,
  `fac_actividad_giro` varchar(100) DEFAULT NULL,
  `fac_nit_emisor` varchar(20) DEFAULT NULL,
  `fac_nit_receptor` varchar(20) DEFAULT NULL,
  `fac_telefono` varchar(15) DEFAULT NULL,
  `fac_razonsocial` varchar(100) DEFAULT NULL,
  `fac_retenido` decimal(15,2) DEFAULT NULL,
  `fac_sumas_detalle` decimal(15,2) DEFAULT NULL,
  `fac_total_pagar` decimal(15,2) DEFAULT NULL,
  `fac_firma` blob,
  `fac_ncr` varchar(45) DEFAULT NULL,
  `fac_estado_factura` int DEFAULT NULL,
  `fac_codigo_generacion` varchar(36) DEFAULT NULL,
  `fac_numero_de_control` varchar(31) DEFAULT NULL,
  `fac_tipo_documento` int DEFAULT NULL,
  `fac_sello_de_recepcion` blob,
  `fac_total_iva` decimal(15,2) DEFAULT NULL,
  `fac_tipo_comprobante` varchar(2) DEFAULT NULL,
  `fac_ventasnosujet_tot` decimal(15,2) DEFAULT NULL,
  `fac_ventasexentas_tot` decimal(15,2) DEFAULT NULL,
  `fac_ventasgravadas_tot` decimal(15,2) DEFAULT NULL,
  `fac_iva_retenido` decimal(15,2) DEFAULT NULL,
  `fac_saldo_favor` decimal(15,2) DEFAULT NULL,
  `fac_total_nograbado` decimal(15,2) DEFAULT NULL,
  `fac_descuento_nosuje` decimal(15,2) DEFAULT NULL,
  `fac_descuento_exent` decimal(15,2) DEFAULT NULL,
  `fac_tot_descuento` decimal(15,2) DEFAULT NULL,
  `fac_total_letras` varchar(100) DEFAULT NULL,
  `fac_descuento_grab` decimal(15,2) DEFAULT NULL,
  `fac_porcen_descuento` decimal(15,2) DEFAULT NULL,
  `fac_tributos` decimal(15,2) DEFAULT NULL,
  `fac_subtotal` decimal(15,2) DEFAULT NULL,
  `fac_iva_porcent` decimal(15,2) DEFAULT NULL,
  `fac_subtotalventas` decimal(15,2) DEFAULT NULL,
  `fac_ivaperci1` decimal(15,2) DEFAULT NULL,
  `fac_montototaloperacion` decimal(15,2) DEFAULT NULL,
  `fac_numpagoelectronico` varchar(100) DEFAULT NULL COMMENT 'Campo destinado para indicar el número de pago electrónico cuando exista (NPE)',
  `fac_condicion_operacion` int DEFAULT NULL,
  `fac_totalcompra` decimal(15,2) DEFAULT NULL COMMENT 'Campo creado unicamente para la factura FSEE (en resumen.totalcompra)',
  `fac_fecha_ini_periodo` datetime DEFAULT NULL,
  `fac_fecha_fin_periodo` datetime DEFAULT NULL,
  `fac_desc` decimal(15,2) DEFAULT NULL COMMENT 'Campo utilizado para resumen.desc en factura FSEE y en resumen.descuento en FEXE',
  `fac_seguro` decimal(15,2) DEFAULT NULL COMMENT 'Campo utilizado únicamente para el tipo de factura FEXE.',
  `fac_flete` decimal(15,2) DEFAULT NULL COMMENT 'Campo utilizado únicamente para el tipo de factura FEXE.',
  `fac_cinc_id` int DEFAULT NULL COMMENT 'Campo de relacion con el id del catalogo de INCOTERMS',
  `fac_observaciones` varchar(500) DEFAULT NULL COMMENT 'Campo utilizado en factura FEXE y FSEE',
  `fac_totalsujetoretencion` decimal(11,2) DEFAULT NULL COMMENT 'Campo utilizado unicamente para el comprobante de retencion (CRE)',
  `fac_ivaretenido_letras` varchar(200) DEFAULT NULL,
  `fac_cri_id` int DEFAULT NULL,
  `fac_tipo_item_expor` int DEFAULT NULL,
  `fac_recinto_fiscal` varchar(2) DEFAULT NULL,
  `fac_regimen` varchar(13) DEFAULT NULL,
  `fac_nombre_receptor` varchar(120) DEFAULT NULL,
  `fac_nrc_receptor` varchar(45) DEFAULT NULL,
  `fac_desactividad_receptor` varchar(150) DEFAULT NULL,
  `fac_direccion_receptor` varchar(200) DEFAULT NULL,
  `fac_telefono_receptor` varchar(15) DEFAULT NULL,
  `fac_correo_receptor` varchar(100) DEFAULT NULL,
  `fac_ce_empresa` int DEFAULT NULL COMMENT 'ID de la empresa en base al "Catalogo_empresas" según el dato que tiene registrado el usuario.',
  `fac_us_id_usuario` int DEFAULT NULL,
  `fac_us_ulb_ingreso` int DEFAULT NULL,
  `fac_retencion_iva` decimal(11,2) DEFAULT NULL,
  `fac_retencion_renta` decimal(15,2) DEFAULT NULL,
  `fac_retencion_iva_porc` decimal(11,2) DEFAULT NULL,
  `fac_retencion_renta_porc` decimal(11,2) DEFAULT NULL,
  `fac_fecha_envio_hacienda` datetime DEFAULT NULL,
  `fac_co_ubicacion` int DEFAULT NULL,
  PRIMARY KEY (`fac_id`),
  UNIQUE KEY `id_UNIQUE` (`fac_id`),
  KEY `FACT_EST_ESTADO_idx` (`fac_estado_factura`),
  KEY `FACT_TIPO_DOCUM_idx` (`fac_tipo_documento`),
  KEY `FACT_CONTRIBUYENTE_DOC_idx` (`fac_nit_emisor`),
  KEY `FACT_CONDICION_OPERACION_idx` (`fac_condicion_operacion`),
  KEY `FACT_INCOTERMS_idx` (`fac_cinc_id`),
  KEY `FACT_RETENCION_idx` (`fac_cri_id`),
  CONSTRAINT `FACT_CONDICION_OPERACION` FOREIGN KEY (`fac_condicion_operacion`) REFERENCES `catalogo_condicion_operacion` (`idcondicion_operacion`),
  CONSTRAINT `FACT_EST_ESTADO` FOREIGN KEY (`fac_estado_factura`) REFERENCES `estados` (`est_id`),
  CONSTRAINT `FACT_INCOTERMS` FOREIGN KEY (`fac_cinc_id`) REFERENCES `catalogo_incoterms` (`cinc_id`),
  CONSTRAINT `FACT_RETENCION` FOREIGN KEY (`fac_cri_id`) REFERENCES `catalogo_retencion_iva_mh` (`cri_id`),
  CONSTRAINT `FACT_TIPO_DOCUM` FOREIGN KEY (`fac_tipo_documento`) REFERENCES `tipos_documentos` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,'1','2025-05-27 22:26:09',NULL,'06141204841181','0000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,474.00,NULL,'1047582',1,'E176DFE6-3B7B-11F0-8D8B-0242AC110003','DTE-01-MUMH0000-000000000000006',1,NULL,54.53,'01',0.00,0.00,474.00,0.00,0.00,0.00,0.00,0.00,0.00,'CUATROCIENTOS SETENTA Y CUATRO CON CERO /100 CTVS',0.00,0.00,20.00,474.00,NULL,474.00,0.00,474.00,NULL,1,0.00,'2025-05-27 06:00:00','2025-05-27 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 27/05/2025 al 27/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(3,'3','2025-05-27 22:40:07','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,316.00,NULL,'1047582',1,'D4DA9EC8-3B7D-11F0-8D8B-0242AC110003','DTE-01-MUMH0000-000000000000007',1,NULL,36.35,'01',0.00,0.00,316.00,0.00,0.00,0.00,0.00,0.00,0.00,'TRESCIENTOS DIECISEIS CON CERO /100 CTVS',0.00,0.00,20.00,316.00,NULL,316.00,0.00,316.00,NULL,1,0.00,'2025-05-27 06:00:00','2025-05-27 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 27/05/2025 al 27/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(4,'4','2025-05-27 22:45:13','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,395.00,NULL,'1047582',2,'8B37F771-3B7E-11F0-8D8B-0242AC110003','DTE-01-S000P000-000000000000008',1,_binary '20258083173D0CCE40E3801D13B5B899E8750E2Q',45.44,'01',0.00,0.00,395.00,0.00,0.00,0.00,0.00,0.00,0.00,'TRESCIENTOS NOVENTA Y CINCO CON CERO /100 CTVS',0.00,0.00,20.00,395.00,NULL,395.00,0.00,395.00,NULL,1,0.00,'2025-05-27 06:00:00','2025-05-27 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 27/05/2025 al 27/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,'2025-05-27 22:45:18',NULL),(7,'7','2025-05-28 08:50:37','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,237.00,NULL,'1047582',1,'20BD5778-3BD3-11F0-B223-FADAF9E6DC92','DTE-01-S000P000-000000000000009',1,NULL,27.27,'01',0.00,0.00,237.00,0.00,0.00,0.00,0.00,0.00,0.00,'DOSCIENTOS TREINTA Y SIETE CON CERO /100 CTVS',0.00,0.00,20.00,237.00,NULL,237.00,0.00,237.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(9,'9','2025-05-28 08:56:33','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,158.00,NULL,'1047582',1,'F21ABBE4-3BD3-11F0-B223-FADAF9E6DC92','DTE-01-S000P000-000000000000010',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(11,'11','2025-05-28 09:16:05','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,158.00,NULL,'1047582',1,'ACDBD900-3BD6-11F0-B223-FADAF9E6DC92','DTE-01-S000P001-000000000000011',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(13,'13','2025-05-28 09:19:08','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,158.00,NULL,'1047582',1,'199220F8-3BD7-11F0-B223-FADAF9E6DC92','DTE-01-S000P001-000000000000012',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(14,'14','2025-05-28 09:19:28','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,237.00,NULL,'1047582',2,'25B81991-3BD7-11F0-B223-FADAF9E6DC92','DTE-01-S000P001-000000000000013',1,_binary '2025DAE7FBA64CF747FBA82EA9AEC2F28B347GUA',27.27,'01',0.00,0.00,237.00,0.00,0.00,0.00,0.00,0.00,0.00,'DOSCIENTOS TREINTA Y SIETE CON CERO /100 CTVS',0.00,0.00,20.00,237.00,NULL,237.00,0.00,237.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,'2025-05-28 09:19:33',NULL),(15,'15','2025-05-28 09:24:06','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,316.00,NULL,'1047582',2,'CB817D19-3BD7-11F0-B223-FADAF9E6DC92','DTE-01-S000P001-000000000000014',1,_binary '2025D8546757864F4F05A25D83F70529F1B2TFXX',36.35,'01',0.00,0.00,316.00,0.00,0.00,0.00,0.00,0.00,0.00,'TRESCIENTOS DIECISEIS CON CERO /100 CTVS',0.00,0.00,20.00,316.00,NULL,316.00,0.00,316.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,'2025-05-28 09:24:11',NULL),(16,'16','2025-05-28 09:27:02','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,158.00,NULL,'1047582',2,'344F43CC-3BD8-11F0-B223-FADAF9E6DC92','DTE-01-S000P001-000000000000015',1,_binary '20259EC6A7B2629C4F0A98A3D94E8FF5E5B99IER',18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,'2025-05-28 09:27:07',NULL),(17,'17','2025-05-28 11:39:22','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,1580.00,NULL,'1047582',2,'B11C59B2-3BEA-11F0-B223-FADAF9E6DC92','DTE-01-S000P001-000000000000016',1,_binary '2025388568F1E58B4671937554D8AE89F641DZVV',181.77,'01',0.00,0.00,1580.00,0.00,0.00,0.00,0.00,0.00,0.00,'MIL QUINIENTOS OCHENTA CON CERO /100 CTVS',0.00,0.00,20.00,1580.00,NULL,1580.00,0.00,1580.00,NULL,1,0.00,'2025-05-28 06:00:00','2025-05-28 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 28/05/2025 al 28/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,'2025-05-28 11:39:27',NULL),(18,'18','2025-05-29 12:40:06','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,158.00,NULL,'1047582',2,'5721E361-3CBC-11F0-A8B0-9A4A3E130EA2','DTE-01-S000P001-000000000000017',1,_binary '2025C870F52A2DA042A6B77ED229648D2948V6CE',18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-05-29 06:00:00','2025-05-29 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 29/05/2025 al 29/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,'2025-05-29 12:40:11',NULL),(19,'19','2025-05-29 13:51:42','68109','06141204841181','00000000000000','22617300','SIN IDENTIFICACION ',0.00,0.00,250.00,NULL,'1047582',2,'582228DC-3CC6-11F0-8D36-66DEE5945C0E','DTE-01-S000P001-000000000000018',1,_binary '2025626D357D1B6F4BD7B72937E525791A2BKUNM',28.76,'01',0.00,0.00,250.00,0.00,0.00,0.00,0.00,0.00,0.00,'DOSCIENTOS CINCUENTA CON CERO /100 CTVS',0.00,0.00,20.00,250.00,NULL,250.00,0.00,250.00,NULL,1,0.00,'2025-05-29 06:00:00','2025-05-29 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 29/05/2025 al 29/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0.00,0.00,0.00,0.00,'2025-05-29 13:51:47',NULL),(20,'20','2025-05-30 15:19:41','10001','06140203981013','000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,NULL,'DTE-01-S000P001-000000000000019',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-05-30 06:00:00','2025-05-30 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 30/05/2025 al 30/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(21,'21','2025-05-30 15:21:20','10001','06140203981013','000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,NULL,'DTE-01-S000P001-000000000000020',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-05-30 06:00:00','2025-05-30 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 30/05/2025 al 30/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(22,'22','2025-05-30 15:24:04','10001','06140203981013','000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,'6FB7BF07-3D9C-11F0-A2E7-7AD83F5004C6','DTE-01-S000P001-000000000000021',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-05-30 06:00:00','2025-05-30 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 30/05/2025 al 30/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(23,'23','2025-05-30 15:27:16','10001','06140203981013','00000000-0','','NA',0.00,0.00,52.60,NULL,NULL,1,'DF3B09BA-3D9C-11F0-A2E7-7AD83F5004C6','DTE-01-S000P001-000000000000022',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-05-30 06:00:00','2025-05-30 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 30/05/2025 al 30/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(24,'24','2025-05-30 16:05:40','10001','06140203981013','00000000000000','','NA',0.00,0.00,105.20,NULL,NULL,1,NULL,'DTE-01-S000P001-000000000000023',2,NULL,12.10,'01',0.00,0.00,105.20,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCO CON VEINTE /100 CTVS',0.00,0.00,20.00,105.20,NULL,105.20,0.00,105.20,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(27,'28','2025-05-30 16:12:20','10001','06140203981013','00000000000000','','NA',0.00,0.00,105.20,NULL,NULL,1,NULL,'DTE-01-S000P001-000000000000026',2,NULL,12.10,'01',0.00,0.00,105.20,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCO CON VEINTE /100 CTVS',0.00,0.00,20.00,105.20,NULL,105.20,0.00,105.20,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(28,'29','2025-05-30 16:12:48','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,NULL,'DTE-01-S000P001-000000000000027',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(29,'30','2025-05-30 16:16:54','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,NULL,'DTE-01-S000P001-000000000000028',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(40,'38','2025-06-03 08:53:44','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,2,'8BF0D6D7-408A-11F0-A2E7-7AD83F5004C6','DTE-01-S000P001-000000000000030',1,_binary '2025E0A0097F2E9043B4A1AB9812D7AC37CDRQ9I',18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,'2025-06-03 08:53:49',NULL),(44,'30','2025-06-03 10:01:28','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,NULL,'DTE-01-S000P000-000000000000001',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(45,'4','2025-06-03 10:01:28','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,NULL,'DTE-01-S000P000-000000000000002',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(46,'5','2025-06-03 10:01:28','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,'07A7A383-409F-11F0-A2E7-7AD83F5004C6','DTE-01-S000P000-000000000000003',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(48,'6','2025-06-03 13:19:44','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,'B4F046D4-40AF-11F0-A2E7-7AD83F5004C6','DTE-01-S000P000-000000000000004',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(49,'7','2025-06-03 13:21:57','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,'0416B21B-40B0-11F0-A2E7-7AD83F5004C6','DTE-01-S000P000-000000000000005',2,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(50,'8','2025-06-03 13:32:04','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,1,'6DD50456-40B1-11F0-A2E7-7AD83F5004C6','DTE-01-S000P000-000000000000006',1,NULL,6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(53,'9','2025-06-03 14:20:45','10001','06140203981013','00000000000000','','NA',0.00,0.00,105.20,NULL,NULL,1,'3AABB8A8-40B8-11F0-A2E7-7AD83F5004C6','DTE-01-S000P000-000000000000007',1,NULL,12.10,'01',0.00,0.00,105.20,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCO CON VEINTE /100 CTVS',0.00,0.00,20.00,105.20,NULL,105.20,0.00,105.20,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(54,'10','2025-06-03 14:21:17','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,2,'4DE7D493-40B8-11F0-A2E7-7AD83F5004C6','DTE-01-S000P000-000000000000008',1,_binary '2025322418A3307841129F62D67DA2E5485FFWUZ',6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,'2025-06-03 14:21:21',NULL),(55,'2','2025-06-03 14:28:46','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,1,'596A53D2-40B9-11F0-A2E7-7AD83F5004C6','DTE-01-MISRP000-000000000000031',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(57,'3','2025-06-03 14:36:14','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,1,'64691587-40BA-11F0-A2E7-7AD83F5004C6','DTE-01-MISRP000-000000000000032',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(59,'4','2025-06-03 14:38:47','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,1,'C01EB6C9-40BA-11F0-A2E7-7AD83F5004C6','DTE-01-MISRP000-000000000000033',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(61,'5','2025-06-03 14:46:34','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,1,'D663E137-40BB-11F0-A2E7-7AD83F5004C6','DTE-01-MISRP000-000000000000034',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(63,'6','2025-06-03 14:52:42','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,1,'B1D48AA4-40BC-11F0-A2E7-7AD83F5004C6','DTE-01-MISRP000-000000000000035',1,NULL,18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(64,'7','2025-06-03 14:53:25','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,2,'CB1140A5-40BC-11F0-A2E7-7AD83F5004C6','DTE-01-MISRP000-000000000000036',1,_binary '2025493B784BC9214776B2D7AB0192488DF7I9YX',18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,'2025-06-03 14:53:29',NULL),(65,'8','2025-06-03 14:54:10','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,158.00,NULL,NULL,2,'E63E0D2D-40BC-11F0-A2E7-7AD83F5004C6','DTE-01-MISRP000-000000000000037',1,_binary '2025A7A9888C494841BBB8614B0191F0270FXIWW',18.18,'01',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,158.00,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,'2025-06-03 14:54:17',NULL),(66,'11','2025-06-03 14:54:44','10001','06140203981013','00000000000000','','NA',0.00,0.00,52.60,NULL,NULL,2,'FA365ACD-40BC-11F0-A2E7-7AD83F5004C6','DTE-01-S000P000-000000000000009',1,_binary '2025486D4368B6A54E3080FD86413AD2C3B8APQ6',6.05,'01',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y DOS CON SESENTA /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,52.60,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,'2025-06-03 14:54:49',NULL),(67,'9','2025-06-03 16:10:45','63110','06141204841181','06141603001014','22617300','G.S.I. El Salvador, S.A. de C.V. ',0.00,0.00,178.54,NULL,'1199782',1,NULL,'DTE-03-MISRP000-000000000000001',1,NULL,20.54,'03',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO SETENTA Y OCHO CON CINCUENTA Y CUATRO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,178.54,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(68,'10','2025-06-03 16:12:18','63110','06141204841181','06141603001014','22617300','G.S.I. El Salvador, S.A. de C.V. ',0.00,0.00,178.54,NULL,'1199782',1,NULL,'DTE-03-MISRP000-000000000000001',1,NULL,20.54,'03',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO SETENTA Y OCHO CON CINCUENTA Y CUATRO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,178.54,NULL,1,0.00,NULL,NULL,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(69,'11','2025-06-03 16:16:41','63110','06141204841181','06141603001014','22617300','G.S.I. El Salvador, S.A. de C.V. ',0.00,0.00,178.54,NULL,'1199782',2,'6CDF4FFE-40C8-11F0-A2E7-7AD83F5004C6','DTE-03-MISRP000-000000000000002',1,_binary '2025CC4CF6F0056A415FA5AB209B9A8C75050D9W',20.54,'03',0.00,0.00,158.00,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO SETENTA Y OCHO CON CINCUENTA Y CUATRO /100 CTVS',0.00,0.00,20.00,158.00,NULL,158.00,0.00,178.54,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,'2025-06-03 16:16:46',NULL),(70,'12','2025-06-03 16:42:20','96092','06141204841181','06141204841181','22336655','Miguel Isaac Sanchez Ramos',0.00,0.00,535.62,NULL,'1875310',1,'0251042C-40CC-11F0-A2E7-7AD83F5004C6','DTE-03-MISRP000-000000000000003',1,NULL,61.62,'03',0.00,0.00,474.00,0.00,0.00,0.00,0.00,0.00,0.00,'QUINIENTOS TREINTA Y CINCO CON SESENTA Y DOS /100 CTVS',0.00,0.00,20.00,474.00,NULL,474.00,0.00,535.62,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(80,'12','2025-06-03 17:10:36','96092','06140203981013','06141204841181','22617300','MIGUEL ISAAC SANCHEZ RAMOS',0.00,0.00,59.44,NULL,'1875310',1,'3324A9BD-40D0-11F0-A2E7-7AD83F5004C6','DTE-03-S000P000-000000000000001',1,NULL,6.84,'03',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y NUEVE CON CUARENTA Y CUATRO /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,59.44,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(81,'13','2025-06-03 18:39:19','96092','06140203981013','06141204841181','22617300','MIGUEL ISAAC SANCHEZ RAMOS',0.00,0.00,59.44,NULL,'1875310',1,'20A7A1F4-40DD-11F0-A2E7-7AD83F5004C6','DTE-03-S000P000-000000000000001',1,NULL,6.84,'03',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y NUEVE CON CUARENTA Y CUATRO /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,59.44,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(82,'14','2025-06-03 18:41:25','96092','06140203981013','06141204841181','22617300','MIGUEL ISAAC SANCHEZ RAMOS',0.00,0.00,118.88,NULL,'1875310',1,'A849878A-40DC-11F0-A2E7-7AD83F5004C6','DTE-03-S000P000-000000000000002',1,NULL,13.68,'03',0.00,0.00,105.20,0.00,0.00,0.00,0.00,0.00,0.00,'CIENTO DIECIOCHO CON OCHENTA Y OCHO /100 CTVS',0.00,0.00,20.00,105.20,NULL,105.20,0.00,118.88,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,NULL,NULL),(83,'15','2025-06-03 18:47:41','96092','06140203981013','06141204841181','22617300','MIGUEL ISAAC SANCHEZ RAMOS',0.00,0.00,59.44,NULL,'1875310',2,'89EAF4CA-40DD-11F0-A2E7-7AD83F5004C6','DTE-03-S000P000-000000000000003',1,_binary '2025A9AAD737EAF74CD0BA6A3F01A6A822FDNQCE',6.84,'03',0.00,0.00,52.60,0.00,0.00,0.00,0.00,0.00,0.00,'CINCUENTA Y NUEVE CON CUARENTA Y CUATRO /100 CTVS',0.00,0.00,20.00,52.60,NULL,52.60,0.00,59.44,NULL,1,0.00,'2025-06-03 06:00:00','2025-06-03 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 03/06/2025 al 03/06/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,2,NULL,0.00,0.00,0.00,0.00,'2025-06-03 18:48:37',NULL);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_detalle`
--

DROP TABLE IF EXISTS `factura_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura_detalle` (
  `det_fac_id` int NOT NULL,
  `det_fac_numlinea` int NOT NULL,
  `det_fac_nro_factura` varchar(15) NOT NULL,
  `det_fac_cantidad` int NOT NULL,
  `det_fac_descripcion` varchar(60) NOT NULL,
  `det_fac_preciounitario` decimal(15,2) DEFAULT NULL,
  `det_fac_subtotal` decimal(15,2) DEFAULT NULL,
  `det_total_operacion` decimal(11,2) DEFAULT NULL COMMENT 'Columna que guarda el monto total de la operación por item',
  `det_fac_nro_credito_fiscal` varchar(20) DEFAULT NULL,
  `det_fac_tipo_item` int NOT NULL,
  `det_fac_unidad_de_medida` int DEFAULT NULL,
  `det_fac_ventasnosujet` decimal(15,2) DEFAULT NULL,
  `det_fac_ventasexentas` decimal(15,2) DEFAULT NULL,
  `det_fact_ventasgravadas` decimal(15,2) DEFAULT NULL,
  `det_fact_iva` decimal(15,2) DEFAULT NULL,
  `det_cantidad_letras` varchar(100) DEFAULT NULL,
  `det_tributo` varchar(5) DEFAULT NULL,
  `det_psv` decimal(15,2) DEFAULT NULL,
  `det_no_gravado` decimal(15,2) DEFAULT NULL,
  `det_iva_item` decimal(15,2) DEFAULT NULL,
  `det_montoDescu` decimal(15,2) DEFAULT NULL,
  `det_codigo` varchar(25) DEFAULT NULL,
  `det_codtributo` varchar(2) DEFAULT NULL,
  `det_numerodocumento_rel` varchar(36) DEFAULT NULL,
  `det_compra` decimal(15,2) DEFAULT NULL COMMENT 'Campo creado unicamente para la factura FSEE (en cuerpoDocumento.Compra)',
  `det_tipo_doc_generacion` int DEFAULT NULL COMMENT 'Requerido unicamente para CRE (comprobante de retencion)',
  `det_ce_empresa` int DEFAULT NULL COMMENT 'Relación con la tabla "Catalogo_empresas" en base al usuario que genero la factura.',
  `det_observacion` varchar(100) DEFAULT NULL COMMENT 'Campo utilizado para la facturas de Sujeto excluido, se imprime en el reporte al generar una factura con observaciones adicionales agregadas en los detelles de productos.',
  `det_retencion_iva` decimal(11,2) DEFAULT NULL,
  `det_retencion_renta` decimal(11,2) DEFAULT NULL,
  `det_retencion_iva_porc` decimal(11,2) DEFAULT NULL,
  `det_retencion_renta_porc` decimal(11,2) DEFAULT NULL,
  `factura_detallecol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`det_fac_id`,`det_fac_numlinea`),
  KEY `fk_id_factura_idx` (`det_fac_id`),
  KEY `fk_retencion_idx` (`det_tipo_doc_generacion`),
  CONSTRAINT `fk_id_factura` FOREIGN KEY (`det_fac_id`) REFERENCES `factura` (`fac_id`),
  CONSTRAINT `fk_retencion` FOREIGN KEY (`det_tipo_doc_generacion`) REFERENCES `catalogo_tipo_generacion_documento` (`ctgd_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_detalle`
--

LOCK TABLES `factura_detalle` WRITE;
/*!40000 ALTER TABLE `factura_detalle` DISABLE KEYS */;
INSERT INTO `factura_detalle` VALUES (1,1,'1',30,'TEST 1',15.80,474.00,NULL,'06141204841181',1,59,0.00,0.00,474.00,54.53,'CUATROCIENTOS SETENTA Y CUATRO CON CERO /100 CTVS','20',0.00,0.00,54.53,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(3,1,'3',20,'TEST 1',15.80,316.00,NULL,'06141204841181',1,59,0.00,0.00,316.00,36.35,'TRESCIENTOS DIECISEIS CON CERO /100 CTVS','20',0.00,0.00,36.35,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(4,1,'4',25,'TEST 1',15.80,395.00,NULL,'06141204841181',1,59,0.00,0.00,395.00,45.44,'TRESCIENTOS NOVENTA Y CINCO CON CERO /100 CTVS','20',0.00,0.00,45.44,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(7,1,'7',15,'TEST 1',15.80,237.00,NULL,'06141204841181',1,59,0.00,0.00,237.00,27.27,'DOSCIENTOS TREINTA Y SIETE CON CERO /100 CTVS','20',0.00,0.00,27.27,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(9,1,'9',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(11,1,'11',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(13,1,'13',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(14,1,'14',15,'TEST 1',15.80,237.00,NULL,'06141204841181',1,59,0.00,0.00,237.00,27.27,'DOSCIENTOS TREINTA Y SIETE CON CERO /100 CTVS','20',0.00,0.00,27.27,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(15,1,'15',20,'TEST 1',15.80,316.00,NULL,'06141204841181',1,59,0.00,0.00,316.00,36.35,'TRESCIENTOS DIECISEIS CON CERO /100 CTVS','20',0.00,0.00,36.35,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(16,1,'16',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(17,1,'17',100,'TEST 1',15.80,1580.00,NULL,'06141204841181',1,59,0.00,0.00,1580.00,181.77,'MIL QUINIENTOS OCHENTA CON CERO /100 CTVS','20',0.00,0.00,181.77,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL),(18,1,'18',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(19,1,'19',10,'TEST 1',25.00,250.00,NULL,'06141204841181',1,59,0.00,0.00,250.00,28.76,'DOSCIENTOS CINCUENTA CON CERO /100 CTVS','20',0.00,0.00,28.76,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(20,1,'20',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(21,1,'21',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(22,1,'22',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(23,1,'23',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(24,1,'28',20,'TEST_STC',5.26,105.20,NULL,'06140203981013',1,59,0.00,0.00,105.20,12.10,'CIENTO CINCO CON VEINTE /100 CTVS','20',0.00,0.00,12.10,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(27,1,'28',20,'TEST_STC',5.26,105.20,NULL,'06140203981013',1,59,0.00,0.00,105.20,12.10,'CIENTO CINCO CON VEINTE /100 CTVS','20',0.00,0.00,12.10,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(28,1,'29',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(29,1,'30',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(40,1,'38',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(44,1,'30',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(45,1,'4',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(46,1,'5',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(48,1,'6',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(49,1,'7',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(50,1,'8',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(53,1,'9',20,'TEST_STC',5.26,105.20,NULL,'06140203981013',1,59,0.00,0.00,105.20,12.10,'CIENTO CINCO CON VEINTE /100 CTVS','20',0.00,0.00,12.10,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(54,1,'10',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(55,1,'2',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(57,1,'3',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(59,1,'4',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(61,1,'5',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(63,1,'6',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(64,1,'7',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(65,1,'8',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,18.18,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,18.18,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(66,1,'11',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.05,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.05,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(67,1,'9',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,20.54,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,20.54,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(68,1,'10',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,20.54,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,20.54,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(69,1,'11',10,'TEST 1',15.80,158.00,NULL,'06141204841181',1,59,0.00,0.00,158.00,20.54,'CIENTO CINCUENTA Y OCHO CON CERO /100 CTVS','20',0.00,0.00,20.54,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(70,1,'12',30,'TEST 1',15.80,474.00,NULL,'06141204841181',1,59,0.00,0.00,474.00,61.62,'CUATROCIENTOS SETENTA Y CUATRO CON CERO /100 CTVS','20',0.00,0.00,61.62,0.00,'1',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(80,1,'12',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.84,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.84,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(81,1,'13',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.84,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.84,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(82,1,'14',20,'TEST_STC',5.26,105.20,NULL,'06140203981013',1,59,0.00,0.00,105.20,13.68,'CIENTO CINCO CON VEINTE /100 CTVS','20',0.00,0.00,13.68,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL),(83,1,'15',10,'TEST_STC',5.26,52.60,NULL,'06140203981013',1,59,0.00,0.00,52.60,6.84,'CINCUENTA Y DOS CON SESENTA /100 CTVS','20',0.00,0.00,6.84,0.00,'01',NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,0.00,0.00,NULL);
/*!40000 ALTER TABLE `factura_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jsongen`
--

DROP TABLE IF EXISTS `jsongen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jsongen` (
  `J_idfact` bigint NOT NULL AUTO_INCREMENT,
  `J_fact` varchar(100) NOT NULL,
  `j_doc` json NOT NULL,
  PRIMARY KEY (`J_idfact`),
  UNIQUE KEY `J_FACT` (`J_fact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jsongen`
--

LOCK TABLES `jsongen` WRITE;
/*!40000 ALTER TABLE `jsongen` DISABLE KEYS */;
/*!40000 ALTER TABLE `jsongen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nosecuencia_factura`
--

DROP TABLE IF EXISTS `nosecuencia_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nosecuencia_factura` (
  `nosec_id` int NOT NULL AUTO_INCREMENT,
  `nosec_anio` int DEFAULT NULL,
  `nosec_tcp_idtipo` int DEFAULT NULL,
  `nosec_secuencia` int DEFAULT NULL,
  `nosec_ruc_id` int DEFAULT NULL,
  `nosec_ce_empresa` int DEFAULT NULL COMMENT 'Id de la empresa en basde al "Catalogo de empresas" según relacion con la tabla usuarios, lleva el control del número de emitidos (DTE) en base a cada empresa.',
  PRIMARY KEY (`nosec_id`),
  KEY `fk_ruc_id_idx` (`nosec_ruc_id`),
  KEY `fk_tipo_comprobante_idx` (`nosec_tcp_idtipo`),
  CONSTRAINT `fk_ruc_id` FOREIGN KEY (`nosec_ruc_id`) REFERENCES `contribuyentes` (`ruc_id`),
  CONSTRAINT `fk_tipo_comprobante` FOREIGN KEY (`nosec_tcp_idtipo`) REFERENCES `tipos_comprobantes` (`tcp_idtipo`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nosecuencia_factura`
--

LOCK TABLES `nosecuencia_factura` WRITE;
/*!40000 ALTER TABLE `nosecuencia_factura` DISABLE KEYS */;
INSERT INTO `nosecuencia_factura` VALUES (1,2025,1,37,1,1),(2,2025,4,0,1,NULL),(3,2025,7,0,1,NULL),(49,2025,2,0,1,NULL),(60,2025,1,9,1,2),(61,2025,2,3,1,1),(71,2025,2,3,1,2);
/*!40000 ALTER TABLE `nosecuencia_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `idpagos` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) DEFAULT NULL,
  `montopago` decimal(15,2) DEFAULT NULL,
  `plazo` varchar(45) DEFAULT NULL,
  `referencia` varchar(45) DEFAULT NULL,
  `periodo` int DEFAULT NULL,
  `id_fac` int DEFAULT NULL,
  `ce_empresa` int DEFAULT NULL COMMENT 'ID de empresa en base al "Catalogo_empresas" según lo registrado por el usuario de ingreso.',
  PRIMARY KEY (`idpagos`),
  KEY `FK_PAGOS_idx` (`id_fac`),
  CONSTRAINT `FK_PAGOS` FOREIGN KEY (`id_fac`) REFERENCES `factura` (`fac_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,'01',474.00,'01','',0,1,NULL),(3,'01',316.00,'01','',0,3,NULL),(4,'01',395.00,'01','',0,4,NULL),(7,'01',237.00,'01','',0,7,NULL),(9,'01',158.00,'01','',0,9,NULL),(11,'01',158.00,'01','',0,11,NULL),(13,'01',158.00,'01','',0,13,NULL),(14,'01',237.00,'01','',0,14,NULL),(15,'01',316.00,'01','',0,15,NULL),(16,'01',158.00,'01','',0,16,NULL),(17,'01',1580.00,'01','',0,17,NULL),(18,'01',158.00,'01',NULL,0,18,NULL),(19,'01',250.00,'01',NULL,0,19,NULL),(20,'01',52.60,'01',NULL,0,20,NULL),(21,'01',52.60,'01',NULL,0,21,NULL),(22,'01',52.60,'01',NULL,0,22,NULL),(23,'01',52.60,'01',NULL,0,23,NULL),(24,'01',105.20,'01',NULL,0,24,NULL),(25,'01',105.20,'01',NULL,0,27,NULL),(26,'01',52.60,'01',NULL,0,28,NULL),(27,'01',52.60,'01',NULL,0,29,NULL),(33,'01',158.00,'01',NULL,0,40,NULL),(37,'01',52.60,'01',NULL,0,44,NULL),(38,'01',52.60,'01',NULL,0,45,NULL),(39,'01',52.60,'01',NULL,0,46,NULL),(41,'01',52.60,'01',NULL,0,48,NULL),(42,'01',52.60,'01',NULL,0,49,NULL),(43,'01',52.60,'01',NULL,0,50,NULL),(46,'01',105.20,'01',NULL,0,53,NULL),(47,'01',52.60,'01',NULL,0,54,NULL),(48,'01',158.00,'01',NULL,0,55,NULL),(50,'01',158.00,'01',NULL,0,57,NULL),(52,'01',158.00,'01',NULL,0,59,NULL),(54,'01',158.00,'01',NULL,0,61,NULL),(56,'01',158.00,'01',NULL,0,63,NULL),(57,'01',158.00,'01',NULL,0,64,NULL),(58,'01',158.00,'01',NULL,0,65,NULL),(59,'01',52.60,'01',NULL,0,66,NULL),(60,'01',178.54,'01',NULL,0,67,NULL),(61,'01',178.54,'01',NULL,0,68,NULL),(62,'01',178.54,'01',NULL,0,69,NULL),(63,'01',535.62,'01',NULL,0,70,NULL),(73,'01',59.44,'01',NULL,0,80,NULL),(74,'01',59.44,'01',NULL,0,81,NULL),(75,'01',118.88,'01',NULL,0,82,NULL),(76,'01',59.44,'01',NULL,0,83,NULL);
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametros_generales`
--

DROP TABLE IF EXISTS `parametros_generales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametros_generales` (
  `pgn_id` int NOT NULL AUTO_INCREMENT,
  `pgn_descripcion` text,
  `pgn_valor` text,
  `pgn_campo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`pgn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametros_generales`
--

LOCK TABLES `parametros_generales` WRITE;
/*!40000 ALTER TABLE `parametros_generales` DISABLE KEYS */;
INSERT INTO `parametros_generales` VALUES (1,'Para la generacion de los JSON en catalogo de MH 00 indica pruebas y 01 produccion ','00','version'),(2,'Para la generacion de los JSON en CAT-003 de MH se indica que 1 es modelo de facturacion previo y 2 es modelo de facturacion diferido','1','tipoModelo'),(3,'Generacion JSON en CAT-004 se indica que transmision 1 es normal y 2 es por contigencia','1','tipoOperacion'),(4,'Para JSON en normativa MH indico que debe ser USD','USD','tipoMoneda'),(5,'código de Casa Matriz, sucursal o Agencia, Bodega y/o Predio o Patio (4 dígitos Alfanumérico) seguido del código de punto venta (4 dígitos alfanumérico)','MUMH5645',NULL);
/*!40000 ALTER TABLE `parametros_generales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametros_mh`
--

DROP TABLE IF EXISTS `parametros_mh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametros_mh` (
  `pm_id` int NOT NULL AUTO_INCREMENT,
  `pm_json_firmador_nit` varchar(20) DEFAULT NULL,
  `pm_json_firmador_pass` varchar(20) DEFAULT NULL,
  `pm_json_firmador_url` varchar(100) DEFAULT NULL,
  `pm_json_auth_user` varchar(45) DEFAULT NULL,
  `pm_json_auth_pass` varchar(45) DEFAULT NULL,
  `pm_json_auth_url` varchar(70) DEFAULT NULL,
  `pm_json_fesv_mh_version` int DEFAULT NULL,
  `pm_json_fesv_mh_ambiente` varchar(2) DEFAULT NULL,
  `pm_json_fesv_mh_idenvio` int DEFAULT NULL,
  `pm_json_fesv_mh_url` varchar(70) DEFAULT NULL,
  `pm_qr_link` varchar(70) DEFAULT NULL,
  `pm_anulaciondte_url` varchar(70) DEFAULT NULL,
  `pm_anulaciondte_version` int DEFAULT NULL,
  `id_empresa` int DEFAULT NULL,
  `certificado` varchar(20) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`pm_id`),
  KEY `fk_pm_json_firmador_nit_idx` (`pm_json_firmador_nit`),
  CONSTRAINT `fk_pm_json_firmador_nit` FOREIGN KEY (`pm_json_firmador_nit`) REFERENCES `contribuyentes` (`ruc_nit_contribuyente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametros_mh`
--

LOCK TABLES `parametros_mh` WRITE;
/*!40000 ALTER TABLE `parametros_mh` DISABLE KEYS */;
INSERT INTO `parametros_mh` VALUES (1,'06141204841181','wkf2Z7Xmd$kkcjR','http://34.225.63.188:8081/firma/firmardocumento/','06141204841181','Gx9@Lm27q#','https://apitest.dtes.mh.gob.sv/seguridad/auth',1,'00',1,'https://apitest.dtes.mh.gob.sv/fesv/recepciondte','https://admin.factura.gob.sv/consultaPublica?ambiente=','https://apitest.dtes.mh.gob.sv/fesv/anulardte',2,1,NULL,NULL),(2,'06140203981013','xiXDPXyG75kppZ','http://34.225.63.188:8081/firma/firmardocumento/','06140203981013','S3rt4acen2022$','https://apitest.dtes.mh.gob.sv/seguridad/auth',1,'00',1,'https://apitest.dtes.mh.gob.sv/fesv/recepciondte','https://admin.factura.gob.sv/consultaPublica?ambiente=','https://apitest.dtes.mh.gob.sv/fesv/anulardte',2,1,NULL,NULL);
/*!40000 ALTER TABLE `parametros_mh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `punto_venta`
--

DROP TABLE IF EXISTS `punto_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `punto_venta` (
  `id_punto_venta` int NOT NULL AUTO_INCREMENT,
  `id_establecimiento` int NOT NULL,
  `nombre_punto_venta` varchar(150) NOT NULL,
  `codigo_punto_venta` varchar(4) DEFAULT NULL,
  `codigo_punto_venta_mh` varchar(4) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_punto_venta`),
  KEY `establecimiento_punto_venta_fk` (`id_establecimiento`),
  CONSTRAINT `establecimiento_punto_venta_fk` FOREIGN KEY (`id_establecimiento`) REFERENCES `establecimiento` (`id_establecimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `punto_venta`
--

LOCK TABLES `punto_venta` WRITE;
/*!40000 ALTER TABLE `punto_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `punto_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retenciones`
--

DROP TABLE IF EXISTS `retenciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retenciones` (
  `ret_id` int NOT NULL AUTO_INCREMENT,
  `ret_numitem` int DEFAULT NULL,
  `ret_tipodte` varchar(2) DEFAULT NULL,
  `ret_numdocumento` varchar(45) DEFAULT NULL,
  `ret_fechaemision` date DEFAULT NULL,
  `ret_montosujetograv` decimal(15,2) DEFAULT NULL,
  `ret_iva` decimal(15,2) DEFAULT NULL,
  `ret_descripcion` varchar(100) DEFAULT NULL,
  `ret_fac_id` int DEFAULT NULL,
  `ret_tipodoc` int DEFAULT NULL,
  `ret_ce_empresa` int DEFAULT NULL,
  PRIMARY KEY (`ret_id`),
  KEY `fk_factura_idx` (`ret_fac_id`),
  CONSTRAINT `fk_factura` FOREIGN KEY (`ret_fac_id`) REFERENCES `factura` (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Tabla utilizada para el documento "Factura de Retencion" para el cuerpoDocumento.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retenciones`
--

LOCK TABLES `retenciones` WRITE;
/*!40000 ALTER TABLE `retenciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `retenciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_parqueo`
--

DROP TABLE IF EXISTS `tickets_parqueo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_parqueo` (
  `id_correlativo` int NOT NULL AUTO_INCREMENT,
  `secuencia_qr` int DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `estado` varchar(10) DEFAULT NULL,
  `fecha_cobro` datetime DEFAULT NULL,
  `usuario_ingreso` varchar(50) DEFAULT NULL,
  `usuario_cobro` varchar(50) DEFAULT NULL,
  `id_factura_generado` int DEFAULT NULL,
  `valor_cobro` decimal(15,2) DEFAULT NULL,
  `tipo_placa` varchar(5) DEFAULT NULL,
  `ulb_user_ingreso` varchar(15) DEFAULT NULL,
  `ulb_user_cobro` varchar(15) DEFAULT NULL,
  `placa` varchar(45) DEFAULT NULL,
  `id_vehiculo` decimal(10,0) DEFAULT NULL,
  `cortesia` varchar(2) DEFAULT NULL,
  `usuario_cortesia` varchar(50) DEFAULT NULL,
  `hora_cortesia` time DEFAULT NULL,
  `dui` varchar(10) DEFAULT NULL,
  `nombres` varchar(60) DEFAULT NULL,
  `apellidos` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id_correlativo`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_parqueo`
--

LOCK TABLES `tickets_parqueo` WRITE;
/*!40000 ALTER TABLE `tickets_parqueo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_parqueo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_comprobantes`
--

DROP TABLE IF EXISTS `tipos_comprobantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_comprobantes` (
  `tcp_idtipo` int NOT NULL,
  `tcp_comprobante` varchar(5) DEFAULT NULL,
  `tcp_descomprobante` varchar(200) DEFAULT NULL,
  `tcp_idtipcom` varchar(2) DEFAULT NULL,
  `tcp_version` int DEFAULT NULL,
  PRIMARY KEY (`tcp_idtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_comprobantes`
--

LOCK TABLES `tipos_comprobantes` WRITE;
/*!40000 ALTER TABLE `tipos_comprobantes` DISABLE KEYS */;
INSERT INTO `tipos_comprobantes` VALUES (1,'FE','Factura','01',1),(2,'CCFE','Comprobante de Crédito Fiscal','03',3),(3,'NRE','Nota de remisión','04',3),(4,'NCE','Nota de crédito','05',3),(6,'NDE','Nota de débito','06',3),(7,'CRE','Comprobante de retención','07',1),(8,'CLE','Comprobante de liquidación','08',NULL),(9,'DCLE','Documento contable de liquidación','09',NULL),(11,'FEXE','Facturas de exportación','11',1),(14,'FSEE','Factura de sujeto excluido','14',1),(15,'CDE','Comprobante de donación','15',NULL);
/*!40000 ALTER TABLE `tipos_comprobantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_documentos`
--

DROP TABLE IF EXISTS `tipos_documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_documentos` (
  `doc_id` int NOT NULL AUTO_INCREMENT,
  `doc_idtipo_documento` int DEFAULT NULL,
  `doc_nombre_documento` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `TP_ID_idx` (`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_documentos`
--

LOCK TABLES `tipos_documentos` WRITE;
/*!40000 ALTER TABLE `tipos_documentos` DISABLE KEYS */;
INSERT INTO `tipos_documentos` VALUES (1,36,'NIT'),(2,13,'DUI');
/*!40000 ALTER TABLE `tipos_documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tmp_factura`
--

DROP TABLE IF EXISTS `tmp_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tmp_factura` (
  `idtmp_factura` int NOT NULL AUTO_INCREMENT,
  `fecha` varchar(40) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `producto` varchar(45) DEFAULT NULL,
  `JSON_TEST` json DEFAULT NULL,
  `sucursal` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtmp_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=2499 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tmp_factura`
--

LOCK TABLES `tmp_factura` WRITE;
/*!40000 ALTER TABLE `tmp_factura` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tributos`
--

DROP TABLE IF EXISTS `tributos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tributos` (
  `tri_fac_id` int NOT NULL,
  `tri_codigo` varchar(5) NOT NULL,
  `tri_descripcion` varchar(150) DEFAULT NULL,
  `tri_valor` decimal(15,2) DEFAULT NULL,
  `tri_ce_empresa` int DEFAULT NULL COMMENT 'Relación con la tabla "Catalogo_empresas" en base al usuario que genero la factura.',
  PRIMARY KEY (`tri_fac_id`,`tri_codigo`),
  CONSTRAINT `fk_tri_fac_id` FOREIGN KEY (`tri_fac_id`) REFERENCES `factura` (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tributos`
--

LOCK TABLES `tributos` WRITE;
/*!40000 ALTER TABLE `tributos` DISABLE KEYS */;
INSERT INTO `tributos` VALUES (1,'20','Impuesto al Valor Agregado 13%',54.53,NULL),(3,'20','Impuesto al Valor Agregado 13%',36.35,NULL),(4,'20','Impuesto al Valor Agregado 13%',45.44,NULL),(7,'20','Impuesto al Valor Agregado 13%',27.27,NULL),(9,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(11,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(13,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(14,'20','Impuesto al Valor Agregado 13%',27.27,NULL),(15,'20','Impuesto al Valor Agregado 13%',36.35,NULL),(16,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(17,'20','Impuesto al Valor Agregado 13%',181.77,NULL),(18,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(19,'20','Impuesto al Valor Agregado 13%',28.76,NULL),(20,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(21,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(22,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(23,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(24,'20','Impuesto al Valor Agregado 13%',12.10,NULL),(27,'20','Impuesto al Valor Agregado 13%',12.10,NULL),(28,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(29,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(40,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(44,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(45,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(46,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(48,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(49,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(50,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(53,'20','Impuesto al Valor Agregado 13%',12.10,NULL),(54,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(55,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(57,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(59,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(61,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(63,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(64,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(65,'20','Impuesto al Valor Agregado 13%',18.18,NULL),(66,'20','Impuesto al Valor Agregado 13%',6.05,NULL),(67,'20','Impuesto al Valor Agregado 13%',20.54,NULL),(68,'20','Impuesto al Valor Agregado 13%',20.54,NULL),(69,'20','Impuesto al Valor Agregado 13%',20.54,NULL),(70,'20','Impuesto al Valor Agregado 13%',61.62,NULL),(80,'20','Impuesto al Valor Agregado 13%',6.84,NULL),(81,'20','Impuesto al Valor Agregado 13%',6.84,NULL),(82,'20','Impuesto al Valor Agregado 13%',13.68,NULL),(83,'20','Impuesto al Valor Agregado 13%',6.84,NULL);
/*!40000 ALTER TABLE `tributos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tributos_por_comprobantes`
--

DROP TABLE IF EXISTS `tributos_por_comprobantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tributos_por_comprobantes` (
  `tpc_id` int NOT NULL AUTO_INCREMENT,
  `tpc_idcatalogo_tributos` int NOT NULL,
  `tpc_tcp_idtipo` int NOT NULL,
  PRIMARY KEY (`tpc_id`),
  KEY `fk_tpc_idcatalogo_tributos` (`tpc_idcatalogo_tributos`),
  KEY `fk_tpc_tcp_idtipo` (`tpc_tcp_idtipo`),
  CONSTRAINT `fk_tpc_idcatalogo_tributos` FOREIGN KEY (`tpc_idcatalogo_tributos`) REFERENCES `catalogo_tributos` (`idcatalogo_tributos`),
  CONSTRAINT `fk_tpc_tcp_idtipo` FOREIGN KEY (`tpc_tcp_idtipo`) REFERENCES `tipos_comprobantes` (`tcp_idtipo`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tributos_por_comprobantes`
--

LOCK TABLES `tributos_por_comprobantes` WRITE;
/*!40000 ALTER TABLE `tributos_por_comprobantes` DISABLE KEYS */;
INSERT INTO `tributos_por_comprobantes` VALUES (1,1,2),(2,2,2),(3,3,2),(4,4,2),(5,5,2),(6,6,2),(7,7,2),(8,8,2),(9,13,2),(10,14,2),(11,15,2),(12,16,2),(13,17,2),(14,18,2),(15,19,2),(16,20,2),(17,21,2),(18,22,2),(19,23,2),(20,24,2),(21,25,2),(22,26,2),(23,27,2),(24,28,2),(25,29,2),(26,30,2),(27,31,2),(28,32,2),(29,33,2),(30,34,2),(31,35,2),(32,36,2),(33,37,2),(34,38,2),(35,39,2),(36,40,2),(37,41,2),(38,42,2),(39,43,2),(40,44,2),(41,45,2),(42,46,2),(43,47,2),(44,2,1),(45,3,1),(46,4,1),(47,5,1),(48,6,1),(49,7,1),(50,8,1),(51,13,1),(52,14,1),(53,15,1),(54,16,1),(55,17,1),(56,18,1),(57,19,1),(58,20,1),(59,21,1),(60,22,1),(61,23,1),(62,24,1),(63,25,1),(64,26,1),(65,27,1),(66,28,1),(67,29,1),(68,30,1),(69,31,1),(70,32,1),(71,33,1),(72,34,1),(73,35,1),(74,36,1),(75,37,1),(76,38,1),(77,39,1),(78,40,1),(79,41,1),(80,42,1),(81,43,1),(82,44,1),(83,45,1),(84,46,1),(85,47,1),(86,1,1),(87,1,4),(88,2,4),(89,3,4),(90,4,4),(91,5,4),(92,6,4),(93,7,4),(94,8,4),(95,1,6),(96,2,6),(97,3,6),(98,4,6),(99,5,6),(100,6,6),(101,7,6),(102,8,6);
/*!40000 ALTER TABLE `tributos_por_comprobantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicaciones_geograficas`
--

DROP TABLE IF EXISTS `ubicaciones_geograficas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicaciones_geograficas` (
  `ubg_id_geograficas` int NOT NULL AUTO_INCREMENT,
  `ubg_codigo` varchar(4) DEFAULT NULL,
  `ubg_descripcion` varchar(200) DEFAULT NULL,
  `ugb_iddepto` int DEFAULT NULL,
  PRIMARY KEY (`ubg_id_geograficas`),
  KEY `fk_iddepto_idx` (`ugb_iddepto`),
  KEY `fk_id_depto_idx` (`ugb_iddepto`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicaciones_geograficas`
--

LOCK TABLES `ubicaciones_geograficas` WRITE;
/*!40000 ALTER TABLE `ubicaciones_geograficas` DISABLE KEYS */;
INSERT INTO `ubicaciones_geograficas` VALUES (1,'00','otro pais',1),(2,'01','AHUACHAPAN',1),(3,'02','APANECA',1),(4,'03','ATIQUIZAYA',1),(5,'04','CONCEPCION DE ATACO',1),(6,'05','EL REFUGIO',1),(7,'06','GUAYMANGO',1),(8,'07','JUJUTLA',1),(9,'08','SAN FRANCISCO MENENDEZ',1),(10,'09','SAN LORENZO',1),(11,'10','SAN PEDRO PUXTLA',1),(12,'11','TACUBA',1),(13,'12','TURIN',1),(15,'01','CANDELARIA DE LA FRONTERA',2),(16,'02','COATEPEQUE',2),(17,'03','CHALCHUAPA',2),(18,'04','EL CONGO',2),(19,'05','EL PORVENIR',2),(20,'06','MASAHUAT',2),(21,'07','METAPAN',2),(22,'08','SAN ANTONIO PAJONAL',2),(23,'09','SAN SEBASTIAN SALITRILLO',2),(24,'10','SANTA ANA',2),(25,'11','STA ROSA GUACHI',2),(26,'12','STGO D LA FRONT',2),(27,'13','TEXISTEPEQUE',2),(29,'01','ACAJUTLA',3),(30,'02','ARMENIA',3),(31,'03','CALUCO',3),(32,'04','CUISNAHUAT',3),(33,'05','STA I ISHUATAN',3),(34,'06','IZALCO',3),(35,'07','JUAYUA',3),(36,'08','NAHUIZALCO',3),(37,'09','NAHULINGO',3),(38,'10','SALCOATITAN',3),(39,'11','SAN ANTONIO DEL MONTE',3),(40,'12','SAN JULIAN',3),(41,'13','STA C MASAHUAT',3),(42,'14','SANTO DOMINGO GUZMAN',3),(43,'15','SONSONATE',3),(44,'16','SONZACATE',3),(46,'01','AGUA CALIENTE',4),(47,'02','ARCATAO',4),(48,'03','AZACUALPA',4),(49,'04','CITALA',4),(50,'05','COMALAPA',4),(51,'06','CONCEPCION QUEZALTEPEQUE',4),(52,'07','CHALATENANGO',4),(53,'08','DULCE NOMBRE DE MARIA',4),(54,'09','EL CARRIZAL',4),(55,'10','EL PARAISO',4),(56,'11','LA LAGUNA',4),(57,'12','LA PALMA',4),(58,'13','LA REINA',4),(59,'14','LAS VUELTAS',4),(60,'15','NOMBRE DE JESUS',4),(61,'16','NVA CONCEPCION',4),(62,'17','NUEVA TRINIDAD',4),(63,'18','OJO DE AGUA',4),(64,'19','POTONICO',4),(65,'20','SAN ANT LA CRUZ',4),(66,'21','SAN ANT RANCHOS',4),(67,'22','SAN FERNANDO',4),(68,'23','SAN FRANCISCO LEMPA',4),(69,'24','SAN FRANCISCO MORAZAN',4),(70,'25','SAN IGNACIO',4),(71,'26','SAN I LABRADOR',4),(72,'27','SAN J CANCASQUE',4),(73,'28','SAN JOSE LAS FLORES',4),(74,'29','SAN LUIS CARMEN',4),(75,'30','SN MIG MERCEDES',4),(77,'01','ANTGO CUSCATLAN',5),(78,'02','CIUDAD ARCE',5),(79,'03','COLON',5),(80,'04','COMASAGUA',5),(81,'05','CHILTIUPAN',5),(82,'06','HUIZUCAR',5),(83,'07','JAYAQUE',5),(84,'08','JICALAPA',5),(85,'09','LA LIBERTAD',5),(86,'10','NUEVO CUSCATLAN',5),(87,'11','SANTA TECLA',5),(88,'12','QUEZALTEPEQUE',5),(89,'13','SACACOYO',5),(90,'14','SN J VILLANUEVA',5),(91,'15','SAN JUAN OPICO',5),(92,'16','SAN MATIAS',5),(93,'17','SAN P TACACHICO',5),(94,'18','TAMANIQUE',5),(95,'19','TALNIQUE',5),(96,'20','TEOTEPEQUE',5),(97,'21','TEPECOYO',5),(98,'22','ZARAGOZA',5),(99,'01','AGUILARES',6),(100,'02','APOPA',6),(101,'03','AYUTUXTEPEQUE',6),(102,'04','CUSCATANCINGO',6),(103,'05','EL PAISNAL',6),(104,'06','GUAZAPA',6),(105,'07','ILOPANGO',6),(106,'08','MEJICANOS',6),(107,'09','NEJAPA',6),(108,'10','PANCHIMALCO',6),(109,'11','ROSARIO DE MORA',6),(110,'12','SAN MARCOS',6),(111,'13','SAN MARTIN',6),(112,'14','SAN SALVADOR',6),(113,'15','STG TEXACUANGOS',6),(114,'16','SANTO TOMAS',6),(115,'17','SOYAPANGO',6),(116,'18','TONACATEPEQUE',6),(117,'19','CIUDAD DELGAGO',6),(118,'01','CANDELARIA',7),(119,'02','COJUTEPEQUE',7),(120,'03','EL CARMEN',7),(121,'04','EL ROSARIO',7),(122,'05','MONTE SAN JUAN',7),(123,'06','ORAT CONCEPCION',7),(124,'07','SAN B PERULAPIA',7),(125,'08','SAN CRISTOBAL',7),(126,'09','SAN J GUAYABAL',7),(127,'10','SAN P PERULAPAN',7),(128,'11','SAN RAF CEDROS',7),(129,'12','SAN RAMON',7),(130,'13','STA C ANALQUITO',7),(131,'14','STA C MICHAPA',7),(132,'15','SUCHITOTO',7),(133,'16','TENANCINGO',7),(135,'01','CUYULTITAN',8),(136,'02','EL ROSARIO',8),(137,'03','JERUSALEN',8),(138,'04','MERCED LA CEIBA',8),(139,'05','OLOCUILTA',8),(140,'06','PARAISO OSORIO',8),(141,'07','SN ANT MASAHUAT',8),(142,'08','SAN EMIGDIO',8),(143,'09','SN FCO CHINAMEC',8),(144,'10','SAN J NONUALCO',8),(145,'11','SAN JUAN TALPA',8),(146,'12','SAN JUAN TEPEZONTES',8),(147,'13','SAN LUIS TALPA',8),(148,'14','SAN MIGUEL TEPEZONTES',8),(149,'15','SAN PEDRO MASAHUAT',8),(150,'16','SAN PEDRO NONUALCO',8),(151,'17','SAN R OBRAJUELO',8),(152,'18','STA MA OSTUMA',8),(153,'19','STGO NONUALCO',8),(154,'20','TAPALHUACA',8),(155,'21','ZACATECOLUCA',8),(156,'22','SAN LUIS LA HERRADURA',8),(158,'01','CINQUERA',9),(159,'02','GUACOTECTI',9),(160,'03','ILOBASCO',9),(161,'04','JUTIAPA',9),(162,'05','SAN ISIDRO',9),(163,'06','SENSUNTEPEQUE',9),(164,'07','TEJUTEPEQUE',9),(165,'08','VICTORIA',9),(166,'09','VILLA DOLORES',9),(168,'01','APASTEPEQUE',10),(169,'02','GUADALUPE',10),(170,'03','SAN CAY ISTEPEQ',10),(171,'04','SANTA CLARA',10),(172,'05','SANTO DOMINGO',10),(173,'06','SN EST CATARINA',10),(174,'07','SAN ILDEFONSO',10),(175,'08','SAN LORENZO',10),(176,'09','SAN SEBASTIAN',10),(177,'10','SAN VICENTE',10),(178,'11','TECOLUCA',10),(179,'12','TEPETITAN',10),(180,'13','VERAPAZ',10),(182,'01','ALEGRIA',11),(183,'02','BERLIN',11),(184,'03','CALIFORNIA',11),(185,'04','CONCEP BATRES',11),(186,'05','EL TRIUNFO',11),(187,'06','EREGUAYQUIN',11),(188,'07','ESTANZUELAS',11),(189,'08','JIQUILISCO',11),(190,'09','JUCUAPA',11),(191,'10','JUCUARAN',11),(192,'11','MERCEDES UMAÑA',11),(193,'12','NUEVA GRANADA',11),(194,'13','OZATLAN',11),(195,'14','PTO EL TRIUNFO',11),(196,'15','SAN AGUSTIN',11),(197,'16','SN BUENAVENTURA',11),(198,'17','SAN DIONISIO',11),(199,'18','SANTA ELENA',11),(200,'19','SAN FCO JAVIER',11),(201,'20','SANTA MARIA',11),(202,'21','STGO DE MARIA',11),(204,'01','CAROLINA',12),(205,'02','CIUDAD BARRIOS',12),(206,'03','COMACARAN',12),(207,'04','CHAPELTIQUE',12),(208,'05','CHINAMECA',12),(209,'06','CHIRILAGUA',12),(210,'07','EL TRANSITO',12),(211,'08','LOLOTIQUE',12),(212,'09','MONCAGUA',12),(213,'10','NUEVA GUADALUPE',12),(214,'11','NUEVO EDEN SAN JUAN',12),(215,'12','QUELEPA',12),(216,'13','SAN ANT D MOSCO',12),(217,'14','SAN GERARDO',12),(218,'15','SAN JORGE',12),(219,'16','SAN LUIS DE LA REINA',12),(220,'17','SAN MIGUEL',12),(221,'18','SAN RAF ORIENTE',12),(222,'19','SESORI',12),(223,'20','ULUAZAPA',12),(225,'01','ARAMBALA',13),(226,'02','CACAOPERA',13),(227,'03','CORINTO',13),(228,'04','CHILANGA',13),(229,'05','DELIC DE CONCEP',13),(230,'06','EL DIVISADERO',13),(231,'07','EL ROSARIO',13),(232,'08','GUALOCOCTI',13),(233,'09','GUATAJIAGUA',13),(234,'10','JOATECA',13),(235,'11','JOCOAITIQUE',13),(236,'12','JOCORO',13),(237,'13','LOLOTIQUILLO',13),(238,'14','MEANGUERA',13),(239,'15','OSICALA',13),(240,'16','PERQUIN',13),(241,'17','SAN CARLOS',13),(242,'18','SAN FERNANDO',13),(243,'19','SAN FCO GOTERA',13),(244,'20','SAN ISIDRO',13),(245,'21','SAN SIMON',13),(246,'22','SENSEMBRA',13),(247,'23','SOCIEDAD',13),(248,'24','TOROLA',13),(249,'25','YAMABAL',13),(251,'01','ANAMOROS',14),(252,'02','BOLIVAR',14),(253,'03','CONCEP DE OTE',14),(254,'04','CONCHAGUA',14),(255,'05','EL CARMEN',14),(256,'06','EL SAUCE',14),(257,'07','INTIPUCA',14),(258,'08','LA UNION',14),(259,'09','LISLIQUE',14),(260,'10','MEANG DEL GOLFO',14),(261,'11','NUEVA ESPARTA',14),(262,'12','PASAQUINA',14),(263,'13','POLOROS',14),(264,'14','SAN ALEJO',14),(265,'15','SAN JOSE',14),(266,'16','SANTA ROSA LIMA',14),(267,'17','YAYANTIQUE',14),(268,'18','YUCUAIQUIN',14),(269,'01',' Ahuachapán',0),(270,'02',' Santa Ana',0),(271,'03',' Sonsonate',0),(272,'04',' Chalatenango',0),(273,'05',' La Libertad',0),(274,'06','San Salvador',0),(275,'07',' Cuscatlán',0),(276,'08',' La Paz',0),(277,'09',' Cabañas',0),(278,'10',' San Vicente',0),(279,'11',' Usulután',0),(280,'12',' San Miguel',0),(281,'13',' Morazán',0),(282,'14',' La Unión',0),(283,'31','SAN RAFAEL',4),(284,'32','SANTA RITA',4),(285,'33','TEJUTLA',4),(286,'22','TECAPAN',11),(287,'23','USULUTAN',11),(288,'26','YOLOAIQUÍN',13);
/*!40000 ALTER TABLE `ubicaciones_geograficas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades_laborales`
--

DROP TABLE IF EXISTS `unidades_laborales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidades_laborales` (
  `ulb_id` int NOT NULL AUTO_INCREMENT,
  `ulb_codigo` varchar(5) DEFAULT NULL,
  `ulb_descripción` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ulb_id`),
  UNIQUE KEY `ulb_id_UNIQUE` (`ulb_id`),
  UNIQUE KEY `ulb_codigo_UNIQUE` (`ulb_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades_laborales`
--

LOCK TABLES `unidades_laborales` WRITE;
/*!40000 ALTER TABLE `unidades_laborales` DISABLE KEYS */;
INSERT INTO `unidades_laborales` VALUES (1,'ADS','UNIDAD ADMINISTRATIVA'),(2,'FTC','FOTOCOPIAS E IMPRESIONES'),(3,'PKO','PARQUEO');
/*!40000 ALTER TABLE `unidades_laborales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades_medida`
--

DROP TABLE IF EXISTS `unidades_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidades_medida` (
  `um_codigo` int NOT NULL,
  `um_descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`um_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades_medida`
--

LOCK TABLES `unidades_medida` WRITE;
/*!40000 ALTER TABLE `unidades_medida` DISABLE KEYS */;
INSERT INTO `unidades_medida` VALUES (1,'Metro'),(2,'Yarda'),(3,'Vara'),(4,'Pie'),(5,'Pulgada'),(6,'Milimetro'),(8,'Milla cuadrada'),(9,'Kilometro cuadrado'),(10,'Hectarea'),(11,'Manzana'),(12,'Acre'),(13,'Metro cuadrado'),(14,'Yarda cuadrada'),(15,'Vara cuadrada'),(16,'Pie cuadrado'),(17,'Pulgada cuadrada'),(18,'Metro cubico'),(19,'Yarda cubica'),(20,'Barril'),(21,'Pie cubico'),(22,'Galon'),(23,'Litro'),(24,'Botella'),(25,'Pulgada cubica'),(26,'Mililitro'),(27,'Onza fluida'),(29,'Tonelada metrica'),(30,'Tonelada'),(31,'Quintal metrico'),(32,'Quintal'),(33,'Arroba'),(34,'Kilogramo'),(35,'Libra troy'),(36,'Libra'),(37,'Onza troy'),(38,'Onza'),(39,'Gramo'),(40,'Miligramo'),(42,'Megawatt'),(43,'Kilowatt'),(44,'Watt'),(45,'Megavoltio-amperio'),(46,'Kilovoltio-amperio'),(47,'Voltio-amperio'),(49,'Gigawatt-hora'),(50,'Megawatt-hora'),(51,'Kilowatt-hora'),(52,'Watt-hora'),(53,'Kilovoltio'),(54,'Voltio'),(55,'Millar'),(56,'Medio millar'),(57,'Ciento'),(58,'Docena'),(59,'Unidad'),(99,'Otra');
/*!40000 ALTER TABLE `unidades_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `correo_electronico` varchar(250) NOT NULL,
  `nombres` varchar(200) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `apellidos` varchar(200) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `correo_verificado` tinyint(1) NOT NULL DEFAULT '0',
  `bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `cambiar_password` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_creacion` date NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`correo_electronico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('admin@gmail.com',NULL,'admin123',NULL,1,1,0,0,'2025-05-30',2),('miguelsr1@gmail.com',NULL,'admin123',NULL,1,1,0,0,'2025-01-26',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `us_id` int NOT NULL AUTO_INCREMENT,
  `us_usuario` varchar(25) DEFAULT NULL,
  `us_clave` varchar(255) DEFAULT NULL,
  `usu_estado` varchar(1) DEFAULT NULL COMMENT 'Se colocaran 1 caracter A-activo o I-Inactivo',
  `us_ruc_id` int NOT NULL,
  `us_correo` varchar(50) DEFAULT NULL,
  `us_created_at` datetime DEFAULT NULL,
  `us_updated_at` datetime DEFAULT NULL,
  `us_is_token_verified` int DEFAULT NULL,
  `us_date_token_verified` datetime DEFAULT NULL,
  `us_must_change_password` int DEFAULT NULL,
  `us_is_verified` int DEFAULT NULL,
  `us_date_verified` datetime DEFAULT NULL,
  `us_ubicacion` int DEFAULT NULL,
  `us_puesto` int DEFAULT NULL,
  `us_cortesia` varchar(1) DEFAULT NULL,
  `us_ce_empresa` int DEFAULT NULL,
  `us_ulb_id` int DEFAULT NULL COMMENT 'Utilizado unicamente para usuarios de SERTRACEN, otras empresas registrar como "NULL"',
  PRIMARY KEY (`us_id`),
  KEY `fk_RUC_idx` (`us_ruc_id`),
  CONSTRAINT `fk_RUC` FOREIGN KEY (`us_ruc_id`) REFERENCES `contribuyentes` (`ruc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (6,'MSANCHEZ_ID','Yk9IMGhiWmNHSUtRd2xlV0xXei9hdz09','A',1,'miguelsr1@gmail.com',NULL,NULL,NULL,NULL,0,NULL,NULL,1,1,'S',1,NULL),(9,'SISDTE','admin123','A',1,'miguelsr1@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'S',1,1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vistageo`
--

DROP TABLE IF EXISTS `vistageo`;
/*!50001 DROP VIEW IF EXISTS `vistageo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistageo` AS SELECT 
 1 AS `ubg_id_geograficas`,
 1 AS `departamento`,
 1 AS `municipio`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'fact'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_calculo_impuesto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_calculo_impuesto`(p_precio DECIMAL(15,2),p_cantidad INT,p_tipo VARCHAR(4),p_codtributo DECIMAL(4) ) RETURNS decimal(15,2)
    READS SQL DATA
BEGIN

DECLARE v_detalle DECIMAL(15,2);

             if p_tipo = '01' then
				set v_detalle = ((p_precio * p_cantidad) / 1.13) * 0.13;
			elseif p_tipo = '03' then
				set v_detalle = (p_precio * p_cantidad) * 0.13;
            end if;

RETURN v_detalle;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_cantletras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fn_cantletras`(NUMERO DECIMAL(4)) RETURNS varchar(1000) CHARSET utf8mb3
    READS SQL DATA
BEGIN
declare EN_LETRAS varchar(1000);
DECLARE MILLARES_DE_MILLON INT;
   DECLARE MILLONES INT;
   DECLARE MILLARES INT;
   DECLARE CENTENAS INT;
   DECLARE CENTIMOS INT;
   DECLARE ENTERO INT;
   DECLARE AUX VARCHAR(15);
   DECLARe CENTIMO_AUX  varchar(1000);

   -- IF ((NUMERO < 0) OR (NUMERO > 999999999999.99)) THEN
    --        SIGNAL SQLSTATE '01000'
    --        SET MESSAGE_TEXT = 'CANTIDAD FUERA DE RANGO', MYSQL_ERRNO = 1000;
    -- END IF;
   SET EN_LETRAS = '';
   SET ENTERO = TRUNCATE(NUMERO,0);
   SET MILLARES_DE_MILLON = TRUNCATE(ENTERO / 1000000000,0);
   SET MILLONES = TRUNCATE((ENTERO MOD 1000000000) / 1000000,0);
   SET MILLARES = TRUNCATE((ENTERO MOD 1000000) / 1000,0);
   SET CENTENAS = ENTERO MOD 1000;
   SET CENTIMOS = (TRUNCATE(NUMERO,2) * 100) MOD 100;

   IF (MILLARES_DE_MILLON = 1) THEN
         IF (MILLONES = 0) THEN
               SET EN_LETRAS = 'MIL MILLONES ';
         ELSE
               SET EN_LETRAS = 'MIL ';
         END IF;
   END IF;
   IF (MILLARES_DE_MILLON > 1) THEN
     SET EN_LETRAS = NUMERO_MENOR_MIL(MILLARES_DE_MILLON);
         IF (MILLONES = 0) THEN
               SET EN_LETRAS = CONCAT(EN_LETRAS, 'MIL MILLONES ');
         ELSE
             SET EN_LETRAS = CONCAT(EN_LETRAS, 'MIL ');
         END IF;
   END IF;
   IF ((MILLONES = 1) AND  (MILLARES_DE_MILLON = 0)) THEN
         SET EN_LETRAS = 'UN MILLÓN ';
   ELSE
      IF   (MILLONES > 0) THEN
         SET EN_LETRAS = CONCAT(EN_LETRAS, NUMERO_MENOR_MIL(MILLONES), 'MILLONES ');
      END IF;
   END IF;
   IF ((MILLARES = 1) AND (MILLARES_DE_MILLON = 0) AND (MILLONES = 0)) THEN
   SET EN_LETRAS = 'MIL ';
   ELSE
      IF (MILLARES > 0) THEN
            SET EN_LETRAS = CONCAT(EN_LETRAS , NUMERO_MENOR_MIL(MILLARES) ,'MIL ');
      END IF;
   END IF;
   IF ((CENTENAS > 0) OR ((ENTERO = 0) AND (CENTIMOS = 0))) THEN
      SET EN_LETRAS = CONCAT(EN_LETRAS, NUMERO_MENOR_MIL(CENTENAS));
   END IF;
   IF (CENTIMOS > 0) THEN
      IF (CENTIMOS = 1) THEN
         SET  AUX = 'CÉNTIMO';
      ELSE
         SET AUX = 'CÉNTIMOS';
      END IF;
   END IF;
   IF (ENTERO > 0) THEN
     SET CENTIMO_AUX = NUMERO_MENOR_MIL(CENTIMOS);
     SET CENTIMO_AUX = REPLACE(CENTIMO_AUX,'UNO ','UN ');
      SET EN_LETRAS = CONCAT(EN_LETRAS, 'CON ', CENTIMO_AUX , AUX);
   ELSE
      SET EN_LETRAS = CONCAT(EN_LETRAS, CENTIMO_AUX, AUX);
   END IF;
   RETURN(EN_LETRAS);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fun_cantidad_a_letras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fun_cantidad_a_letras`(pnumero DECIMAL(15,2)) RETURNS text CHARSET utf8mb3
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE EN_LETRAS TEXT;
    DECLARE MILLARES_DE_MILLON INT;
    DECLARE MILLONES INT;
    DECLARE MILLARES INT;
    DECLARE CENTENAS INT;
    DECLARE CENTIMOS INT;
    DECLARE ENTERO INT;
    DECLARE AUX VARCHAR(30);
    DECLARE CENTIMO_AUX TEXT;

    SET EN_LETRAS = '';
    SET ENTERO = TRUNCATE(pnumero,0);  
    SET MILLARES_DE_MILLON = TRUNCATE(ENTERO / 1000000000,0);
    SET MILLONES = TRUNCATE((ENTERO MOD 1000000000) / 1000000,0);
    SET MILLARES = TRUNCATE((ENTERO MOD 1000000) / 1000,0);
    SET CENTENAS = ENTERO MOD 1000;
    SET CENTIMOS = (TRUNCATE(pnumero,2) * 100) MOD 100;

    -- Lógica de conversión
    IF (MILLARES_DE_MILLON = 1) THEN
        IF (MILLONES = 0) THEN
            SET EN_LETRAS = 'MIL MILLONES ';
        ELSE
            SET EN_LETRAS = 'MIL ';
        END IF;
    END IF;
   
    IF (MILLARES_DE_MILLON > 1) THEN
        SET EN_LETRAS = NUMERO_MENOR_MIL(MILLARES_DE_MILLON);
        IF (MILLONES = 0) THEN
            SET EN_LETRAS = CONCAT(EN_LETRAS, 'MIL MILLONES ');
        ELSE
            SET EN_LETRAS = CONCAT(EN_LETRAS, 'MIL ');
        END IF;
    END IF;
    
    IF ((MILLONES = 1) AND  (MILLARES_DE_MILLON = 0)) THEN
        SET EN_LETRAS = 'UN MILLÓN ';
    ELSE
        IF   (MILLONES > 0) THEN
            SET EN_LETRAS = CONCAT(EN_LETRAS, NUMERO_MENOR_MIL(MILLONES), 'MILLONES ');
        END IF;
    END IF;
    
    IF ((MILLARES = 1) AND (MILLARES_DE_MILLON = 0) AND (MILLONES = 0)) THEN
        SET EN_LETRAS = 'MIL ';
    ELSE
        IF (MILLARES > 0) THEN
            SET EN_LETRAS = CONCAT(EN_LETRAS , NUMERO_MENOR_MIL(MILLARES) ,'MIL ');
        END IF;
    END IF;
    
    IF ((CENTENAS > 0) OR ((ENTERO = 0) AND (CENTIMOS = 0))) THEN
        SET EN_LETRAS = CONCAT(EN_LETRAS, NUMERO_MENOR_MIL(CENTENAS));
    END IF;
    
    IF (CENTIMOS = 1) THEN
        SET AUX = '/100 CTVS';
    ELSE
        SET AUX = '/100 CTVS';
    END IF;
    
    IF (ENTERO > 0 ) THEN
        SET CENTIMO_AUX = NUMERO_MENOR_MIL(CENTIMOS);
        SET EN_LETRAS = CONCAT(EN_LETRAS, 'CON ', CENTIMO_AUX , AUX);
    END IF;

    RETURN EN_LETRAS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fun_genera_numero_interno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fun_genera_numero_interno`(`PAPP` VARCHAR(55), `PUSER` VARCHAR(55)) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE new_id INT;
    
    -- Insertar una nueva fila con la fecha actual
    INSERT INTO `fact`.`buzon_encabezado` (`fecha`,`usuario`,`aplicacion`) VALUES (NOW(),`PUSER`,`PAPP`);

    -- Obtener el último ID insertado
    SET new_id = LAST_INSERT_ID();
    
    RETURN new_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fun_retorna_correomh` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fun_retorna_correomh`(p_factura int) RETURNS longtext CHARSET utf8mb4
    READS SQL DATA
BEGIN
	
	DECLARE num_control varchar(50);
	declare tipoDte varchar(150);
    declare codGene varchar(150);
    declare fechaIngreso varchar(150);
    declare selloRecibido varchar(150);


declare texto_correo longtext ;
    
SELECT fac_numero_de_control into num_control 
FROM fact.factura where fac_id = p_factura LIMIT 1;

select 
	tc.tcp_descomprobante,
    bdh.codigo_generacion,
    DATE_FORMAT(bdh.fecha_ingreso, '%d/%m/%Y %H:%i'),
    bdh.selloRecibido into tipoDte, codGene, fechaIngreso, selloRecibido
from buzoncsv b 
	inner join tipos_comprobantes tc on b.tipodoc = tc.tcp_idtipcom
    inner join factura f on f.fac_nro_factura = b.cod_factura
    inner join bitacora_declaracion_hacienda bdh on f.fac_id = bdh.id_fac and bdh.estado in ('PROCESADO','OBSERVADO')
where f.fac_id = p_factura LIMIT 1;

set texto_correo = CONCAT('
		<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notificación de Emisión de DTE</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            text-align: center;
            border-radius: 8px 8px 0 0;
        }
        .content {
            padding: 20px;
        }
        .footer {
            text-align: center;
            font-size: 12px;
            color: #888;
            padding: 10px;
            border-top: 1px solid #ddd;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Notificación de Emisión de DTE</h2>
        </div>
        <div class="content">
            <p>Estimado(a) cliente,</p>
            <p>Se le informa que el <strong>Documento Tributario Electrónico (DTE)</strong> correspondiente ha sido emitido con éxito.</p>
            <p>A continuación, encontrará los detalles del documento:</p>
            <ul>
                <li><strong>Tipo de DTE: </strong>',tipoDte,'</li>
                <li><strong>Código Generación: </strong>',codGene,'</li>
                <li><strong>Fecha de emisión: </strong>',fechaIngreso,'</li>
                <li><strong>Sello Recepción: </strong>',selloRecibido,'</li>
            </ul>
            <p>Adjunto a este correo se encuentran los siguientes archivos:</p>
            <ul>
                <li><strong>PDF:</strong> Documento PDF con la representación del DTE.</li>
                <li><strong>JSON:</strong> Información detallada del DTE en formato JSON.</li>
            </ul>
        </div>
        <div class="footer">
            <p>Este es un mensaje automático. Por favor, no responda a este correo.</p>
        </div>
    </div>
</body>
</html>');

    select replace(texto_correo,'N_ESQID',num_control)
    into texto_correo;

    return texto_correo;
  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fun_retorna_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fun_retorna_json`(`ptipo_fac` VARCHAR(15) CHARSET utf8mb4, `pfactura` VARCHAR(15) CHARSET utf8mb4, pidemp int) RETURNS json
    READS SQL DATA
BEGIN


declare vjson json;
CASE
WHEN ptipo_fac = 'CCFE' THEN

    /*CREDITO FISCAL*/
set vjson = (
SELECT JSON_OBJECT(
    'identificacion',
        JSON_OBJECT(
            'version',3,
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
            'tipoDte',fac_tipo_comprobante,
            'numeroControl',fac_numero_de_control,
            'codigoGeneracion',fac_codigo_generacion,
            'tipoModelo',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoModelo'),
            'tipoOperacion',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'),
            'tipoContingencia',null,
            'motivoContin',null,
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'),
            'horEmi', DATE_FORMAT(NOW(), '%H:%i:%s'),
            'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda')
        ),
   'documentoRelacionado', null,
   'emisor',
       JSON_OBJECT(
           'nit', REPLACE(a.nit, "-", ""),
           'nrc', a.nrc,
           'nombre', a.razon_social,
           'codActividad',a.codigo_actividad,
           'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.codigo_actividad),
           'nombreComercial', a.nombre_comercial,
           'tipoEstablecimiento', a.codigo_establecimiento,
           'direccion',
               JSON_OBJECT(
                   'departamento', a.codigo_departamento,
                   'municipio', a.codigo_municipio,
                   'complemento', a.direccion
                ),
           'telefono', a.telefono,
           'correo', a.correo,
           'codEstable', a.codigo_estable,
           'codPuntoVenta', a.codigo_estable_mh,
           'codEstableMH',  a.codigo_puntoventa,
           'codPuntoVentaMH', a.codigo_puntoventa_mh
        ),
    'receptor',
       JSON_OBJECT(
            'nrc', b.ruc_nrc,
            'nombre', b.ruc_nombre_razonsocial,
            'codActividad', b.ruc_codactividad,
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = b.ruc_codactividad),
            'direccion',
               JSON_OBJECT(
                   'departamento', b.ruc_codigo_departamento,
                   'municipio', b.ruc_codigo_municipio,
                   'complemento', b.ruc_domicilio
                ),
            'telefono', b.ruc_telefono_personal,
            'correo', b.ruc_email_contribuyente,
            'nombreComercial', b.ruc_nombre_razonsocial,
            'nit', REPLACE(b.ruc_nit_contribuyente, "-", "")
       ),
       'otrosDocumentos', null,
       'ventaTercero',  null,
       'cuerpoDocumento', (SELECT JSON_ARRAYAGG(JSON_OBJECT(
            'numItem',det_fac_numlinea,
            'tipoItem',det_fac_tipo_item,
            'numeroDocumento',det_numerodocumento_rel,
            'cantidad',det_fac_cantidad,
            'codigo', det_codigo,
            'codTributo',(CASE when det_fac_tipo_item = 4 then det_codtributo else null end),
            'uniMedida',det_fac_unidad_de_medida,
            'descripcion',det_fac_descripcion,
            'precioUni',det_fac_preciounitario,
            'montoDescu',det_montoDescu,
            'ventaNoSuj',0.00, #comentado de momento para enviar creadito fiscal por envio urgente 
            'ventaExenta',det_fac_ventasexentas,
            'ventaGravada',det_fact_ventasgravadas,
            'tributos',(SELECT JSON_ARRAYAGG(tri_codigo)
                        FROM tributos
                        where tri_fac_id = fac_id),
            /*( SELECT JSON_ARRAYAGG(det_tributo) from (
				SELECT distinct det_tributo FROM factura_detalle WHERE det_fac_nro_factura = pfactura) a), */
            'psv',det_psv,
            'noGravado',det_no_gravado))
            FROM factura_detalle WHERE det_fac_id = fac_id),
       'resumen',
            JSON_OBJECT(
            'totalNoSuj', fac_ventasnosujet_tot,
            'totalExenta', fac_ventasexentas_tot,
            'totalGravada', fac_ventasgravadas_tot,
            'subTotalVentas', fac_subtotalventas,
            'descuNoSuj', fac_descuento_nosuje,
            'descuExenta', fac_descuento_exent,
            'descuGravada', fac_descuento_grab,
            'porcentajeDescuento', fac_porcen_descuento,
            'totalDescu', fac_tot_descuento,
            'tributos', (SELECT JSON_ARRAYAGG(JSON_OBJECT('codigo', tri_codigo,
                'descripcion', tri_descripcion,
                'valor', tri_valor))
                FROM tributos WHERE tri_fac_id = fac_id),
            'subTotal',fac_subtotal,
            'ivaPerci1',fac_ivaperci1,
            'ivaRete1', fac_iva_retenido,
            'reteRenta', fac_retencion_renta,
            'montoTotalOperacion', fac_total_pagar,
            'totalNoGravado', fac_total_nograbado,
            'totalPagar', fac_total_pagar,
            'totalLetras', fac_total_letras,
            'saldoFavor', fac_saldo_favor,
            'condicionOperacion', fac_condicion_operacion, #Debe ser una variable con 1,2 o 3
            'pagos', (SELECT JSON_ARRAYAGG(JSON_OBJECT(
                'codigo', codigo,
                'montoPago', montopago,
                'plazo', plazo,
                'referencia', referencia,
                'periodo', IF(periodo = 0, NULL, periodo)
                ))
                FROM pagos WHERE id_fac = fac_id),
            'numPagoElectronico', fac_numpagoelectronico
            ),
        'extension',
            JSON_OBJECT(
                'nombEntrega', null,
                'docuEntrega', null,
                'nombRecibe', null,
                'docuRecibe', null,
                'observaciones', null,
                'placaVehiculo', null
            ),
            'apendice', null
)
FROM factura 
	LEFT JOIN empresa as a ON a.id_empresa = fac_ce_empresa
	LEFT JOIN contribuyentes as b ON b.ruc_nit_contribuyente = fac_nit_receptor AND b.ruc_tipo_contribuyente = 'RECEPTOR' and b.id_empresa = a.id_empresa
	where fac_id = pfactura and fac_ce_empresa = pidemp);

WHEN ptipo_fac = 'FE' THEN
    /*CONSUMIDOR FINAL*/
set vjson = (
SELECT JSON_OBJECT(
    'identificacion',
        JSON_OBJECT(
            'version',1, #int, const=1
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'), #string, 00-01
            'tipoDte',fac_tipo_comprobante, #
            'numeroControl',fac_numero_de_control, #string, max-min=31, "^DTE-01-[A-Z0-9]{8}-[0-9]{15}$"
            'codigoGeneracion',fac_codigo_generacion, #string, max-min=36, "^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$"
            'tipoModelo',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoModelo'), #number, 1-2
            'tipoOperacion',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'), #number, 1-2
            'tipoContingencia',null, #int-null - 1-5
            'motivoContin',null, #string-null min=5 max=150
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'), #date
            'horEmi', DATE_FORMAT(NOW(), '%H:%i:%s'), #"^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]?$"
            'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda') #string, val='USD'
        ),
    'documentoRelacionado', null,
    'emisor',
        JSON_OBJECT(
            'nit', REPLACE(a.nit, "-", ""),
            'nrc', a.nrc,
            'nombre', a.razon_social,
            'codActividad', a.codigo_actividad,
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.codigo_actividad),
            'nombreComercial', a.nombre_comercial,
            'tipoEstablecimiento', a.codigo_establecimiento,
            'direccion',
                JSON_OBJECT(
                    'departamento', a.codigo_departamento,
                    'municipio', a.codigo_municipio,
                    'complemento', a.direccion
                ),
           'telefono', a.telefono,
           'codEstableMH', a.codigo_estable,
           'codEstable', a.codigo_estable_mh,
           'codPuntoVentaMH', a.codigo_puntoventa,
           'codPuntoVenta', a.codigo_puntoventa_mh,
           'correo', a.correo
        ),
    'receptor',
        JSON_OBJECT(
            'tipoDocumento', (SELECT CAST(doc_idtipo_documento as CHAR) FROM fact.tipos_documentos where doc_id=ifnull(b.ruc_tipo_doc_id,1)),
            'numDocumento',ifnull(REPLACE(ifnull(b.ruc_nit_contribuyente,fac_nit_receptor), "-", ""),'00000000000000'),
            'nrc', ifnull(b.ruc_nrc,fac_nrc_receptor),
            'nombre', case when fac_nombre_receptor is null then b.ruc_nombre_razonsocial else fac_nombre_receptor end,
            'codActividad', b.ruc_codactividad,
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = b.ruc_codactividad),
            'direccion',
                JSON_OBJECT(
                    'departamento', ifnull(b.ruc_codigo_departamento,'06'),
                    'municipio', ifnull(b.ruc_codigo_municipio,'14'),
                    'complemento', ifnull(ifnull(b.ruc_domicilio,fac_direccion_receptor),'SAN SALVADOR')
                ),
            'telefono', ifnull(b.ruc_telefono_personal,fac_telefono_receptor),
            'correo', ifnull(b.ruc_email_contribuyente,fac_correo_receptor)
        ),
        'ventaTercero', null,
        'cuerpoDocumento',
            (SELECT JSON_ARRAYAGG(JSON_OBJECT(
            'numItem',det_fac_numlinea,
            'tipoItem', det_fac_tipo_item,
            'numeroDocumento', det_numerodocumento_rel,
            'cantidad',det_fac_cantidad,
            'codigo', det_codigo,
            'codTributo',null/*det_codtributo*/ ,
            'uniMedida',det_fac_unidad_de_medida,
            'descripcion',det_fac_descripcion,
            'precioUni',det_fac_preciounitario,
            'montoDescu',det_montoDescu,
            'ventaNoSuj',det_fact_ventasgravadas,-- det_fac_ventasnosujet,
            'ventaExenta',det_fac_ventasexentas,
            'ventaGravada',0.0,-- det_fact_ventasgravadas,
            'tributos',null/*(SELECT JSON_ARRAYAGG(tri_codigo)
                        FROM tributos
                        where tri_fac_id = fac_id)*/ ,
            'psv',det_psv,
            'noGravado',det_no_gravado,
            'ivaItem',0.0))-- det_fact_iva))
            FROM factura_detalle WHERE det_fac_id = fac_id),
        'resumen',
            JSON_OBJECT(
                'totalNoSuj', fac_ventasgravadas_tot,-- fac_ventasnosujet_tot,
                'totalExenta', fac_ventasexentas_tot,
                'totalGravada', 0.0,-- fac_ventasgravadas_tot,
                'subTotalVentas', fac_subtotalventas,
                'descuNoSuj', fac_descuento_nosuje,
                'descuExenta', fac_descuento_exent,
                'descuGravada', fac_descuento_grab,
                'porcentajeDescuento', fac_porcen_descuento,
                'totalDescu', fac_tot_descuento,
                'tributos',null/* (SELECT JSON_ARRAYAGG(JSON_OBJECT('codigo', tri_codigo,
                'descripcion', tri_descripcion,
                'valor', tri_valor))
                FROM tributos WHERE tri_fac_id = fac_id)*/ ,
                'subTotal',fac_subtotal,
                'ivaRete1', fac_iva_retenido,
                'reteRenta', fac_retencion_renta,
                'montoTotalOperacion', fac_montototaloperacion,
                'totalNoGravado', fac_total_nograbado,
                'totalPagar', fac_total_pagar,
                'totalLetras', fac_total_letras,
                'totalIva', 0.0,-- fac_total_iva,
                'saldoFavor', fac_saldo_favor,
                'condicionOperacion', fac_condicion_operacion,
                'pagos',(SELECT JSON_ARRAYAGG(JSON_OBJECT(
                'codigo', codigo,
                'montoPago', montopago,
                'plazo', plazo,
                'referencia', referencia,
                'periodo', IF(periodo = 0, NULL, periodo)
                ))
                FROM pagos WHERE id_fac = fac_id),
                'numPagoElectronico', fac_numpagoelectronico
            ),
       'extension',
            JSON_OBJECT(
                'nombEntrega', null,
                'docuEntrega', null,
                'nombRecibe', null,
                'docuRecibe', null,
                'observaciones', null,
                'placaVehiculo', null
            ),
        'otrosDocumentos', null,
        'apendice', null
)
FROM factura 
	LEFT JOIN empresa as a ON a.id_empresa = fac_ce_empresa
	LEFT JOIN contribuyentes as b ON b.ruc_nit_contribuyente = fac_nit_receptor AND b.ruc_tipo_contribuyente = 'RECEPTOR' and b.id_empresa = a.id_empresa
	where fac_id = pfactura and fac_ce_empresa = pidemp);

 
WHEN ptipo_fac = 'FSEE' THEN

/*SUJETO EXCLUIDO*/

set vjson = (
SELECT JSON_OBJECT(
    'identificacion',
        JSON_OBJECT(
            'version',1,
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
            'tipoDte',fac_tipo_comprobante,
            'numeroControl',fac_numero_de_control,
            'codigoGeneracion',fac_codigo_generacion,
            'tipoModelo',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoModelo'),
            'tipoOperacion',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'),
            'tipoContingencia',null,
            'motivoContin',null,
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'),
            'horEmi', DATE_FORMAT(NOW(), '%H:%i:%s'),
            'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda')
        ),
    'emisor',
        JSON_OBJECT(
            'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
            'nrc', a.ruc_nrc,
            'nombre', a.ruc_nombre_razonsocial,
            'codActividad', a.ruc_codactividad,
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.ruc_codactividad),
            'direccion',
                JSON_OBJECT(
                    'departamento', a.ruc_codigo_departamento,
                    'municipio', a.ruc_codigo_municipio,
                    'complemento', a.ruc_domicilio
                ),
            'telefono',REPLACE(a.ruc_telefono_personal, "-", ""),
            'codEstableMH', a.ruc_codigo_mh,
            'codEstable', a.ruc_cod_establecimiento,
            'codPuntoVentaMH', a.ruc_cod_punto_venta_mh,
            'codPuntoVenta', a.ruc_cod_punto_venta_mh,
            'correo', a.ruc_email_contribuyente
        ),
    'sujetoExcluido',
        JSON_OBJECT(
            'tipoDocumento', (SELECT CAST(doc_idtipo_documento as CHAR) FROM fact.tipos_documentos where doc_id=b.ruc_tipo_doc_id),
            'numDocumento', REPLACE(b.ruc_nit_contribuyente, "-", ""),#Número de documento de Identificación
            'nombre', b.ruc_nombre_razonsocial,#Nombre, denominación o razón social del contribuyente
            'codActividad', b.ruc_codactividad, #Codigo de actividad economica
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = b.ruc_codactividad), #Actividad Económica
            'direccion',
                JSON_OBJECT(
                    'departamento', b.ruc_codigo_departamento,
                    'municipio', b.ruc_codigo_municipio,
                    'complemento', b.ruc_domicilio
                ),
            'telefono', b.ruc_telefono_personal, #telefono receptor
            'correo',b.ruc_email_contribuyente #Correo electrónico
        ),
    'cuerpoDocumento',
        (SELECT JSON_ARRAYAGG(JSON_OBJECT(
        'numItem',det_fac_numlinea,
        'tipoItem', det_fac_tipo_item,
        'cantidad', det_fac_cantidad,
        'codigo', det_codigo,
        'uniMedida',det_fac_unidad_de_medida,
        'descripcion', det_fac_descripcion,
        'precioUni', det_fac_preciounitario,
        'montoDescu', det_montoDescu,
        'compra',det_compra))
        FROM factura_detalle WHERE det_fac_id = fac_id),
    'resumen',
        JSON_OBJECT(
            'totalCompra',fac_totalcompra,
            'descu',fac_desc,
            'totalDescu',fac_tot_descuento,
            'subTotal',fac_subtotal,
            'ivaRete1',fac_retencion_iva,
            'reteRenta',fac_retencion_renta,
            #'totalPagar',(fac_total_pagar - fac_retencion_renta),
            'totalPagar',(fac_subtotal - fac_retencion_renta - fac_retencion_iva),
            'totalLetras',fac_total_letras,
            'condicionOperacion',fac_condicion_operacion,
            'pagos', 
                (SELECT JSON_ARRAYAGG(JSON_OBJECT(
                'codigo', codigo,
                'montoPago', montopago,
                'plazo', plazo,
                'referencia', referencia,
                'periodo', periodo
                ))
                FROM pagos WHERE id_fac = fac_id),
            'observaciones',fac_observaciones
        ),
    'apendice',
        (select JSON_ARRAYAGG(JSON_OBJECT(
        'campo',ape_campo,
        'etiqueta',ape_etiqueta,
        'valor',ape_valor))
        from apendice where ape_fac_id = fac_id order by ape_id asc)
)
FROM factura, contribuyentes as a, contribuyentes as b
where a.ruc_nit_contribuyente = fac_nit_emisor and 
	a.ruc_tipo_contribuyente = 'EMISOR' and 
	b.ruc_nit_contribuyente = fac_nit_receptor and 
	b.ruc_tipo_contribuyente = 'RECEPTOR' and 
	fac_id = pfactura );


WHEN ptipo_fac = 'FEXE' THEN

/*Factura de exportacion*/
set vjson = (
SELECT JSON_OBJECT(
   'identificacion',
       JSON_OBJECT(
            'version',1,
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
            'tipoDte',fac_tipo_comprobante,
            'numeroControl',fac_numero_de_control,
            'codigoGeneracion',fac_codigo_generacion,
            'tipoModelo',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoModelo'),
            'tipoOperacion',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'),
            'tipoContingencia',null,
            'motivoContigencia',null,
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'),
            'horEmi', DATE_FORMAT(NOW(), '%H:%i:%s'),
            'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda')
        ),
   'emisor',
       JSON_OBJECT(
           'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
           'nrc', a.ruc_nrc,
           'nombre', a.ruc_nombre_razonsocial,
           'codActividad', a.ruc_codactividad,
           'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.ruc_codactividad),
           'nombreComercial', a.ruc_nombre_comercial,
           'tipoEstablecimiento',a.ruc_tipoestablecimiento,
           'direccion',
               JSON_OBJECT(
                   'departamento', a.ruc_codigo_departamento,
                   'municipio', a.ruc_codigo_municipio,
                   'complemento', a.ruc_domicilio
                ),
           'telefono',REPLACE(a.ruc_telefono_personal, "-", ""),
           'correo', a.ruc_email_contribuyente,
           'codEstableMH',a.ruc_codigo_mh,
           'codEstable',a.ruc_cod_establecimiento,
           'codPuntoVentaMH',a.ruc_cod_punto_venta_mh,
           'codPuntoVenta',a.ruc_cod_punto_venta_mh,
           'tipoItemExpor',a.ruc_tipo_item_expor,
           'recintoFiscal',a.ruc_recinto_fiscal,
           'regimen',a.ruc_regimen
        ),
       'receptor',
       JSON_OBJECT(
            'nombre', b.ruc_nombre_razonsocial,
            'tipoDocumento',(SELECT CAST(doc_idtipo_documento as CHAR) FROM fact.tipos_documentos where doc_id=b.ruc_tipo_doc_id), #Tipo de documento de identificación (Receptor) (catalogo)
            'numDocumento', REPLACE(b.ruc_nit_contribuyente, "-", ""), #NIT (Receptor)
            'nombreComercial', b.ruc_nombre_razonsocial,
            'codPais', (SELECT cp_codigo FROM fact.catalogo_pais where cp_id_pais=b.ruc_cp_id_pais),
            'nombrePais',(SELECT cp_valor FROM fact.catalogo_pais where cp_id_pais=b.ruc_cp_id_pais),
            'complemento',b.ruc_domicilio,
            'tipoPersona',b.ruc_ctper_id, #tipo de persona Juridica o persona natural
            'descActividad',(SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = b.ruc_codactividad),
            'telefono', b.ruc_telefono_personal,
            'correo', b.ruc_email_contribuyente
       ),
       "otrosDocumentos", null,
       'ventaTercero',null,
      'cuerpoDocumento', (SELECT JSON_ARRAYAGG(JSON_OBJECT(
            'numItem',det_fac_numlinea,
            'cantidad',det_fac_cantidad,
            'codigo',fac_nro_factura,
            'uniMedida',det_fac_unidad_de_medida,
            'descripcion',det_fac_descripcion,
            'precioUni',det_fac_preciounitario,
            'montoDescu',det_montoDescu,
            'ventaGravada',det_fact_ventasgravadas,
            'tributos',(SELECT JSON_ARRAYAGG(tri_codigo)
                        FROM tributos
                        where tri_fac_id = fac_id),
            'noGravado',det_no_gravado
            )
            )FROM factura_detalle WHERE det_fac_id = fac_id),
      'resumen',
            JSON_OBJECT(
            'totalGravada',fac_ventasgravadas_tot,
            'descuento',fac_desc,
            'porcentajeDescuento',fac_porcen_descuento,
            'totalDescu',fac_tot_descuento,
            'seguro',fac_seguro,
            'flete',fac_flete,
            'montoTotalOperacion',fac_total_pagar,
            'totalNoGravado',fac_total_nograbado,
            'totalPagar',fac_total_pagar,
            'totalLetras',fac_total_letras,
            'condicionOperacion',fac_condicion_operacion,
            'pagos', (SELECT JSON_ARRAYAGG(JSON_OBJECT(
                'codigo', codigo,
                'montoPago', montopago,
                'plazo', plazo,
                'referencia', referencia,
                'periodo', periodo
                ))
                FROM pagos WHERE id_fac = fac_id),
            'codIncoterms',(SELECT cinc_codigo FROM fact.catalogo_incoterms WHERE cinc_id=fac_cinc_id),
            'descIncoterms',(SELECT cinc_valor FROM fact.catalogo_incoterms WHERE cinc_id=fac_cinc_id),
            'numPagoElectronico',fac_numpagoelectronico,
            'observaciones',fac_observaciones
            ),
            'apendice',(select JSON_ARRAYAGG(JSON_OBJECT(
        'campo',ape_campo,
        'etiqueta',ape_etiqueta,
        'valor',ape_valor))
        from apendice where ape_fac_id = fac_id order by ape_id asc)
)
FROM factura, contribuyentes as a, contribuyentes as b
where a.ruc_nit_contribuyente = fac_nit_emisor and 
	a.ruc_tipo_contribuyente = 'EMISOR' and 
	b.ruc_nit_contribuyente = fac_nit_receptor and 
	b.ruc_tipo_contribuyente = 'RECEPTOR' and 
	fac_id = pfactura );

WHEN ptipo_fac = 'NCE' THEN
/*NOTA DE CREDITO */
set vjson = (

SELECT JSON_OBJECT(
   'identificacion',
       JSON_OBJECT(
            'version',3,
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
            'tipoDte',fac_tipo_comprobante,
            'numeroControl',fac_numero_de_control,
            'codigoGeneracion',fac_codigo_generacion,
            'tipoModelo',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoModelo'),
            'tipoOperacion',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'),
            'tipoContingencia',null,
            'motivoContin',null,
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'),
            'horEmi', DATE_FORMAT(NOW(), '%H:%i:%s'),
            'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda')
        ),
       'documentoRelacionado',  JSON_ARRAY(JSON_OBJECT(
               'tipoDocumento',(SELECT doc_tipo_doc FROM fact.documentos_relacionados where doc_fac_id = fac_id), #Tipo de Documento Tributario Relacionado
               'tipoGeneracion',(SELECT doc_tipo_gen FROM fact.documentos_relacionados where doc_fac_id = fac_id), #Tipo de Generación del Documento Tributario relacionado
               'numeroDocumento',(SELECT doc_num FROM fact.documentos_relacionados where doc_fac_id = fac_id),
               'fechaEmision', DATE_FORMAT((SELECT doc_fecha FROM fact.documentos_relacionados where doc_fac_id = fac_id), '%Y-%m-%d')
       )),
   'emisor',
       JSON_OBJECT(
           'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
           'nrc', a.ruc_nrc,
           'nombre', a.ruc_nombre_razonsocial,
           'codActividad', a.ruc_codactividad,
           'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.ruc_codactividad),
           'nombreComercial',a.ruc_nombre_comercial,
           'tipoEstablecimiento',a.ruc_tipoestablecimiento,
           'direccion',
               JSON_OBJECT(
                   'departamento', a.ruc_codigo_departamento,
                   'municipio', a.ruc_codigo_municipio,
                   'complemento', a.ruc_domicilio
                ),
           'telefono',REPLACE(a.ruc_telefono_personal, "-", ""),
           'correo', a.ruc_email_contribuyente
        ),
       'receptor',
       JSON_OBJECT(
            'nit', b.ruc_nit_contribuyente, #NIT (Receptor)
            'nrc', b.ruc_nrc,
            'nombre', b.ruc_nombre_razonsocial,
            'codActividad', b.ruc_codactividad, #Código de Actividad Económica (Receptor)
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = b.ruc_codactividad), #Descripcion actividad Económica (Receptor)
            'nombreComercial',b.ruc_nombre_razonsocial,
            'direccion',
               JSON_OBJECT(
                   'departamento', b.ruc_codigo_departamento,
                   'municipio', b.ruc_codigo_municipio,
                   'complemento', b.ruc_domicilio
                ),
            'telefono', b.ruc_telefono_personal,
            'correo', b.ruc_email_contribuyente
       ),
      'ventaTercero', null,
      'cuerpoDocumento', (SELECT JSON_ARRAYAGG(JSON_OBJECT(
            'numItem',det_fac_numlinea,
            'tipoItem',det_fac_tipo_item,
            'numeroDocumento',det_numerodocumento_rel,
            'cantidad',det_fac_cantidad,
            'codigo',fac_nro_factura,
            'codTributo',det_codtributo, # Tributo sujeto a cálculo de IVA
            'uniMedida',det_fac_unidad_de_medida,
            'descripcion',det_fac_descripcion,
            'precioUni',det_fac_preciounitario,
            'montoDescu',det_montoDescu,
            'ventaNoSuj',det_fac_ventasnosujet,
            'ventaExenta',det_fac_ventasexentas,
            'ventaGravada',det_fact_ventasgravadas,
            'tributos',(SELECT JSON_ARRAYAGG(tri_codigo)
                        FROM tributos
                        where tri_fac_id = fac_id)
            )
            )FROM factura_detalle WHERE det_fac_id = fac_id),
       'resumen',
            JSON_OBJECT(
            'totalNoSuj',fac_ventasnosujet_tot,
            'totalExenta',fac_ventasexentas_tot,
            'totalGravada',fac_ventasgravadas_tot,
            'subTotalVentas',fac_subtotalventas,
            'descuNoSuj',fac_descuento_nosuje,
            'descuExenta',fac_descuento_exent,
            'descuGravada',fac_descuento_grab,
            'totalDescu',fac_tot_descuento,
            'tributos', (SELECT JSON_ARRAYAGG(JSON_OBJECT('codigo', tri_codigo,
                'descripcion', tri_descripcion,
                'valor', tri_valor))
                FROM tributos WHERE tri_fac_id = fac_id),
            'subTotal',fac_subtotal,
            'ivaPerci1',fac_ivaperci1,
            'ivaRete1',fac_iva_retenido,
            'reteRenta',fac_retencion_renta,
            'montoTotalOperacion',fac_total_pagar,
            'totalLetras',fac_total_letras,
            'condicionOperacion',fac_condicion_operacion
            ),
            'extension',
            JSON_OBJECT(
                'nombEntrega', null,
                'docuEntrega', null,
                'nombRecibe', null,
                'docuRecibe', null,
                'observaciones', null
            ),
            'apendice',(select JSON_ARRAYAGG(JSON_OBJECT(
        'campo',ape_campo,
        'etiqueta',ape_etiqueta,
        'valor',ape_valor))
        from apendice where ape_fac_id = fac_id order by ape_id asc)
)
FROM factura, contribuyentes as a, contribuyentes as b
where a.ruc_nit_contribuyente = fac_nit_emisor and 
	a.ruc_tipo_contribuyente = 'EMISOR' and 
	b.ruc_nit_contribuyente = fac_nit_receptor and 
	b.ruc_tipo_contribuyente = 'RECEPTOR' and 
	fac_id = pfactura
 );

WHEN ptipo_fac = 'NDE' THEN

/*NOTA DE DEBITO */
set vjson = (
SELECT JSON_OBJECT(
   'identificacion',
       JSON_OBJECT(
            'version',3,
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
            'tipoDte',fac_tipo_comprobante,
            'numeroControl',fac_numero_de_control,
            'codigoGeneracion',fac_codigo_generacion,
            'tipoModelo',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoModelo'),
            'tipoOperacion',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'),
            'tipoContingencia',null,
            'motivoContin',null,
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'),
            'horEmi', DATE_FORMAT(NOW(), '%H:%i:%s'),
            'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda')
        ),
       'documentoRelacionado',  JSON_ARRAY(JSON_OBJECT(
               'tipoDocumento',(SELECT doc_tipo_doc FROM fact.documentos_relacionados where doc_fac_id = fac_id), #Tipo de Documento Tributario Relacionado
               'tipoGeneracion',(SELECT doc_tipo_gen FROM fact.documentos_relacionados where doc_fac_id = fac_id), #Tipo de Generación del Documento Tributario relacionado
               'numeroDocumento',(SELECT doc_num FROM fact.documentos_relacionados where doc_fac_id = fac_id),
               'fechaEmision', DATE_FORMAT((SELECT doc_fecha FROM fact.documentos_relacionados where doc_fac_id = fac_id), '%Y-%m-%d')
       )),
   'emisor',
       JSON_OBJECT(
           'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
           'nrc', a.ruc_nrc,
           'nombre', a.ruc_nombre_razonsocial,
           'codActividad', a.ruc_codactividad,
           'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.ruc_codactividad),
           'nombreComercial',a.ruc_nombre_comercial,
           'tipoEstablecimiento',a.ruc_tipoestablecimiento,
           'direccion',
               JSON_OBJECT(
                   'departamento', a.ruc_codigo_departamento,
                   'municipio', a.ruc_codigo_municipio,
                   'complemento', a.ruc_domicilio
                ),
           'telefono',REPLACE(a.ruc_telefono_personal, "-", ""),
           'correo', a.ruc_email_contribuyente
        ),
       'receptor',
       JSON_OBJECT(
            'nit', b.ruc_nit_contribuyente, #NIT (Receptor)
            'nrc', b.ruc_nrc,
            'nombre', b.ruc_nombre_razonsocial,
            'codActividad', b.ruc_codactividad, #Código de Actividad Económica (Receptor)
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = b.ruc_codactividad), #Descripcion actividad Económica (Receptor)
            'nombreComercial',b.ruc_nombre_razonsocial,
            'direccion',
               JSON_OBJECT(
                   'departamento', b.ruc_codigo_departamento,
                   'municipio', b.ruc_codigo_municipio,
                   'complemento', b.ruc_domicilio
                ),
            'telefono', b.ruc_telefono_personal,
            'correo', b.ruc_email_contribuyente
       ),
      'ventaTercero', null,
      'cuerpoDocumento', (SELECT JSON_ARRAYAGG(JSON_OBJECT(
            'numItem',det_fac_numlinea,
            'tipoItem',det_fac_tipo_item,
            'numeroDocumento',det_numerodocumento_rel,
            'cantidad',det_fac_cantidad,
            'codigo',fac_nro_factura,
            'codTributo',det_codtributo, # Tributo sujeto a cálculo de IVA
            'uniMedida',det_fac_unidad_de_medida,
            'descripcion',det_fac_descripcion,
            'precioUni',det_fac_preciounitario,
            'montoDescu',det_montoDescu,
            'ventaNoSuj',det_fac_ventasnosujet,
            'ventaExenta',det_fac_ventasexentas,
            'ventaGravada',det_fact_ventasgravadas,
            'tributos',(SELECT JSON_ARRAYAGG(tri_codigo)
                        FROM tributos
                        where tri_fac_id = fac_id)
            )
            )FROM factura_detalle WHERE det_fac_id = fac_id),
       'resumen',
            JSON_OBJECT(
            'totalNoSuj',fac_ventasnosujet_tot,
            'totalExenta',fac_ventasexentas_tot,
            'totalGravada',fac_ventasgravadas_tot,
            'subTotalVentas',fac_subtotalventas,
            'descuNoSuj',fac_descuento_nosuje,
            'descuExenta',fac_descuento_exent,
            'descuGravada',fac_descuento_grab,
            'totalDescu',fac_tot_descuento,
            'tributos', (SELECT JSON_ARRAYAGG(JSON_OBJECT('codigo', tri_codigo,
                'descripcion', tri_descripcion,
                'valor', tri_valor))
                FROM tributos WHERE tri_fac_id = fac_id),
            'subTotal',fac_subtotal,
            'ivaPerci1',fac_ivaperci1,
            'ivaRete1',fac_iva_retenido,
            'reteRenta',fac_retencion_renta,
            'montoTotalOperacion',fac_total_pagar,
            'totalLetras',fac_total_letras,
            'numPagoElectronico',fac_numpagoelectronico,
            'condicionOperacion',fac_condicion_operacion
            ),
            'extension',
            JSON_OBJECT(
                'nombEntrega', null,
                'docuEntrega', null,
                'nombRecibe', null,
                'docuRecibe', null,
                'observaciones', null
            ),
            'apendice',(select JSON_ARRAYAGG(JSON_OBJECT(
        'campo',ape_campo,
        'etiqueta',ape_etiqueta,
        'valor',ape_valor))
        from apendice where ape_fac_id = fac_id order by ape_id asc)
)
FROM factura, contribuyentes as a, contribuyentes as b
where a.ruc_nit_contribuyente = fac_nit_emisor and 
	a.ruc_tipo_contribuyente = 'EMISOR' and 
	b.ruc_nit_contribuyente = fac_nit_receptor and 
	b.ruc_tipo_contribuyente = 'RECEPTOR' and 
	fac_id = pfactura
);

 
WHEN ptipo_fac = 'ANU' THEN
/*ANULACION*/
set vjson = (

SELECT JSON_OBJECT(
   'identificacion',
       JSON_OBJECT(
            'version',2,
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
            'codigoGeneracion',fac_codigo_generacion,
            'fecAnula', DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d'),
            'horAnula', DATE_FORMAT(CURRENT_TIMESTAMP, '%H:%i:%s')
        ),
   'emisor',
       JSON_OBJECT(
           'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
           'correo', a.ruc_email_contribuyente,
           'nombre', a.ruc_nombre_razonsocial,
           'codEstableMH',a.ruc_codigo_mh,
           'codEstable',a.ruc_tipoestablecimiento,
           'codPuntoVentaMH',a.ruc_cod_punto_venta_mh,
           'codPuntoVenta',a.ruc_cod_punto_venta_mh,
           'tipoEstablecimiento',a.ruc_tipoestablecimiento,
           'telefono',REPLACE(a.ruc_telefono_personal, "-", ""),
           'nomEstablecimiento', a.ruc_nombre_comercial
        ),
     'documento',
       JSON_OBJECT(
            'tipoDte',fac_tipo_comprobante,
            'codigoGeneracion',fac_codigo_generacion,
            'selloRecibido',(SELECT distinct selloRecibido FROM bitacora_declaracion_hacienda where id_fac = fac_id),
            'numeroControl',fac_numero_de_control,
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'),
            'tipoDocumento',(SELECT CAST(doc_idtipo_documento as CHAR) FROM fact.tipos_documentos where doc_id=b.ruc_tipo_doc_id),
            'numDocumento',REPLACE(b.ruc_nit_contribuyente, "-", ""),
            'nombre', b.ruc_nombre_razonsocial,
            'codigoGeneracionR', CASE WHEN (SELECT da_cti_id FROM fact.detalle_anulaciones where da_fac_id= fac_id and da_id = (SELECT max(da_id)FROM fact.detalle_anulaciones where da_fac_id= fac_id)) = 2 THEN NULL ELSE (SELECT da_codigo_generacionr FROM fact.detalle_anulaciones where da_fac_id= fac_id and da_id = (SELECT max(da_id)FROM fact.detalle_anulaciones where da_fac_id= fac_id)) END,
            'montoIva', fac_total_iva
        ),
      'motivo',
            JSON_OBJECT(
                'tipoAnulacion', (SELECT da_cti_id FROM fact.detalle_anulaciones where da_fac_id=fac_id and da_id = (SELECT max(da_id)FROM fact.detalle_anulaciones where da_fac_id= fac_id)),
                'motivoAnulacion', (SELECT da_motivo FROM fact.detalle_anulaciones where da_fac_id=fac_id and da_id = (SELECT max(da_id)FROM fact.detalle_anulaciones where da_fac_id= fac_id)),
                'nombreResponsable', (SELECT ef_nombentrega FROM fact.extensiones_facturas WHERE ef_ruc_id=a.ruc_id),
                'tipDocResponsable', (SELECT CAST(doc_idtipo_documento as CHAR) FROM fact.tipos_documentos where doc_id=a.ruc_tipo_doc_id),
                'numDocResponsable', (SELECT ef_docuEntrega FROM fact.extensiones_facturas WHERE ef_ruc_id=a.ruc_id),
                'nombreSolicita', (SELECT ef_nombEntrega FROM fact.extensiones_facturas WHERE ef_ruc_id=a.ruc_id),
                'tipDocSolicita', (SELECT CAST(doc_idtipo_documento as CHAR) FROM fact.tipos_documentos where doc_id=a.ruc_tipo_doc_id),
                'numDocSolicita', (SELECT ef_docuEntrega FROM fact.extensiones_facturas WHERE ef_ruc_id=a.ruc_id)
            )
)
FROM factura, contribuyentes as a,  contribuyentes as b
where a.ruc_nit_contribuyente = fac_nit_emisor and 
	a.ruc_tipo_contribuyente = 'EMISOR' and 
	b.ruc_nit_contribuyente = fac_nit_receptor and 
	b.ruc_tipo_contribuyente = 'RECEPTOR' and 
	fac_id = pfactura
);


WHEN ptipo_fac = 'CRE' THEN
/*RETENCION*/
set vjson = (
SELECT JSON_OBJECT(
    'identificacion',
        JSON_OBJECT(
            'version', 1,
            'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
            'tipoDte',fac_tipo_comprobante,
            'numeroControl',fac_numero_de_control,
            'codigoGeneracion',fac_codigo_generacion,
            'tipoModelo',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoModelo'),
            'tipoOperacion',(SELECT CAST(pgn_valor as SIGNED) FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'),
            'tipoContingencia',null,
            'motivoContin',null,
            'fecEmi', DATE_FORMAT(NOW(), '%Y-%m-%d'),
            'horEmi', DATE_FORMAT(NOW(), '%H:%i:%s'),
            'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda')
        ),
    'emisor',
        JSON_OBJECT(
            'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
            'nrc', a.ruc_nrc,
            'nombre', a.ruc_nombre_razonsocial,
            'codActividad', a.ruc_codactividad,
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.ruc_codactividad),
            'nombreComercial', a.ruc_nombre_razonsocial,
            'tipoEstablecimiento', a.ruc_tipoestablecimiento,
            'direccion',
                JSON_OBJECT(
                    'departamento', a.ruc_codigo_departamento,
                    'municipio', a.ruc_codigo_municipio,
                    'complemento', a.ruc_domicilio
                ),
            'telefono',REPLACE(a.ruc_telefono_personal, "-", ""),
            'codigoMH', a.ruc_codigo_mh,
            'codigo', null,
            'puntoVenta', a.ruc_cod_punto_venta,
            'puntoVentaMH', a.ruc_cod_punto_venta_mh,
            'correo', a.ruc_email_contribuyente
        ),
    'receptor',
        JSON_OBJECT(
            'tipoDocumento', (SELECT CAST(doc_idtipo_documento as CHAR) FROM fact.tipos_documentos where doc_id=b.ruc_tipo_doc_id),
            'numDocumento',REPLACE(b.ruc_nit_contribuyente, "-", ""),
            'nrc', b.ruc_nrc,
            'nombre', b.ruc_nombre_razonsocial,
            'codActividad', b.ruc_codactividad,
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = b.ruc_codactividad),
            'nombreComercial', b.ruc_nombre_razonsocial,
            'direccion',
                JSON_OBJECT(
                    'departamento', b.ruc_codigo_departamento,
                    'municipio', b.ruc_codigo_municipio,
                    'complemento', b.ruc_domicilio
                ),
            'telefono', REPLACE(b.ruc_telefono_personal, "-", ""),
            'correo', b.ruc_email_contribuyente
        ),
        'cuerpoDocumento',
            (SELECT JSON_ARRAYAGG(JSON_OBJECT(
            'numItem',ret_numitem,
            'tipoDte', ret_tipodte,
            'tipoDoc', ret_tipodoc,
            'numDocumento', ret_numdocumento,
            'fechaEmision', DATE_FORMAT(ret_fechaemision, '%Y-%m-%d'),
            'montoSujetoGrav', ret_montosujetograv,
            'codigoRetencionMH', (SELECT cri_codigo FROM fact.catalogo_retencion_iva_mh where cri_id=fac_cri_id),
            'ivaRetenido', ret_iva,
            'descripcion', ret_descripcion))
            FROM retenciones WHERE ret_fac_id = fac_id),
        'resumen',
            JSON_OBJECT(
                'totalSujetoRetencion',fac_totalsujetoretencion,
                'totalIVAretenido',fac_iva_retenido,
                'totalIVAretenidoLetras',fac_ivaretenido_letras
            ),
        'extension',
            JSON_OBJECT(
                'nombEntrega', null,
                'docuEntrega',null,
                'nombRecibe', null,
                'docuRecibe', null,
                'observaciones', null
            ),
        'apendice',
            (select JSON_ARRAYAGG(JSON_OBJECT(
        'campo',ape_campo,
        'etiqueta',ape_etiqueta,
        'valor',ape_valor))
        from apendice where ape_fac_id = fac_id order by ape_id asc)
)
FROM factura, contribuyentes as a, contribuyentes as b
where a.ruc_nit_contribuyente = fac_nit_emisor and 
	a.ruc_tipo_contribuyente = 'EMISOR' and 
	b.ruc_nit_contribuyente = fac_nit_receptor and 
	b.ruc_tipo_contribuyente = 'RECEPTOR' and 
	fac_id = pfactura);
else
    set    vjson := null;
END CASE;
RETURN vjson;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fun_retorna_link` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fun_retorna_link`(p_factura int) RETURNS longtext CHARSET utf8mb4
    READS SQL DATA
BEGIN
	
DECLARE vcod_gene varchar(50);
DECLARE vambiente varchar(5);
DECLARE vfecha DATE;
   
declare texto_link longtext ;
    
SELECT fac_codigo_generacion, DATE_FORMAT(fac_fecha_emision,'%y-%m-%d') into vcod_gene,vfecha FROM fact.factura where fac_id= p_factura;

SELECT pgn_valor into vambiente FROM fact.parametros_generales where pgn_campo='version';

set texto_link = '
		https://admin.factura.gob.sv/consultaPublica?ambiente=B_AMBIE&codGen=A_CODGENE&fechaEmi=C_FECHA
    ';

    select replace(replace(replace(texto_link,'A_CODGENE',vcod_gene),'B_AMBIE',vambiente),'C_FECHA',vfecha)
    into texto_link;

    return texto_link;
  

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fun_secuencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fun_secuencia`(`tipo_comprobante` VARCHAR(5), pid_emp int) RETURNS varchar(31) CHARSET utf8mb3
    READS SQL DATA
BEGIN

declare dte varchar(31);
declare  idtipo int ;
declare secuencia int;
DECLARE vcod varchar(100) ;
set dte = null ;
set idtipo = 0;
set secuencia = 0;
set vcod = 1;

select tcp_idtipo into idtipo
from tipos_comprobantes
where tcp_comprobante = tipo_comprobante;


set vcod = (select 0 
			where not exists (select nosec_tcp_idtipo 
							from fact.nosecuencia_factura
							where nosec_tcp_idtipo = idtipo and
								nosec_ce_empresa = pid_emp and
								nosec_anio = 2025));

if vcod = 0 then
  
	INSERT INTO fact.nosecuencia_factura (nosec_anio, nosec_tcp_idtipo, nosec_secuencia, nosec_ruc_id, nosec_ce_empresa) VALUES (2025, idtipo, 0, 1, pid_emp);

	select 
		concat('DTE-',tcp_idtipcom,'-', (select estable_pv from empresa where id_empresa = pid_emp),'-',LPAD((1),15,'0') )
		into dte
	from tipos_comprobantes
	where tcp_comprobante = tipo_comprobante;
else
	select 
		concat('DTE-',tcp_idtipcom,'-', (select estable_pv from empresa where id_empresa = pid_emp),'-',LPAD((SELECT nosec_secuencia+1 FROM fact.nosecuencia_factura where nosec_tcp_idtipo = idtipo and nosec_ce_empresa = pid_emp and nosec_anio = year(curdate()) ),15,'0') )
		into dte
	from tipos_comprobantes
	where tcp_comprobante = tipo_comprobante;

	update fact.nosecuencia_factura
	set nosec_secuencia = nosec_secuencia + 1
	where nosec_tcp_idtipo = idtipo and 
		nosec_ce_empresa = pid_emp and
		nosec_anio = 2025;
 
end if; 

## limpieza de variables
set tipo_comprobante = null ;
RETURN dte;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fun_verifica_receptor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `fun_verifica_receptor`(`pnit` VARCHAR(45)) RETURNS varchar(2) CHARSET utf8mb3
    READS SQL DATA
BEGIN
	DECLARE vcod varchar(2) ;
	DECLARE vres varchar(2) ;

	SELECT 1 into vcod
	FROM fact.contribuyentes
	where ruc_nit_contribuyente = pnit
	and ruc_tipo_contribuyente = 'RECEPTOR';

	If ifnull(vcod,0) = 1 then
		set vres = 'SI';
	else 
	   set vres = 'NO';
	end if;

RETURN vres;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `NUMERO_MENOR_MIL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `NUMERO_MENOR_MIL`(NUMERO DECIMAL(4)) RETURNS varchar(1000) CHARSET utf8mb3
    READS SQL DATA
BEGIN
       DECLARE CENTENAS INT;
       DECLARE DECENAS INT;
       DECLARE UNIDADES INT;
       DECLARE EN_LETRAS VARCHAR(1000);
       DECLARE UNIR VARCHAR(2);
          SET EN_LETRAS = '';
        IF (NUMERO = 100) THEN
            RETURN ('CIEN ');
        ELSEIF NUMERO = 0 THEN
            RETURN ('CERO ');
        ELSEIF NUMERO = 1 THEN
            RETURN ('UNO ');
        ELSE
            SET CENTENAS = TRUNCATE(NUMERO / 100,0);
            SET DECENAS  = TRUNCATE((NUMERO MOD 100)/10,0);
            SET UNIDADES = NUMERO MOD 10;
            SET UNIR = 'Y ';

                  IF CENTENAS = 1 THEN
                SET EN_LETRAS = 'CIENTO ';
            ELSEIF CENTENAS = 2 THEN
                SET EN_LETRAS = 'DOSCIENTOS ';
            ELSEIF CENTENAS = 3 THEN
                SET EN_LETRAS = 'TRESCIENTOS ';
            ELSEIF CENTENAS = 4 THEN
                SET EN_LETRAS = 'CUATROCIENTOS ';
            ELSEIF CENTENAS = 5 THEN
                SET EN_LETRAS = 'QUINIENTOS ';
            ELSEIF CENTENAS = 6 THEN
                SET EN_LETRAS = 'SEISCIENTOS ';
            ELSEIF CENTENAS = 7 THEN
                SET EN_LETRAS = 'SETECIENTOS ';
            ELSEIF CENTENAS = 8 THEN
                SET EN_LETRAS = 'OCHOCIENTOS ';
            ELSEIF CENTENAS = 9 THEN
                SET EN_LETRAS = 'NOVECIENTOS ';
            END IF;

                  IF DECENAS = 3 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , 'TREINTA ');
            ELSEIF DECENAS = 4 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , 'CUARENTA ');
            ELSEIF DECENAS = 5 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , 'CINCUENTA ');
            ELSEIF DECENAS = 6 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , 'SESENTA ');
            ELSEIF DECENAS = 7 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , 'SETENTA ');
            ELSEIF DECENAS = 8 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , 'OCHENTA ');
            ELSEIF DECENAS = 9 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , 'NOVENTA ');
            ELSEIF DECENAS = 1 THEN
                IF UNIDADES < 6 THEN
                    IF UNIDADES = 0 THEN
                        SET EN_LETRAS = CONCAT(EN_LETRAS , 'DIEZ ');
                    ELSEIF UNIDADES = 1 THEN
                        SET EN_LETRAS = CONCAT(EN_LETRAS , 'ONCE ');
                    ELSEIF UNIDADES = 2 THEN
                        SET EN_LETRAS = CONCAT(EN_LETRAS , 'DOCE ');
                    ELSEIF UNIDADES = 3 THEN
                        SET EN_LETRAS = CONCAT(EN_LETRAS , 'TRECE ');
                    ELSEIF UNIDADES = 4 THEN
                        SET EN_LETRAS = CONCAT(EN_LETRAS , 'CATORCE ');
                    ELSEIF UNIDADES = 5 THEN
                        SET EN_LETRAS = CONCAT(EN_LETRAS , 'QUINCE ');
                    END IF;
                    SET UNIDADES = 0;
                ELSE
                    SET EN_LETRAS = CONCAT(EN_LETRAS, 'DIECI');
                    SET UNIR = '';
                END IF;
            ELSEIF (DECENAS = 2) THEN
                IF (UNIDADES = 0) THEN
                    SET EN_LETRAS = CONCAT(EN_LETRAS, 'VEINTE ');
                ELSE
                    SET EN_LETRAS = CONCAT(EN_LETRAS, 'VEINTI');
                END IF;
                SET UNIR = '';
            ELSEIF (DECENAS = 0) THEN
                SET UNIR = '';
            END IF;

            IF (UNIDADES = 1) THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'UNO ');
            ELSEIF UNIDADES = 2 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'DOS ');
            ELSEIF UNIDADES = 3 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'TRES ');
            ELSEIF UNIDADES = 4 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'CUATRO ');
            ELSEIF UNIDADES = 5 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'CINCO ');
            ELSEIF UNIDADES = 6 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'SEIS ');
            ELSEIF UNIDADES = 7 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'SIETE ');
            ELSEIF UNIDADES = 8 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS, UNIR, 'OCHO ');
            ELSEIF UNIDADES = 9 THEN
                SET EN_LETRAS = CONCAT(EN_LETRAS , UNIR , 'NUEVE ');
            END IF;
        END IF;
        RETURN(EN_LETRAS);
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_factura_det` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `new_factura_det`(
in fac_id int ,
in fac_nro_factura int(15),
in  numlinea int ,
in cantidad  int,
in decripcion  varchar(50),
in preciounitario decimal(15,2),
in subtotal decimal(15,2),
in tipo_item int,
in unidad_medida  int ,
in ventas_no_sujetas decimal(15,2),
in ventas_exentas decimal(15,2),
in ventas_gravadas decimal(15,2),
in fac_iva decimal(15,2),
in cantidad_letras varchar(100),
in tributo  decimal(15,2),
in psv  decimal(15,2),
in no_gravado decimal(15,2),
in iva_item decimal(15,2),
in monto_desc decimal(15,2),
out nofactid int )
begin 

select count(fac_id) into nofactid from factura_detalle  where fac_id =fac_id;
if nofactid =0 then
insert into factura_detalle values (
fac_id  ,
 fac_nro_factura ,
  numlinea  ,
 cantidad ,
 decripcion ,
 preciounitario ,
 subtotal ,
 tipo_item ,
 unidad_medida ,
 ventas_no_sujetas ,
 ventas_exentas,
 ventas_gravadas,
 fac_iva ,
 cantidad_letras ,
 tributo ,
 psv  ,
 no_gravado ,
 iva_item ,
 monto_desc );
 end if;
select det_fac_id into nofactid  from factura_detalle where det_fac_id= fac_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_datos_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `obtener_datos_usuario`(
    IN p_usuario VARCHAR(25),
    OUT p_clave VARCHAR(255),
    OUT p_ubicacion VARCHAR(10),
    OUT p_puesto VARCHAR(30),
    OUT pval VARCHAR(5),
    OUT pmensaje VARCHAR(255)
)
BEGIN
    SELECT us_clave, us_ubicacion, us_puesto
    INTO p_clave, p_ubicacion, p_puesto
    FROM usuarios
    WHERE us_usuario = p_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_actualiza_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_actualiza_ticket`(    
    IN pcorrelativo VARCHAR(20),
    IN pidfactura varchar(50),
    IN papp varchar(30),
	IN pusuario varchar(50),
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN

    DECLARE vfactura_count INT;
     DECLARE vid INT;

	-- Verificar si la factura existe
    SELECT COUNT(*) INTO vfactura_count
    FROM factura
    WHERE fac_id = pidfactura;
    
    IF vfactura_count = 0 THEN
        SET pval = 1; -- Indicador de que la factura no existe
        SET pmensaje = 'La factura especificada no existe';
    ELSE
    
		Select id_correlativo into vid
        from tickets_parqueo 
        Where secuencia_qr = pcorrelativo
        AND fecha_ingreso=DATE(now());

		-- Actualizar la fecha de cobro y estado en la tabla
		UPDATE tickets_parqueo
		SET id_factura_generado = pidfactura
		WHERE id_correlativo = vid;

		SET pval = 0; -- Indicador de éxito
		SET pmensaje = 'La factura ha sido actualizada correctamente';
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_agrega_producto_copias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_agrega_producto_copias`(
    IN pusuario VARCHAR(50), 
    IN papp varchar(30),
	IN pproducto VARCHAR(10),
    IN pcantidad INT,
    OUT pvalor decimal(15,2),
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN

	DECLARE vvalor_unitario decimal(11,5);

	SET pval = 0;
    SET pmensaje = 'OK';

	IF (pproducto IS NOT NULL AND pcantidad IS NOT NULL) AND (pproducto <> '' AND pcantidad <> '') then

		SELECT valor_unitario 
		INTO  vvalor_unitario 
		FROM fact.catalogo_productos
		WHERE codigo_prod = pproducto;
		
		set pvalor = ifnull(vvalor_unitario,0.0)*pcantidad;
			
		SET pval = 0;
		SET pmensaje = 'OK';
	ELSE
		SET pval = 1;
		SET pmensaje = 'PRODUCTO O CANTIDAD SE ENCUENTRAN VACIOS';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_anulacion_automatica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_anulacion_automatica`(in `pfactura` JSON, out pval int, out pmensaje text)
BEGIN
  -- Declare variable para usar después en el bucle
  -- En la proxima mejora se debe agregar la sucursal de cobro y el producto al catalogo de productos para no hacer un case
	DECLARE i INT DEFAULT 0;
	DECLARE vnum_fact INT DEFAULT 0;
	DECLARE vcodigo_prod  text;
	DECLARE vdescripcion text;
	DECLARE vvalor_unitario decimal(11,5);
	DECLARE vtotal decimal(11,5);
    DECLARE vexist int;
	DECLARE vexist_anu int;
    DECLARE vfac_id int;
  
  BEGIN
    DECLARE fecha_val VARCHAR(10);
    DECLARE cantidad_val INT;
    DECLARE producto_val VARCHAR(255);
    DECLARE sucursal_val VARCHAR(10);
	DECLARE cdc_id_val int;
	DECLARE nombre_val VARCHAR(120);

    -- Inicializa el índice para el bucle
    SET i = 0;

    -- Establece los valores de salida
    SET pval = 0;
    SET pmensaje = 'ÉXITO';

    -- Obtén la longitud del array JSON
    SET @array_length = JSON_LENGTH(JSON_EXTRACT(pfactura, '$.myArrayList'));
    

    -- Inicia el bucle para recorrer el array JSON
    WHILE i < @array_length DO
      -- Extrae los valores del objeto JSON
      SET fecha_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fecha')));
      SET cdc_id_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cdc')));


      -- Convierte la fecha al formato YYYY-MM-DD
      SET fecha_val = STR_TO_DATE(fecha_val, '%d/%m/%Y');

      -- Inserta en la tabla
      INSERT INTO tmp_factura (fecha, cantidad, producto, JSON_TEST,sucursal)
      VALUES (fecha_val, 0, 'ANULACION', pfactura,null);

		SELECT IF(COUNT(*) > 0, 1, 0) into vexist
        FROM fact.buzoncsv
		WHERE cdc_id=cdc_id_val;

		if vexist= 1 then
			SELECT distinct id_factura into vfac_id
			FROM fact.buzoncsv
			WHERE cdc_id=vfac_id;
            
			SELECT IF(COUNT(*) > 0, 1, 0) into vexist_anu
			FROM fact.detalle_anulaciones
			WHERE da_fac_id=cdc_id_val;
            
			if vexist_anu = 1 then
				SET pval = 1;
				SET pmensaje = 'FACTURA POSEE 1 ANULACION YA EFECTUADA';
            else
            
			    CALL pro_inserta_anulacion('TEST', vfac_id,2,null, pval, pmensaje);
                
            end if;
        else
			SET pval = 1;
			SET pmensaje = 'FACTURA NO EXISTE PARA ANULARLA';
        end if;
        


      -- Incrementa el índice del bucle
      SET i = i + 1;
    END WHILE; 


  END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_aut_facturas_fin_mes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_aut_facturas_fin_mes`(in `pfactura` JSON, out pval int, out pmensaje text)
BEGIN
  -- Declare variable para usar después en el bucle
  DECLARE i INT DEFAULT 0;
  DECLARE vnum_fact INT DEFAULT 0;
  DECLARE vcodigo_prod  text;
  DECLARE vdescripcion text;
  DECLARE vvalor_unitario decimal(11,5);
  DECLARE vtotal decimal(11,5);
	DECLARE vruc_nombre_razonsocial varchar(120);
	DECLARE vruc_domicilio varchar(200);
	DECLARE vruc_nrc varchar(45);
  
  
  BEGIN
    DECLARE fecha_val VARCHAR(10);
    DECLARE cantidad_val INT;
    DECLARE producto_val VARCHAR(255);
    DECLARE sucursal_val VARCHAR(10);

    -- Inicializa el índice para el bucle
    SET i = 0;

    -- Obtén la longitud del array JSON
    SET @array_length = JSON_LENGTH(JSON_EXTRACT(pfactura, '$.myArrayList'));
    

    -- Inicia el bucle para recorrer el array JSON
    WHILE i < @array_length DO
      -- Extrae los valores del objeto JSON
      SET fecha_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fecha')));
      SET cantidad_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cantidad')));
      SET producto_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.producto')));  
      SET sucursal_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.sucursal')));

      -- Convierte la fecha al formato YYYY-MM-DD
      SET fecha_val = STR_TO_DATE(fecha_val, '%d/%m/%Y');


      -- Inserta en la tabla
      INSERT INTO tmp_factura (fecha, cantidad, producto, JSON_TEST,sucursal)
      VALUES (fecha_val, cantidad_val, producto_val, pfactura,sucursal_val);
      
      -- SELECT cod_factura+1
		SELECT  fac_nro_factura+1
        INTO vnum_fact
		FROM fact.factura
		ORDER BY fac_id DESC
		LIMIT 1;
        
		SELECT codigo_prod,descripcion,valor_unitario 
		INTO vcodigo_prod, vdescripcion, vvalor_unitario 
        FROM fact.catalogo_productos
		WHERE codigo_prod = case when producto_val = 'TARJETA' then 'TC'  else 
		case when sucursal_val = 'SA' then 'LICSA' when  sucursal_val ='SM' then 'LICSM' when sucursal_val ='CS' then 'LICCSC' when  sucursal_val ='LD' then 'LICLD'  else 'LICSS' end end;

		SET vtotal = (cantidad_val*vvalor_unitario)+((cantidad_val*vvalor_unitario)*0.13);
        
        SELECT ruc_nombre_razonsocial,ruc_domicilio,ruc_nrc 
		INTO vruc_nombre_razonsocial,vruc_domicilio,vruc_nrc
        FROM fact.contribuyentes
		WHERE ruc_nit_contribuyente='06141708001052';
        
	INSERT INTO `buzoncsv` (`cod_factura`,`cod_emisor`,`tipodoc`,`tipodocrec`,`nit`,`nrc`,`nombrecliente`,
    `correo`,`telefono`,`moneda`,`tipocambio`,
    `depart`,`municipio`,`complemento`,`codactcom`,`codigo`,
    `detalle`,`unidad_medida`,`tipo`,`cantidad`,`precio_unitario`,`descuento`,`exento`,`codigo_`,
    `porcentaje`,`valor`,`condicionpago`,`mediopago`,`monto`,`referencia`,`plazo`,`periodo`,`tipogeneracion`,`tipodte`,`numeroautorizacion`,`fechahoraemision`,
    `tipodocidreceptor`,`bientitulo`,`fecha_migrado`,`factura_migrada`,
    `buzoncsvcol`,`tipo_item_expor`,`recinto_fiscal`,`regimen`,`codtributo`,`doc_relacionado`,
    `tipo_doc_relacionado`,`fecha_doc_relacionado`,`tipo_generacion_doc_rel`,`descripcion_retencion`,`id_retencion`) 
    VALUES 
    (vnum_fact,'06140203981013','03',36,'06141708001052',vruc_nrc,vruc_nombre_razonsocial,
    'jcrivcruz@gmail.com'/*PARA PRUEBAS*/ ,'2133-3600','USD',1,
    '06',14,vruc_domicilio,'84110',vcodigo_prod/*COLOCAR TC O EL COD DE LIC*/ ,
    vdescripcion/*DESCRIPCION*/ ,59,2,cantidad_val/*CANTIDAD*/ ,vvalor_unitario/*PRECIO UNITARIO*/ ,0.00000,'No',20,
    13,vtotal/*CANTIDAD*PRECIO + IVA*/ ,2,'05',vtotal/*MISMO QUE EL VALOR*/ ,'','01','15',NULL,NULL,NULL,NULL,
    NULL,NULL,NOW(),'N',
    NULL,NULL,NULL,NULL,NULL,NULL,
    NULL,NULL,NULL,NULL,NULL);

      -- Incrementa el índice del bucle
      SET i = i + 1;
    END WHILE; 

    -- Establece los valores de salida
    SET pval = 0;
    SET pmensaje = 'ÉXITO';
  END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_calcula_montos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_calcula_montos`(in papp varchar(50), in pusuario varchar(50), in popcion varchar(50), in pmonto decimal(15,2), in pcantidad int, 
in pfactura varchar(10), out ptotal decimal(15,2), out pval int, out pmensaje text)
BEGIN
	set pval = 0;
	set pmensaje = 'OK';
        
	case popcion
    when 'IVA' then
		if pfactura = '01' then
			set ptotal = ((pmonto * ifnull(pcantidad, 1)) / 1.13) * 0.13;
		elseif pfactura = '03' then
			set ptotal = (pmonto * ifnull(pcantidad, 1)) * 0.13;
		else
			set pval = 1;
			set pmensaje = 'TIPO DE FACTURA INGRESADA NO VALIDA';
		end if;
	when 'VENTASNOSUJETAS' then
		set ptotal = 0.00;
    when 'VENTASSUJETAS' then
		set ptotal = 0.00;
	when 'VENTASEXENTAS' then
		set ptotal = 0.00;
    else
		set pval = 1;
        set pmensaje = 'OPCION INGRESADA NO VALIDA';
    end case;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_calcula_pago_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_calcula_pago_ticket`(    
	IN pcorrelativo VARCHAR(20),
	IN pusuario_cobro varchar(50),
    IN pvalor_cobro DECIMAL(15, 2),
	IN pdui VARCHAR(10),
    IN pnombres VARCHAR(60),
    IN papellidos VARCHAR(60),
    OUT pval INT,
    OUT pmensaje VARCHAR(255))
BEGIN
 DECLARE vtipoplaca VARCHAR(20);
 DECLARE vh_hora_inicio TIME;
 DECLARE vh_diferencia INT;
 DECLARE vnum_fact INT DEFAULT 0;
 DECLARE vruc_nombre_razonsocial varchar(120);
 DECLARE vruc_domicilio varchar(200);
 DECLARE vruc_nrc varchar(45);
 DECLARE vcorreo VARCHAR(100);
 DECLARE vcodigo_prod  text;
 DECLARE vdescripcion text;
 DECLARE vvalor_unitario decimal(11,5);
 DECLARE vtotal_horas int;
 DECLARE vid int;
 DECLARE vcobrado int;
 DECLARE vh_hora_fin TIME;
 DECLARE vcobro DECIMAL(15, 2);
 DECLARE vcortesia VARCHAR(2);
 DECLARE vulb varchar(15);

    -- Inicializar variables
    SET vcobro = 0.0;
    SET pmensaje = NULL;
	SET vh_hora_fin = DATE_SUB(CURTIME(),INTERVAL 6 HOUR); 
    
    IF pusuario_cobro IS NOT NULL THEN
    
		IF pcorrelativo IS NOT NULL THEN
			
			IF (pnombres IS NOT NULL AND papellidos IS NOT NULL) AND (pnombres <> '' AND papellidos <> '') then
				SET vcortesia = 'N';
				-- Obtener información del vehículo
				SELECT ifnull(cortesia,'N')
				INTO vcortesia
				FROM tickets_parqueo
				WHERE secuencia_qr = pcorrelativo
				AND fecha_ingreso = DATE(NOW())
				ORDER BY fecha_ingreso DESC
				LIMIT 1;
				
				IF  vcortesia != 'S' THEN
				
					-- Obtener información del vehículo
					SET vcobrado = 0;
					
					-- Validación para confirmar que la factura no se encuentre cancelada
					SELECT 1
					INTO vcobrado
					FROM tickets_parqueo
					WHERE secuencia_qr = pcorrelativo
					AND fecha_ingreso=DATE(now())
					AND estado='C'
					ORDER BY fecha_ingreso DESC
					LIMIT 1;      
					
					IF vcobrado != 1 THEN
					
						SELECT hora_inicio, tipo_placa, id_correlativo
						INTO vh_hora_inicio, vtipoplaca, vid
						FROM tickets_parqueo
						WHERE secuencia_qr = pcorrelativo
						AND fecha_ingreso=DATE(now())
						AND estado='P'
						ORDER BY fecha_ingreso DESC
						LIMIT 1;

						-- Calcular la diferencia de tiempo en minutos
						SET vh_diferencia = TIMESTAMPDIFF(MINUTE, vh_hora_inicio, vh_hora_fin);

						-- Se verifica si el ticket es cobrado desde el primer segundo
						IF vh_diferencia = 0  and TIMESTAMPDIFF(SECOND, vh_hora_inicio, vh_hora_fin) > 0 then -- se evalua que la diferencia los segundos sea al menos de mas 1 segundo
							set vh_diferencia = 60;
						end if;
						-- Rosy indico que el maximo a cobrar serian 4 horas
						IF vh_diferencia>240 then
							set vh_diferencia = 240;
						end if;
						
						SET vtotal_horas = CEIL(vh_diferencia / 60);
						-- Calcular el valor del cobro según la placa
						IF vtipoplaca = 'M' THEN
							-- Si la placa inicia con 'M' pero no es 'MB'
							-- SET vcobro = CEIL(vh_diferencia / 60) * 0.25;
							SET vcodigo_prod = CONCAT('TPM',vtotal_horas);
							SELECT valor_unitario INTO vcobro FROM catalogo_productos where codigo_prod=vcodigo_prod;
						ELSE
							-- Si la placa no cumple con ninguna condición especial
							-- SET vcobro = CEIL(vh_diferencia / 60) * 0.5;
							SET vcodigo_prod = CONCAT('TP',vtotal_horas);
							SELECT valor_unitario INTO vcobro FROM catalogo_productos where codigo_prod=vcodigo_prod;
						END IF;

						-- Validacion para confirmar que el valor de cobro ingresado coincida con el valor real al cobrar
						IF pvalor_cobro = vcobro THEN
						
						SELECT us_ubicacion 
						INTO vulb
						FROM fact.usuarios 
						WHERE us_usuario=pusuario_cobro;
						
							-- Actualizar la fecha de cobro y estado en la tabla
							UPDATE tickets_parqueo
							SET fecha_cobro = NOW(),
								estado = 'C',
								ulb_user_cobro = vulb,
								usuario_cobro = pusuario_cobro, -- Reemplaza con el nombre de usuario correspondiente
								valor_cobro = pvalor_cobro,
								hora_fin = vh_hora_fin,
								dui = pdui,
								nombres = pnombres,
								apellidos = papellidos
							WHERE id_correlativo = vid;
							
                            -- SELECT para cod_factura en buzoncsv
							select fact.fun_genera_numero_interno('TICKETPARKING', pusuario_cobro)
							INTO vnum_fact;
                            
							
							SELECT descripcion, valor_unitario 
							INTO  vdescripcion, vvalor_unitario 
							FROM fact.catalogo_productos
							WHERE codigo_prod = vcodigo_prod;
							
							SELECT ruc_nombre_razonsocial,ruc_domicilio,ruc_nrc, ruc_email_contribuyente
							INTO vruc_nombre_razonsocial,vruc_domicilio,vruc_nrc,vcorreo
							FROM fact.contribuyentes
							WHERE ruc_nit_contribuyente= '00000000000000' and ruc_tipo_contribuyente='RECEPTOR';
							
							INSERT INTO `buzoncsv` (`cod_factura`,`cod_emisor`,`tipodoc`,`tipodocrec`,`nit`,`nrc`,`nombrecliente`,
							`correo`,`telefono`,`moneda`,`tipocambio`,
							`depart`,`municipio`,`complemento`,`codactcom`,`codigo`,
							`detalle`,`unidad_medida`,`tipo`,`cantidad`,`precio_unitario`,`descuento`,`exento`,`codigo_`,
							`porcentaje`,`valor`,`condicionpago`,`mediopago`,`monto`,`referencia`,`plazo`,`periodo`,`tipogeneracion`,`tipodte`,`numeroautorizacion`,`fechahoraemision`,
							`tipodocidreceptor`,`bientitulo`,`fecha_migrado`,`factura_migrada`,
							`buzoncsvcol`,`tipo_item_expor`,`recinto_fiscal`,`regimen`,`codtributo`,`doc_relacionado`,
							`tipo_doc_relacionado`,`fecha_doc_relacionado`,`tipo_generacion_doc_rel`,`descripcion_retencion`,`id_retencion`,`nombre_receptor`) 
							VALUES 
							(vnum_fact,'06140203981013','01',36,IFNULL(REPLACE(pdui, "-", ""),'000000000'),vruc_nrc,vruc_nombre_razonsocial,
							vcorreo,'2133-3600','USD',1,
							'06',14,vruc_domicilio,'84110',vcodigo_prod,
							vdescripcion/*DESCRIPCION*/ ,59,2,1/*CANTIDAD*/ ,vvalor_unitario/*PRECIO UNITARIO */ ,0.00000,'No',20,
							13,pvalor_cobro/*CANTIDAD*PRECIO + IVA*/ ,1,'05',pvalor_cobro/*total*/ ,'','01','15',NULL,NULL,NULL,NULL,
							NULL,NULL,NOW(),'N',
							NULL,NULL,NULL,NULL,NULL,NULL,
							NULL,NULL,NULL,NULL,NULL,CONCAT(CONCAT(pnombres,' '),papellidos)
							);
							
						SET pval = 0;
						SET pmensaje = 'OK';
					

                    
						ELSE
							SET pval = 1;
							SET pmensaje = 'Error, Valor a pagar ingresado no coincide con el total a pagar.';
						END IF;
					ELSE
						SET pval = 1;
						SET pmensaje = 'La factura indicada ya se encuentra cancelada';

					END IF;
			
				ELSE
					SET pval = 1;
					SET pmensaje = 'Ticket ha sido catalogado como cortesía, no requiere cobro.';
				END IF;
           
			ELSE
				SET pval = 1;
				SET pmensaje = 'DEBE INGRESAR LOS DATOS NOMBRES Y/O APELLIDOS';
			END IF;
            
		ELSE
			SET pval = 1;
			SET pmensaje = 'Correlativo no encontrado.';
		END IF;
    ELSE
		SET pval = 1;
        SET pmensaje = 'Usuario Cobro se envuentra vacio.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_cantidad_a_letras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_cantidad_a_letras`(IN NUMERO DECIMAL(15,2), OUT EN_LETRAS TEXT)
BEGIN
    DECLARE MILLARES_DE_MILLON INT;
    DECLARE MILLONES INT;
    DECLARE MILLARES INT;
    DECLARE CENTENAS INT;
    DECLARE CENTIMOS INT;
    DECLARE ENTERO INT;
    DECLARE AUX VARCHAR(30);
    DECLARE CENTIMO_AUX VARCHAR(500);

    SET EN_LETRAS = '';
    SET ENTERO = TRUNCATE(NUMERO, 0);
    SET MILLARES_DE_MILLON = TRUNCATE(ENTERO / 1000000000, 0);
    SET MILLONES = TRUNCATE((ENTERO MOD 1000000000) / 1000000, 0);
    SET MILLARES = TRUNCATE((ENTERO MOD 1000000) / 1000, 0);
    SET CENTENAS = ENTERO MOD 1000;
    SET CENTIMOS = (TRUNCATE(NUMERO * 100, 0) MOD 100);

    -- Manejo de los millares de millón
    IF MILLARES_DE_MILLON > 0 THEN
        SET EN_LETRAS = CONCAT(NUMERO_MENOR_MIL(MILLARES_DE_MILLON), ' MIL MILLONES ');
    END IF;

    -- Manejo de los millones
    IF MILLONES > 0 THEN
        IF MILLONES = 1 AND MILLARES_DE_MILLON = 0 THEN
            SET EN_LETRAS = CONCAT(EN_LETRAS, 'UN MILLÓN ');
        ELSE
            SET EN_LETRAS = CONCAT(EN_LETRAS, NUMERO_MENOR_MIL(MILLONES), ' MILLONES ');
        END IF;
    END IF;

    -- Manejo de los millares
    IF MILLARES > 0 THEN
        IF MILLARES = 1 AND MILLARES_DE_MILLON = 0 AND MILLONES = 0 THEN
            SET EN_LETRAS = CONCAT(EN_LETRAS, 'MIL ');
        ELSE
            SET EN_LETRAS = CONCAT(EN_LETRAS, NUMERO_MENOR_MIL(MILLARES), ' MIL ');
        END IF;
    END IF;

    -- Manejo de las centenas
    IF CENTENAS > 0 THEN
        SET EN_LETRAS = CONCAT(EN_LETRAS, NUMERO_MENOR_MIL(CENTENAS));
    ELSEIF MILLARES = 0 AND MILLONES = 0 AND MILLARES_DE_MILLON = 0 THEN
        -- Para manejar el caso donde el número es exactamente 0
        SET EN_LETRAS = 'CERO ';
    END IF;

    -- Manejo de los centavos
    IF CENTIMOS > 0 THEN
        SET CENTIMO_AUX = NUMERO_MENOR_MIL(CENTIMOS);
        SET AUX = '/100 CTVS';
        SET EN_LETRAS = CONCAT(EN_LETRAS, 'CON ', CENTIMO_AUX, AUX);
    ELSE
        IF ENTERO > 0 THEN
            SET EN_LETRAS = CONCAT(EN_LETRAS, 'CON CERO /100 CTVS');
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_carga_facturas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_carga_facturas`(in papp varchar(30), in pusuario varchar(30), in pidemp int, out pid_factura int, out pval int, out pmensaje text)
BEGIN
	/*
		Por indicaciones de Mariano al SubTotal se le suma la retencion del IVA por WFLORES_ID 16/9/2024
    */
	declare vid_buzon int;
	declare vcod_factura varchar(250);
	declare vcod_emisor text;
	declare vtipodoc text;
	declare vtipodocrec int;
	declare vnit text;
	declare vnrc int;
	declare vnombrecliente text;
	declare vcorreo text;
	declare vtelefono text;
	declare vmoneda text;
	declare vtipocambio int;
	declare vdepart text;
	declare vmunicipio int;
	declare vcomplemento text;
	declare vcodactcom text;
	declare vcodigo text;
	declare vdetalle text;
	declare vunidad_medida int;
	declare vtipo int;
	declare vcantidad decimal(15);
	declare vprecio_unitario decimal(15,4);
	declare vdescuento text;
    declare vdescuento_total text;
	declare vexento text;
	declare vcodigo_ int;
	declare vporcentaje int;
	declare vvalor text;
	declare vcondicionpago int;
	declare vmediopago text;
	declare vmonto text;
	declare vreferencia text;
	declare vplazo text;
	declare vperiodo int default 0;
	declare vtipogeneracion text;
	declare vtipodte text;
    declare vobservaciones_detalles text;
	declare vnumeroautorizacion text;
	declare vfechahoraemision text;
	declare vtipodocidreceptor text;
	declare vbientitulo text;
	declare vfecha_migrado datetime;
	DECLARE vinserted INT DEFAULT 0;
    declare vid_fac int DEFAULT 1;
    declare vcontador_detalle int;
    declare vconta_ret int;
    declare vcantidad_detalles int;
    declare vdescripcion_tributo varchar(150);
    declare vsuma_tributo decimal(15,4);
    declare vtotal_iva decimal(15,4);
    declare vtotal_venta decimal(15,2);
	declare vtotal_compra decimal(15,2);
    declare vtotal decimal(15,4);
    declare vruc_codactividad varchar(6);
    declare vid_tipo_doc int;
    declare vcodigo_dte varchar(31);
    declare vexiste_factura int;
    declare vnum_linea_detalle int;
    declare vtexto_num_letras text;
    declare vval int;
    declare vpagos int;
    declare vtipo_comprobante varchar(5);
    declare viva_detalle decimal(15,4);
    declare vmontototaloperacion decimal(15,4);
    declare vtipo_item_expor int;
    declare vrecinto_fiscal varchar(2);
    declare vregimen varchar(13);
    declare vcodtributo varchar(5);
	declare vfin_cur int;
    declare vdoc_relacionado varchar(45);
    declare vtipo_doc_relacionado varchar(2);
    declare vfecha_doc_relacionado datetime;
    declare vtipo_generacion_doc_rel int;
    declare vdescripcion_retencion varchar(100);
    declare vid_retencion varchar(45);
    declare vnombre_receptor varchar(120);
    declare vret_iva decimal(15,2);
    declare vtotal_ret_iva decimal(15,2);
    declare vretencion_iva decimal(15,2);
    declare vid_usuario_ingreso INT;
    declare vulb_usuario_ingreso INT;    
    declare vfac_retencion_iva decimal(15,2);
    declare vfac_retencion_renta decimal(15,2);
    declare vimpuesto_reten_retenido decimal(11,2);
    declare vimpuesto_reten_retenido_porc decimal(11,2);
    declare vretencion_iva_porc decimal(11,2);
    declare vus_ubicacion int;
    
	declare vfacturas_a_migrar cursor for
		select id_buzon,cod_factura,cod_emisor,tipodoc,tipodocrec,
		nit,nrc,nombrecliente,correo,
		telefono,moneda,tipocambio,depart,
		municipio,complemento,codactcom,codigo,
		detalle,unidad_medida,tipo,cantidad,
		precio_unitario,descuento,exento,codigo_,
		porcentaje,valor,condicionpago,mediopago,
		monto,referencia,plazo,IFNULL(periodo,1),
		tipogeneracion,tipodte,numeroautorizacion,fechahoraemision,
		tipodocidreceptor,bientitulo,fecha_migrado,
        tipo_item_expor,recinto_fiscal,regimen,codtributo,
        doc_relacionado,tipo_doc_relacionado,fecha_doc_relacionado,tipo_generacion_doc_rel,
        descripcion_retencion, id_retencion, nombre_receptor, observaciones_detalles, retencion_iva,id_usuario_ingreso,ulb_usuario_ingreso,
        retencion_iva_porc,impuesto_reten_retenido,impuesto_reten_retenido_porc
		FROM 
			buzoncsv
		LEFT JOIN 
			catalogo_productos ON codigo = codigo_prod
		LEFT JOIN 
			fact.aplicaciones_por_procesos ON CP_PROCESO = app_proceso AND app_app = papp
		WHERE 
			buzoncsv.id_empresa = pidemp and
			IFNULL(factura_migrada, 'N') = 'N' and
			cod_factura IS NOT NULL
		ORDER BY 
			cod_factura ASC;
	declare continue handler for not found set vfin_cur = 1;
	

    SET vconta_ret = 1;
	set pval = 0;
    set pmensaje = 'ok.!';
	set vcontador_detalle = 0;
    set vsuma_tributo = 0;
    set viva_detalle = 0;
    
    
	open vfacturas_a_migrar;
    bucle: loop
    Set vfin_cur = 0;
		fetch vfacturas_a_migrar into
			vid_buzon, vcod_factura,vcod_emisor,vtipodoc,vtipodocrec,
			vnit,vnrc,vnombrecliente,vcorreo,
			vtelefono,vmoneda,vtipocambio,vdepart,
			vmunicipio,vcomplemento,vcodactcom,vcodigo,
			vdetalle,vunidad_medida,vtipo,vcantidad,
			vprecio_unitario,vdescuento,vexento,vcodigo_,
			vporcentaje,vvalor,vcondicionpago,vmediopago,
			vmonto,vreferencia,vplazo,vperiodo,
			vtipogeneracion,vtipodte,vnumeroautorizacion,vfechahoraemision,
			vtipodocidreceptor,vbientitulo,vfecha_migrado,
            vtipo_item_expor,vrecinto_fiscal,vregimen, vcodtributo,
            vdoc_relacionado,vtipo_doc_relacionado,vfecha_doc_relacionado,vtipo_generacion_doc_rel,
            vdescripcion_retencion, vid_retencion, vnombre_receptor,vobservaciones_detalles, vretencion_iva,vid_usuario_ingreso,vulb_usuario_ingreso,
            vretencion_iva_porc,vimpuesto_reten_retenido, vimpuesto_reten_retenido_porc;
 		
-- set pmensaje = concat(concat(pmensaje,' factura '),ifnull(vcod_factura,0));
set vdescuento_total = ifnull(vdescuento_total,0) + CAST((ifnull(vdescuento,0) * vcantidad)AS DECIMAL(10, 2));

-- set pmensaje = concat(pmensaje,' AQUI  vval 0');
            
IF vperiodo IS NULL or vperiodo = 'null' THEN
    SET vperiodo := 0; 
  END IF;

		if vfin_cur = 1 then
			leave bucle;
        end if;
        
		set vcontador_detalle = ifnull(vcontador_detalle,0) + 1;
        
        -- set pmensaje = concat(concat(pmensaje,' AQUI  contador'),vcontador_detalle);
		
		if vcontador_detalle = 1 then
			set vcantidad_detalles = 0;
			set vexiste_factura = 0;
			set vid_fac = 0;
			set vnum_linea_detalle = 0;
			set vval = 0;
			
			begin
				declare continue handler for not found set vexiste_factura = 0;
                
				select count(1) 
				into vcantidad_detalles 
				from buzoncsv
				where cod_factura = vcod_factura and
					buzoncsv.id_empresa = pidemp and
					ifnull(factura_migrada, 'N') = 'N';
				
				select 1, fac_id
				into vexiste_factura, vid_fac
				from factura
				where fac_nro_factura = vcod_factura and
					fac_ce_empresa = pidemp;
				
                set pid_factura = vid_fac;
                
                if vid_usuario_ingreso is not null then
					SELECT us_ubicacion
					INTO vus_ubicacion
					FROM fact.usuarios
					where us_id = vid_usuario_ingreso;
				end if;
                
				if ifnull(vexiste_factura, 0) = 1 then
					begin
						select max(det_fac_numlinea)
						into vnum_linea_detalle
						from factura_detalle
						where det_fac_id = vid_fac;
					end;
				end if;
			end;
		end if;
		
		if vcontador_detalle = 1 and vexiste_factura = 0 then 
            
			select ruc_codactividad
			into vruc_codactividad
			from contribuyentes
			where ruc_nit_contribuyente = vnit AND 
				id_empresa = pidemp and
				ruc_tipo_contribuyente='RECEPTOR';
			
			select doc_id
			into vid_tipo_doc
			from tipos_documentos
			where doc_idtipo_documento = vtipodocrec;
            
            SELECT tcp_comprobante
			into vtipo_comprobante
			FROM tipos_comprobantes
			where tcp_idtipcom = vtipodoc;
            
			select fact.fun_secuencia(vtipo_comprobante, pidemp) into vcodigo_dte; 
			
			begin
				declare continue handler for not found set vval = 1;
                
				select 0
				into vval
				from tributos_por_comprobantes
				inner join catalogo_tributos
				on tpc_idcatalogo_tributos = idcatalogo_tributos
				inner join tipos_comprobantes
				on tpc_tcp_idtipo = tcp_idtipo
				where tcp_idtipcom = vtipodoc
				and codigo = vcodigo_;
            end;
            
            if vtipodoc in ('01', '11','07', '14') and vval = 1 then
				set vval = 0;
            end if;
            -- set pmensaje = concat(pmensaje,' AQUI  vval 0');
			if vval = 0 then
           
            
				insert into factura
				(fac_nro_factura,fac_fecha_emision,fac_actividad_giro,fac_nit_emisor,
				fac_nit_receptor,fac_telefono,fac_razonsocial,fac_retenido,fac_sumas_detalle,
				fac_total_pagar,fac_firma,fac_ncr,fac_estado_factura,fac_codigo_generacion,
				fac_numero_de_control,fac_tipo_documento,fac_sello_de_recepcion,fac_total_iva,
				fac_tipo_comprobante,fac_ventasnosujet_tot,fac_ventasexentas_tot,fac_ventasgravadas_tot,
				fac_iva_retenido,fac_saldo_favor,fac_total_nograbado,fac_descuento_nosuje,
				fac_descuento_exent,fac_retencion_renta,fac_tot_descuento,fac_total_letras,
				fac_descuento_grab,fac_porcen_descuento,fac_tributos,fac_ivaperci1,
				fac_condicion_operacion,fac_desc,
                fac_tipo_item_expor,fac_recinto_fiscal,fac_regimen,fac_cri_id, fac_nombre_receptor,fac_us_id_usuario,fac_us_ulb_ingreso,fac_co_ubicacion,
                fac_retencion_iva_porc,fac_retencion_renta_porc, fac_ce_empresa)
				values 
				(vcod_factura, case when papp = 'CRONFINMES' then STR_TO_DATE(DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 DAY), '%Y-%m-%d %H:%i:%s') else CURRENT_TIMESTAMP() end, vruc_codactividad, vcod_emisor,
				vnit, vtelefono, vnombrecliente, 0.0, 0.0,
				case when vtipodoc = '07' then vmonto else 0.0 end, null, vnrc, 1, null,
				vcodigo_dte, vid_tipo_doc,null, 0.0,
				vtipodoc, 0.0, 0.0, 0.0,
				case when vtipodoc = '07' then 0.0 else 0.0 end/*moooood*/ , 0.0, 0.0, 0.0,
				0.0, 0.0, 0.0, null,
				0.0, 0.0, vcodigo_, 0.0,
				vcondicionpago, 0.0,
                vtipo_item_expor,vrecinto_fiscal,vregimen,vid_retencion, vnombre_receptor,vid_usuario_ingreso,vulb_usuario_ingreso,vus_ubicacion,
                vretencion_iva_porc,vimpuesto_reten_retenido_porc, pidemp);
				
				select LAST_INSERT_ID()
				into pid_factura;
                
                select concat('LAST_INSERT_ID: ',pid_factura);
				
                set vid_fac = pid_factura;
                
                if vcodigo_ is not null and vtipodoc not in ('07') then
					select descripcion
					into vdescripcion_tributo
					from catalogo_tributos
					where codigo = vcodigo_;
                    
					insert into tributos
					(tri_fac_id, tri_codigo, tri_descripcion)
					values
					(vid_fac, IFNULL(vcodigo_, 0.0), vdescripcion_tributo);
				end if;
                
                if vtipodoc in ('05', '06') then
					INSERT INTO `fact`.`documentos_relacionados`
					(`doc_tipo_doc`, `doc_fecha`, `doc_num`, `doc_tipo_gen`, `doc_fac_id`)
					VALUES
					( vtipo_doc_relacionado, vfecha_doc_relacionado, vdoc_relacionado, vtipo_generacion_doc_rel, vid_fac);
				end if;
                
				set vtotal_iva = 0;
				set	vtotal_venta = 0;
            end if;
		end if;
		
		if vtipodoc in ('07') then
			if vid_retencion = 1 then
				set vret_iva = vmonto * 0.01;
            elseif vid_retencion = 2 then
				set vret_iva = vmonto * 0.13;
            end if;

            
            set vinserted = 0;
            
            INSERT INTO `retenciones`
			(`ret_numitem`,`ret_tipodte`,`ret_numdocumento`,`ret_fechaemision`,
			`ret_montosujetograv`,`ret_iva`,`ret_descripcion`,`ret_fac_id`,`ret_tipodoc`)
            VALUES
            (vconta_ret, vtipo_doc_relacionado, vdoc_relacionado, vfecha_doc_relacionado,
            vmonto, vret_iva, vdescripcion_retencion, vid_fac,vtipo_generacion_doc_rel);
            
            -- select CONCAT('antes del LAST_INSERT_ID: ',vinserted);
            
            -- Verificar si el INSERT se realizó
			 SELECT ROW_COUNT() INTO vinserted;
            
           -- select CONCAT('DESPUES del LAST_INSERT_ID: ',vinserted);
            

			IF vinserted > 0 THEN
				-- Incrementar la variable de sesión para el siguiente uso
				SET vconta_ret = vconta_ret + 1;
			END IF;
			set vtotal_ret_iva = ifnull(vtotal_ret_iva,0.0)+vret_iva;
            call pro_cantidad_a_letras(vtotal_ret_iva, vtexto_num_letras);
            
            update factura
				set fac_totalsujetoretencion = ifnull(fac_totalsujetoretencion,0.0)+ CAST(vmonto AS DECIMAL(11, 2)),
                fac_iva_retenido = vtotal_ret_iva,
                fac_ivaretenido_letras = vtexto_num_letras
				where fac_id = vid_fac;
                
			update buzoncsv
			set factura_migrada = 'S',
			fecha_migrado = CURRENT_TIMESTAMP()
			where id_buzon = vid_buzon;
                
		end if;

        if vval = 0 and vtipodoc not in ('07') then
			set vtexto_num_letras = null;
			call pro_cantidad_a_letras(ifnull(((vprecio_unitario-ifnull(vdescuento,0)) * vcantidad),0.0), vtexto_num_letras);
			
            if vtipodoc = '01' then
				set viva_detalle = ((vprecio_unitario * vcantidad) / 1.13) * 0.13;
			elseif vtipodoc in ('03', '05', '06', '07', '14') then
				set viva_detalle = (vprecio_unitario * vcantidad) * 0.13;
			else
				set viva_detalle = 0;
            end if;
            
            set vtotal_iva = vtotal_iva + viva_detalle;
            
			INSERT INTO factura_detalle
			(det_fac_id,det_fac_numlinea,det_fac_nro_factura,det_fac_cantidad,
			det_fac_descripcion,det_fac_preciounitario,det_fac_subtotal,det_fac_nro_credito_fiscal,
			det_fac_tipo_item,det_fac_unidad_de_medida,det_fac_ventasnosujet,det_fac_ventasexentas,
			det_fact_ventasgravadas,det_fact_iva,det_cantidad_letras,det_tributo,
			det_psv, det_no_gravado, det_iva_item, det_montoDescu, 
            det_codigo, det_codtributo, det_numerodocumento_rel, det_compra, 
            det_tipo_doc_generacion, det_observacion,
            det_retencion_renta,
            det_retencion_renta_porc,
            det_retencion_iva,
            det_retencion_iva_porc)
			VALUES
			(vid_fac, (ifnull(vnum_linea_detalle, 0) + vcontador_detalle), vcod_factura, vcantidad,
			vdetalle, vprecio_unitario, ((vprecio_unitario-ifnull(vdescuento,0)) * vcantidad), vcod_emisor, 
			vtipo, vunidad_medida,0.00, 0.00,#De momento se quema el valor de 0.00 a las ventas no sujetas, porque no son casos que se apliquen en STC 10/9/2024 WFLORES_ID
            #vtipo, vunidad_medida,((vprecio_unitario-ifnull(vdescuento,0)) * vcantidad), 0.0,
			((vprecio_unitario-ifnull(vdescuento,0)) * vcantidad), viva_detalle, vtexto_num_letras, vcodigo_,
			0.0 ,0.0, viva_detalle, (ifnull(vdescuento,0) * vcantidad),
            vcodigo, case when vtipo != 4 then null else vcodtributo end, vdoc_relacionado, case when vtipodoc != 14 then null else ((vprecio_unitario-ifnull(vdescuento,0)) * vcantidad) end,
            null, vobservaciones_detalles,
            vimpuesto_reten_retenido,
            case when vtipodoc = 14 and ifnull(vimpuesto_reten_retenido_porc,0.00) > 0 then vimpuesto_reten_retenido_porc else 0.00 end,
            vretencion_iva,
            case when vtipodoc = 14 and ifnull(vretencion_iva_porc,0.00) > 0 then vretencion_iva_porc else 0.00 end);
			
			update buzoncsv
			set factura_migrada = 'S',
			fecha_migrado = CURRENT_TIMESTAMP()
			where id_buzon = vid_buzon;
            
            begin
				declare continue handler for not found set vpagos = 1;
				
                select 0
                into vpagos
                from pagos
                where codigo = vmediopago
                and id_fac = vid_fac;
                
                if vpagos = 1 then
					insert into pagos
					(codigo, montopago, plazo, referencia, periodo, id_fac)
					values
					(vmediopago, CAST(vmonto AS DECIMAL(11, 2)), vplazo, vreferencia, IFNULL(vperiodo,0), vid_fac);
				elseif vpagos = 0 then
					update pagos
					set montopago = IFNULL(montopago, 0.0) + IFNULL(CAST(vmonto AS DECIMAL(11, 2)), 0.0)
					where codigo = vmediopago
					and id_fac = vid_fac;
                end if;
            end;
		end if;
        
		if vcantidad_detalles = vcontador_detalle or vtipodoc in ('07') then
			set vcantidad_detalles = 0;
			set vcontador_detalle = 0;
            
			if vtipodoc not in ('07') then
				select sum(det_fac_subtotal), sum(det_compra)/*, sum(det_fact_iva)*/
				into vtotal_venta, vtotal_compra/*, vtotal_iva*/
				from factura_detalle
				where det_fac_id = vid_fac;
				/*
				if vtipodoc = '01' then
					set vtotal_iva = (vtotal_venta / 1.13) * 0.13;
				elseif vtipodoc = '03' then
					set vtotal_iva = vtotal_venta * 0.13;
				end if;
				*/
				set vsuma_tributo = vtotal_iva;
            end if;
            
			if vtipodoc in ('01', '11') then
				set vmontototaloperacion = vtotal_venta;
				set vtotal = vtotal_venta;
				call pro_cantidad_a_letras(vtotal_venta, vtexto_num_letras);
			elseif vtipodoc in ('03', '05', '06', '14') then
				
                if vtipodoc not in ('14') then 
					set vtotal = (vtotal_venta + vtotal_iva);
                else
					set vtotal = (vtotal_venta  -  vimpuesto_reten_retenido);
                end if;
                
				set vmontototaloperacion = vtotal;
                #AQUI
				call pro_cantidad_a_letras(vtotal, vtexto_num_letras);
            end if;
			
			if vval = 0 then
            
				#Por instrucciones de Miguel se coloca el fac_iva_retenido 0.0 dentro de la logica de negocio de STC, no hay casos en los que lleven iva retenido
				update factura
				set fac_total_letras = vtexto_num_letras,
				fac_total_iva = IFNULL(fac_total_iva, 0.0) + IFNULL(vtotal_iva, 0.0),
				fac_subtotal = IFNULL(fac_subtotal, 0.0) + IFNULL(vtotal_venta, 0.0),
				fac_ventasgravadas_tot = IFNULL(fac_ventasgravadas_tot, 0.0) + IFNULL(vtotal_venta, 0.0),
				fac_subtotalventas = IFNULL(fac_subtotalventas, 0.0) + IFNULL(vtotal_venta, 0.0),
				#fac_total_pagar = IFNULL(fac_total_pagar, 0.0) + IFNULL(case when vtipodoc != 14 then vtotal else vtotal_venta - ifnull(vretencion_iva,0) end, 0.0) ,
                fac_total_pagar = IFNULL(fac_total_pagar, 0.0) + IFNULL(case when vtipodoc != 14 then vtotal else vtotal_venta  end, 0.0) ,
				fac_montototaloperacion = IFNULL(fac_montototaloperacion, 0.0) + IFNULL(vmontototaloperacion, 0.0),
                fac_totalcompra =  IFNULL(vtotal_compra, 0.0),
                fac_desc = 0.0,-- IFNULL(fac_desc,0.0) +(ifnull(vdescuento,0) * vcantidad),
                fac_tot_descuento = IFNULL(fac_tot_descuento,0.0) + vdescuento_total,
                #Calculo de retenciones
                #renta (precio x  cantidad) x 0.10
                #inva (precio x cantidad) x 0.13
                /*fac_retencion_renta = IFNULL(fac_retencion_renta,0.0) + (case when vtipodoc = 14 then ifnull(vdescuento,0) * vcantidad else 0.0 end),
                fac_retencion_iva = case when vtipodoc = 14 then ifnull(fac_retencion_iva,0) when vtipodoc = 07 then ifnull(fac_retencion_iva,0) else 0.0 end*/
                fac_retencion_renta = 
					case when vtipodoc = 14 and ifnull(vimpuesto_reten_retenido,0.00) > 0 then 
						ifnull(fac_retencion_renta,0.00) + (select sum(det_retencion_renta) from factura_detalle where det_fac_id = vid_fac)
                        else 
						ifnull(fac_retencion_renta,0.00) end,
                fac_retencion_iva = 
					case when vtipodoc = 14 and ifnull(vretencion_iva,0.00) > 0 then 
						(ifnull(fac_retencion_iva,0.00) + ((select sum(det_retencion_iva) from factura_detalle where det_fac_id = vid_fac)))
                        else ifnull(fac_retencion_iva,0.00) end
				where fac_id = vid_fac;
                
				if vtipodoc not in ('07') then
					update tributos
					set tri_valor = IFNULL(tri_valor, 0.0) + vsuma_tributo
					where tri_fac_id = vid_fac;
				end if;
			end if;
		end if; 
    end loop bucle;
    close vfacturas_a_migrar;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_generacion_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_generacion_json`(in ptipo_fac varchar(15), in pfactura VARCHAR(15), out pjson json, out codigoGeneracion varchar(100))
BEGIN 

# CREADO POR MEGONZALEZ EL 29/06/2023 PROCESO SE INCLUIRA EN EL ENVIO DEL JSON AL MH E INSERTARA El CODIGO DE GENERACION.


DECLARE vexiste INT ;
DECLARE vcod varchar(100) ;
DECLARE vid INT ;
DECLARE videmp INT;

set vexiste = 0; 
set vcod = null; 

select  IFNULL(fac_codigo_generacion,0), fac_ce_empresa into vcod, videmp from factura
where
fac_id=pfactura ;

    
if vcod = 0 then
	ver_loop:loop
		SELECT upper(UUID()) AS UUID_Value  into codigoGeneracion;
		select 1 into vexiste from factura
		where fac_codigo_generacion IN (codigoGeneracion) ;

		if vexiste != 1 then
			UPDATE fact.factura set fac_codigo_generacion=codigoGeneracion where fac_id=pfactura; 
			LEAVE ver_loop;
		end if;
	end loop ver_loop;
else
	set codigoGeneracion =   vcod;
end if; 

select  fun_retorna_json(ptipo_fac,pfactura, videmp) into pjson;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_respuesta_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_respuesta_json`(IN pnro_de_control INT, IN pestado varchar(45)
,IN psello_recibido varchar(100),IN pcodigo_generacion varchar(50),IN pfin_procesamiento varchar(45),IN pjson JSON, IN plink varchar(300),out pval int, out pmensaje text)
BEGIN #Creado el 26/06/2023 por MEGONZALEZ para actualizar en bitacora los datos enviados al MH a traves del JSON y la respuesta.
declare usuario varchar(50);
declare vnro_fac int;
DECLARE vfecha_procesamiento DATETIME;
SELECT USER() INTO usuario;

	if pestado IN ('PROCESADO','OBSERVADO') then
        UPDATE factura
		SET fac_codigo_generacion = pcodigo_generacion,
		fac_sello_de_recepcion=psello_recibido,
		fac_estado_factura=2,
		fac_fecha_envio_hacienda = now()
		WHERE fac_id=pnro_de_control;
	end if;
    
    if pestado IN ('ANULADA') then
        UPDATE factura
		SET fac_codigo_generacion = pcodigo_generacion,
		fac_sello_de_recepcion=psello_recibido,
		fac_estado_factura=4,
		fac_fecha_envio_hacienda = now()
		WHERE fac_id=pnro_de_control;
	end if;
    
    
    SELECT fac_nro_factura into vnro_fac
    FROM fact.factura where fac_id=pnro_de_control;


    insert into bitacora_declaracion_hacienda(id_fac, nro_control, estado,codigo_generacion,json_doc,fecha_respuesta, selloRecibido,usuario_ingreso,fecha_ingreso,link)
    values (pnro_de_control, vnro_fac, pestado, pcodigo_generacion, pjson,DATE_FORMAT(SYSDATE(),'%Y/%m/%d% %T'), psello_recibido,usuario,DATE_FORMAT(SYSDATE(),'%Y/%m/%d% %T'),plink);
    set pval = 0;
    set pmensaje = 'ok';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vistageo`
--

/*!50001 DROP VIEW IF EXISTS `vistageo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vistageo` AS select `a`.`ubg_id_geograficas` AS `ubg_id_geograficas`,`b`.`valor` AS `departamento`,`a`.`ubg_descripcion` AS `municipio` from (`ubicaciones_geograficas` `a` join `departamentos` `b`) where (`b`.`iddepto` = `a`.`ugb_iddepto`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-03 18:51:37
