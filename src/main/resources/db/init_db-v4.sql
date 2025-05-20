-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host:     Database: fact
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE  IF NOT EXISTS `fact`;
USE `fact`;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_declaracion_hacienda`
--

LOCK TABLES `bitacora_declaracion_hacienda` WRITE;
/*!40000 ALTER TABLE `bitacora_declaracion_hacienda` DISABLE KEYS */;
INSERT INTO `bitacora_declaracion_hacienda` VALUES (1,'1','PROCESADO','E758A000-3532-11F0-84F2-0242AC110002',NULL,'{\"emisor\": {\"nit\": \"06141204841181\", \"nrc\": \"1875310\", \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"MIGUEL ISAAC SANCHEZ RAMOS\", \"telefono\": \"2261-7300\", \"direccion\": {\"municipio\": \"14\", \"complemento\": \"COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1\", \"departamento\": \"06\"}, \"codEstable\": \"0001\", \"codActividad\": \"96092\", \"codEstableMH\": \"0000\", \"codPuntoVenta\": null, \"descActividad\": \"Servicios n.c.p.\", \"codPuntoVentaMH\": null, \"nombreComercial\": \"MIGUEL SANCHEZ\", \"tipoEstablecimiento\": \"02\"}, \"resumen\": {\"pagos\": [{\"plazo\": \"01\", \"codigo\": \"03\", \"periodo\": null, \"montoPago\": 1501.0, \"referencia\": \"\"}], \"ivaRete1\": 0.0, \"subTotal\": 1501.0, \"totalIva\": 0.0, \"tributos\": null, \"reteRenta\": 0.0, \"descuNoSuj\": 0.0, \"saldoFavor\": 0.0, \"totalDescu\": 0.0, \"totalNoSuj\": 1501.0, \"totalPagar\": 1501.0, \"descuExenta\": 0.0, \"totalExenta\": 0.0, \"totalLetras\": \"MIL QUINIENTOS UNO CON CERO /100 CTVS\", \"descuGravada\": 0.0, \"totalGravada\": 0.0, \"subTotalVentas\": 1501.0, \"totalNoGravado\": 0.0, \"condicionOperacion\": 1, \"numPagoElectronico\": null, \"montoTotalOperacion\": 1501.0, \"porcentajeDescuento\": 0.0}, \"apendice\": null, \"receptor\": {\"nrc\": null, \"correo\": \"miguelsr1@gmail.com\", \"nombre\": \"JUAN GUTIERREZ\", \"telefono\": \"22617300\", \"direccion\": {\"municipio\": \"15\", \"complemento\": \"1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR\", \"departamento\": \"06\"}, \"codActividad\": \"10005\", \"numDocumento\": \"00000000000008\", \"descActividad\": \"Otros\", \"tipoDocumento\": \"36\"}, \"extension\": {\"docuRecibe\": null, \"nombRecibe\": null, \"docuEntrega\": null, \"nombEntrega\": null, \"observaciones\": null, \"placaVehiculo\": null}, \"ventaTercero\": null, \"identificacion\": {\"fecEmi\": \"2025-05-19\", \"horEmi\": \"22:28:39\", \"tipoDte\": \"01\", \"version\": 1, \"ambiente\": \"00\", \"tipoModelo\": 1, \"tipoMoneda\": \"USD\", \"motivoContin\": null, \"numeroControl\": \"DTE-01-MUMH0001-000000000000005\", \"tipoOperacion\": 1, \"codigoGeneracion\": \"E758A000-3532-11F0-84F2-0242AC110002\", \"tipoContingencia\": null}, \"cuerpoDocumento\": [{\"psv\": 0.0, \"codigo\": \"1\", \"ivaItem\": 0.0, \"numItem\": 1, \"cantidad\": 95, \"tipoItem\": 1, \"tributos\": null, \"noGravado\": 0.0, \"precioUni\": 15.8, \"uniMedida\": 59, \"codTributo\": null, \"montoDescu\": 0.0, \"ventaNoSuj\": 1501.0, \"descripcion\": \"TEST 1\", \"ventaExenta\": 0.0, \"ventaGravada\": 0.0, \"numeroDocumento\": null}], \"otrosDocumentos\": null, \"documentoRelacionado\": null}','2025-05-19 22:28:44','root@172.17.0.1','2025-05-19 22:28:44','202597B38278ED5B45C2A832FF18B436751E2NLA','https://admin.factura.gob.sv/consultaPublica?ambiente=00&codGen=E758A000-3532-11F0-84F2-0242AC110002&fechaEmi=2025-05-19',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='Se crea trabla que permitirá controlar el numero interno en el buzoncsv y evitar el proceso de ingreso manual, utilizado en fun_genera_numero_interno.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buzon_encabezado`
--

