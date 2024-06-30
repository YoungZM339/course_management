-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: course_management
-- ------------------------------------------------------
-- Server version	8.4.0

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

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID，唯一标识每门课程',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '课程名称',
  `term` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '学期',
  `school` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '开设课程的学院',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (2,'高等数学','2024秋','粮食和物资储备学院'),(3,'离散数学','2023春','信息科学与工程学院'),(4,'大学物理','2023秋','土木工程（建筑）学院'),(5,'机械制图','2024春','机电工程学院'),(6,'工程力学','2023春','机电工程学院'),(7,'机械制造基础','2023春','机电工程学院'),(8,'电工与电子技术','2023秋','机电工程学院'),(9,'粮食化学','2024秋','粮油食品学院'),(10,'有机化学','2023春','粮油食品学院'),(11,'粮食化学实验','2023秋','粮食和物资储备学院'),(12,'岩土力学','2023春','土木工程（建筑）学院'),(13,'流体力学','2024秋','土木工程（建筑）学院'),(14,'给水排水工程','2024秋','土木工程（建筑）学院'),(15,'施工技术与管理','2023秋','土木工程（建筑）学院'),(16,'电磁场与微波技术','2024春','信息科学与工程学院'),(17,'信号与信息处理','2023春','信息科学与工程学院'),(18,'通信与网络技术','2023春','信息科学与工程学院'),(19,'数字电子技术','2024春','人工智能与大数据学院'),(20,'模拟电路基础','2024秋','人工智能与大数据学院'),(21,'数据结构','2024春','人工智能与大数据学院');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_teacher`
--

DROP TABLE IF EXISTS `course_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_teacher` (
  `course_id` bigint NOT NULL COMMENT '课程的主键',
  `teacher_id` bigint NOT NULL COMMENT '教师的主键',
  PRIMARY KEY (`course_id`,`teacher_id`),
  KEY `FKsb9lnio7h0a885b871ogw0ajg` (`teacher_id`),
  CONSTRAINT `FKrna6ik293g84mo3rslnkk7m1a` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `FKsb9lnio7h0a885b871ogw0ajg` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_teacher`
--

LOCK TABLES `course_teacher` WRITE;
/*!40000 ALTER TABLE `course_teacher` DISABLE KEYS */;
INSERT INTO `course_teacher` VALUES (2,2),(9,2),(5,3),(10,3),(11,3),(3,5),(19,5),(12,6),(6,7),(7,8),(17,8),(20,8),(4,9),(8,9),(19,9),(13,10),(14,11),(15,12),(16,12),(2,13),(17,13),(18,13),(14,14),(17,14),(18,14),(21,14);
/*!40000 ALTER TABLE `course_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '教师ID，唯一标识每位教师',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '教师姓名',
  `school` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '教师所属学院',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (2,'赵仁勇','粮油食品学院'),(3,'孙尚德','粮油食品学院'),(5,'刘昆仑','粮食和物资储备学院'),(6,'张玉荣','粮食和物资储备学院'),(7,'张小彩','机电工程学院'),(8,'郭永刚','机电工程学院'),(9,'丁永刚','土木工程（建筑）学院'),(10,'陈桂香','土木工程（建筑）学院'),(11,'李卫东','信息科学与工程学院'),(12,'吕宗旺','信息科学与工程学院'),(13,'杨卫东','人工智能与大数据学院'),(14,'刘於勋','人工智能与大数据学院');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'course_management'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-01  4:08:37
