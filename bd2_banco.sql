DROP DATABASE IF EXISTS `skateshop`;
CREATE DATABASE `skateshop`;
USE `skateshop`;


DROP TABLE IF EXISTS `seller`;
CREATE TABLE `buyer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `alternative_phone` varchar(50),
  `document` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
);

LOCK TABLES `seller` WRITE;
INSERT INTO `seller` VALUES (1,'luan','luan@gmail.com','BR','1234-3123',null,'000-837-271/78'),
                          (2,'marcio','marcio@gmail.com','BR','0000-3123',null,'111-837-271/29'),
                          (3,'ricardo','ricardo@gmail.com','BR','8888-3123','8291-28172','222-837-271/90');
UNLOCK TABLES;


DROP TABLE IF EXISTS `seller`;
CREATE TABLE `seller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `reputation` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `alternative_phone` varchar(50),
  `document` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
);

LOCK TABLES `seller` WRITE;
INSERT INTO `seller` VALUES (1,'gabriel',5,'gabrielarraesbarbosa@gmail.com','BR','7833-3123',null,'082-837-271/78'),
                          (2,'Kenniston',8,'kenniston@gmail.com','BR','9827-3123',null,'087-837-271/29'),
                          (4,'thiago',10,'thiagoarraes@gmail.com','BR','8827-3123','8291-28172','083-837-271/90');
UNLOCK TABLES;

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `zipcode` int NOT NULL,
  `street` int NOT NULL,
  `address_type` int NOT NULL,
  `seller_id` int DEFAULT NULL,
  `buyer_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seller_ibfk_1` (`seller_id`),
  CONSTRAINT `seller_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`)
);

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `image` varchar(512) NOT NULL,
  `description` varchar(8000) NOT NULL,
  `material` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `size` float NOT NULL,
  `size_unity` varchar(45) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`)
);

LOCK TABLES `product` WRITE;
INSERT INTO `product` VALUES (1,'Shape','Element','Nyjah',400,'https','Shape de maple normal','Maple','Roxo',8,'Polegadas',40),(2,'Rodas ','spitfire','Luan Oliveira',250,'https','Rodas para skate de street','silicone','branca',52,'milímetros',50),(3,'Shape','Flip','Luan Oliveira',300,'https','Shape de maple','Maple','verde',8,'Polegadas',20);
UNLOCK TABLES;

DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(512) NOT NULL,
  `stock` int NOT NULL,
  `description` varchar(8000) NOT NULL,
  `reputation` int NOT NULL,
  `product_id` int NOT NULL,
  `seller_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `announcement_ibfk_2` (`seller_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `announcement_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`)
);

LOCK TABLES `announcement` WRITE;
INSERT INTO `announcement` VALUES (1,'shape da element',40,'shape de street',10,1,1),(6,'Shape da element',40,'Shape de Street',10,1,1),(7,'Shape da Flip Luan',6,'Shape de Street Luan Oliveira',8,3,1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `payment_method`;
CREATE TABLE `payment_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
);

LOCK TABLES `payment_method` WRITE;
INSERT INTO `payment_method` VALUES (1,'pix'),(2,'credit card');
UNLOCK TABLES;

DROP TABLE IF EXISTS `announcement_payment`;
CREATE TABLE `announcement_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_id` int NOT NULL,
  `announcement_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `announcement_id` (`announcement_id`),
  KEY `payment_id` (`payment_id`),
  CONSTRAINT `announcement_payment_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment_method` (`id`),
  CONSTRAINT `announcement_payment_ibfk_2` FOREIGN KEY (`announcement_id`) REFERENCES `announcement` (`id`)
);

LOCK TABLES `announcement_payment` WRITE;
INSERT INTO `announcement_payment` VALUES (1,1,1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `shipping`;
CREATE TABLE `shipping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
);

LOCK TABLES `shipping` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `announcement_shipping`;
CREATE TABLE `announcement_shipping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_announcement` int NOT NULL,
  `id_shipping` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_announcement` (`id_announcement`),
  KEY `id_shipping` (`id_shipping`),
  CONSTRAINT `announcement_shipping_ibfk_1` FOREIGN KEY (`id_announcement`) REFERENCES `announcement` (`id`),
  CONSTRAINT `announcement_shipping_ibfk_2` FOREIGN KEY (`id_shipping`) REFERENCES `shipping` (`id`)
);


LOCK TABLES `announcement_shipping` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(8000) NOT NULL,
  `announcement_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `annoucement_id` (`announcement_id`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`announcement_id`) REFERENCES `announcement` (`id`)
);

LOCK TABLES `question` WRITE;
INSERT INTO `question` VALUES (1,'produto realmente de qualidade?',1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(8000) DEFAULT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`)
);

LOCK TABLES `answer` WRITE;
INSERT INTO `answer` VALUES (1,'sim funciona',1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `seller_product`;
CREATE TABLE `seller_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `seller_product_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`id`),
  CONSTRAINT `seller_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
);

LOCK TABLES `seller_product` WRITE;
INSERT INTO `seller_product` VALUES (1,1,1);
UNLOCK TABLES;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
	`id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `username` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

LOCK TABLES `user` WRITE;
INSERT INTO `user` Values (1,"Gabriel Arraes Barbosa","gabriel","$e0801$mtX4BXHDE5B83DkzNuUWJdDuPpJTDv51qyxdvLBVsBNxdWbCZ1oFpW2ENi+jaCid5Dsl636HxkHzGdj74fpTrw==$7fIds25YhVaqPneBXslakjza1TU870Pjqa51TfHnVPQ=");
INSERT INTO `user` Values (2,"Kenniston Arraes Bonfim","kenniston","$e0801$mtX4BXHDE5B83DkzNuUWJdDuPpJTDv51qyxdvLBVsBNxdWbCZ1oFpW2ENi+jaCid5Dsl636HxkHzGdj74fpTrw==$7fIds25YhVaqPneBXslakjza1TU870Pjqa51TfHnVPQ=");
UNLOCK TABLES;

DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
	`id` int NOT NULL AUTO_INCREMENT,
    `user_id` int NOT NULL,
    `authority` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`),
    CONSTRAINT `authority_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
);

LOCK TABLES `authority` WRITE;
INSERT INTO `authority` Values (1,1,"ADMIN");
INSERT INTO `authority` Values (2,2,"USER");
UNLOCK TABLES;

CREATE USER 'gabriel123'@'localhost' IDENTIFIED BY 'gabriel1234';
CREATE USER 'gabriel34231'@'localhost' IDENTIFIED BY 'gabriel12345';
GRANT ALL ON skateshop.* TO 'gabriel123'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE  ON skateshop.* TO 'gabriel34231'@'localhost';