LOCK TABLES `buzon_encabezado` WRITE;
/*!40000 ALTER TABLE `buzon_encabezado` DISABLE KEYS */;
INSERT INTO `buzon_encabezado` VALUES (1,'2025-05-19 22:28:39','SISDTE','PROINGDATOS');
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
  PRIMARY KEY (`id_buzon`),
  KEY `BUZ_ID_idx` (`id_buzon`) /*!80000 INVISIBLE */,
  KEY `BUZ_COD_idx` (`cod_factura`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buzoncsv`
--

LOCK TABLES `buzoncsv` WRITE;
/*!40000 ALTER TABLE `buzoncsv` DISABLE KEYS */;
INSERT INTO `buzoncsv` VALUES (1,'1','06141204841181','01',36,'00000000000008',NULL,'JUAN GUTIERREZ','miguelsr1@gmail.com','22617300','USD',1,'06',15,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','10005','1','TEST 1',59,1,95.00000,15.80000,NULL,'No',20,13,'1501.00',1,'03','1501.00','','01','0',NULL,NULL,NULL,NULL,NULL,NULL,'2025-05-19 22:28:39','S',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00000,0.00,0.00000,0.00,'',9,NULL,NULL);
/*!40000 ALTER TABLE `buzoncsv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_codigo_actividad_economica`
--

DROP TABLE IF EXISTS `catalogo_codigo_actividad_economica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_codigo_actividad_economica` (
  `ccae_id` int NOT NULL AUTO_INCREMENT,
  `ccae_codigo` varchar(6) DEFAULT NULL,
  `ccae_valor` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ccae_id`)
) ENGINE=InnoDB AUTO_INCREMENT=774 DEFAULT CHARSET=utf8mb3 COMMENT='CAT-019 Código de Actividad Económica';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_codigo_actividad_economica`
--

LOCK TABLES `catalogo_codigo_actividad_economica` WRITE;
/*!40000 ALTER TABLE `catalogo_codigo_actividad_economica` DISABLE KEYS */;
INSERT INTO `catalogo_codigo_actividad_economica` VALUES (1,'1112','Cultivo de legumbres'),(2,'1113','Cultivo de semillas oleaginosas'),(3,'1114','Cultivo de plantas para la preparaciÃ³n de semillas'),(4,'1119','Cultivo de otros cereales excepto arroz y forrajeros n.c.p.'),(5,'1120','Cultivo de arroz'),(6,'1131','Cultivo de raÃ­ces y tubÃ©rculos'),(7,'1132','Cultivo de brotes, bulbos, vegetales tubÃ©rculos y cultivos similares'),(8,'1133','Cultivo hortÃ­cola de fruto'),(9,'1134','Cultivo de hortalizas de hoja y otras hortalizas ncp'),(10,'1140','Cultivo de caÃ±a de azÃºcar'),(11,'1150','Cultivo de tabaco'),(12,'1161','Cultivo de algodÃ³n'),(13,'1162','Cultivo de fibras vegetales excepto algodÃ³n'),(14,'1191','Cultivo de plantas no perennes  para la producciÃ³n de semillas y flores'),(15,'1192','Cultivo de cereales y pastos para la alimentaciÃ³n animal'),(16,'1199','ProducciÃ³n de cultivos no estacionales  ncp'),(17,'1220','Cultivo de frutas tropicales'),(18,'1230','Cultivo de cÃ­tricos'),(19,'1240','Cultivo de frutas de pepita y hueso'),(20,'1251','Cultivo de frutas ncp'),(21,'1252','Cultivo de otros frutos  y nueces de Ã¡rboles y arbustos'),(22,'1260','Cultivo de frutos oleaginosos'),(23,'1271','Cultivo de cafÃ©'),(24,'1272','Cultivo de plantas para la elaboraciÃ³n de bebidas excepto cafÃ©'),(25,'1281','Cultivo de especias y aromÃ¡ticas'),(26,'1282','Cultivo de plantas para la obtenciÃ³n de productos medicinales y farmacÃ©uticos'),(27,'1291','Cultivo de Ã¡rboles de hule (caucho) para la obtenciÃ³n de lÃ¡tex'),(28,'1292','Cultivo de plantas para la obtenciÃ³n de productos quÃ­micos y colorantes'),(29,'1299','ProducciÃ³n de cultivos perennes ncp'),(30,'1300','PropagaciÃ³n de plantas'),(31,'1301','Cultivo de plantas y flores ornamentales'),(32,'1410','CrÃ­a y engorde de ganado bovino'),(33,'1420','CrÃ­a de caballos y otros equinos'),(34,'1440','CrÃ­a de ovejas y cabras'),(35,'1450','CrÃ­a de cerdos'),(36,'1460','CrÃ­a de aves de corral y producciÃ³n de huevos'),(37,'1491','CrÃ­a de abejas apicultura para la obtenciÃ³n de miel y otros productos apÃ­colas'),(38,'1492','CrÃ­a de conejos'),(39,'1493','CrÃ­a de iguanas y garrobos'),(40,'1494','CrÃ­a de mariposas y otros insectos'),(41,'1499','CrÃ­a y obtenciÃ³n de productos animales n.c.p.'),(42,'1500','Cultivo de productos agrÃ­colas en combinaciÃ³n con la crÃ­a de animales'),(43,'1611','Servicios de maquinaria agrÃ­cola'),(44,'1612','Control de plagas'),(45,'1613','Servicios de riego'),(46,'1614','Servicios de contrataciÃ³n de mano de obra para la agricultura'),(47,'1619','Servicios agrÃ­colas ncp'),(48,'1621','Actividades para mejorar la reproducciÃ³n, el crecimiento y el rendimiento de los animales y sus productos'),(49,'1622','Servicios de mano de obra pecuaria'),(50,'1629','Servicios pecuarios ncp'),(51,'1631','Labores post cosecha de preparaciÃ³n de los productos agrÃ­colas para su comercializaciÃ³n o para la industria'),(52,'1632','Servicio de beneficio de cafÃ©'),(53,'1633','Servicio de beneficiado de plantas textiles (incluye el beneficiado cuando este es realizado en la misma explotaciÃ³n agropecuaria)'),(54,'1640','Tratamiento de semillas para la propagaciÃ³n'),(55,'1700','Caza ordinaria y mediante trampas, repoblaciÃ³n de animales de caza y servicios conexos'),(56,'2100','Silvicultura y otras actividades forestales'),(57,'2200','ExtracciÃ³n de madera'),(58,'2300','RecolecciÃ³n de productos diferentes a la madera'),(59,'2400','Servicios de apoyo a la silvicultura'),(60,'3110','Pesca marÃ­tima de altura y costera'),(61,'3120','Pesca de agua dulce'),(62,'3210','Acuicultura marÃ­tima'),(63,'3220','Acuicultura de agua dulce'),(64,'3300','Servicios de apoyo a la pesca y acuicultura'),(65,'5100','ExtracciÃ³n de hulla'),(66,'5200','ExtracciÃ³n y aglomeraciÃ³n de lignito'),(67,'6100','ExtracciÃ³n de petrÃ³leo crudo'),(68,'6200','ExtracciÃ³n de gas natural'),(69,'7100','ExtracciÃ³n de minerales  de hierro'),(70,'7210','ExtracciÃ³n de minerales de uranio y torio'),(71,'7290','ExtracciÃ³n de minerales metalÃ­feros no ferrosos'),(72,'8100','ExtracciÃ³n de piedra, arena y arcilla'),(73,'8910','ExtracciÃ³n de minerales para la fabricaciÃ³n de abonos y productos quÃ­micos'),(74,'8920','ExtracciÃ³n y aglomeraciÃ³n de turba'),(75,'8930','ExtracciÃ³n de sal'),(76,'8990','ExplotaciÃ³n de otras minas y canteras ncp'),(77,'9100','Actividades de apoyo a la extracciÃ³n de petrÃ³leo y gas natural'),(78,'9900','Actividades de apoyo a la explotaciÃ³n de minas y canteras'),(79,'10101','Servicio de rastros y mataderos de bovinos y porcinos'),(80,'10102','Matanza y procesamiento de bovinos y porcinos'),(81,'10103','Matanza y procesamientos de aves de corral'),(82,'10104','ElaboraciÃ³n y conservaciÃ³n de embutidos y tripas naturales'),(83,'10105','Servicios de conservaciÃ³n y empaque de carnes'),(84,'10106','ElaboraciÃ³n y conservaciÃ³n de grasas y aceites animales'),(85,'10107','Servicios de molienda de carne'),(86,'10108','ElaboraciÃ³n de productos de carne ncp'),(87,'10201','Procesamiento y conservaciÃ³n de pescado, crustÃ¡ceos y moluscos'),(88,'10209','FabricaciÃ³n de productos de pescado ncp'),(89,'10301','ElaboraciÃ³n de jugos de frutas y hortalizas'),(90,'10302','ElaboraciÃ³n y envase de jaleas, mermeladas y frutas deshidratadas'),(91,'10309','ElaboraciÃ³n de productos de frutas y hortalizas n.c.p.'),(92,'10401','FabricaciÃ³n de aceites y grasas vegetales y animales comestibles'),(93,'10402','FabricaciÃ³n de aceites y grasas vegetales y animales no comestibles'),(94,'10409','Servicio de maquilado de aceites'),(95,'10501','FabricaciÃ³n de productos lÃ¡cteos excepto sorbetes y quesos sustitutos'),(96,'10502','FabricaciÃ³n de sorbetes y helados'),(97,'10503','FabricaciÃ³n de quesos'),(98,'10611','Molienda de cereales'),(99,'10612','ElaboraciÃ³n de cereales para el desayuno y similares'),(100,'10613','Servicios de beneficiado de productos agrÃ­colas ncp (excluye Beneficio de azÃºcar rama 1072  y beneficio de cafÃ© rama 0163)'),(101,'10621','FabricaciÃ³n de almidÃ³n'),(102,'10628','Servicio de molienda de maÃ­z hÃºmedo molino para nixtamal'),(103,'10711','ElaboraciÃ³n de tortillas'),(104,'10712','FabricaciÃ³n de pan, galletas y barquillos'),(105,'10713','FabricaciÃ³n de reposterÃ­a'),(106,'10721','Ingenios azucareros'),(107,'10722','Molienda de caÃ±a de azÃºcar para la elaboraciÃ³n de dulces'),(108,'10723','ElaboraciÃ³n de jarabes de azÃºcar y otros similares'),(109,'10724','Maquilado de azÃºcar de caÃ±a'),(110,'10730','FabricaciÃ³n de cacao, chocolates y  productos de confiterÃ­a'),(111,'10740','ElaboraciÃ³n de macarrones, fideos, y productos farinÃ¡ceos similares'),(112,'10750','ElaboraciÃ³n de comidas y platos preparados para la reventa en locales y/o  para exportaciÃ³n'),(113,'10791','ElaboraciÃ³n de productos de cafÃ©'),(114,'10792','ElaboraciÃ³n de especies, sazonadores y condimentos'),(115,'10793','ElaboraciÃ³n de sopas, cremas y consomÃ©'),(116,'10794','FabricaciÃ³n de bocadillos tostados y/o fritos'),(117,'10799','ElaboraciÃ³n de productos alimenticios ncp'),(118,'10800','ElaboraciÃ³n de alimentos preparados para animales'),(119,'11012','FabricaciÃ³n de aguardiente y licores'),(120,'11020','ElaboraciÃ³n de vinos'),(121,'11030','FabricaciÃ³n de cerveza'),(122,'11041','FabricaciÃ³n de aguas gaseosas'),(123,'11042','FabricaciÃ³n y envasado  de agua'),(124,'11043','ElaboraciÃ³n de refrescos'),(125,'11048','Maquilado de aguas gaseosas'),(126,'11049','ElaboraciÃ³n de bebidas no alcohÃ³licas'),(127,'12000','ElaboraciÃ³n de productos de tabaco'),(128,'13111','PreparaciÃ³n de fibras textiles'),(129,'13112','FabricaciÃ³n de hilados'),(130,'13120','FabricaciÃ³n de telas'),(131,'13130','Acabado de productos textiles'),(132,'13910','FabricaciÃ³n de tejidos de punto y  ganchillo'),(133,'13921','FabricaciÃ³n de productos textiles para el hogar'),(134,'13922','Sacos, bolsas y otros artÃ­culos textiles'),(135,'13929','FabricaciÃ³n de artÃ­culos confeccionados con materiales textiles, excepto prendas de vestir n.c.p'),(136,'13930','FabricaciÃ³n de tapices y alfombras'),(137,'13941','FabricaciÃ³n de cuerdas de henequÃ©n y otras fibras naturales (lazos, pitas)'),(138,'13942','FabricaciÃ³n de redes de diversos materiales'),(139,'13948','Maquilado de productos trenzables de cualquier material (petates, sillas, etc.)'),(140,'13991','FabricaciÃ³n de adornos, etiquetas y otros artÃ­culos para prendas de vestir'),(141,'13992','Servicio de bordados en artÃ­culos y prendas de tela'),(142,'13999','FabricaciÃ³n de productos textiles ncp'),(143,'14101','FabricaciÃ³n de ropa  interior, para dormir y similares'),(144,'14102','FabricaciÃ³n de ropa para niÃ±os'),(145,'14103','FabricaciÃ³n de prendas de vestir para ambos sexos'),(146,'14104','ConfecciÃ³n de prendas a medida'),(147,'14105','FabricaciÃ³n de prendas de vestir para deportes'),(148,'14106','ElaboraciÃ³n de artesanÃ­as de uso personal confeccionadas especialmente de materiales textiles'),(149,'14108','Maquilado  de prendas de vestir, accesorios y otros'),(150,'14109','FabricaciÃ³n de prendas y accesorios de vestir n.c.p.'),(151,'14200','FabricaciÃ³n de artÃ­culos de piel'),(152,'14301','FabricaciÃ³n de calcetines, calcetas, medias (panty house) y otros similares'),(153,'14302','FabricaciÃ³n de ropa interior de tejido de punto'),(154,'14309','FabricaciÃ³n de prendas de vestir de tejido de punto ncp'),(155,'15110','Curtido y adobo de cueros; adobo y teÃ±ido de pieles'),(156,'15121','FabricaciÃ³n de maletas, bolsos de mano y otros artÃ­culos de marroquinerÃ­a'),(157,'15122','FabricaciÃ³n de monturas, accesorios y vainas  talabarterÃ­a'),(158,'15123','FabricaciÃ³n  de artesanÃ­as principalmente de cuero natural y sintÃ©tico'),(159,'15128','Maquilado de artÃ­culos de cuero natural, sintÃ©tico y de otros materiales'),(160,'15201','FabricaciÃ³n de calzado'),(161,'15202','FabricaciÃ³n de partes y accesorios de calzado'),(162,'15208','Maquilado de partes y accesorios de calzado'),(163,'16100','Aserradero y acepilladura de madera'),(164,'16210','FabricaciÃ³n de madera laminada, terciada, enchapada y contrachapada, paneles para la construcciÃ³n'),(165,'16220','FabricaciÃ³n de partes y piezas de carpinterÃ­a para edificios y construcciones'),(166,'16230','FabricaciÃ³n de envases y recipientes de madera'),(167,'16292','FabricaciÃ³n de artesanÃ­as de madera, semillas,  materiales trenzables'),(168,'16299','FabricaciÃ³n de productos de madera, corcho, paja y materiales trenzables ncp'),(169,'17010','FabricaciÃ³n de pasta de madera, papel y cartÃ³n'),(170,'17020','FabricaciÃ³n de papel y cartÃ³n ondulado y envases de papel y cartÃ³n'),(171,'17091','FabricaciÃ³n de artÃ­culos de papel y cartÃ³n de uso personal y domÃ©stico'),(172,'17092','FabricaciÃ³n de productos de papel ncp'),(173,'18110','ImpresiÃ³n'),(174,'18120','Servicios relacionados con la impresiÃ³n'),(175,'18200','ReproducciÃ³n de grabaciones'),(176,'19100','FabricaciÃ³n de productos de hornos de coque'),(177,'19201','FabricaciÃ³n de combustible'),(178,'19202','FabricaciÃ³n de aceites y lubricantes'),(179,'20111','FabricaciÃ³n de materias primas para la fabricaciÃ³n de colorantes'),(180,'20112','FabricaciÃ³n de materiales curtientes'),(181,'20113','FabricaciÃ³n de gases industriales'),(182,'20114','FabricaciÃ³n de alcohol etÃ­lico'),(183,'20119','FabricaciÃ³n de sustancias quÃ­micas bÃ¡sicas'),(184,'20120','FabricaciÃ³n de abonos y fertilizantes'),(185,'20130','FabricaciÃ³n de plÃ¡stico y caucho en formas primarias'),(186,'20210','FabricaciÃ³n de plaguicidas y otros productos quÃ­micos de uso agropecuario'),(187,'20220','FabricaciÃ³n de pinturas, barnices y productos de revestimiento similares; tintas de imprenta y masillas'),(188,'20231','FabricaciÃ³n de jabones, detergentes y similares para limpieza'),(189,'20232','FabricaciÃ³n de perfumes, cosmÃ©ticos y productos de higiene y cuidado personal, incluyendo tintes, champÃº, etc.'),(190,'20291','FabricaciÃ³n de tintas y colores para escribir y pintar; fabricaciÃ³n de cintas para impresoras'),(191,'20292','FabricaciÃ³n de productos pirotÃ©cnicos, explosivos y municiones'),(192,'20299','FabricaciÃ³n de productos quÃ­micos n.c.p.'),(193,'20300','FabricaciÃ³n de fibras artificiales'),(194,'21001','Manufactura de productos farmacÃ©uticos, sustancias quÃ­micas y productos botÃ¡nicos'),(195,'21008','Maquilado de medicamentos'),(196,'22110','FabricaciÃ³n de cubiertas y cÃ¡maras; renovaciÃ³n y recauchutado de cubiertas'),(197,'22190','FabricaciÃ³n de otros productos de caucho'),(198,'22201','FabricaciÃ³n de envases plÃ¡sticos'),(199,'22202','FabricaciÃ³n de productos plÃ¡sticos para uso personal o domÃ©stico'),(200,'22208','Maquila de plÃ¡sticos'),(201,'22209','FabricaciÃ³n de productos plÃ¡sticos n.c.p.'),(202,'23101','FabricaciÃ³n de vidrio'),(203,'23102','FabricaciÃ³n de recipientes y envases de vidrio'),(204,'23108','Servicio de maquilado'),(205,'23109','FabricaciÃ³n de productos de vidrio ncp'),(206,'23910','FabricaciÃ³n de productos refractarios'),(207,'23920','FabricaciÃ³n de productos de arcilla para la construcciÃ³n'),(208,'23931','FabricaciÃ³n de productos de cerÃ¡mica y porcelana no refractaria'),(209,'23932','FabricaciÃ³n de productos de cerÃ¡mica y porcelana ncp'),(210,'23940','FabricaciÃ³n de cemento, cal y yeso'),(211,'23950','FabricaciÃ³n de artÃ­culos de hormigÃ³n, cemento y yeso'),(212,'23960','Corte, tallado y acabado de la piedra'),(213,'23990','FabricaciÃ³n de productos minerales no metÃ¡licos ncp'),(214,'24100','Industrias bÃ¡sicas de hierro y acero'),(215,'24200','FabricaciÃ³n de productos primarios de metales preciosos y metales no ferrosos'),(216,'24310','FundiciÃ³n de hierro y acero'),(217,'24320','FundiciÃ³n de metales no ferrosos'),(218,'25111','FabricaciÃ³n de productos metÃ¡licos para uso estructural'),(219,'25118','Servicio de maquila para la fabricaciÃ³n de estructuras metÃ¡licas'),(220,'25120','FabricaciÃ³n de tanques, depÃ³sitos y recipientes de metal'),(221,'25130','FabricaciÃ³n de generadores de vapor, excepto calderas de agua caliente  para calefacciÃ³n central'),(222,'25200','FabricaciÃ³n de armas y municiones'),(223,'25910','Forjado, prensado, estampado y laminado de metales; pulvimetalurgia'),(224,'25920','Tratamiento y revestimiento de metales'),(225,'25930','FabricaciÃ³n de artÃ­culos de cuchillerÃ­a, herramientas de mano y artÃ­culos de ferreterÃ­a'),(226,'25991','FabricaciÃ³n de envases y artÃ­culos conexos de metal'),(227,'25992','FabricaciÃ³n de artÃ­culos metÃ¡licos de uso personal y/o domÃ©stico'),(228,'25999','FabricaciÃ³n de productos elaborados de metal ncp'),(229,'26100','FabricaciÃ³n de componentes electrÃ³nicos'),(230,'26200','FabricaciÃ³n de computadoras y equipo conexo'),(231,'26300','FabricaciÃ³n de equipo de comunicaciones'),(232,'26400','FabricaciÃ³n de aparatos  electrÃ³nicos de consumo para audio, video radio y televisiÃ³n'),(233,'26510','FabricaciÃ³n de instrumentos y aparatos para medir, verificar, ensayar, navegar y de control de procesos industriales'),(234,'26520','FabricaciÃ³n de relojes y piezas de relojes'),(235,'26600','FabricaciÃ³n de equipo mÃ©dico de irradiaciÃ³n y equipo electrÃ³nico de uso mÃ©dico y terapÃ©utico'),(236,'26700','FabricaciÃ³n de instrumentos de Ã³ptica y equipo fotogrÃ¡fico'),(237,'26800','FabricaciÃ³n de medios magnÃ©ticos y Ã³pticos'),(238,'27100','FabricaciÃ³n de motores, generadores , transformadores elÃ©ctricos, aparatos de distribuciÃ³n y control de electricidad'),(239,'27200','FabricaciÃ³n de pilas, baterÃ­as y acumuladores'),(240,'27310','FabricaciÃ³n de cables de fibra Ã³ptica'),(241,'27320','FabricaciÃ³n de otros  hilos y cables elÃ©ctricos'),(242,'27330','FabricaciÃ³n de dispositivos de cableados'),(243,'27400','FabricaciÃ³n de equipo elÃ©ctrico de iluminaciÃ³n'),(244,'27500','FabricaciÃ³n de aparatos de uso domÃ©stico'),(245,'27900','FabricaciÃ³n de otros tipos de equipo elÃ©ctrico'),(246,'28110','FabricaciÃ³n de motores y turbinas, excepto motores para aeronaves, vehÃ­culos automotores y motocicletas'),(247,'28120','FabricaciÃ³n de equipo hidrÃ¡ulico'),(248,'28130','FabricaciÃ³n de otras bombas, compresores, grifos y vÃ¡lvulas'),(249,'28140','FabricaciÃ³n de cojinetes, engranajes, trenes de engranajes y piezas de transmisiÃ³n'),(250,'28150','FabricaciÃ³n de hornos y quemadores'),(251,'28160','FabricaciÃ³n de equipo de elevaciÃ³n y manipulaciÃ³n'),(252,'28170','FabricaciÃ³n de maquinaria y equipo de oficina'),(253,'28180','FabricaciÃ³n de herramientas manuales'),(254,'28190','FabricaciÃ³n de otros tipos de maquinaria de uso general'),(255,'28210','FabricaciÃ³n de maquinaria agropecuaria y forestal'),(256,'28220','FabricaciÃ³n de mÃ¡quinas para conformar metales y maquinaria herramienta'),(257,'28230','FabricaciÃ³n de maquinaria metalÃºrgica'),(258,'28240','FabricaciÃ³n de maquinaria para la explotaciÃ³n de minas y canteras y para obras de construcciÃ³n'),(259,'28250','FabricaciÃ³n de maquinaria para la elaboraciÃ³n de alimentos, bebidas y tabaco'),(260,'28260','FabricaciÃ³n de maquinaria para la elaboraciÃ³n de productos textiles, prendas de vestir y cueros'),(261,'28291','FabricaciÃ³n de mÃ¡quinas para imprenta'),(262,'28299','FabricaciÃ³n de maquinaria de uso especial ncp'),(263,'29100','FabricaciÃ³n vehÃ­culos automotores'),(264,'29200','FabricaciÃ³n de carrocerÃ­as para vehÃ­culos automotores; fabricaciÃ³n de remolques y semiremolques'),(265,'29300','FabricaciÃ³n de partes, piezas y accesorios para vehÃ­culos automotores'),(266,'30110','FabricaciÃ³n de buques'),(267,'30120','ConstrucciÃ³n y reparaciÃ³n de embarcaciones de recreo'),(268,'30200','FabricaciÃ³n de locomotoras y de material rodante'),(269,'30300','FabricaciÃ³n de aeronaves y naves espaciales'),(270,'30400','FabricaciÃ³n de vehÃ­culos militares de combate'),(271,'30910','FabricaciÃ³n de motocicletas'),(272,'30920','FabricaciÃ³n de bicicletas y sillones de ruedas para invÃ¡lidos'),(273,'30990','FabricaciÃ³n de equipo de transporte ncp'),(274,'31001','FabricaciÃ³n de colchones y somier'),(275,'31002','FabricaciÃ³n de muebles y otros productos de madera a medida'),(276,'31008','Servicios de maquilado de muebles'),(277,'31009','FabricaciÃ³n de muebles ncp'),(278,'32110','FabricaciÃ³n de joyas platerÃ­as y joyerÃ­as'),(279,'32120','FabricaciÃ³n de joyas de imitaciÃ³n (fantasÃ­a) y artÃ­culos conexos'),(280,'32200','FabricaciÃ³n de instrumentos musicales'),(281,'32301','FabricaciÃ³n de artÃ­culos de deporte'),(282,'32308','Servicio de maquila de productos deportivos'),(283,'32401','FabricaciÃ³n de juegos de mesa y de salÃ³n'),(284,'32402','Servicio de maquilado de juguetes y juegos'),(285,'32409','FabricaciÃ³n de juegos y juguetes n.c.p.'),(286,'32500','FabricaciÃ³n de instrumentos y materiales mÃ©dicos y odontolÃ³gicos'),(287,'32901','FabricaciÃ³n de lÃ¡pices, bolÃ­grafos, sellos y artÃ­culos de librerÃ­a en general'),(288,'32902','FabricaciÃ³n de escobas, cepillos, pinceles y similares'),(289,'32903','FabricaciÃ³n de artesanÃ­as de materiales diversos'),(290,'32904','FabricaciÃ³n de artÃ­culos de uso personal y domÃ©sticos n.c.p.'),(291,'32905','FabricaciÃ³n de accesorios para las confecciones y la marroquinerÃ­a n.c.p.'),(292,'32908','Servicios de maquila ncp'),(293,'32909','FabricaciÃ³n de productos manufacturados n.c.p.'),(294,'33110','ReparaciÃ³n y mantenimiento de productos elaborados de metal'),(295,'33120','ReparaciÃ³n y mantenimiento de maquinaria'),(296,'33130','ReparaciÃ³n y mantenimiento de equipo electrÃ³nico y Ã³ptico'),(297,'33140','ReparaciÃ³n y mantenimiento  de equipo elÃ©ctrico'),(298,'33150','ReparaciÃ³n y mantenimiento de equipo de transporte, excepto vehÃ­culos automotores'),(299,'33190','ReparaciÃ³n y mantenimiento de equipos n.c.p.'),(300,'33200','InstalaciÃ³n de maquinaria y equipo industrial'),(301,'35101','GeneraciÃ³n de energÃ­a elÃ©ctrica'),(302,'35102','TransmisiÃ³n de energÃ­a elÃ©ctrica'),(303,'35103','DistribuciÃ³n de energÃ­a elÃ©ctrica'),(304,'35200','FabricaciÃ³n de gas, distribuciÃ³n de combustibles gaseosos por tuberÃ­as'),(305,'35300','Suministro de vapor y agua caliente'),(306,'36000','CaptaciÃ³n, tratamiento y suministro de agua'),(307,'37000','EvacuaciÃ³n de aguas residuales (alcantarillado)'),(308,'38110','RecolecciÃ³n y transporte de desechos sÃ³lidos proveniente de hogares y  sector urbano'),(309,'38120','RecolecciÃ³n de desechos peligrosos'),(310,'38210','Tratamiento y eliminaciÃ³n de desechos inicuos'),(311,'38220','Tratamiento y eliminaciÃ³n de desechos peligrosos'),(312,'38301','Reciclaje de desperdicios y desechos textiles'),(313,'38302','Reciclaje de desperdicios y desechos de plÃ¡stico y caucho'),(314,'38303','Reciclaje de desperdicios y desechos de vidrio'),(315,'38304','Reciclaje de desperdicios y desechos de papel y cartÃ³n'),(316,'38305','Reciclaje de desperdicios y desechos metÃ¡licos'),(317,'38309','Reciclaje de desperdicios y desechos no metÃ¡licos  n.c.p.'),(318,'39000','Actividades de Saneamiento y otros Servicios de GestiÃ³n de Desechos'),(319,'41001','ConstrucciÃ³n de edificios residenciales'),(320,'41002','ConstrucciÃ³n de edificios no residenciales'),(321,'42100','ConstrucciÃ³n de carreteras, calles y caminos'),(322,'42200','ConstrucciÃ³n de proyectos de servicio pÃºblico'),(323,'42900','ConstrucciÃ³n de obras de ingenierÃ­a civil n.c.p.'),(324,'43110','DemoliciÃ³n'),(325,'43120','PreparaciÃ³n de terreno'),(326,'43210','Instalaciones elÃ©ctricas'),(327,'43220','InstalaciÃ³n de fontanerÃ­a, calefacciÃ³n y aire acondicionado'),(328,'43290','Otras instalaciones para obras de construcciÃ³n'),(329,'43300','TerminaciÃ³n y acabado de edificios'),(330,'43900','Otras actividades especializadas de construcciÃ³n'),(331,'43901','FabricaciÃ³n de techos y materiales diversos'),(332,'45100','Venta de vehÃ­culos automotores'),(333,'45201','ReparaciÃ³n mecÃ¡nica de vehÃ­culos automotores'),(334,'45202','Reparaciones elÃ©ctricas del automotor y recarga de baterÃ­as'),(335,'45203','Enderezado y pintura de vehÃ­culos automotores'),(336,'45204','Reparaciones de radiadores, escapes y silenciadores'),(337,'45205','ReparaciÃ³n y reconstrucciÃ³n de vÃ­as, stop y otros artÃ­culos de fibra de vidrio'),(338,'45206','ReparaciÃ³n de llantas de vehÃ­culos automotores'),(339,'45207','Polarizado de vehÃ­culos (mediante la adhesiÃ³n de papel especial a los vidrios)'),(340,'45208','Lavado y pasteado de vehÃ­culos (carwash)'),(341,'45209','Reparaciones de vehÃ­culos n.c.p.'),(342,'45211','Remolque de vehÃ­culos automotores'),(343,'45301','Venta de partes, piezas y accesorios nuevos para vehÃ­culos automotores'),(344,'45302','Venta de partes, piezas y accesorios usados para vehÃ­culos automotores'),(345,'45401','Venta de motocicletas'),(346,'45402','Venta de repuestos, piezas y accesorios de motocicletas'),(347,'45403','Mantenimiento y reparaciÃ³n  de motocicletas'),(348,'46100','Venta al por mayor a cambio de retribuciÃ³n o por contrata'),(349,'46201','Venta al por mayor de materias primas agrÃ­colas'),(350,'46202','Venta al por mayor de productos de la silvicultura'),(351,'46203','Venta al por mayor de productos pecuarios y de granja'),(352,'46211','Venta de productos para uso agropecuario'),(353,'46291','Venta al por mayor de granos bÃ¡sicos (cereales, leguminosas)'),(354,'46292','Venta  al por mayor de semillas mejoradas para cultivo'),(355,'46293','Venta  al por mayor de cafÃ© oro y uva'),(356,'46294','Venta  al por mayor de caÃ±a de azÃºcar'),(357,'46295','Venta al por mayor de flores, plantas  y otros productos naturales'),(358,'46296','Venta al por mayor de productos agrÃ­colas'),(359,'46297','Venta  al por mayor de ganado bovino (vivo)'),(360,'46298','Venta al por mayor de animales porcinos, ovinos, caprino, canÃ­culas, apÃ­colas, avÃ­colas vivos'),(361,'46299','Venta de otras especies vivas del reino animal'),(362,'46301','Venta al por mayor de alimentos'),(363,'46302','Venta al por mayor de bebidas'),(364,'46303','Venta al por mayor de tabaco'),(365,'46371','Venta al por mayor de frutas, hortalizas (verduras), legumbres y tubÃ©rculos'),(366,'46372','Venta al por mayor de pollos, gallinas destazadas, pavos y otras aves'),(367,'46373','Venta al por mayor de carne bovina y porcina, productos de carne y embutidos'),(368,'46374','Venta  al por mayor de huevos'),(369,'46375','Venta al por mayor de productos lÃ¡cteos'),(370,'46376','Venta al por mayor de productos farinÃ¡ceos de panaderÃ­a (pan dulce, cakes, resposterÃ­a, etc.)'),(371,'46377','Venta al por mayor de pastas alimenticias, aceites y grasas comestibles vegetal y animal'),(372,'46378','Venta al por mayor de sal comestible'),(373,'46379','Venta al por mayor de azÃºcar'),(374,'46391','Venta al por mayor de abarrotes (vinos, licores, productos alimenticios envasados, etc.)'),(375,'46392','Venta al por mayor de aguas gaseosas'),(376,'46393','Venta al por mayor de agua purificada'),(377,'46394','Venta al por mayor de refrescos y otras bebidas, lÃ­quidas o en polvo'),(378,'46395','Venta al por mayor de cerveza y licores'),(379,'46396','Venta al por mayor de hielo'),(380,'46411','Venta al por mayor de hilados, tejidos y productos textiles de mercerÃ­a'),(381,'46412','Venta al por mayor de artÃ­culos textiles excepto confecciones para el hogar'),(382,'46413','Venta al por mayor de confecciones textiles para el hogar'),(383,'46414','Venta al por mayor de prendas de vestir y accesorios de vestir'),(384,'46415','Venta al por mayor de ropa usada'),(385,'46416','Venta al por mayor de calzado'),(386,'46417','Venta al por mayor de artÃ­culos de marroquinerÃ­a y talabarterÃ­a'),(387,'46418','Venta al por mayor de artÃ­culos de peleterÃ­a'),(388,'46419','Venta al por mayor de otros artÃ­culos textiles n.c.p.'),(389,'46471','Venta al por mayor de instrumentos musicales'),(390,'46472','Venta al por mayor de colchones, almohadas, cojines, etc.'),(391,'46473','Venta al por mayor de artÃ­culos de aluminio para el hogar y para otros usos'),(392,'46474','Venta al por mayor de depÃ³sitos y otros artÃ­culos plÃ¡sticos para el hogar y otros usos, incluyendo los desechables de durapax  y no desechables'),(393,'46475','Venta al por mayor de cÃ¡maras fotogrÃ¡ficas, accesorios y materiales'),(394,'46482','Venta al por mayor de medicamentos, artÃ­culos y otros productos de uso veterinario'),(395,'46483','Venta al por mayor de productos y artÃ­culos de belleza  y de  uso personal'),(396,'46484','Venta de productos farmacÃ©uticos y medicinales'),(397,'46491','Venta al por mayor de productos medicinales, cosmÃ©ticos, perfumerÃ­a y productos de limpieza'),(398,'46492','Venta al por mayor de relojes y artÃ­culos de joyerÃ­a'),(399,'46493','Venta al por mayor de electrodomÃ©sticos y artÃ­culos del hogar excepto bazar;  artÃ­culos de iluminaciÃ³n'),(400,'46494','Venta al por mayor de artÃ­culos de bazar y similares'),(401,'46495','Venta al por mayor de artÃ­culos de Ã³ptica'),(402,'46496','Venta al por mayor de revistas, periÃ³dicos, libros, artÃ­culos de librerÃ­a y artÃ­culos de papel y cartÃ³n en general'),(403,'46497','Venta de artÃ­culos deportivos, juguetes y rodados'),(404,'46498','Venta al por mayor de productos usados para el hogar o el uso personal'),(405,'46499','Venta al por mayor de enseres domÃ©sticos y de uso personal n.c.p.'),(406,'46500','Venta al por mayor de bicicletas, partes, accesorios y otros'),(407,'46510','Venta al por mayor de computadoras, equipo perifÃ©rico y programas informÃ¡ticos'),(408,'46520','Venta al por mayor de equipos de comunicaciÃ³n'),(409,'46530','Venta al por mayor de maquinaria y equipo agropecuario, accesorios, partes y suministros'),(410,'46590','Venta de equipos e instrumentos de uso profesional y cientÃ­fico y aparatos de medida y control'),(411,'46591','Venta al por mayor de maquinaria equipo, accesorios y materiales para la industria de la madera y  sus  productos'),(412,'46592','Venta al por mayor de maquinaria,  equipo, accesorios y materiales para las industria grÃ¡fica y del papel, cartÃ³n y productos de papel y cartÃ³n'),(413,'46593','Venta al por mayor de maquinaria, equipo, accesorios y materiales para la  industria de  productos quÃ­micos, plÃ¡stico y caucho'),(414,'46594','Venta al por mayor de maquinaria, equipo, accesorios y materiales para la industria metÃ¡lica y de sus productos'),(415,'46595','Venta al por mayor de equipamiento para uso mÃ©dico, odontolÃ³gico, veterinario y servicios conexos'),(416,'46596','Venta al por mayor de maquinaria, equipo, accesorios y partes para la industria de la alimentaciÃ³n'),(417,'46597','Venta al por mayor de maquinaria, equipo, accesorios y partes para la industria textil, confecciones y cuero'),(418,'46598','Venta al por mayor de maquinaria, equipo y accesorios para la construcciÃ³n y explotaciÃ³n de minas y canteras'),(419,'46599','Venta al por mayor de otro tipo de maquinaria y equipo con sus accesorios y partes'),(420,'46610','Venta al por mayor  de otros combustibles sÃ³lidos, lÃ­quidos, gaseosos y de productos conexos'),(421,'46612','Venta al por mayor de combustibles para automotores, aviones, barcos, maquinaria  y otros'),(422,'46613','Venta al por mayor de lubricantes, grasas y  otros aceites para automotores, maquinaria  industrial, etc.'),(423,'46614','Venta al por mayor de gas propano'),(424,'46615','Venta al  por mayor de leÃ±a y carbÃ³n'),(425,'46620','Venta al por mayor de metales y minerales metalÃ­feros'),(426,'46631','Venta al por mayor de puertas, ventanas, vitrinas y similares'),(427,'46632','Venta al por mayor de artÃ­culos de ferreterÃ­a y pinturerÃ­as'),(428,'46633','VidrierÃ­as'),(429,'46634','Venta al por mayor de maderas'),(430,'46639','Venta al por mayor de materiales para la construcciÃ³n n.c.p.'),(431,'46691','Venta al por mayor de sal industrial sin yodar'),(432,'46692','Venta al por mayor de productos intermedios y desechos de origen textil'),(433,'46693','Venta al por mayor de productos intermedios y desechos de origen metÃ¡lico'),(434,'46694','Venta al por mayor de productos intermedios y desechos de papel y cartÃ³n'),(435,'46695','Venta al por mayor fertilizantes, abonos, agroquÃ­micos y productos similares'),(436,'46696','Venta al por mayor de productos intermedios y desechos de origen plÃ¡stico'),(437,'46697','Venta al por mayor de tintas para imprenta, productos curtientes y materias y productos colorantes'),(438,'46698','Venta de productos intermedios y desechos de origen quÃ­mico y de caucho'),(439,'46699','Venta al por mayor de productos intermedios y desechos ncp'),(440,'46701','Venta de algodÃ³n en oro'),(441,'46900','Venta al por mayor de otros productos'),(442,'46901','Venta al por mayor de cohetes y otros productos pirotÃ©cnicos'),(443,'46902','Venta al por mayor de artÃ­culos diversos para consumo humano'),(444,'46903','Venta al por mayor de armas de fuego, municiones y accesorios'),(445,'46904','Venta al por mayor de toldos y tiendas de campaÃ±a de cualquier material'),(446,'46905','Venta al por mayor de exhibidores publicitarios y rÃ³tulos'),(447,'46906','Venta al por mayor de artÃ­culos promocionales  diversos'),(448,'47111','Venta en supermercados'),(449,'47112','Venta en tiendas de artÃ­culos de primera necesidad'),(450,'47119','Almacenes (venta de diversos artÃ­culos)'),(451,'47190','Venta al por menor de otros productos en comercios no especializados'),(452,'47199','Venta de establecimientos no especializados con surtido compuesto principalmente de alimentos, bebidas y tabaco'),(453,'47211','Venta al por menor  de frutas y hortalizas'),(454,'47212','Venta al por menor de carnes, embutidos y productos de granja'),(455,'47213','Venta al por menor de pescado y mariscos'),(456,'47214','Venta al por menor de productos  lÃ¡cteos'),(457,'47215','Venta al por menor de productos de panaderÃ­a, reposterÃ­a y galletas'),(458,'47216','Venta al por menor de huevos'),(459,'47217','Venta al por menor de carnes y productos cÃ¡rnicos'),(460,'47218','Venta al por menor  de granos bÃ¡sicos y otros'),(461,'47219','Venta al por menor de alimentos n.c.p.'),(462,'47221','Venta al por menor de hielo'),(463,'47223','Venta de bebidas no alcohÃ³licas, para su consumo fuera del establecimiento'),(464,'47224','Venta de bebidas alcohÃ³licas, para su consumo fuera del establecimiento'),(465,'47225','Venta de bebidas alcohÃ³licas para su consumo dentro del establecimiento'),(466,'47230','Venta al por menor de tabaco'),(467,'47300','Venta de combustibles, lubricantes y otros (gasolineras)'),(468,'47411','Venta al por menor de computadoras y equipo perifÃ©rico'),(469,'47412','Venta de equipo y accesorios de telecomunicaciÃ³n'),(470,'47420','Venta al por menor de equipo de audio y video'),(471,'47510','Venta al por menor de hilados, tejidos y productos textiles de mercerÃ­a; confecciones para el hogar y textiles n.c.p.'),(472,'47521','Venta al por menor de productos de madera'),(473,'47522','Venta al por menor de artÃ­culos de ferreterÃ­a'),(474,'47523','Venta al por menor de productos de pinturerÃ­as'),(475,'47524','Venta al por menor en vidrierÃ­as'),(476,'47529','Venta al por menor de materiales de construcciÃ³n y artÃ­culos conexos'),(477,'47530','Venta al por menor de tapices, alfombras y revestimientos de paredes y pisos en comercios  especializados'),(478,'47591','Venta al por menor de muebles'),(479,'47592','Venta al por menor de artÃ­culos de bazar'),(480,'47593','Venta al por menor de aparatos electrodomÃ©sticos, repuestos y accesorios'),(481,'47594','Venta al por menor de artÃ­culos elÃ©ctricos y de iluminaciÃ³n'),(482,'47598','Venta al por menor de instrumentos musicales'),(483,'47610','Venta al por menor de libros, periÃ³dicos y artÃ­culos de papelerÃ­a en comercios especializados'),(484,'47620','Venta al por menor de discos lÃ¡ser, cassettes, cintas de video y otros'),(485,'47630','Venta al por menor de productos y equipos de deporte'),(486,'47631','Venta al por menor de bicicletas, accesorios y repuestos'),(487,'47640','Venta al por menor de juegos y juguetes  en comercios especializados'),(488,'47711','Venta al por menor de prendas de vestir y accesorios de vestir'),(489,'47712','Venta al por menor de calzado'),(490,'47713','Venta al por menor de artÃ­culos de peleterÃ­a, marroquinerÃ­a y talabarterÃ­a'),(491,'47721','Venta al por menor de medicamentos farmacÃ©uticos y otros materiales y artÃ­culos de uso mÃ©dico, odontolÃ³gico y veterinario'),(492,'47722','Venta al por menor de productos cosmÃ©ticos y de tocador'),(493,'47731','Venta al por menor de productos de joyerÃ­a, bisuterÃ­a, Ã³ptica, relojerÃ­a'),(494,'47732','Venta al por menor de plantas, semillas, animales y artÃ­culos conexos'),(495,'47733','Venta al por menor de combustibles de uso domÃ©stico (gas propano y gas licuado)'),(496,'47734','Venta al por menor de artesanÃ­as, artÃ­culos cerÃ¡micos y recuerdos en general'),(497,'47735','Venta al por menor de ataÃºdes, lÃ¡pidas y cruces, trofeos, artÃ­culos religiosos en general'),(498,'47736','Venta al por menor de armas de fuego, municiones y accesorios'),(499,'47737','Venta al por menor de artÃ­culos de coheterÃ­a y pirotÃ©cnicos'),(500,'47738','Venta al por menor de artÃ­culos desechables de uso personal y domÃ©stico (servilletas, papel higiÃ©nico, paÃ±ales, toallas sanitarias, etc.)'),(501,'47739','Venta al por menor de otros productos  n.c.p.'),(502,'47741','Venta al por menor de artÃ­culos usados'),(503,'47742','Venta al por menor de textiles y confecciones usados'),(504,'47743','Venta al por menor de libros, revistas, papel y cartÃ³n usados'),(505,'47749','Venta al por menor de productos usados n.c.p.'),(506,'47811','Venta al por menor de frutas, verduras y hortalizas'),(507,'47814','Venta al por menor de productos lÃ¡cteos'),(508,'47815','Venta al por menor de productos de panaderÃ­a, galletas y similares'),(509,'47816','Venta al por menor de bebidas'),(510,'47818','Venta al por menor en tiendas de mercado y puestos'),(511,'47821','Venta al por menor de hilados, tejidos y productos textiles de mercerÃ­a en puestos de mercados y ferias'),(512,'47822','Venta al por menor de artÃ­culos textiles excepto confecciones para el hogar en puestos de mercados y ferias'),(513,'47823','Venta al por menor de confecciones textiles para el hogar en puestos de mercados y ferias'),(514,'47824','Venta al por menor de prendas de vestir, accesorios de vestir y similares en puestos de mercados y ferias'),(515,'47825','Venta al por menor de ropa usada'),(516,'47826','Venta al por menor de calzado, artÃ­culos de marroquinerÃ­a y talabarterÃ­a en puestos de mercados y ferias'),(517,'47827','Venta al por menor de artÃ­culos de marroquinerÃ­a y talabarterÃ­a en puestos de mercados y ferias'),(518,'47829','Venta al por menor de artÃ­culos textiles ncp en puestos de mercados y ferias'),(519,'47891','Venta al por menor de animales, flores y productos conexos en puestos de feria y mercados'),(520,'47892','Venta al por menor de productos medicinales, cosmÃ©ticos, de tocador y de limpieza en puestos de ferias y mercados'),(521,'47893','Venta al por menor de artÃ­culos de bazar en puestos de ferias y mercados'),(522,'47894','Venta al por menor de artÃ­culos de papel, envases, libros, revistas y conexos en puestos de feria y mercados'),(523,'47895','Venta al por menor de materiales de construcciÃ³n, electrodomÃ©sticos, accesorios para autos y similares en puestos de feria y mercados'),(524,'47896','Venta al por menor de equipos accesorios para las comunicaciones en puestos de feria y mercados'),(525,'47899','Venta al por menor en puestos de ferias y mercados n.c.p.'),(526,'47910','Venta al por menor por correo o Internet'),(527,'47990','Otros tipos de venta al por menor no realizada, en almacenes, puestos de venta o mercado'),(528,'49110','Transporte interurbano de pasajeros  por ferrocarril'),(529,'49120','Transporte de carga por ferrocarril'),(530,'49211','Transporte de pasajeros urbanos e interurbano mediante buses'),(531,'49212','Transporte de pasajeros interdepartamental mediante microbuses'),(532,'49213','Transporte de pasajeros urbanos e interurbano mediante microbuses'),(533,'49214','Transporte de pasajeros interdepartamental mediante buses'),(534,'49221','Transporte internacional de pasajeros'),(535,'49222','Transporte de pasajeros mediante taxis y autos con chofer'),(536,'49223','Transporte escolar'),(537,'49225','Transporte de pasajeros para excursiones'),(538,'49226','Servicios de transporte de personal'),(539,'49229','Transporte de pasajeros por vÃ­a terrestre ncp'),(540,'49231','Transporte de carga urbano'),(541,'49232','Transporte nacional de carga'),(542,'49233','Transporte de carga  internacional'),(543,'49234','Servicios de  mudanza'),(544,'49235','Alquiler de vehÃ­culos de carga con conductor'),(545,'49300','Transporte por oleoducto o gasoducto'),(546,'50110','Transporte de pasajeros marÃ­timo y de cabotaje'),(547,'50120','Transporte de carga marÃ­timo y de cabotaje'),(548,'50211','Transporte de pasajeros por vÃ­as de navegaciÃ³n interiores'),(549,'50212','Alquiler de equipo de transporte de pasajeros por vÃ­as de navegaciÃ³n interior con conductor'),(550,'50220','Transporte de carga por vÃ­as de navegaciÃ³n interiores'),(551,'51100','Transporte aÃ©reo de pasajeros'),(552,'51201','Transporte de carga por vÃ­a aÃ©rea'),(553,'51202','Alquiler de equipo de aerotransporte  con operadores para el propÃ³sito de transportar carga'),(554,'52101','Alquiler de instalaciones de almacenamiento en zonas francas'),(555,'52102','Alquiler de silos para conservaciÃ³n y almacenamiento de granos'),(556,'52103','Alquiler de instalaciones con refrigeraciÃ³n para almacenamiento y conservaciÃ³n de alimentos y otros productos'),(557,'52109','Alquiler de bodegas para almacenamiento y depÃ³sito n.c.p.'),(558,'52211','Servicio de garaje y estacionamiento'),(559,'52212','Servicios de terminales para el transporte por vÃ­a terrestre'),(560,'52219','Servicios para el transporte por vÃ­a terrestre n.c.p.'),(561,'52220','Servicios para el transporte acuÃ¡tico'),(562,'52230','Servicios para el transporte aÃ©reo'),(563,'52240','ManipulaciÃ³n de carga'),(564,'52290','Servicios para el transporte ncp'),(565,'52291','Agencias de tramitaciones aduanales'),(566,'53100','Servicios de  correo nacional'),(567,'53200','Actividades de correo distintas a las actividades postales nacionales'),(568,'53201','Agencia privada de correo y encomiendas'),(569,'55101','Actividades de alojamiento para estancias cortas'),(570,'55102','Hoteles'),(571,'55200','Actividades de campamentos, parques de vehÃ­culos de recreo y parques de caravanas'),(572,'55900','Alojamiento n.c.p.'),(573,'56101','Restaurantes'),(574,'56106','PupuserÃ­a'),(575,'56107','Actividades varias de restaurantes'),(576,'56108','Comedores'),(577,'56109','Merenderos ambulantes'),(578,'56210','PreparaciÃ³n de comida para eventos especiales'),(579,'56291','Servicios de provisiÃ³n de comidas por contrato'),(580,'56292','Servicios de concesiÃ³n de cafetines y chalet en empresas e instituciones'),(581,'56299','Servicios de preparaciÃ³n de comidas ncp'),(582,'56301','Servicio de expendio de bebidas en salones y bares'),(583,'56302','Servicio de expendio de bebidas en puestos callejeros, mercados y ferias'),(584,'58110','EdiciÃ³n de libros, folletos, partituras y otras ediciones distintas a estas'),(585,'58120','EdiciÃ³n de directorios y listas de correos'),(586,'58130','EdiciÃ³n de periÃ³dicos, revistas y otras publicaciones periÃ³dicas'),(587,'58190','Otras actividades de ediciÃ³n'),(588,'58200','EdiciÃ³n de programas informÃ¡ticos (software)'),(589,'59110','Actividades de producciÃ³n cinematogrÃ¡fica'),(590,'59120','Actividades de post producciÃ³n de pelÃ­culas, videos y programas  de televisiÃ³n'),(591,'59130','Actividades de distribuciÃ³n de pelÃ­culas cinematogrÃ¡ficas, videos y programas de televisiÃ³n'),(592,'59140','Actividades de exhibiciÃ³n de pelÃ­culas cinematogrÃ¡ficas y cintas de vÃ­deo'),(593,'59200','Actividades de ediciÃ³n y grabaciÃ³n de mÃºsica'),(594,'60100','Servicios de difusiones de radio'),(595,'60201','Actividades de programaciÃ³n y difusiÃ³n de televisiÃ³n abierta'),(596,'60202','Actividades de suscripciÃ³n y difusiÃ³n de televisiÃ³n por cable y/o suscripciÃ³n'),(597,'60299','Servicios de televisiÃ³n, incluye televisiÃ³n por cable'),(598,'60900','ProgramaciÃ³n y transmisiÃ³n de radio y televisiÃ³n'),(599,'61101','Servicio de telefonÃ­a'),(600,'61102','Servicio de Internet '),(601,'61103','Servicio de telefonÃ­a fija'),(602,'61109','Servicio de Internet n.c.p.'),(603,'61201','Servicios de telefonÃ­a celular'),(604,'61202','Servicios de Internet inalÃ¡mbrico'),(605,'61209','Servicios de telecomunicaciones inalÃ¡mbrico n.c.p.'),(606,'61301','Telecomunicaciones satelitales'),(607,'61309','ComunicaciÃ³n vÃ­a satÃ©lite n.c.p.'),(608,'61900','Actividades de telecomunicaciÃ³n n.c.p.'),(609,'62010','ProgramaciÃ³n InformÃ¡tica'),(610,'62020','ConsultorÃ­as y gestiÃ³n de servicios informÃ¡ticos'),(611,'62090','Otras actividades de tecnologÃ­a de informaciÃ³n y servicios de computadora'),(612,'63110','Procesamiento de datos y actividades relacionadas'),(613,'63120','Portales WEB'),(614,'63910','Servicios de Agencias de Noticias'),(615,'63990','Otros servicios de informaciÃ³n  n.c.p.'),(616,'64110','Servicios provistos por el Banco Central de El salvador'),(617,'64190','Bancos'),(618,'64192','Entidades dedicadas al envÃ­o de remesas'),(619,'64199','Otras entidades financieras'),(620,'64200','Actividades de sociedades de cartera'),(621,'64300','Fideicomisos, fondos y otras fuentes de financiamiento'),(622,'64910','Arrendamiento financieros'),(623,'64920','Asociaciones cooperativas de ahorro y crÃ©dito dedicadas a la intermediaciÃ³n financiera'),(624,'64921','Instituciones emisoras de tarjetas de crÃ©dito y otros'),(625,'64922','Tipos de crÃ©dito ncp'),(626,'64928','Prestamistas y casas de empeÃ±o'),(627,'64990','Actividades de servicios financieros, excepto la financiaciÃ³n de planes de seguros y de pensiones n.c.p.'),(628,'65110','Planes de seguros de vida'),(629,'65120','Planes de seguro excepto de vida'),(630,'65199','Seguros generales de todo tipo'),(631,'65200','Planes se seguro'),(632,'65300','Planes de pensiones'),(633,'66110','AdministraciÃ³n de mercados financieros (Bolsa de Valores)'),(634,'66120','Actividades bursÃ¡tiles (Corredores de Bolsa)'),(635,'66190','Actividades auxiliares de la intermediaciÃ³n financiera ncp'),(636,'66210','EvaluaciÃ³n de riesgos y daÃ±os'),(637,'66220','Actividades de agentes y corredores de seguros'),(638,'66290','Otras actividades auxiliares de seguros y fondos de pensiones'),(639,'66300','Actividades de administraciÃ³n de fondos'),(640,'68101','Servicio de alquiler y venta de lotes en cementerios'),(641,'68109','Actividades inmobiliarias realizadas con bienes propios o arrendados n.c.p.'),(642,'68200','Actividades Inmobiliarias Realizadas a Cambio de una RetribuciÃ³n o por Contrata'),(643,'69100','Actividades jurÃ­dicas'),(644,'69200','Actividades de contabilidad, tenedurÃ­a de libros y auditorÃ­a; asesoramiento en materia de impuestos'),(645,'70100','Actividades de oficinas centrales de sociedades de cartera'),(646,'70200','Actividades de consultorÃ­a en gestiÃ³n empresarial'),(647,'71101','Servicios de arquitectura y planificaciÃ³n urbana y servicios conexos'),(648,'71102','Servicios de ingenierÃ­a'),(649,'71103','Servicios de agrimensura, topografÃ­a, cartografÃ­a, prospecciÃ³n y geofÃ­sica y servicios conexos'),(650,'71200','Ensayos y anÃ¡lisis tÃ©cnicos'),(651,'72100','Investigaciones y desarrollo experimental en el campo de las ciencias naturales y la ingenierÃ­a'),(652,'72199','Investigaciones cientÃ­ficas'),(653,'72200','Investigaciones y desarrollo experimental en el campo de las ciencias sociales y las humanidades cientÃ­fica y desarrollo'),(654,'73100','Publicidad'),(655,'73200','InvestigaciÃ³n de mercados y realizaciÃ³n de encuestas de opiniÃ³n pÃºblica'),(656,'74100','Actividades de diseÃ±o especializado'),(657,'74200','Actividades de fotografÃ­a'),(658,'74900','Servicios profesionales y cientÃ­ficos ncp'),(659,'75000','Actividades veterinarias'),(660,'77101','Alquiler de equipo de transporte terrestre'),(661,'77102','Alquiler de equipo de transporte acuÃ¡tico'),(662,'77103','Alquiler de equipo de transporte  por vÃ­a aÃ©rea'),(663,'77210','Alquiler y arrendamiento de equipo de recreo y deportivo'),(664,'77220','Alquiler de cintas de video y discos'),(665,'77290','Alquiler de otros efectos personales y enseres domÃ©sticos'),(666,'77300','Alquiler de maquinaria y equipo'),(667,'77400','Arrendamiento de productos de propiedad intelectual'),(668,'78100','ObtenciÃ³n y dotaciÃ³n de personal'),(669,'78200','Actividades de las agencias de trabajo temporal'),(670,'78300','DotaciÃ³n de recursos humanos y gestiÃ³n; gestiÃ³n de las funciones de recursos humanos'),(671,'79110','Actividades de agencias de viajes y organizadores de viajes; actividades de asistencia a turistas'),(672,'79120','Actividades de los operadores turÃ­sticos'),(673,'79900','Otros servicios de reservas y actividades relacionadas'),(674,'80100','Servicios de seguridad privados'),(675,'80201','Actividades de servicios de sistemas de seguridad'),(676,'80202','Actividades para la prestaciÃ³n de sistemas de seguridad'),(677,'80300','Actividades de investigaciÃ³n'),(678,'81100','Actividades combinadas de mantenimiento de edificios e instalaciones'),(679,'81210','Limpieza general de edificios'),(680,'81290','Otras actividades combinadas de mantenimiento de edificios e instalaciones ncp'),(681,'81300','Servicio de jardinerÃ­a'),(682,'82110','Servicios administrativos de oficinas'),(683,'82190','Servicio de fotocopiado y similares, excepto en imprentas'),(684,'82200','Actividades de las centrales de llamadas (call center)'),(685,'82300','OrganizaciÃ³n de convenciones y ferias de negocios'),(686,'82910','Actividades de agencias de cobro y oficinas de crÃ©dito'),(687,'82921','Servicios de envase y empaque de productos alimenticios'),(688,'82922','Servicios de envase y empaque de productos medicinales'),(689,'82929','Servicio de envase y empaque ncp'),(690,'82990','Actividades de apoyo empresariales ncp'),(691,'84110','Actividades de la AdministraciÃ³n PÃºblica en general'),(692,'84111','AlcaldÃ­as Municipales'),(693,'84120','RegulaciÃ³n de las actividades de prestaciÃ³n de servicios sanitarios, educativos, culturales y otros servicios sociales, excepto seguridad social'),(694,'84130','RegulaciÃ³n y facilitaciÃ³n de la actividad econÃ³mica'),(695,'84210','Actividades de administraciÃ³n y funcionamiento del Ministerio de Relaciones Exteriores'),(696,'84220','Actividades de defensa'),(697,'84230','Actividades de mantenimiento del orden pÃºblico y de seguridad'),(698,'84300','Actividades de planes de seguridad social de afiliaciÃ³n obligatoria'),(699,'85101','GuarderÃ­a educativa'),(700,'85102','EnseÃ±anza preescolar o parvularia'),(701,'85103','EnseÃ±anza primaria'),(702,'85104','Servicio de educaciÃ³n preescolar y primaria integrada'),(703,'85211','EnseÃ±anza secundaria tercer ciclo (7Â°, 8Â° y 9Â° )'),(704,'85212','EnseÃ±anza secundaria  de formaciÃ³n general  bachillerato'),(705,'85221','EnseÃ±anza secundaria de formaciÃ³n tÃ©cnica y profesional'),(706,'85222','EnseÃ±anza secundaria de formaciÃ³n tÃ©cnica y profesional integrada con enseÃ±anza primaria'),(707,'85301','EnseÃ±anza superior universitaria'),(708,'85302','EnseÃ±anza superior no universitaria'),(709,'85303','EnseÃ±anza superior integrada a educaciÃ³n secundaria y/o primaria'),(710,'85410','EducaciÃ³n deportiva y recreativa'),(711,'85420','EducaciÃ³n cultural'),(712,'85490','Otros tipos de enseÃ±anza n.c.p.'),(713,'85499','EnseÃ±anza formal'),(714,'85500','Servicios de apoyo a la enseÃ±anza'),(715,'86100','Actividades de hospitales'),(716,'86201','ClÃ­nicas mÃ©dicas'),(717,'86202','Servicios de OdontologÃ­a'),(718,'86203','Servicios mÃ©dicos'),(719,'86901','Servicios de anÃ¡lisis y estudios de diagnÃ³stico'),(720,'86902','Actividades de atenciÃ³n de la salud humana'),(721,'86909','Otros Servicio relacionados con la salud ncp'),(722,'87100','Residencias de ancianos con atenciÃ³n de enfermerÃ­a'),(723,'87200','Instituciones dedicadas al tratamiento del retraso mental, problemas de salud mental y el uso indebido de sustancias nocivas'),(724,'87300','Instituciones dedicadas al cuidado de ancianos y discapacitados'),(725,'87900','Actividades de asistencia a niÃ±os y jÃ³venes'),(726,'87901','Otras actividades de atenciÃ³n en instituciones'),(727,'88100','Actividades de asistencia sociales sin alojamiento para ancianos y discapacitados'),(728,'88900','servicios sociales sin alojamiento ncp'),(729,'90000','Actividades creativas artÃ­sticas y de esparcimiento'),(730,'91010','Actividades de bibliotecas y archivos'),(731,'91020','Actividades de museos y preservaciÃ³n de lugares y edificios histÃ³ricos'),(732,'91030','Actividades de jardines botÃ¡nicos, zoolÃ³gicos y de reservas naturales'),(733,'92000','Actividades de juegos y apuestas'),(734,'93110','GestiÃ³n de instalaciones deportivas'),(735,'93120','Actividades de clubes deportivos'),(736,'93190','Otras actividades deportivas'),(737,'93210','Actividades de parques de atracciones y parques temÃ¡ticos'),(738,'93291','Discotecas y salas de baile'),(739,'93298','Centros vacacionales'),(740,'93299','Actividades de esparcimiento ncp'),(741,'94110','Actividades de organizaciones empresariales y de empleadores'),(742,'94120','Actividades de organizaciones profesionales'),(743,'94200','Actividades de sindicatos'),(744,'94910','Actividades de organizaciones religiosas'),(745,'94920','Actividades de organizaciones polÃ­ticas'),(746,'94990','Actividades de asociaciones n.c.p.'),(747,'95110','ReparaciÃ³n de computadoras y equipo perifÃ©rico'),(748,'95120','ReparaciÃ³n de equipo de comunicaciÃ³n'),(749,'95210','ReparaciÃ³n de aparatos electrÃ³nicos de consumo'),(750,'95220','ReparaciÃ³n de aparatos domÃ©stico y equipo de hogar y jardÃ­n'),(751,'95230','ReparaciÃ³n de calzado y artÃ­culos de cuero'),(752,'95240','ReparaciÃ³n de muebles y accesorios para el hogar'),(753,'95291','ReparaciÃ³n de Instrumentos musicales'),(754,'95292','Servicios de cerrajerÃ­a y copiado de llaves'),(755,'95293','ReparaciÃ³n de joyas y relojes'),(756,'95294','ReparaciÃ³n de bicicletas, sillas de ruedas y rodados n.c.p.'),(757,'95299','Reparaciones de enseres personales n.c.p.'),(758,'96010','Lavado y limpieza de prendas de tela y de piel, incluso la limpieza en seco'),(759,'96020','PeluquerÃ­a y otros tratamientos de belleza'),(760,'96030','Pompas fÃºnebres y actividades conexas'),(761,'96091','Servicios de sauna y otros servicios para la estÃ©tica corporal n.c.p.'),(762,'96092','Servicios n.c.p.'),(763,'97000','Actividad de los hogares en calidad de empleadores de personal domÃ©stico'),(764,'98100','Actividades indiferenciadas de producciÃ³n de bienes de los hogares privados para uso propio'),(765,'98200','Actividades indiferenciadas de producciÃ³n de servicios de los hogares privados para uso propio'),(766,'99000','Actividades de organizaciones y Ã³rganos extraterritoriales'),(767,'10001','Empleados'),(768,'10002','Pensionado'),(769,'10003','Estudiante'),(770,'10004','Desempleado'),(771,'10005','Otros'),(772,'10006','Comerciante'),(773,'1111','Cultivo de cereales excepto arroz y para forrajes');
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
  `cp_empresa` int DEFAULT NULL,
  PRIMARY KEY (`idcat_prod`),
  KEY `PK_CIT_ID_idx` (`cp_cit_id`),
  KEY `FK_UNIDAD_MED_idx` (`um_codigo`),
  CONSTRAINT `FK_UNIDAD_MED` FOREIGN KEY (`um_codigo`) REFERENCES `unidades_medida` (`um_codigo`),
  CONSTRAINT `PK_CIT_ID` FOREIGN KEY (`cp_cit_id`) REFERENCES `catalogo_tipo_item` (`cit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_productos`
--

LOCK TABLES `catalogo_productos` WRITE;
/*!40000 ALTER TABLE `catalogo_productos` DISABLE KEYS */;
INSERT INTO `catalogo_productos` VALUES (63,'TEST 1',15.80,'1',59,'N',NULL,'S',1,NULL,'MANUAL',NULL);
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
  `idtipo_establecimiento` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) DEFAULT NULL,
  `valor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipo_establecimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipo_establecimiento`
--

LOCK TABLES `catalogo_tipo_establecimiento` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_establecimiento` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_establecimiento` VALUES (1,'01','Sucursal / Agencia'),(2,'02','Casa matriz'),(3,'04','Bodega'),(4,'07','Predio y/o patio'),(5,'20','Otro');
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
  `ruc_ce_empresa` varchar(45) DEFAULT NULL COMMENT 'Relacion con la tabla "catalogo de empresa" por ID para hacer unico cada contribuyente según la empresa que tenga relacionada el usuario (tabla usuarios)',
  PRIMARY KEY (`ruc_id`),
  KEY `PK_PAIS_idx` (`ruc_cp_id_pais`),
  KEY `PK_TIPO_PERSON_idx` (`ruc_ctper_id`),
  KEY `PK_NIT_idx` (`ruc_nit_contribuyente`),
  CONSTRAINT `PK_PAIS` FOREIGN KEY (`ruc_cp_id_pais`) REFERENCES `catalogo_pais` (`cp_id_pais`),
  CONSTRAINT `PK_TIPO_PERSON` FOREIGN KEY (`ruc_ctper_id`) REFERENCES `catalogo_tipo_de_persona` (`ctper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contribuyentes`
--

LOCK TABLES `contribuyentes` WRITE;
/*!40000 ALTER TABLE `contribuyentes` DISABLE KEYS */;
INSERT INTO `contribuyentes` VALUES (1,'06141204841181','MIGUEL ISAAC SANCHEZ RAMOS','SANCHEZ','RAMOS','COL. ESCALON, CANTON EL CARMEN, PJE PEREZ, CASA 1','2261-7300','2261-7300','miguelsr1@gmail.com','007589275',NULL,NULL,'06','14','EMISOR',NULL,'0000','1875310','96092','Actividades de asociaciones n.c.p.','02',NULL,'MUMH0001','0001',1,'MIGUEL SANCHEZ',NULL,NULL,NULL,NULL,2,NULL),(2,'06141708001052','Fondo de actividades especiales para la venta de productos y servicios del MOP y de transporte',NULL,NULL,'Kilometro 5 1/2 plantel la lechuza, alameda manuel e. araujo, san salvador, san salvador','2133-3600','2133-3600','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,'m568','1252622','82990','Actividades de la administración publica en general','02',NULL,NULL,'1234',1,'prueba',NULL,NULL,NULL,2,2,NULL),(3,'06141603001014','G.S.I. El Salvador, S.A. de C.V. ','G.S.I. El Salvador, S.A. de C.V. ','G.S.I. El Salvador, S.A. de C.V. ','Calle Llama del Bosque Pte. Blvd. Luis Poma Local 204, Urbanizacion Madre Selva Edificio ','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'1199782','63110','Actividades de asociaciones n.c.p.',NULL,NULL,'',NULL,1,NULL,NULL,NULL,NULL,NULL,2,NULL),(4,'06141810841054','pruebas update nombre razon social',NULL,NULL,'Domicilio update pruebas','22445588','22445588','miguelsr1@gmail.com',NULL,NULL,NULL,'06','03','EMISOR',NULL,NULL,'456123','94990',NULL,NULL,NULL,NULL,NULL,NULL,'pruebas update nombre comercial',NULL,NULL,NULL,NULL,NULL,NULL),(5,'0000000000000','SIN IDENTIFICACION ',NULL,NULL,'SAN SALVADOR ','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','EMISOR',NULL,NULL,'1047582','10005',NULL,NULL,NULL,NULL,NULL,1,'SIN IDENTIFICACION ',NULL,NULL,NULL,NULL,NULL,NULL),(6,'00000000000003','SIN IDENTIFICACION ',NULL,NULL,'SAN SALVADOR','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'1047582','10005',NULL,NULL,NULL,NULL,NULL,1,'SIN IDENTIFICACION ',NULL,NULL,NULL,NULL,NULL,NULL),(8,'022862818','prueba creacion emisor',NULL,NULL,'Pruebas creacion de emisor','22822136','22822136','miguelsr1@gmail.com',NULL,NULL,NULL,'06','03','EMISOR',NULL,NULL,'1567894','56107',NULL,NULL,NULL,NULL,NULL,1,'Prueba creacion emisor',NULL,NULL,NULL,NULL,NULL,NULL),(9,'0228628186','prueba creacion receptor',NULL,NULL,'Pruebas domicilio nuevo receptor','72725063','72725063','miguelsr1@gmail.com',NULL,NULL,NULL,'06','08','RECEPTOR',NULL,NULL,'16546818','1150',NULL,NULL,NULL,NULL,NULL,1,'prueba creacion receptor',NULL,NULL,NULL,NULL,NULL,NULL),(291,'00000000000001','PRUEBAS NRC NULL',NULL,NULL,'pruebas insert nrc null','22822136','22822136','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'94990','Actividades de asociaciones n.c.p.',NULL,NULL,NULL,NULL,1,'PRUEBAS NRC NULL',NULL,NULL,NULL,NULL,2,NULL),(292,'00000000000002','PRUEBAS STC FACTURACION ',NULL,NULL,'PRUEBAS STC FACTURACION ','22558899','22558899','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'11048','Maquilado de aguas gaseosas',NULL,NULL,NULL,NULL,1,'PRUEBAS',NULL,NULL,NULL,NULL,NULL,NULL),(293,'00000000000000','PEDRITO PEREZ',NULL,NULL,'SAN SALVADOR, SAN SALVADOR.','2261-7300','2261-7300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'68109','Actividades inmobiliarias realizadas con bienes propios o arrendados n.c.p.',NULL,NULL,NULL,NULL,1,'PEDRITO PEREZ',NULL,NULL,NULL,NULL,NULL,NULL),(294,'00000000000008','JUAN GUTIERREZ',NULL,NULL,'1a. CALLE OTE, SANTIAGO TEXACUANGOS, SAN SALVADOR','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','15','RECEPTOR',NULL,NULL,NULL,'10005','Otros',NULL,NULL,NULL,NULL,1,'JUAN GUTIERREZ',NULL,NULL,NULL,NULL,NULL,NULL),(295,'06081208901020','SR PRUEBA FSE',NULL,NULL,'SAN SALVADOR, SAN SALVADOR.','22617300','22617300','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,NULL,'10005','Otros',NULL,NULL,NULL,NULL,1,'SR PRUEBA FSE',NULL,NULL,NULL,NULL,NULL,NULL),(306,'022862817','prueba receptor s.a. de c.v.',NULL,NULL,'pruebas domicilio',NULL,'72725063','miguelsr1@gmail.com',NULL,NULL,NULL,'06','14','RECEPTOR',NULL,NULL,'18108410','62090',NULL,NULL,NULL,NULL,NULL,1,'prueba receptor s.a. de c.v.',NULL,NULL,NULL,NULL,NULL,NULL);
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
  UNIQUE KEY `FACT_UNIQUE_idx` (`fac_nro_factura`),
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,'1','2025-05-19 22:28:39','10005','06141204841181','00000000000008','22617300','JUAN GUTIERREZ',0.00,0.00,1501.00,NULL,NULL,2,'E758A000-3532-11F0-84F2-0242AC110002','DTE-01-MUMH0001-000000000000005',1,_binary '202597B38278ED5B45C2A832FF18B436751E2NLA',172.68,'01',0.00,0.00,1501.00,0.00,0.00,0.00,0.00,0.00,0.00,'MIL QUINIENTOS UNO CON CERO /100 CTVS',0.00,0.00,20.00,1501.00,NULL,1501.00,0.00,1501.00,NULL,1,0.00,'2025-05-19 06:00:00','2025-05-19 06:00:00',0.00,NULL,NULL,NULL,'Fecha del Periodo del 19/05/2025 al 19/05/2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9,NULL,0.00,0.00,0.00,0.00,'2025-05-19 22:28:44',1);
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
INSERT INTO `factura_detalle` VALUES (1,1,'1',95,'TEST 1',15.80,1501.00,NULL,'06141204841181',1,59,0.00,0.00,1501.00,172.68,'MIL QUINIENTOS UNO CON CERO /100 CTVS','20',0.00,0.00,172.68,0.00,'1',NULL,NULL,NULL,NULL,NULL,'',0.00,0.00,0.00,0.00,NULL);
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
  `nosec_secuencia` varchar(15) DEFAULT NULL,
  `nosec_ruc_id` int DEFAULT NULL,
  `nosec_ce_empresa` int DEFAULT NULL COMMENT 'Id de la empresa en basde al "Catalogo de empresas" según relacion con la tabla usuarios, lleva el control del número de emitidos (DTE) en base a cada empresa.',
  PRIMARY KEY (`nosec_id`),
  KEY `fk_ruc_id_idx` (`nosec_ruc_id`),
  KEY `fk_tipo_comprobante_idx` (`nosec_tcp_idtipo`),
  CONSTRAINT `fk_ruc_id` FOREIGN KEY (`nosec_ruc_id`) REFERENCES `contribuyentes` (`ruc_id`),
  CONSTRAINT `fk_tipo_comprobante` FOREIGN KEY (`nosec_tcp_idtipo`) REFERENCES `tipos_comprobantes` (`tcp_idtipo`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nosecuencia_factura`
--

LOCK TABLES `nosecuencia_factura` WRITE;
/*!40000 ALTER TABLE `nosecuencia_factura` DISABLE KEYS */;
INSERT INTO `nosecuencia_factura` VALUES (1,2025,1,'5',1,1),(2,2025,4,'0',1,NULL),(3,2025,7,'0',1,NULL),(49,2025,2,'2',1,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,'03',1501.00,'01','',0,1,NULL);
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
INSERT INTO `parametros_generales` VALUES (1,'Para la generacion de los JSON en catalogo de MH 00 indica pruebas y 01 produccion ','00','version'),(2,'Para la generacion de los JSON en CAT-003 de MH se indica que 1 es modelo de facturacion previo y 2 es modelo de facturacion diferido','1','tipoModelo'),(3,'Generacion JSON en CAT-004 se indica que transmision 1 es normal y 2 es por contigencia','1','tipoOperacion'),(4,'Para JSON en normativa MH indico que debe ser USD','USD','tipoMoneda'),(5,'código de Casa Matriz, sucursal o Agencia, Bodega y/o Predio o Patio (4 dígitos Alfanumérico) seguido del código de punto venta (4 dígitos alfanumérico)','TEST5645',NULL);
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
  `pm_ce_empresa` int DEFAULT NULL,
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
INSERT INTO `parametros_mh` VALUES (1,'06141204841181','wkf2Z7Xmd$kkcjR','http://34.225.63.188:8081/firma/firmardocumento/','06141204841181','Gx9@Lm27q#','https://apitest.dtes.mh.gob.sv/seguridad/auth',1,'00',1,'https://apitest.dtes.mh.gob.sv/fesv/recepciondte','https://admin.factura.gob.sv/consultaPublica?ambiente=','https://apitest.dtes.mh.gob.sv/fesv/anulardte',2,NULL);
/*!40000 ALTER TABLE `parametros_mh` ENABLE KEYS */;
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
INSERT INTO `tributos` VALUES (1,'20','Impuesto al Valor Agregado 13%',172.68,NULL);
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
INSERT INTO `unidades_laborales` VALUES (1,'ADS','UNIDAD ADMINISTRATIVA - SERTRACEN'),(2,'FTC','FOTOCOPIAS E IMPRESIONES'),(3,'PKO','PARQUEO SERTRACEN');
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
FROM fact.factura where fac_id = p_factura;

select 
	tc.tcp_descomprobante,
    bdh.codigo_generacion,
    DATE_FORMAT(bdh.fecha_ingreso, '%d/%m/%Y %H:%i'),
    bdh.selloRecibido into tipoDte, codGene, fechaIngreso, selloRecibido
from buzoncsv b 
	inner join tipos_comprobantes tc on b.tipodoc = tc.tcp_idtipcom
    inner join factura f on f.fac_nro_factura = b.cod_factura
    inner join bitacora_declaracion_hacienda bdh on f.fac_id = bdh.id_fac and bdh.estado in ('PROCESADO','OBSERVADO')
where f.fac_id = p_factura;

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
CREATE DEFINER=`root`@`%` FUNCTION `fun_retorna_json`(`ptipo_fac` VARCHAR(15) CHARSET utf8mb4, `pfactura` VARCHAR(15) CHARSET utf8mb4) RETURNS json
    READS SQL DATA
BEGIN

# CREADO POR MEGONZALEZ EL 28/06/2023 SE GENERA ESTRUCTURA DE JSON SEGUN TIPO DE COMPROBANTE

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

           'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),

           'nrc', a.ruc_nrc,

           'nombre', a.ruc_nombre_razonsocial,

           'codActividad',a.ruc_codactividad,

           'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.ruc_codactividad),

           'nombreComercial', a.ruc_nombre_comercial,

           'tipoEstablecimiento', a.ruc_tipoestablecimiento,

           'direccion',

               JSON_OBJECT(

                   'departamento', a.ruc_codigo_departamento,

                   'municipio', a.ruc_codigo_municipio,

                   'complemento', a.ruc_domicilio

                ),

           'telefono', a.ruc_telefono_personal,

           'correo', a.ruc_email_contribuyente,

           'codEstable', a.ruc_cod_establecimiento,

           'codPuntoVenta', a.ruc_cod_punto_venta_mh,

           'codEstableMH',  a.ruc_codigo_mh,

           'codPuntoVentaMH', a.ruc_cod_punto_venta_mh

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

FROM factura, contribuyentes as a, contribuyentes as b

where a.ruc_nit_contribuyente = fac_nit_emisor

and a.ruc_tipo_contribuyente = 'EMISOR'

and b.ruc_nit_contribuyente = fac_nit_receptor

and b.ruc_tipo_contribuyente = 'RECEPTOR'

and fac_id = pfactura

    );

 

 

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
            'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
            'nrc', a.ruc_nrc,
            'nombre', a.ruc_nombre_razonsocial,
            'codActividad', a.ruc_codactividad,
            'descActividad', (SELECT ccae_valor FROM fact.catalogo_codigo_actividad_economica where ccae_codigo = a.ruc_codactividad),
            'nombreComercial', a.ruc_nombre_comercial,
            'tipoEstablecimiento', a.ruc_tipoestablecimiento,
            'direccion',
                JSON_OBJECT(
                    'departamento', a.ruc_codigo_departamento,
                    'municipio', a.ruc_codigo_municipio,
                    'complemento', a.ruc_domicilio
                ),
           'telefono', a.ruc_telefono_personal,
           'codEstableMH', a.ruc_codigo_mh,
           'codEstable', a.ruc_cod_establecimiento,
           'codPuntoVentaMH', a.ruc_cod_punto_venta_mh,
           'codPuntoVenta', a.ruc_cod_punto_venta_mh,
           'correo', a.ruc_email_contribuyente
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
       /* 'extension', null,*/
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
LEFT JOIN contribuyentes as a ON a.ruc_nit_contribuyente = fac_nit_emisor AND a.ruc_tipo_contribuyente = 'EMISOR'
LEFT JOIN contribuyentes as b ON b.ruc_nit_contribuyente = fac_nit_receptor AND b.ruc_tipo_contribuyente = 'RECEPTOR'
where -- a.ruc_nit_contribuyente = f.fac_nit_emisor
-- and a.ruc_tipo_contribuyente = 'EMISOR'
fac_id = pfactura
);

 

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

                /**/

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

where a.ruc_nit_contribuyente = fac_nit_emisor

and a.ruc_tipo_contribuyente = 'EMISOR'

and b.ruc_nit_contribuyente = fac_nit_receptor

and b.ruc_tipo_contribuyente = 'RECEPTOR'

and fac_id = pfactura

 );

 

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

where a.ruc_nit_contribuyente = fac_nit_emisor

and a.ruc_tipo_contribuyente = 'EMISOR'

and b.ruc_nit_contribuyente = fac_nit_receptor

and b.ruc_tipo_contribuyente = 'RECEPTOR'

and fac_id = pfactura

 

 );

 

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

              /* JSON_OBJECT(

               'nit',null, #NIT por cuenta de Terceros

               'nombre',null #Nombre, denominación o razón social del Tercero

               ),*/

 

 

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

where a.ruc_nit_contribuyente = fac_nit_emisor

and a.ruc_tipo_contribuyente = 'EMISOR'

and b.ruc_nit_contribuyente = fac_nit_receptor

and b.ruc_tipo_contribuyente = 'RECEPTOR'

and fac_id = pfactura

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

              /* JSON_OBJECT(

               'nit',null, #NIT por cuenta de Terceros

               'nombre',null #Nombre, denominación o razón social del Tercero

               ),*/

 

 

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

where a.ruc_nit_contribuyente = fac_nit_emisor

and a.ruc_tipo_contribuyente = 'EMISOR'

and b.ruc_nit_contribuyente = fac_nit_receptor

and b.ruc_tipo_contribuyente = 'RECEPTOR'

and fac_id = pfactura

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

where a.ruc_nit_contribuyente = fac_nit_emisor

and a.ruc_tipo_contribuyente = 'EMISOR'

and b.ruc_nit_contribuyente = fac_nit_receptor

and b.ruc_tipo_contribuyente = 'RECEPTOR'

and fac_id = pfactura

 

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

                /**/

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

where a.ruc_nit_contribuyente = fac_nit_emisor

and a.ruc_tipo_contribuyente = 'EMISOR'

and b.ruc_nit_contribuyente = fac_nit_receptor

and b.ruc_tipo_contribuyente = 'RECEPTOR'

and fac_id = pfactura

  );

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
CREATE DEFINER=`root`@`%` FUNCTION `fun_secuencia`(`tipo_comprobante` VARCHAR(5)) RETURNS varchar(31) CHARSET utf8mb3
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


set vcod = (select 0 where not exists (select  nosec_tcp_idtipo from fact.nosecuencia_factura
where
nosec_tcp_idtipo=idtipo and nosec_anio=2025/*year(curdate())*/ ));

if vcod = 0 then
  
	INSERT INTO fact.nosecuencia_factura (nosec_anio, nosec_tcp_idtipo, nosec_secuencia, nosec_ruc_id) VALUES (2025/*year(curdate())*/ ,idtipo, 0,1);

	select concat('DTE-',tcp_idtipcom,'-', (select ruc_cod_punto_venta from contribuyentes where ruc_id = 1),'-',LPAD((SELECT nosec_secuencia+1 FROM fact.nosecuencia_factura where nosec_tcp_idtipo = idtipo and nosec_anio = 2025/*year(curdate())*/ ),15,'0') )
	into dte
	from tipos_comprobantes
	where tcp_comprobante = tipo_comprobante;
    
    

else

	select concat('DTE-',tcp_idtipcom,'-', (select ruc_cod_punto_venta from contribuyentes where ruc_id = 1),'-',LPAD((SELECT nosec_secuencia+1 FROM fact.nosecuencia_factura where nosec_tcp_idtipo = idtipo and nosec_anio = 2025/*year(curdate())*/ ),15,'0') )
	into dte
	from tipos_comprobantes
	where tcp_comprobante = tipo_comprobante;

	update fact.nosecuencia_factura
	set nosec_secuencia = nosec_secuencia +1
	 where nosec_tcp_idtipo = idtipo and nosec_anio = 2025/*year(curdate())*/ ;
 
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
CREATE DEFINER=`root`@`%` PROCEDURE `pro_carga_facturas`(in papp varchar(30), in pusuario varchar(30), out pid_factura int, out pval int, out pmensaje text)
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
    declare  vtipo_item_expor int;
    declare  vrecinto_fiscal varchar(2);
    declare  vregimen varchar(13);
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
			IFNULL(factura_migrada, 'N') = 'N'
			AND cod_factura IS NOT NULL
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
				where cod_factura = vcod_factura
				and ifnull(factura_migrada, 'N') = 'N';
				
				select 1, fac_id
				into vexiste_factura, vid_fac
				from factura
				where fac_nro_factura = vcod_factura;
				-- set pmensaje = concat(concat(pmensaje,' AQUI  vid_fac'),vid_fac);
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
			where ruc_nit_contribuyente = vnit
              AND ruc_tipo_contribuyente='RECEPTOR';
			
			select doc_id
			into vid_tipo_doc
			from tipos_documentos
			where doc_idtipo_documento = vtipodocrec;
            
            SELECT tcp_comprobante
			into vtipo_comprobante
			FROM tipos_comprobantes
			where tcp_idtipcom = vtipodoc;
            
			select fact.fun_secuencia(vtipo_comprobante) into vcodigo_dte; 
			
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
                fac_retencion_iva_porc,fac_retencion_renta_porc)
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
                vretencion_iva_porc,vimpuesto_reten_retenido_porc);
				
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
/*!50003 DROP PROCEDURE IF EXISTS `pro_carga_facturas_por_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_carga_facturas_por_id`(in papp varchar(30), in pusuario varchar(30),in pid_buzon int, out pid_factura int, out pval int, out pmensaje text)
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
    declare  vtipo_item_expor int;
    declare  vrecinto_fiscal varchar(2);
    declare  vregimen varchar(13);
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
			IFNULL(factura_migrada, 'N') = 'N'
			AND cod_factura IS NOT NULL
            AND cod_factura=pid_buzon
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
				where cod_factura = vcod_factura
				and ifnull(factura_migrada, 'N') = 'N';
				
				select 1, fac_id
				into vexiste_factura, vid_fac
				from factura
				where fac_nro_factura = vcod_factura;
				-- set pmensaje = concat(concat(pmensaje,' AQUI  vid_fac'),vid_fac);
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
			where ruc_nit_contribuyente = vnit
              AND ruc_tipo_contribuyente='RECEPTOR';
			
			select doc_id
			into vid_tipo_doc
			from tipos_documentos
			where doc_idtipo_documento = vtipodocrec;
            
            SELECT tcp_comprobante
			into vtipo_comprobante
			FROM tipos_comprobantes
			where tcp_idtipcom = vtipodoc;
            
			select fact.fun_secuencia(vtipo_comprobante) into vcodigo_dte; 
			
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
                fac_retencion_iva_porc,fac_retencion_renta_porc)
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
                vretencion_iva_porc,vimpuesto_reten_retenido_porc);
				
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
/*!50003 DROP PROCEDURE IF EXISTS `pro_consulta_pago_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_consulta_pago_ticket`(    
    IN pcorrelativo VARCHAR(20),
    IN pusuario_cobro varchar(50),
    OUT pvalor_cobro DECIMAL(15, 2),
    OUT phoraini TIME,
    OUT phorafin TIME,
    OUT pfecha varchar(10),
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN
    DECLARE vtipoplaca VARCHAR(20);
    DECLARE vh_hora_inicio TIME;
    DECLARE vh_diferencia INT;
    DECLARE vnum_fact INT DEFAULT 0;
    DECLARE vtotal_horas int;
    DECLARE vid int;
	DECLARE vcobrado int;
    DECLARE vcortesia VARCHAR(2);
    DECLARE vh_hora_fin TIME;
     DECLARE vcodigo_prod  text;

    -- Inicializar variables
    SET pvalor_cobro = 0.0;
    SET pval = 0;
    SET pmensaje = 'ok';
    SET vh_hora_fin = DATE_SUB(CURTIME(),INTERVAL 6 HOUR); 
    
    -- Se verifica que el correlativo no se encuentre vacio
    IF pcorrelativo IS NOT NULL THEN
	
		SET vcortesia = 'N';
		-- Obtener información del vehículo
		SELECT ifnull(cortesia,'N')
		INTO vcortesia
		FROM tickets_parqueo
		WHERE secuencia_qr = pcorrelativo
		AND fecha_ingreso = DATE(NOW())
		ORDER BY fecha_ingreso DESC
		LIMIT 1;
		
        SELECT vcortesia;
        
        IF  vcortesia != 'S' THEN
        
			SET vcobrado = 0;
		
    
			-- Validacion para confirmar que la factura no se encuentre cobrada
			SELECT 1
			INTO vcobrado
			FROM tickets_parqueo
			WHERE secuencia_qr = pcorrelativo
			AND fecha_ingreso=DATE(now())
			AND estado='C'
			ORDER BY fecha_ingreso DESC
			LIMIT 1;      
				
			IF vcobrado != 1 THEN
			
				-- Obtener información del vehículo
				SELECT hora_inicio, tipo_placa, id_correlativo, DATE_FORMAT(fecha_ingreso, '%d/%m/%Y')
				INTO vh_hora_inicio, vtipoplaca, vid, pfecha
				FROM tickets_parqueo
				WHERE secuencia_qr = pcorrelativo
				AND fecha_ingreso = DATE(NOW())
				AND estado = 'P'
				ORDER BY fecha_ingreso DESC
				LIMIT 1;

				IF vh_hora_inicio IS NULL THEN
					-- No se encontraron registros, manejar la excepción
					SET pval = 1;
					SET pmensaje = 'Error: No se encontraron registros para el correlativo proporcionado.';
				   
				ELSE

					SET phoraini = vh_hora_inicio;
					
					-- Calcular la diferencia de tiempo en minutos
					SET vh_diferencia = TIMESTAMPDIFF(MINUTE, vh_hora_inicio, vh_hora_fin);

                     -- Se verifica si el ticket es cobrado desde el primer segundo
                    IF vh_diferencia = 0  and TIMESTAMPDIFF(SECOND, vh_hora_inicio, vh_hora_fin) > 0 then -- se evalua que la diferencia los segundos sea al menos de mas 1 segundo
						set vh_diferencia = 60;
                    end if;
                    
                    IF vh_diferencia>240 then
						set vh_diferencia = 240;
                    end if;
                    
					SET phorafin = DATE_SUB(CURTIME(),INTERVAL 6 HOUR); -- CURRENT_TIMESTAMP;
					
					SET vtotal_horas = CEIL(vh_diferencia / 60);
					-- Calcular el valor del cobro
					IF vtipoplaca = 'M' THEN
						-- Si la placa inicia con 'M' pero no es 'MB'
                        
						SET vcodigo_prod = CONCAT('TPM',vtotal_horas);
                        
                        SELECT valor_unitario INTO pvalor_cobro FROM catalogo_productos where codigo_prod=vcodigo_prod;
           
					ELSE
						-- Si la placa no cumple con ninguna condición especial
						SET vcodigo_prod = CONCAT('TP',vtotal_horas);
                        
                        SELECT valor_unitario INTO pvalor_cobro FROM catalogo_productos where codigo_prod=vcodigo_prod;

					END IF;
					
				END IF;
			ELSE
					SET pval = 1;
					SET pmensaje = 'El ticket indicado ya se encuentra cancelado';

			END IF;
        ELSE
			SET pval = 1;
			SET pmensaje = 'Ticket ha sido catalogado como cortesía, no requiere cobro.';
        END IF;
    ELSE
        SET pval = 1;
        SET pmensaje = 'Correlativo no encontrado.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_crea_ticket_inconforme` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_crea_ticket_inconforme`(
    IN pusuario VARCHAR(50), 
    IN ptipoplaca VARCHAR(5), 
    IN papp varchar(30),
    out pfecha_ing VARCHAR(10),
    out pcorrelativo INT,
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN

	DECLARE vultimo_correlativo INT;
    DECLARE vid_ticket INT;
    DECLARE vfecha_ing VARCHAR(10);
    DECLARE vhora TIME;
    DECLARE vulb varchar(15);
    DECLARE vcorrelativo INT;
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

	SET pval = 0;
    SET pmensaje = 'OK';

    -- Obtener la fecha actual en formato YYYY-MM-DD
    SET vfecha_ing = DATE_FORMAT(NOW(), '%Y-%m-%d');
    
    -- Obtener la hora actual en formato HH:MM:SS
	SET vhora = DATE_SUB(CURTIME(),INTERVAL 6 HOUR); -- Se restan 6 horas en DESARROLLO por hora erronea del servidor en produccion NO se debe restar

    SELECT IFNULL(MAX(secuencia_qr), 0) INTO vultimo_correlativo
    FROM tickets_parqueo
    WHERE fecha_ingreso = vfecha_ing;
    
    -- Incrementar el correlativo si la fecha de ingreso es la misma
    SET vcorrelativo = vultimo_correlativo + 1;
    
    SELECT us_ubicacion 
    INTO vulb
    FROM fact.usuarios 
    WHERE us_usuario=pusuario;

    -- Insertar el nuevo registro en la tabla tickets_parqueo
    INSERT INTO tickets_parqueo ( fecha_ingreso, hora_inicio, usuario_ingreso, estado,tipo_placa, secuencia_qr,ulb_user_ingreso) 
    VALUES ( vfecha_ing, vhora, pusuario, 'R',ptipoplaca, vcorrelativo, vulb);
    
    -- retornando el correlativo del tck de parqueo insertado y la fecha de ingreso del tck de parqueo
    SET pcorrelativo = vcorrelativo;
    SET pfecha_ing = DATE_FORMAT(vfecha_ing, '%d/%m/%Y');

	-- Obtener el ID del último registro insertado
	SELECT LAST_INSERT_ID() into vid_ticket;

	IF ptipoplaca = 'M' THEN
		-- Si la placa inicia con 'M' pero no es 'MB'
		SET vcobro = 0.0;
	ELSE
		-- Si la placa no cumple con ninguna condición especial
		SET vcobro = 0.0;
	END IF;
    
	-- Actualizar la fecha de cobro y estado en la tabla
	UPDATE tickets_parqueo
	SET fecha_cobro = NOW(),
		estado = 'R', -- Se coloca estado R de Retiro inconforme
		usuario_cobro = pusuario, -- Reemplaza con el nombre de usuario correspondiente
		valor_cobro = vcobro,
		hora_fin = vh_hora_fin
	WHERE id_correlativo = vid_ticket;
	
SET pval = 0;
SET pmensaje = 'OK';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_datos_login_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_datos_login_usuario`(
    IN p_usuario VARCHAR(25),
    OUT p_clave VARCHAR(255),
    OUT p_ubicacion VARCHAR(50),
    OUT p_puesto VARCHAR(30),
    OUT p_id_ubicacion VARCHAR(5),
    OUT pval VARCHAR(5),
    OUT pmensaje VARCHAR(255)
)
BEGIN
	SET pval = 0;
    SET pmensaje = 'OK';
    
	SELECT us_clave, co_descripcion , cpu_puesto, us_ubicacion
    INTO p_clave, p_ubicacion, p_puesto, p_id_ubicacion
    FROM usuarios
	INNER JOIN catalogo_origenes
    ON co_id = us_ubicacion
    INNER JOIN catalogo_puestos_usuarios
    ON cpu_id = us_puesto
    WHERE us_usuario = p_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_envio_examen_visual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_envio_examen_visual`(in `pfactura` JSON, out pval int, out pmensaje text)
BEGIN
  -- Declare variable para usar después en el bucle
  -- En la proxima mejora se debe agregar la sucursal de cobro y el producto al catalogo de productos para no hacer un case
	DECLARE i INT DEFAULT 0;
	DECLARE vnum_fact INT DEFAULT 0;
	DECLARE vcodigo_prod  text;
	DECLARE vdescripcion text;
	DECLARE vvalor_unitario decimal(11,5);
	DECLARE vtotal decimal(11,5);
	DECLARE vruc_nombre_razonsocial varchar(120);
	DECLARE vruc_domicilio varchar(200);
	DECLARE vruc_nrc varchar(45);
	DECLARE vcorreo VARCHAR(100);
	DECLARE vcodigo_prod2  text;
	DECLARE vdescripcion2 text;
	DECLARE vvalor_unitario2 decimal(11,5); 

  BEGIN
    DECLARE fecha_val VARCHAR(10);
    DECLARE cantidad_val INT;
    DECLARE producto_val VARCHAR(255);
    DECLARE sucursal_val VARCHAR(10);
	DECLARE cdc_id_val int;
	DECLARE nombre_val VARCHAR(120);

    -- Inicializa el índice para el bucle
    SET i = 0;

    -- Obtén la longitud del array JSON
    SET @array_length = JSON_LENGTH(JSON_EXTRACT(pfactura, '$.myArrayList'));
    
    SET pval = 1;
    SET pmensaje = concat('REGISTRO NO INSERTADO');
    
    -- Inicia el bucle para recorrer el array JSON
    WHILE i < @array_length DO
      -- Extrae los valores del objeto JSON
      SET fecha_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fecha')));
      SET cantidad_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cantidad')));
      SET producto_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.producto')));  
      SET sucursal_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.sucursal')));
      SET cdc_id_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cdc')));
      SET nombre_val = JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.nombre')));

      -- Convierte la fecha al formato YYYY-MM-DD
      -- SET fecha_val = STR_TO_DATE(fecha_val, '%Y-%m-%d');


      -- Inserta en la tabla
      INSERT INTO tmp_factura (fecha, cantidad, producto, JSON_TEST,sucursal)
      VALUES (fecha_val, cantidad_val, producto_val, pfactura,sucursal_val);
      
      -- SELECT para cod_factura en buzoncsv
        select fact.fun_genera_numero_interno('CRONEXAMVISUALDTE', 'CRONEXAMVISUALDTE')
        INTO vnum_fact;

        
          -- En la proxima mejora se debe agregar la sucursal de cobro y el producto al catalogo de productos para no hacer un case
        IF producto_val = 'VISUAL' then
        
			SELECT codigo_prod,descripcion,valor_unitario 
			INTO vcodigo_prod, vdescripcion, vvalor_unitario 
			FROM fact.catalogo_productos
			WHERE codigo_prod = 
			case when sucursal_val = 'SER08' then 'EXVSS' 
			when  sucursal_val ='SER06' then 'EXVSA' 
			when sucursal_val ='SER07' then 'EXVSM' 
			when  sucursal_val ='SER09' then 'EXVCS'  
			when  sucursal_val ='SER10' then 'EXVPM'
			when  sucursal_val ='SER12' then 'EXVLD'
			when  sucursal_val ='DAV00' then 'EXVDAV'
			when  sucursal_val ='BAC00' then 'EXVBAC'
			end;
		
        elseif producto_val = 'NOTARIAL' then
        
			SELECT codigo_prod,descripcion,valor_unitario 
			INTO vcodigo_prod, vdescripcion, vvalor_unitario 
			FROM fact.catalogo_productos
			WHERE codigo_prod = 
			case when sucursal_val = 'SER02' then 'SNSS' 
			when  sucursal_val ='SER04' then 'SNCS' 
			end;
        
        elseif producto_val = 'CURIER' then
        
			SELECT codigo_prod,descripcion,valor_unitario 
			INTO vcodigo_prod, vdescripcion, vvalor_unitario 
			FROM fact.catalogo_productos
			WHERE codigo_prod = '25';
            
		elseif producto_val = 'AMBOS' then

			SELECT codigo_prod,descripcion,valor_unitario 
			INTO vcodigo_prod, vdescripcion, vvalor_unitario 
			FROM fact.catalogo_productos
			WHERE codigo_prod = 
			case when sucursal_val = 'SER08' then 'EXVSS' 
			when  sucursal_val ='SER06' then 'EXVSA' 
			when sucursal_val ='SER07' then 'EXVSM' 
			when  sucursal_val ='SER09' then 'EXVCS'  
			when  sucursal_val ='SER10' then 'EXVPM'
			when  sucursal_val ='SER12' then 'EXVLD'
			when  sucursal_val ='DAV00' then 'EXVDAV'
			when  sucursal_val ='BAC00' then 'EXVBAC'
			end;

        	SELECT codigo_prod,descripcion,valor_unitario 
			INTO vcodigo_prod2, vdescripcion2, vvalor_unitario2 
			FROM fact.catalogo_productos
			WHERE codigo_prod = '25';
            
        else
			SET pval = 1;
			SET pmensaje = 'Error, producto no contemplado';
		end if;

		SET vtotal = (cantidad_val*vvalor_unitario)+((cantidad_val*vvalor_unitario)*0.13);
        
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
    `tipo_doc_relacionado`,`fecha_doc_relacionado`,`tipo_generacion_doc_rel`,`descripcion_retencion`,`id_retencion`,`nombre_receptor`,`cdc_id`) 
    VALUES 
    (vnum_fact,'06140203981013','01',36,'00000000000000',vruc_nrc,vruc_nombre_razonsocial,
    vcorreo,'2133-3600','USD',1,
    '06',14,vruc_domicilio,'84110',vcodigo_prod,
    vdescripcion/*DESCRIPCION*/ ,59,2,cantidad_val/*CANTIDAD*/ ,vvalor_unitario/*PRECIO UNITARIO*/ ,0.00000,'No',20,
    13,vtotal/*CANTIDAD*PRECIO + IVA*/ ,1,'05',vtotal/*MISMO QUE EL VALOR*/ ,'','01','15',NULL,NULL,NULL,NULL,
    NULL,NULL,NOW(),'N',
    NULL,NULL,NULL,NULL,NULL,NULL,
    NULL,NULL,NULL,NULL,NULL,nombre_val,cdc_id_val);
    
    -- Establece los valores de salida
    SET pval = 0;
    SET pmensaje = concat('ÉXITO, ID DE BUZON CREADO: ', (SELECT LAST_INSERT_ID()));
    
    IF producto_val = 'AMBOS' then
    
    	INSERT INTO `buzoncsv` (`cod_factura`,`cod_emisor`,`tipodoc`,`tipodocrec`,`nit`,`nrc`,`nombrecliente`,
    `correo`,`telefono`,`moneda`,`tipocambio`,
    `depart`,`municipio`,`complemento`,`codactcom`,`codigo`,
    `detalle`,`unidad_medida`,`tipo`,`cantidad`,`precio_unitario`,`descuento`,`exento`,`codigo_`,
    `porcentaje`,`valor`,`condicionpago`,`mediopago`,`monto`,`referencia`,`plazo`,`periodo`,`tipogeneracion`,`tipodte`,`numeroautorizacion`,`fechahoraemision`,
    `tipodocidreceptor`,`bientitulo`,`fecha_migrado`,`factura_migrada`,
    `buzoncsvcol`,`tipo_item_expor`,`recinto_fiscal`,`regimen`,`codtributo`,`doc_relacionado`,
    `tipo_doc_relacionado`,`fecha_doc_relacionado`,`tipo_generacion_doc_rel`,`descripcion_retencion`,`id_retencion`,`nombre_receptor`,`cdc_id`) 
    VALUES 
    (vnum_fact,'06140203981013','01',36,'00000000000000',vruc_nrc,vruc_nombre_razonsocial,
    vcorreo,'2133-3600','USD',1,
    '06',14,vruc_domicilio,'84110',vcodigo_prod2,
    vdescripcion2/*DESCRIPCION*/ ,59,2,cantidad_val/*CANTIDAD*/ ,vvalor_unitario2/*PRECIO UNITARIO*/ ,0.00000,'No',20,
    13,vtotal/*CANTIDAD*PRECIO + IVA*/ ,1,'05',vtotal/*MISMO QUE EL VALOR*/ ,'','01','15',NULL,NULL,NULL,NULL,
    NULL,NULL,NOW(),'N',
    NULL,NULL,NULL,NULL,NULL,NULL,
    NULL,NULL,NULL,NULL,NULL,nombre_val,cdc_id_val);
    
    
    END IF;

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
/*!50003 DROP PROCEDURE IF EXISTS `pro_factura_ticket_parqueo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_factura_ticket_parqueo`(
    IN pusuario VARCHAR(50), 
    IN ptipoplaca VARCHAR(5), 
    IN papp varchar(30),
	IN pdui VARCHAR(10),
    IN pnombres VARCHAR(60),
    IN papellidos VARCHAR(60),
    IN pcantidad_horas INT,
    out pfecha_ing VARCHAR(10),
    out pcorrelativo INT,
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN

	DECLARE vultimo_correlativo INT;
    DECLARE vid_ticket INT;
    DECLARE vfecha_ing VARCHAR(10);
    DECLARE vhora TIME;
    DECLARE vulb varchar(15);
    DECLARE vcorrelativo INT;
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
	DECLARE vcortesia VARCHAR(2);

	SET pval = 0;
    SET pmensaje = 'OK';

	IF (pnombres IS NOT NULL AND papellidos IS NOT NULL) AND (pnombres <> '' AND papellidos <> '') then
			
			-- Obtener la fecha actual en formato YYYY-MM-DD
			SET vfecha_ing = DATE_FORMAT(NOW(), '%Y-%m-%d');
			
			-- Obtener la hora actual en formato HH:MM:SS
			SET vhora = DATE_SUB(CURTIME(),INTERVAL 6 HOUR); -- Se restan 6 horas en DESARROLLO por hora erronea del servidor en produccion NO se debe restar
			
            			SELECT IFNULL(MAX(secuencia_qr), 0) INTO vultimo_correlativo
			FROM tickets_parqueo
			WHERE fecha_ingreso = vfecha_ing;
			
			-- Incrementar el correlativo si la fecha de ingreso es la misma
			SET vcorrelativo = vultimo_correlativo + 1;
			
			SELECT us_ubicacion
			INTO vulb
			FROM fact.usuarios 
			WHERE us_usuario=pusuario;

			-- Insertar el nuevo registro en la tabla tickets_parqueo
			INSERT INTO tickets_parqueo ( fecha_ingreso, hora_inicio, usuario_ingreso, estado,tipo_placa, secuencia_qr,ulb_user_ingreso) 
			VALUES ( vfecha_ing, vhora, pusuario, 'P',ptipoplaca, vcorrelativo, vulb);
            
			-- retornando el correlativo del tck de parqueo insertado y la fecha de ingreso del tck de parqueo
			SET pcorrelativo = vcorrelativo;
			SET pfecha_ing = DATE_FORMAT(vfecha_ing, '%d/%m/%Y');

			-- Obtener el ID del último registro insertado
			SELECT LAST_INSERT_ID() into vid_ticket;

			IF ptipoplaca = 'M' THEN
				-- Si la placa inicia con 'M'
				SET vcodigo_prod = 'TPM1';
			ELSE
				-- Si la placa es P
				SET vcodigo_prod = 'TP1';
			END IF;

			-- SELECT para cod_factura en buzoncsv
			select fact.fun_genera_numero_interno(papp, pusuario)
			INTO vnum_fact;

			
			SELECT descripcion, valor_unitario 
			INTO  vdescripcion, vvalor_unitario 
			FROM fact.catalogo_productos
			WHERE codigo_prod = vcodigo_prod;
		
			UPDATE tickets_parqueo
			SET fecha_cobro = NOW(),
				estado = 'C', -- Se coloca estado C 
				usuario_cobro = pusuario, -- Reemplaza con el nombre de usuario correspondiente
				valor_cobro = vvalor_unitario,
				dui = pdui,
				nombres = pnombres,
				apellidos = papellidos
			WHERE id_correlativo = vid_ticket;
            
            SET vruc_nrc = NULL;
            SET vcorreo = NULL;
			
			INSERT INTO `buzoncsv` (`cod_factura`,`cod_emisor`,`tipodoc`,`tipodocrec`,`nit`,`nrc`,`nombrecliente`,
			`correo`,`telefono`,`moneda`,`tipocambio`,
			`depart`,`municipio`,`complemento`,`codactcom`,`codigo`,
			`detalle`,`unidad_medida`,`tipo`,`cantidad`,`precio_unitario`,`descuento`,`exento`,`codigo_`,
			`porcentaje`,`valor`,`condicionpago`,`mediopago`,`monto`,`referencia`,`plazo`,`periodo`,`tipogeneracion`,`tipodte`,`numeroautorizacion`,`fechahoraemision`,
			`tipodocidreceptor`,`bientitulo`,`fecha_migrado`,`factura_migrada`,
			`buzoncsvcol`,`tipo_item_expor`,`recinto_fiscal`,`regimen`,`codtributo`,`doc_relacionado`,
			`tipo_doc_relacionado`,`fecha_doc_relacionado`,`tipo_generacion_doc_rel`,`descripcion_retencion`,`id_retencion`,`nombre_receptor`) 
			VALUES 
			(vnum_fact,'06140203981013','01',36,IFNULL(REPLACE(pdui, "-", ""),'000000000'),vruc_nrc,CONCAT(CONCAT(pnombres,' '),papellidos),
			vcorreo,'2133-3600','USD',1,
			'06',14,vruc_domicilio,'84110',vcodigo_prod,
			vdescripcion/*DESCRIPCION*/ ,59,2,1/*CANTIDAD*/ ,vvalor_unitario/*PRECIO UNITARIO */ ,0.00000,'No',20,
			13,vvalor_unitario/*CANTIDAD*PRECIO + IVA*/ ,1,'05',vvalor_unitario/*total*/ ,'','01','15',NULL,NULL,NULL,NULL,
			NULL,NULL,NOW(),'N',
			NULL,NULL,NULL,NULL,NULL,NULL,
			NULL,NULL,NULL,NULL,NULL,CONCAT(CONCAT(pnombres,' '),papellidos));
			
		SET pval = 0;
		SET pmensaje = 'OK';
	ELSE
		SET pval = 1;
		SET pmensaje = 'DEBE INGRESAR LOS DATOS NOMBRES Y/O APELLIDOS';
	END IF;
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

set vexiste = 0; 
set vcod = null; 

select  IFNULL(fac_codigo_generacion,0)    into vcod   from factura
where
fac_id=pfactura ;

    
if vcod = 0 then
	ver_loop:loop	
		SELECT upper(UUID()) AS UUID_Value into codigoGeneracion;
		select 1 into vexiste   from factura
		where fac_codigo_generacion IN (codigoGeneracion);

		if vexiste != 1 then
			UPDATE fact.factura set fac_codigo_generacion=codigoGeneracion where fac_id=pfactura; 
			LEAVE ver_loop;
		end if; 
	end loop ver_loop;
else
	set codigoGeneracion =   vcod;
end if; 

select  fun_retorna_json(ptipo_fac,pfactura) into pjson;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_inserta_anulacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_inserta_anulacion`(in pmotivo varchar(200), in pfac_id int, in ptipo_anu int, in pcod_n varchar(45), out pval int, out pmensaje text)
BEGIN
DECLARE vexiste INT ;
DECLARE vexist_fac INT ;
DECLARE vcod varchar(100) ;

set pval=0;
set pmensaje = 'ok';
set vexist_fac=0;

select   1    into   vexist_fac  from factura
where
fac_id IN (pfac_id); 

if vexist_fac!=1 then

	set pval=1;
	set pmensaje = 'Id de factura ingresado no existe';

else
	if ptipo_anu > 3 or ptipo_anu < 1 then

	set pval=1;
	set pmensaje = 'Tipo de anulacion ingresado incorrecto';

	else
	set vexiste=0;
			ver_loop:loop
				
				SELECT upper(UUID()) AS UUID_Value into vcod;
				
				select   1       into vexiste   from factura
				where
				fac_codigo_generacion IN (vcod) ; 


				if vexiste != 1 then
				
				select   1       into vexiste   from detalle_anulaciones
				where
				da_codigo_generacionr IN (vcod) ; 
				
					if vexiste != 1 then
						insert into fact.detalle_anulaciones
						(da_motivo, da_fac_id, da_cti_id,da_codigo_generacionr,da_nuevo_codigo_generacion)
						values
						(pmotivo, pfac_id, ptipo_anu, pcod_n, vcod);
						
						LEAVE ver_loop;
					end if; 
					
				end if; 

			end loop ver_loop;
					
	end if;
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_inserta_buzon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_inserta_buzon`(in `pfactura` JSON, out pval int, out pmensaje text)
BEGIN
  -- Declare variable para usar después en el bucle
  -- En la proxima mejora se debe agregar la sucursal de cobro y el producto al catalogo de productos para no hacer un case
	DECLARE i INT DEFAULT 0;
	DECLARE vnum_fact INT DEFAULT 0;
    

DECLARE vcod_emisor	text;
DECLARE vtipodoc	text;
DECLARE vtipodocrec	int;
DECLARE vnit	text;
DECLARE vnrc	int;
DECLARE vnombrecliente	text;
DECLARE vcorreo	text;
DECLARE vtelefono	text;
DECLARE vmoneda	text;
DECLARE vtipocambio	int;
DECLARE vdepart	text;
DECLARE vmunicipio	int;
DECLARE vcomplemento	text;
DECLARE vcodactcom	text;
DECLARE vcodigo	text;
DECLARE vdetalle	text;
DECLARE vunidad_medida	int;
DECLARE vtipo	int;
DECLARE vcantidad	decimal(11,5);
DECLARE vprecio_unitario	decimal(11,5);
DECLARE vdescuento	decimal(11,5);
DECLARE vexento	text;
DECLARE vcodigo_	int;
DECLARE vporcentaje	int;
DECLARE vvalor	text;
DECLARE vcondicionpago	int;
DECLARE vmediopago	text;
DECLARE vmonto	text;
DECLARE vreferencia	text;
DECLARE vplazo	text;
DECLARE vperiodo	text;
DECLARE vtipogeneracion	text;
DECLARE vtipodte	text;
DECLARE vnumeroautorizacion	text;
DECLARE vfechahoraemision	text;
DECLARE vtipodocidreceptor	text;
DECLARE vbientitulo	text;
DECLARE vfecha_migrado	datetime;
DECLARE vfactura_migrada	char(1);
DECLARE vbuzoncsvcol	varchar(45);
DECLARE vtipo_item_expor	int;
DECLARE vrecinto_fiscal	varchar(2);
DECLARE vregimen	varchar(13);
DECLARE vcodtributo	varchar(2);
DECLARE vdoc_relacionado	varchar(45);
DECLARE vtipo_doc_relacionado	varchar(2);
DECLARE vfecha_doc_relacionado	datetime;
DECLARE vtipo_generacion_doc_rel	int;
DECLARE vdescripcion_retencion	varchar(45);
DECLARE vid_retencion	int;
DECLARE vnombre_receptor	varchar(120);
DECLARE vcdc_id	int;
DECLARE vid_factura	int;
DECLARE vanulacion	varchar(1);
    

  BEGIN
    -- Inicializa el índice para el bucle
    SET i = 0;

    -- Obtén la longitud del array JSON
    SET @array_length = JSON_LENGTH(JSON_EXTRACT(pfactura, '$.myArrayList'));
    
    SET pval = 1;
    SET pmensaje = concat('REGISTRO NO INSERTADO');
    
          -- SELECT cod_factura+1
		SELECT  fac_nro_factura+1
        INTO vnum_fact
		FROM fact.factura
		ORDER BY fac_id DESC
		LIMIT 1;
    
    -- Inicia el bucle para recorrer el array JSON
    WHILE i < @array_length DO
      -- Extrae los valores del objeto JSON

SET vcod_emisor	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cod_emisor')));
SET vtipodoc	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipodoc')));
SET vtipodocrec	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipodocrec')));
SET vnit	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.nit')));
SET vnrc	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.nrc')));
SET vnombrecliente	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.nombrecliente')));
SET vcorreo	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.correo')));
SET vtelefono	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.telefono')));
SET vmoneda	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.moneda')));
SET vtipocambio	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipocambio')));
SET vdepart	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.depart')));
SET vmunicipio	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.municipio')));
SET vcomplemento	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.complemento')));
SET vcodactcom	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.codactcom')));
SET vcodigo	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.codigo')));
SET vdetalle	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.detalle')));
SET vunidad_medida	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.unidad_medida')));
SET vtipo	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipo')));
SET vcantidad	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cantidad')));
SET vprecio_unitario	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.precio_unitario')));
SET vdescuento	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.descuento')));
SET vexento	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.exento')));
SET vcodigo_	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.codigo_')));
SET vporcentaje	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.porcentaje')));
SET vvalor	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.valor')));
SET vcondicionpago	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.condicionpago')));
SET vmediopago	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.mediopago')));
SET vmonto	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.monto')));
SET vreferencia	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.referencia'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.referencia'))) END ;
SET vplazo	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.plazo')));
SET vperiodo	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.periodo')));
SET vtipogeneracion	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipogeneracion'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipogeneracion'))) END;
SET vtipodte	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipodte'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipodte'))) END;
SET vnumeroautorizacion	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.numeroautorizacion'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.numeroautorizacion'))) END;
SET vfechahoraemision	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fechahoraemision'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fechahoraemision'))) END;
SET vtipodocidreceptor	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipodocidreceptor'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipodocidreceptor'))) END;
SET vbientitulo	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.bientitulo'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.bientitulo'))) END;
SET vfecha_migrado	= JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fecha_migrado')));
SET vfactura_migrada	= 'N';
SET vbuzoncsvcol	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.buzoncsvcol')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.buzoncsvcol'))) END;
SET vtipo_item_expor	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipo_item_expor')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipo_item_expor'))) END;
SET vrecinto_fiscal	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.vecinto_fiscal')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.vecinto_fiscal'))) END;
SET vregimen	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.regimen')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.regimen'))) END;
SET vcodtributo	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.codtributo')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.codtributo'))) END;
SET vdoc_relacionado	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.doc_relacionado')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.doc_relacionado'))) END;
SET vtipo_doc_relacionado	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipo_doc_relacionado')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipo_doc_relacionado'))) END;
SET vfecha_doc_relacionado	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fecha_doc_relacionado')))= 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.fecha_doc_relacionado'))) END;
SET vtipo_generacion_doc_rel	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipo_generacion_doc_rel'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.tipo_generacion_doc_rel'))) end;
SET vdescripcion_retencion	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.descripcion_retencion'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.descripcion_retencion'))) END;
SET vid_retencion	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.id_retencion'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.id_retencion'))) END;
SET vnombre_receptor	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.nombre_receptor'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.nombre_receptor'))) END;
SET vcdc_id	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cdc_id'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cdc_id'))) END;
SET vid_factura	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.id_factura'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cdc_id'))) END;
SET vanulacion	= CASE WHEN JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.anulacion'))) = 'null' then NULL ELSE JSON_UNQUOTE(JSON_EXTRACT(pfactura, CONCAT('$.myArrayList[', i, '].map.cdc_id'))) END;

      


INSERT INTO `buzoncsv` 
(`cod_factura`,`cod_emisor`,`tipodoc`,`tipodocrec`,`nit`,`nrc`,`nombrecliente`,`correo`,`telefono`,`moneda`,`tipocambio`,`depart`,`municipio`,`complemento`,`codactcom`,`codigo`,`detalle`,`unidad_medida`,`tipo`,`cantidad`,`precio_unitario`,`descuento`,`exento`,`codigo_`,`porcentaje`,`valor`,`condicionpago`,`mediopago`,`monto`,`referencia`,`plazo`,`periodo`,`tipogeneracion`,`tipodte`,`numeroautorizacion`,`fechahoraemision`,`tipodocidreceptor`,`bientitulo`,`fecha_migrado`,`factura_migrada`,`tipo_item_expor`,`recinto_fiscal`,`regimen`,`codtributo`,`doc_relacionado`,`tipo_doc_relacionado`,`fecha_doc_relacionado`,`tipo_generacion_doc_rel`,`buzoncsvcol`,`descripcion_retencion`,`id_retencion`,`nombre_receptor`,`cdc_id`,`id_factura`,`anulacion`) 
VALUES 
(vnum_fact,vcod_emisor,vtipodoc,vtipodocrec,vnit,vnrc,vnombrecliente,vcorreo,vtelefono,vmoneda,vtipocambio,vdepart,vmunicipio,vcomplemento,vcodactcom,vcodigo,vdetalle,vunidad_medida,vtipo,vcantidad,
vprecio_unitario,vdescuento,vexento,vcodigo_,vporcentaje,vvalor,vcondicionpago,vmediopago,vmonto,vreferencia,vplazo,vperiodo,vtipogeneracion,vtipodte,vnumeroautorizacion,vfechahoraemision,vtipodocidreceptor,
vbientitulo,vfecha_migrado,vfactura_migrada,vbuzoncsvcol,vtipo_item_expor,vrecinto_fiscal,vregimen,vcodtributo,vdoc_relacionado,vtipo_doc_relacionado,vfecha_doc_relacionado,vtipo_generacion_doc_rel,
vdescripcion_retencion,vid_retencion,vnombre_receptor,vcdc_id,vid_factura,vanulacion);

    
    -- Establece los valores de salida
    SET pval = 0;
    SET pmensaje = concat('ÉXITO, ID DE BUZON CREADO: ', (SELECT LAST_INSERT_ID()));
    

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
/*!50003 DROP PROCEDURE IF EXISTS `pro_inserta_copias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_inserta_copias`(
    IN pusuario VARCHAR(50), 
	IN papp varchar(30),
    IN psucursal VARCHAR(10),
    IN pdui VARCHAR (14),
    IN pnombre VARCHAR(120),
    IN papellido VARCHAR(120),
    IN pdatos JSON,
	IN ptipofactura VARCHAR(5), 
    OUT pfecha_ing VARCHAR(10),
    OUT pid_buzon int,
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN

	DECLARE i INT DEFAULT 0;
	DECLARE vnum_fact INT DEFAULT 0;
	DECLARE vruc_nombre_razonsocial varchar(245);
	DECLARE vruc_domicilio varchar(200);
	DECLARE vruc_nrc varchar(45);
	DECLARE vfecha_ing VARCHAR(10);
	DECLARE vcorreo VARCHAR(100);
	DECLARE vdescripcion text;
	DECLARE vvalor_unitario decimal(11,5);
	DECLARE vcobro DECIMAL(15, 2);
    DECLARE cantidad_val INT;
	DECLARE producto_val VARCHAR(255);
    DECLARE vus_id INT;
    DECLARE vus_ulb_id INT;

	SET pval = 0;
    SET pmensaje = 'OK';
    
		    -- Inicializa el índice para el bucle
			SET i = 0;
            
            -- Obtén la longitud del array JSON
			SET @array_length = JSON_LENGTH(JSON_EXTRACT(pdatos, '$.myArrayList'));
            
			-- Obtener la fecha actual en formato YYYY-MM-DD
			SET vfecha_ing = DATE_FORMAT(NOW(), '%Y-%m-%d');

			-- SELECT para cod_factura en buzoncsv
			select fact.fun_genera_numero_interno(papp, pusuario)
			INTO vnum_fact;
			
            SET pfecha_ing = DATE_FORMAT(vfecha_ing, '%d/%m/%Y');
            
			INSERT INTO tmp_factura (fecha, cantidad, producto, JSON_TEST,sucursal)
			VALUES (pfecha_ing, 1, 'COPIAS', pdatos,psucursal);

            -- Inicia el bucle para recorrer el array JSON
			WHILE i < @array_length DO
            
				-- Extrae los valores del objeto JSON
				SET cantidad_val = JSON_UNQUOTE(JSON_EXTRACT(pdatos, CONCAT('$.myArrayList[', i, '].map.cantidad')));
				SET producto_val = JSON_UNQUOTE(JSON_EXTRACT(pdatos, CONCAT('$.myArrayList[', i, '].map.producto')));  


				SELECT descripcion, valor_unitario 
				INTO  vdescripcion, vvalor_unitario 
				FROM fact.catalogo_productos
				WHERE codigo_prod = producto_val;
				
				SET vcobro = (IFNULL(cantidad_val,0.0) * vvalor_unitario);
				SET vruc_nombre_razonsocial = CONCAT(CONCAT(pnombre,' '),papellido);
				SET vruc_domicilio = NULL;
				SET vruc_nrc = NULL;
				SET vcorreo = NULL;
				
                IF ptipofactura = 'CCFE' THEN
					set vruc_nombre_razonsocial = null;
					SELECT concat(concat(ruc_nombre_razonsocial,' '),concat(concat(ruc_apellidos_paterno,' '),ruc_apellidos_materno)), ruc_domicilio, ruc_nrc, ruc_email_contribuyente
                    into vruc_nombre_razonsocial, vruc_domicilio, vruc_nrc, vcorreo
					FROM fact.contribuyentes
					where ruc_nit_contribuyente = pdui
					and ruc_tipo_contribuyente = 'RECEPTOR';
                    
                END IF;
                
                SELECT us_id, us_ulb_id into vus_id, vus_ulb_id
                FROM fact.usuarios
				where us_usuario = pusuario;
                
				INSERT INTO `buzoncsv` (`cod_factura`,`cod_emisor`,`tipodoc`,`tipodocrec`,`nit`,`nrc`,`nombrecliente`,
				`correo`,`telefono`,`moneda`,`tipocambio`,
				`depart`,`municipio`,`complemento`,`codactcom`,`codigo`,
				`detalle`,`unidad_medida`,`tipo`,`cantidad`,`precio_unitario`,`descuento`,`exento`,`codigo_`,
				`porcentaje`,`valor`,`condicionpago`,`mediopago`,`monto`,`referencia`,`plazo`,`periodo`,`tipogeneracion`,`tipodte`,`numeroautorizacion`,`fechahoraemision`,
				`tipodocidreceptor`,`bientitulo`,`fecha_migrado`,`factura_migrada`,
				`buzoncsvcol`,`tipo_item_expor`,`recinto_fiscal`,`regimen`,`codtributo`,`doc_relacionado`,
				`tipo_doc_relacionado`,`fecha_doc_relacionado`,`tipo_generacion_doc_rel`,`descripcion_retencion`,`id_retencion`,`nombre_receptor`,`id_usuario_ingreso`,`ulb_usuario_ingreso`) 
				VALUES 
				(vnum_fact,'06140203981013', case when ptipofactura = 'FE' then '01' else '03' end, 36,IFNULL(REPLACE(pdui, "-", ""),'000000000'),vruc_nrc,vruc_nombre_razonsocial,
				vcorreo,'2133-3600','USD',1,
				'06',14,vruc_domicilio,'84110',producto_val,
				vdescripcion/*DESCRIPCION*/ ,59,2,cantidad_val/*CANTIDAD*/ ,vvalor_unitario/*PRECIO UNITARIO */ ,0.00000,'No',20,
				13,vcobro/*CANTIDAD*PRECIO + IVA*/ ,1,'05',vcobro/*total*/ ,'','01','15',NULL,NULL,NULL,NULL,
				NULL,NULL,NOW(),'N',
				NULL,NULL,NULL,NULL,NULL,NULL,
				NULL,NULL,NULL,NULL,NULL,CONCAT(CONCAT(pnombre,' '),papellido),vus_id, vus_ulb_id);
				
			SET pid_buzon = vnum_fact;
            SET pval = 0;
			SET pmensaje = 'OK';
            
			-- Incrementa el índice del bucle
			SET i = i + 1;
            
		END WHILE; 


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_inserta_datos_tickets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_inserta_datos_tickets`(
    in pusuario VARCHAR(50), 
    in ptipo VARCHAR(5), 
	out pfecha_ing VARCHAR(10),
	out phora TIME,
    out pulb varchar(15),
    out pcorrelativo INT,
    out pval VARCHAR(2),
    out pmensaje VARCHAR(255)
)
BEGIN

	DECLARE vultimo_correlativo INT;

	SET pval = 0;
    SET pmensaje = 'OK';

    -- Obtener la fecha actual en formato YYYY-MM-DD
    SET pfecha_ing = DATE_FORMAT(NOW(), '%Y-%m-%d');
    
    -- Obtener la hora actual en formato HH:MM:SS
	SET phora = DATE_SUB(CURTIME(),INTERVAL 6 HOUR); -- Se restan 6 horas en DESARROLLO por hora erronea del servidor en produccion NO se debe restar

    SELECT IFNULL(MAX(secuencia_qr), 0) INTO vultimo_correlativo
    FROM tickets_parqueo
    WHERE fecha_ingreso = pfecha_ing;
    
    -- Incrementar el correlativo si la fecha de ingreso es la misma
    SET pcorrelativo = vultimo_correlativo + 1;
    
    SELECT us_ubicacion 
    INTO pulb
    FROM fact.usuarios 
    WHERE us_usuario=pusuario;


	-- Insertar el nuevo registro en la tabla tickets_parqueo
	INSERT INTO tickets_parqueo ( fecha_ingreso, hora_inicio, usuario_ingreso, estado,tipo_placa, secuencia_qr,ulb_user_ingreso) 
	VALUES ( pfecha_ing, phora, pusuario, 'P',ptipo, pcorrelativo, pulb);

	SET pfecha_ing = DATE_FORMAT(pfecha_ing, '%d/%m/%Y');


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_perdida_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_perdida_ticket`(
    IN pusuario VARCHAR(50), 
    IN ptipoplaca VARCHAR(5), 
    IN papp varchar(30),
	IN pdui VARCHAR(10),
    IN pnombres VARCHAR(60),
    IN papellidos VARCHAR(60),
    out pfecha_ing VARCHAR(10),
    out pcorrelativo INT,
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN

	DECLARE vultimo_correlativo INT;
    DECLARE vid_ticket INT;
    DECLARE vfecha_ing VARCHAR(10);
    DECLARE vhora TIME;
    DECLARE vulb varchar(15);
    DECLARE vcorrelativo INT;
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

	SET pval = 0;
    SET pmensaje = 'OK';

	IF (pnombres IS NOT NULL AND papellidos IS NOT NULL) AND (pnombres <> '' AND papellidos <> '') then
			
			-- Obtener la fecha actual en formato YYYY-MM-DD
			SET vfecha_ing = DATE_FORMAT(NOW(), '%Y-%m-%d');
			
			-- Obtener la hora actual en formato HH:MM:SS
			SET vhora = DATE_SUB(CURTIME(),INTERVAL 6 HOUR); -- Se restan 6 horas en DESARROLLO por hora erronea del servidor en produccion NO se debe restar

			SELECT IFNULL(MAX(secuencia_qr), 0) INTO vultimo_correlativo
			FROM tickets_parqueo
			WHERE fecha_ingreso = vfecha_ing;
			
			-- Incrementar el correlativo si la fecha de ingreso es la misma
			SET vcorrelativo = vultimo_correlativo + 1;
			
			SELECT us_ubicacion 
			INTO vulb
			FROM fact.usuarios 
			WHERE us_usuario=pusuario;

			-- Insertar el nuevo registro en la tabla tickets_parqueo
			INSERT INTO tickets_parqueo ( fecha_ingreso, hora_inicio, usuario_ingreso, estado,tipo_placa, secuencia_qr,ulb_user_ingreso) 
			VALUES ( vfecha_ing, vhora, pusuario, 'P',ptipoplaca, vcorrelativo, vulb);
			
			-- retornando el correlativo del tck de parqueo insertado y la fecha de ingreso del tck de parqueo
			SET pcorrelativo = vcorrelativo;
			SET pfecha_ing = DATE_FORMAT(vfecha_ing, '%d/%m/%Y');

			-- Obtener el ID del último registro insertado
			SELECT LAST_INSERT_ID() into vid_ticket;

			IF ptipoplaca = 'M' THEN
				-- Si la placa inicia con 'M' pero no es 'MB'
				SET vcobro = 1.25;
				SET vcodigo_prod = 'TPPM';
			ELSE
				-- Si la placa no cumple con ninguna condición especial
				SET vcobro = 2.50;
				SET vcodigo_prod = 'TPPC';
			END IF;
			
			-- Actualizar la fecha de cobro y estado en la tabla
			UPDATE tickets_parqueo
			SET fecha_cobro = NOW(),
				estado = 'E', -- Se coloca estado E de Extraviado para reportes
				usuario_cobro = pusuario, -- Reemplaza con el nombre de usuario correspondiente
				valor_cobro = vcobro,
				hora_fin = vh_hora_fin,
				dui = pdui,
				nombres = pnombres,
				apellidos = papellidos
			WHERE id_correlativo = vid_ticket;

			-- SELECT para cod_factura en buzoncsv
			select fact.fun_genera_numero_interno(papp, pusuario)
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
			13,vcobro/*CANTIDAD*PRECIO + IVA*/ ,1,'05',vcobro/*total*/ ,'','01','15',NULL,NULL,NULL,NULL,
			NULL,NULL,NOW(),'N',
			NULL,NULL,NULL,NULL,NULL,NULL,
			NULL,NULL,NULL,NULL,NULL,CONCAT(CONCAT(pnombres,' '),papellidos));
			
		SET pval = 0;
		SET pmensaje = 'OK';
	ELSE
		SET pval = 1;
		SET pmensaje = 'DEBE INGRESAR LOS DATOS NOMBRES Y/O APELLIDOS';
	END IF;
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
/*!50003 DROP PROCEDURE IF EXISTS `pro_ticket_cortesia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_ticket_cortesia`(    
    IN pcorrelativo int,
	IN pusuario_aut varchar(50),
    IN papp varchar(30),
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN

    DECLARE vexist INT;

	-- Verificar si el ticket existe
    SELECT COUNT(*) INTO vexist
    FROM tickets_parqueo
    WHERE secuencia_qr = pcorrelativo
    AND usuario_ingreso = pusuario_aut
    AND fecha_ingreso = CURDATE();
    
    IF vexist = 0 THEN
        SET pval = 1; -- Indicador de que el ticket no existe
        SET pmensaje = 'El ticket especificado no existe';
    ELSE

		-- Actualizar la fecha de cobro y estado en la tabla
		UPDATE tickets_parqueo
		SET cortesia = 'S',
        estado = 'A',
        usuario_cortesia = pusuario_aut,
        hora_cortesia = DATE_SUB(CURTIME(),INTERVAL 6 HOUR)
		WHERE secuencia_qr = pcorrelativo
        AND fecha_ingreso = CURDATE();

		SET pval = 0; -- Indicador de éxito
		SET pmensaje = 'Se agrego el indicativo de "cortesia" a el ticket correctamente';
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_tmp_pruebas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_tmp_pruebas`(out x int)
BEGIN
	declare vid_fac int;
    declare vexiste_factura int;
	declare continue handler for not found set vexiste_factura = 0;
	set vexiste_factura = 0;
	select 1
	into vexiste_factura
	from factura
	where fac_nro_factura = '10000';

	if vexiste_factura = 1 then
		select fac_id
		into vid_fac
		from factura
		where fac_nro_factura = '1';
        
        set x = vid_fac;
	else
		set x = 0;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_valida_documento_rel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_valida_documento_rel`( in pdoc varchar(36), in ptipo int, out pval int, out pmensaje text)
BEGIN

DECLARE vexist_fac INT ;

set pval=0;
set pmensaje = 'ok';
set vexist_fac=0;

select   1    into   vexist_fac  from factura
where
fac_codigo_generacion IN (pdoc)
and SUBSTRING(fac_numero_de_control,5,2) = ptipo; 

if vexist_fac<1 then

	set pval=1;
	set pmensaje = 'El documento ingresado no existe ';

end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_valida_ingreso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_valida_ingreso`( in pfac int, out pval int, out pmensaje text)
BEGIN

DECLARE vexist_fac INT ;

set pval=0;
set pmensaje = 'ok';
set vexist_fac=0;

select   1    into   vexist_fac  from factura
where
fac_nro_factura IN (pfac); 

if vexist_fac>=1 then

	set pval=1;
	set pmensaje = 'El número de factura ingresado ya existe';

end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pro_verifica_receptor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `pro_verifica_receptor`(
    IN pusuario VARCHAR(50), 
	IN papp varchar(30),
    IN pnit VARCHAR(45), 
    OUT pnombre VARCHAR(120),
	OUT papellido VARCHAR(120),
    OUT pval int,
    OUT pmensaje VARCHAR(255)
)
BEGIN
	DECLARE vcod varchar(2) ;
    
	SET pval = 0;
    SET pmensaje = 'OK';
    
	SELECT 1, ruc_nombre_razonsocial,concat(concat(ruc_apellidos_paterno,' '),ruc_apellidos_materno) into vcod, pnombre, papellido
	FROM fact.contribuyentes
	where ruc_nit_contribuyente = pnit
	and ruc_tipo_contribuyente = 'RECEPTOR';

	If ifnull(vcod,0) = 1 then
		SET pmensaje = 'Ok, registro encontrado';
	else 
		SET pval = 1;
        set pnombre = null;
        set papellido = null;
		SET pmensaje = 'No posee datos registrados para el NIT seleccionado, por ser un tipo de factura credito fiscal debe crear el registro';
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_codigoGeneracion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_codigoGeneracion`(out nofac varchar(100))
BEGIN 
#devuelve el codigoGeneracion, cuya funcion es identificar el documento electronico.
    declare existcad varchar(100) ;
    SELECT upper(UUID()) into existcad  from dual   WHERE  EXISTS (  select distinct fac_codigo_generacion  FROM fact.factura);       
    SELECT upper(UUID()) into nofac from dual;
  if (existcad = nofac) then 
  SELECT upper(UUID()) into nofac from dual;
    end if;
/*if contador =0 then update fact.factura set  fac_codigo_generacion=nofac; end if; */
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_estados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_estados`()
begin
select *
from estados ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_generacion_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_generacion_json`(in ptipo_fac varchar(15), in pfactura VARCHAR(15), out pjson json, out codigoGeneracion varchar(100))
BEGIN 
#devuelve el codigoGeneracion, cuya funcion es identificar el documento electronico.

select  fun_retorna_json(ptipo_fac,pfactura) into pjson;
SELECT upper(UUID()) AS UUID_Value into codigoGeneracion;

select codigoGeneracion;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_generacion_serie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_generacion_serie`(
in contador varchar(15) ,out nofac varchar(15))
BEGIN 
 SELECT LPAD(contador,15,'0') INTO nofac  FROM DUAL;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_secuencia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_historial_secuencia`(
in anio varchar(4),
in tipodoc varchar(2),
in codcontribuyente varchar(8),
in nosec varchar(15))
BEGIN 
#se agrega a la tabla historial de secuencias
insert into nosecuencia_factura   values(anio,tipodoc,codcontribuyente,nosec) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_jsoncreditofiscal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_jsoncreditofiscal`(in nofact varchar(100),in nitcontribuyente varchar(15) ,out jsoncadena varchar(4000))
BEGIN
select (
 SELECT JSON_OBJECT(
   'identificacion',
	   JSON_OBJECT(
			'version',1,
			'ambiente', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'version'),
			'tipoDte',fac_tipo_comprobante,
			'numeroControl',fac_numero_de_control, 
			'codigoGeneracion',fac_codigo_generacion,
			'tipoModelo',(SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoModelo'),
			'tipoOperacion',(SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoOperacion'),
			'tipoContingencia',null,
			'motivoContin',null,
			'fecEmi', DATE_FORMAT(fac_fecha_emision, '%Y-%m-%d'),
			'horEmi', DATE_FORMAT(fac_fecha_emision, '%H:%i:%s'),
			'tipoMoneda', (SELECT pgn_valor FROM fact.parametros_generales where pgn_campo = 'tipoMoneda') 
		),
   'documentoRelacionado', null,
   'emisor',
	   JSON_OBJECT(
		   'nit', REPLACE(a.ruc_nit_contribuyente, "-", ""),
		   'nrc',a.ruc_ncr , /*"1047582"dato correcto compartido por Miguel*/
		   'nombre', a.ruc_nombre_razonsocial,
		   'codActividad',a.ruc_codactividad , /*"94990"Dato correcto de actividad confirmado con Miguel al revisar el NIT de SERTRACEN*/
		   'descActividad', a.ruc_desactividad,
		   'nombreComercial', a.ruc_nombre_razonsocial,
		   'tipoEstablecimiento', a.ruc_tipoestablecimiento,
		   'direccion',
			   JSON_OBJECT(
				   'departamento', a.ruc_codigo_departamento,
				   'municipio', a.ruc_codigo_municipio,
				   'complemento', a.ruc_domicilio
				),
		   'telefono', a.ruc_telefono_personal,
           'correo', a.ruc_email_contribuyente,
		   'codEstable', a.ruc_codigo_mh,
           'codPuntoVenta', null,
           'codEstableMH', a.ruc_codigo_mh,
		   'codPuntoVentaMH', null
		),
        
        
	'receptor',
	   JSON_OBJECT(
			'nrc', b.ruc_ncr,
			'nombre', b.ruc_nombre_razonsocial,
			'codActividad', b.ruc_codactividad,
            'descActividad', b.ruc_desactividad,
            'direccion',
			   JSON_OBJECT(
				   'departamento', b.ruc_codigo_departamento,
				   'municipio', b.ruc_codigo_municipio,
				   'complemento', b.ruc_domicilio
				),
			'telefono', b.ruc_telefono_personal,
			'correo', b.ruc_email_contribuyente,
			'nombreComercial', b.ruc_nombre_razonsocial,
			'numDocumento',REPLACE(b.ruc_nit_contribuyente, "-", "")
       ),
       
       'otrosDocumentos', null,
       'ventaTercero',  JSON_OBJECT(
       'nit',REPLACE(b.ruc_nit_contribuyente, "-", ""),
       'nombre', b.ruc_nombre_razonsocial
        ),
       'cuerpoDocumento', (SELECT JSON_ARRAYAGG(JSON_OBJECT('numItem',det_fac_numlinea,
            'tipoItem',3,
            'numeroDocumento',null,
            'cantidad',det_fac_cantidad,
            'codigo', det_fac_nro_factura,
            'codTributo',det_fac_tributo,
            'uniMedida',det_fac_unidad_de_medida,
            'descripcion',det_fac_descripcion,
            'precioUni',det_fac_preciounitario,
            'montoDescu',det_montoDescu,
            'ventaNoSuj',det_fac_ventasnosujet,
            'ventaExenta',det_fac_ventasexentas,
            'ventaGravada',det_fact_ventasgravadas,
            'tributos',det_tributo,
            'psv',det_psv,
            'noGravado',det_no_gravado,
            'ivaItem',det_fact_iva))
			FROM factura_detalle WHERE det_fac_id = fac_id),  
       'resumen',
			JSON_OBJECT(
            'totalNoSuj', fac_ventasnosujet_tot,
            'totalExenta', fac_ventasexentas_tot,
            'totalGravada', fac_ventasgravadas_tot,
            'subTotalVentas', fac_subtotal,#RECORDAR A MOI CREAR fac_subtotal,
            'descuNoSuj', fac_descuento_nosuje,
            'descuExenta', fac_descuento_exent,
            'descuGravada', fac_descuento_grab,
            'porcentajeDescuento', fac_porcen_descuento,
            'totalDescu', fac_tot_descuento,
            'tributos', (SELECT JSON_ARRAYAGG(JSON_OBJECT('codigo', tri_codigo,
				'descripcion', tri_descripcion,
				'valor', tri_valor))
				FROM tributos WHERE tri_fac_id = fac_id),
            'subTotal',fac_subtotal,#RECORDAR A MOI CREAR fac_subtotal,
            'ivaPerci1',fac_iva_porcent,
            'ivaRete1', fac_iva_retenido,
            'reteRenta', fac_retencion_renta,
            'montoTotalOperacion', fac_total_pagar,
            'totalNoGravado', fac_total_nograbado,
            'totalPagar', fac_total_pagar,
            'totalLetras', fac_total_letras,/**/
			'saldoFavor', fac_saldo_favor,
            'condicionOperacion', 2,
            'pagos', null,   
            'numPagoElectronico', null
            ),
		'extension',
			JSON_OBJECT(
				'nombEntrega',  null,
                'docuEntrega',  null,
                'nombRecibe', null,
                'docuRecibe', null,
                'observaciones', null,
                'placaVehiculo', null
            ),
            'apendice', null
)
FROM factura, contribuyentes as a, contribuyentes as b
where a.ruc_nit_contribuyente = fac_nit_emisor
and b.ruc_nit_contribuyente = nitcontribuyente /*'0614-250693-102-0'*/
and factura.fac_id =nofact
AND factura.fac_tipo_documento in(  SELECT tcp_idtipo FROM fact.tipos_comprobantes where tcp_comprobante= tipodoc)  ) into jsoncadena from dual  ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_jsonsujecexcluido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_jsonsujecexcluido`(in nofact varchar(100),in tipodoc varchar(3) ,out jsoncadena varchar(4000))
BEGIN
/*SUJETO EXCLUIDO*/
select (SELECT 
    JSON_OBJECT('identificacion',
            JSON_OBJECT('version',
                    1,
                    'ambiente',
                    '00',
                    'tipoDte',
                    fac_tipo_comprobante,
                    'numeroControl',
                    fac_numero_de_control,
                    'codigoGeneracion',
                    fac_codigo_generacion,
                    'tipoModelo',
                    1,
                    'tipoOperacion',
                    1,
                    'tipoContingencia',
                    NULL,
                    'motivoContin',
                    NULL,
                    'fecEmi',
                    DATE_FORMAT(fac_fecha_emision, '%Y-%m-%d'),
                    'horEmi',
                    DATE_FORMAT(fac_fecha_emision, '%H:%i:%s'),
                    'tipoMoneda',
                    'USD'),
            'emisor',
            JSON_OBJECT('nit',
                    REPLACE(a.ruc_nit_contribuyente,
                        '-',
                        ''),
                    'nrc',
                    fac_ncr,
                    'nombre',
                    a.ruc_nombre_razonsocial,
                    'codActividad',
                    a.ruc_codactividad,
                    'descActividad',
                    a.ruc_desactividad,
                    'direccion',
                    JSON_OBJECT('departamento',
                            a.ruc_codigo_departamento,
                            'municipio',
                            a.ruc_codigo_municipio,
                            'complemento',
                            a.ruc_domicilio),
                    'telefono',
                    REPLACE(a.ruc_telefono_personal,
                        '-',
                        ''),
                    'codigoEstableMH',
                    a.ruc_codigo_mh,
                    'codigoEstable',
                    a.ruc_codigo_mh,
                    'codPuntoVentaMH',
                    NULL,
                    'codPuntoVenta',
                    NULL,
                    'correo',
                    a.ruc_email_contribuyente),
            'sujetoExcluido',
            JSON_OBJECT('tipoDocumento',
                    fac_tipo_documento,
                    'numDocumento',
                    NULL,
                    'nombre',
                    a.ruc_nombre_razonsocial,
                    'codActividad',
                    a.ruc_codactividad,
                    'descActividad',
                    a.ruc_desactividad,
                    'direccion',
                    JSON_OBJECT('departamento',
                            a.ruc_codigo_departamento,
                            'municipio',
                            a.ruc_codigo_municipio,
                            'complemento',
                            a.ruc_domicilio),
                    'telefono',
                    a.ruc_telefono_personal,
                    'correo',
                    a.ruc_email_contribuyente),
            'cuerpoDocumento',
            (SELECT 
                    JSON_ARRAYAGG(JSON_OBJECT('numItem',
                                        det_fac_numlinea,
                                        'tipoItem',
                                        det_fac_tipo_item,
                                        'cantidad',
                                        det_fac_cantidad,
                                        'codigo',
                                        det_fac_nro_factura,
                                        'uniMedida',
                                        det_fac_unidad_de_medida,
                                        'descripcion',
                                        det_fac_descripcion,
                                        'precioUni',
                                        det_fac_preciounitario,
                                        'montoDescu',
                                        det_montoDescu,
                                        'compra',
                                        NULL))
                FROM
                    factura_detalle
                WHERE
                    det_fac_id = fac_id),
            'resumen',
            JSON_OBJECT('totalCompra',
                    fac_total_pagar,
                    'descu',
                    fac_descuento_grab,
                    'totalDescu',
                    fac_tot_descuento,
                    'subTotal',
                    fac_sumas_detalle,
                    'ivaRete1',
                    fac_iva_retenido,
                    'reteRenta',
                    fac_retencion_renta,
                    'totalPagar',
                    fac_total_pagar,
                    'totalLetras',
                    fac_total_letras,
                    'condicionOperacion',
                    NULL,
                    'pagos',
                    JSON_ARRAY(JSON_OBJECT('codigo',
                                    NULL,
                                    'montoPago',
                                    NULL,
                                    'referencia',
                                    NULL,
                                    'plazo',
                                    NULL,
                                    'periodo',
                                    NULL)),
                    'observaciones',
                    NULL),
            'apendice',
            (SELECT 
                    JSON_ARRAYAGG(JSON_OBJECT('campo',
                                        ape_campo,
                                        'etiqueta',
                                        ape_etiqueta,
                                        'valor',
                                        ape_valor))
                FROM
                    apendice
                WHERE
                    ape_fac_id = fac_id
                ORDER BY ape_fac_id))
FROM
    factura,
    contribuyentes AS a,
    contribuyentes AS b
WHERE
    a.ruc_nit_contribuyente = fac_nit_emisor
        AND b.ruc_nit_contribuyente = fac_nit_receptor
        AND fac_id = nofact
        AND factura.fac_tipo_comprobante in(  SELECT tcp_idtipcom FROM fact.tipos_comprobantes where tcp_comprobante= tipodoc)
        ) into jsoncadena from dual  ; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_newfactura_enc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_newfactura_enc`(
in fac_nro_factura int(15),
in fecha_emision datetime,
in giro varchar(100),
in factnit varchar(20),
in telefono varchar(15),
in razonsocial varchar(100),
in retenido decimal(15,2),
in suma_detalle decimal(15,2),
in fac_total_pagar decimal(15,2),
in firmadigital blob,
in ncr varchar(45) ,
in id_estadofac int,
in codigo_generacion varchar(45),
in numero_control varchar(45),
in tipodoc int,
in sello_recepcion blob,
in total_iva decimal(15,2),
in tipo_comporbante varchar(2),
in ventajanosujet_tot decimal (15,2),
in ventasexentas_tot decimal (15,2),
in ventasgravadas decimal(15,2),
in iva_retenido decimal(15,2),
in saldo_favor decimal(15,2),
in totalnograbado decimal(15,2),
in descuento_nosujeto decimal(15,2),
in descuento_exent decimal(15,2) ,
in retencion_renta decimal(15,2),
in tot_descuento  decimal(15,2),
in total_letras varchar(100),
in descuent_grab  decimal(15,2),
in porcentaje_descuento decimal(15,2),
in tributo decimal(15,2),out nofactid int )
BEGIN
select count(fac_id) into nofactid  where fac_nro_factura =fac_nro_factura;
if nofactid =0 then
insert into factura values ( fac_nro_factura , fecha_emision , giro , factnit , telefono , razonsocial , retenido , suma_detalle ,
 fac_total_pagar, firmadigital , ncr  , id_estadofac , codigo_generacion , numero_control, tipodoc , sello_recepcion , total_iva ,
 tipo_comporbante, ventajanosujet_tot, ventasexentas_tot , ventasgravadas , iva_retenido , saldo_favor , totalnograbado ,descuento_nosujeto ,
 descuento_exent ,retencion_renta,tot_descuento , total_letras,descuent_grab  , porcentaje_descuento , tributo );
 end if;
 select fac_id into nofactid  where fac_nro_factura =fac_nro_factura;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nocontrol_factura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_nocontrol_factura`(
in tipocat varchar(3),
in tipodoc varchar(2),
in cod_contribuyente varchar(8),
in serie varchar(15),out nofac varchar(31))
BEGIN 
#devuelve la secuencia del numero de control de la factura 
select CONCAT(tipocat,"-",tipodoc,"-",cod_contribuyente,"-",serie) INTO nofac;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nocontrol_facturanew` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_nocontrol_facturanew`(
in numfacture varchar(100) ,out nofac varchar(31))
BEGIN 
declare NOSERIE int;
declare numfact varchar(100); 
declare numserie varchar(100);

select Cast(numfacture as UNSIGNED) into NOSERIE  from dual ;
set NOSERIE=NOSERIE+1;

select Cast(NOSERIE as char(100)) into  numfact from dual ;
#devuelve la secuencia del numero de control de la factura  CONCAT(tipocat,"-",tipodoc,"-",cod_contribuyente,"-",serie)
SELECT LPAD(numfact,15,'0') INTO numserie  FROM DUAL;
select CONCAT(tcp_comprobante,"-",tcp_idtipcom,"-",ruc_codigo_mh,"-", numserie ) INTO nofac
from factura ,contribuyentes,tipos_comprobantes  
where factura.fac_nit_emisor=contribuyentes.ruc_nit_contribuyente
and  factura.fac_nro_factura =numfacture
and factura.fac_tipo_comprobante=tipos_comprobantes.tcp_idtipcom  ;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Numeros_a_Letras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_Numeros_a_Letras`(IN lnEntero varchar(1000),out lcRetorno varchar(1000) )
BEGIN
 
DECLARE lnTerna INT;
DECLARE lcMiles VARCHAR(512);
DECLARE lcCadena VARCHAR(512);
DECLARE lnUnidades INT;
DECLARE lnDecenas INT;
DECLARE lnCentenas INT;

IF Cast(lnEntero as UNSIGNED) > 0 THEN
SET lcRetorno = '';
SET lnTerna = 1 ;

WHILE Cast(lnEntero as UNSIGNED)  > 0 DO

-- Recorro columna por columna
SET lcCadena = '';

SET lnUnidades = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;

SET lnDecenas = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;

SET lnCentenas = RIGHT(lnEntero,1);
SET lnEntero = LEFT(lnEntero,LENGTH(lnEntero)-1) ;
-- Analizo las unidades
SET lcCadena =
CASE /* UNIDADES */
WHEN Cast(lnUnidades as UNSIGNED) = 1 AND lnTerna = 1 THEN CONCAT('UNO ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED)= 1 AND lnTerna <> 1 THEN CONCAT('UN',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED) = 2 THEN CONCAT('DOS ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED) = 3 THEN CONCAT('TRES ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED) = 4 THEN CONCAT('CUATRO ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED) = 5 THEN CONCAT('CINCO ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED) = 6 THEN CONCAT('SEIS ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED) = 7 THEN CONCAT('SIETE ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED)= 8 THEN CONCAT('OCHO ',lcCadena)
WHEN Cast(lnUnidades as UNSIGNED) = 9 THEN CONCAT('NUEVE ',lcCadena)
ELSE lcCadena
END ;/* UNIDADES */

-- Analizo las decenas
SET lcCadena =
CASE /* DECENAS */
WHEN Cast(lnDecenas as UNSIGNED)  = 1 THEN
CASE Cast(lnUnidades as UNSIGNED)
WHEN 0 THEN 'DIEZ '
WHEN 1 THEN 'ONCE '
WHEN 2 THEN 'DOCE '
WHEN 3 THEN 'TRECE '
WHEN 4 THEN 'CATORCE '
WHEN 5 THEN 'QUINCE '
ELSE CONCAT('DIECI',lcCadena)
END
WHEN Cast(lnDecenas as UNSIGNED) = 2 AND Cast(lnUnidades as UNSIGNED)  = 0 THEN CONCAT('VEINTE ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED)= 2 AND Cast(lnUnidades as UNSIGNED) <> 0 THEN CONCAT('VEINTI',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 3 AND Cast(lnUnidades as UNSIGNED) = 0 THEN CONCAT('TREINTA ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED)= 3 AND Cast(lnUnidades as UNSIGNED) <> 0 THEN CONCAT('TREINTA Y ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 4 AND Cast(lnUnidades as UNSIGNED) = 0 THEN CONCAT('CUARENTA ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED)= 4 AND Cast(lnUnidades as UNSIGNED) <> 0 THEN CONCAT('CUARENTA Y ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 5 AND Cast(lnUnidades as UNSIGNED) = 0 THEN CONCAT('CINCUENTA ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 5 AND Cast(lnUnidades as UNSIGNED) <> 0 THEN CONCAT('CINCUENTA Y ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED)= 6 AND Cast(lnUnidades as UNSIGNED) = 0 THEN CONCAT('SESENTA ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 6 AND Cast(lnUnidades as UNSIGNED) <> 0 THEN CONCAT('SESENTA Y ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED)= 7 AND Cast(lnUnidades as UNSIGNED) = 0 THEN CONCAT('SETENTA ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 7 AND Cast(lnUnidades as UNSIGNED)<> 0 THEN CONCAT('SETENTA Y ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED)= 8 AND Cast(lnUnidades as UNSIGNED) = 0 THEN CONCAT('OCHENTA ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 8 AND Cast(lnUnidades as UNSIGNED)<> 0 THEN CONCAT('OCHENTA Y ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED) = 9 AND Cast(lnUnidades as UNSIGNED) = 0 THEN CONCAT('NOVENTA ',lcCadena)
WHEN Cast(lnDecenas as UNSIGNED)= 9 AND Cast(lnUnidades as UNSIGNED) <> 0 THEN CONCAT('NOVENTA Y ',lcCadena)
ELSE lcCadena
END ;/* DECENAS */

-- Analizo las centenas
SET lcCadena =
CASE /* CENTENAS */
WHEN Cast(lnCentenas as UNSIGNED)  = 1 AND lnUnidades = 0 AND  Cast(lnDecenas as UNSIGNED) = 0 THEN CONCAT('CIEN ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED) AND NOT(lnUnidades = 0 AND Cast(lnDecenas as UNSIGNED) = 0) THEN CONCAT('CIENTO ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED)=2 THEN CONCAT('DOSCIENTOS ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED)=3 THEN CONCAT('TRESCIENTOS ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED)=4 THEN CONCAT('CUATROCIENTOS ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED) = 5 THEN CONCAT('QUINIENTOS ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED) = 6 THEN CONCAT('SEISCIENTOS ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED) = 7 THEN CONCAT('SETECIENTOS ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED) = 8 THEN CONCAT('OCHOCIENTOS ',lcCadena)
WHEN Cast(lnCentenas as UNSIGNED) = 9 THEN CONCAT('NOVECIENTOS ',lcCadena)
ELSE lcCadena
END ;/* CENTENAS */



-- Analizo los millares
SET lcCadena =
CASE /* TERNA */
WHEN Cast(lnTerna as UNSIGNED) = 1 THEN lcCadena
WHEN Cast(lnTerna as UNSIGNED) = 2 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL ')
WHEN Cast(lnTerna as UNSIGNED) = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' MILLON ')
WHEN Cast(lnTerna as UNSIGNED) = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' MILLONES ')
WHEN Cast(lnTerna as UNSIGNED) = 4 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL MILLONES ')
WHEN Cast(lnTerna as UNSIGNED) = 5 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' BILLON ')
WHEN Cast(lnTerna as UNSIGNED) = 5 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' BILLONES ')
WHEN Cast(lnTerna as UNSIGNED) = 6 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL BILLONES ')
WHEN Cast(lnTerna as UNSIGNED) = 7 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN CONCAT(lcCadena,' TRILLON ')
WHEN Cast(lnTerna as UNSIGNED) = 7 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN CONCAT(lcCadena,' TRILLONES ')
WHEN Cast(lnTerna as UNSIGNED) = 8 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena,' MIL TRILLONES ')
ELSE ''
END ;/* MILLARES */


-- Armo el retorno columna a columna
SET lcRetorno = CONCAT(lcCadena,lcRetorno);

SET lnTerna = lnTerna + 1;

END WHILE ; /* WHILE */
ELSE
SET lcRetorno = 'CERO' ;
END IF ;

SELECT RTRIM(lcRetorno) ;

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

-- Dump completed on 2025-05-19 22:31:23
