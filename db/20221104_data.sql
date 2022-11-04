/*
SQLyog Community v13.1.8 (64 bit)
MySQL - 10.4.24-MariaDB : Database - YoriJori
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`YoriJori` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `YoriJori`;

/*Table structure for table `attr` */

DROP TABLE IF EXISTS `attr`;

CREATE TABLE `attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `typeCode` char(30) NOT NULL,
  `type2Code` char(70) NOT NULL,
  `value` text NOT NULL,
  `expireDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relTypeCode` (`relTypeCode`,`relId`,`typeCode`,`type2Code`),
  KEY `relTypeCode_2` (`relTypeCode`,`typeCode`,`type2Code`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

/*Data for the table `attr` */

insert  into `attr`(`id`,`regDate`,`updateDate`,`relTypeCode`,`relId`,`typeCode`,`type2Code`,`value`,`expireDate`) values 
(1,'2022-10-29 17:54:06','2022-10-29 17:54:06','member',3,'extra','memberModifyAuthKey','jco0qs7hg5','2022-10-29 17:59:06'),
(4,'2022-10-30 10:20:38','2022-10-30 11:35:27','member',4,'extra','memberModifyAuthKey','jwyc0lsrd9','2022-10-30 11:40:27'),
(19,'2022-10-30 11:38:35','2022-10-30 11:38:35','member',5,'extra','memberModifyAuthKey','2dappztt24','2022-10-30 11:43:35');

/*Table structure for table `board` */

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `code` char(50) NOT NULL COMMENT 'sort,method,content,free...',
  `boardName` char(50) NOT NULL COMMENT '종류,방법,재료,상황...',
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=삭제)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `boardName` (`boardName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `board` */

insert  into `board`(`id`,`regDate`,`updateDate`,`code`,`boardName`,`delStatus`) values 
(1,'2022-10-29 17:33:17','2022-10-29 17:33:17','sort','종류',0),
(2,'2022-10-29 17:33:17','2022-10-29 17:33:17','method','방법',0),
(3,'2022-10-29 17:33:17','2022-10-29 17:33:17','content','재료',0),
(4,'2022-10-29 17:33:17','2022-10-29 17:33:17','free','상황',0);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `boardId` int(10) unsigned NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `name` char(50) NOT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=삭제)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;

/*Data for the table `category` */

insert  into `category`(`id`,`regDate`,`updateDate`,`boardId`,`relId`,`name`,`delStatus`) values 
(1,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,1,'밑반찬',0),
(2,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,2,'메인반찬',0),
(3,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,3,'국/탕/찌게',0),
(4,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,4,'밥/죽',0),
(5,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,5,'면/국수',0),
(6,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,6,'장류',0),
(7,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,7,'소스/양념',0),
(8,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,8,'한식',0),
(9,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,9,'중식',0),
(10,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,10,'일식',0),
(11,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,11,'양식',0),
(12,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,12,'동남아식',0),
(13,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,13,'베이커리',0),
(14,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,14,'음료/차',0),
(15,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,1,'볶기',0),
(16,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,2,'굽기',0),
(17,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,3,'끓이기',0),
(18,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,4,'찜',0),
(19,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,5,'조림',0),
(20,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,6,'튀김',0),
(21,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,7,'삶기',0),
(22,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,8,'데치기',0),
(23,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,9,'무치기',0),
(24,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,10,'전/부침',0),
(25,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,1,'소고기',0),
(26,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,2,'돼지고기',0),
(27,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,3,'닭고기',0),
(28,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,4,'생선류',0),
(29,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,5,'갑각류',0),
(30,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,6,'해조류',0),
(31,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,7,'건어물류',0),
(32,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,8,'과일류',0),
(33,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,9,'채소류',0),
(34,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,10,'버섯류',0),
(35,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,11,'견과류/곡류',0),
(36,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,12,'쌀/밀',0),
(37,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,13,'달걀/유제품',0),
(38,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,14,'구황작물',0),
(39,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,15,'가공식품',0),
(40,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,1,'술안주',0),
(41,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,2,'해장',0),
(42,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,3,'야식',0),
(43,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,4,'다이어트',0),
(44,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,5,'간편식',0),
(45,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,6,'영양식',0),
(46,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,7,'도시락',0),
(47,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,8,'기념일',0),
(48,'2022-10-29 17:33:17','2022-10-29 17:33:17',4,9,'집들이',0);

/*Table structure for table `cookingOrder` */

DROP TABLE IF EXISTS `cookingOrder`;

CREATE TABLE `cookingOrder` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `recipeId` int(10) unsigned NOT NULL,
  `body` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `cookingOrder` */

insert  into `cookingOrder`(`id`,`regDate`,`updateDate`,`recipeId`,`body`) values 
(1,'2022-10-29 18:05:13','2022-10-29 18:09:09',1,'감자를 얇게 썰어주세요@전분기를 빼도록 물에 담가주세요\r\n그 사이 양파를 썰고 볶아주세요@양파가 절반 정도 익으면 감자와 함께 볶아주세요'),
(2,'2022-10-29 18:05:16','2022-11-04 16:30:03',2,'갈비대 핏물을 빼주세요@양념을 미리 섞어서 준비해주세요\r\n설탕이 다 녹을때까지  잘 저어주세요@생수1병과 양념을 고기에 넣고 강불에 끓여주세요@그동안 감자, 양파, 당근 등 야채를 썰어서 넣어주세요@불은 바글바글 끓는 정도를 유지해주세요\r\n중간중간 거품기를 걷어내면서 물을 채워주세요\r\n국물이 쫄아들어 색깔진해면 완성'),
(3,'2022-10-29 18:05:19','2022-10-29 18:07:22',3,'파스타면 삶을 물에 소금과 올리브오일을 넣고 면을 삶아주세요.@마늘은 편으로 썰고 베이컨도 잘게 썰어주세요.@팬에 올리브오일을 넣고 마늘을 볶아 마늘기름을 만들어주세요. 노릇해지면 베이컨과 함께 볶아주세요@파스타면과 소금을 넣고 면이 익을때까지 볶아주세요@접시에 담고 파슬리를 뿌려 마무리'),
(4,'2022-10-29 18:14:34','2022-10-29 18:14:34',4,'잘씻은 방풍나물을 준비해주세요@마늘과 들기름을 나물과 무쳐주세요'),
(5,'2022-10-30 11:38:14','2022-10-30 11:38:14',5,'양파를 준비'),
(6,'2022-10-31 09:24:58','2022-10-31 09:24:58',6,'장조림용고기나, 불고기감, 등심 등 소고기면 괜찮아요\r\n적당한 크기로 썰어주세요@대파가 많이 들어가야 맛이 나요\r\n고기보다 약간 크게 파를 썰고 볶아주세요@숨이죽을때까지 볶은 뒤, 참기름을 두르고 고기와 함께 볶아주세요@고기가 익은 뒤 고춧가루를 넣어주세요\r\n자칫 탈수있으니, 약불로@이제 물을 붓고 끓여주세요@끓이면서 다른 야채를 준비\r\n버섯, 고사리 등 야채를 썰고, 국간장과 다진마늘을 넣어주세요@야채가 뭉게질때까지 끓여주세요\r\n그리고 불린당면을 넣으면 완성@+ 취향에 따라 계란을 풀어보세요\r\n먹을 만큼 덜어서 다른 냄비에서 계란푼 버전으로 즐겨보는 건 어떨까요'),
(7,'2022-10-31 11:01:42','2022-10-31 11:01:42',7,'돼지고기기름이 빠지도록 최소 10분정도 끓여주세요@그 사이에 김치를 썰고\r\n원하는 야채를 준비하세요@김치를 넣고, 고춧가루 야채를 함께 끓이기'),
(8,'2022-10-31 11:10:30','2022-10-31 11:10:30',8,'양파를 정말 얇게, 최선을 다해서 얇게 다져주세요\r\n피클로 얇게 다져주시고, 없다면 양파를 더 넣어주세요@그릇에 마요네즈와 양파를 잘 섞고\r\n나머지 설탕, 레몬즙, 소금후추를 섞어주세요\r\n레몬즙1T or 매실액 1T or 설탕 1스푼 추가'),
(9,'2022-10-31 12:46:19','2022-10-31 14:59:04',9,'가지썰기\r\n가지를 반으로 가르고 썰어주세요@양파와 다른 야채를 썰어주세요@파기름을 내고 야채와 가지를 볶아주세요\r\n중불에 가지가 반쯤 투명해질때까지@간장부터 기름에 눌리듯이 넣고 다른 양념을 넣고 버무리듯 볶아주세요@불을 끄고 다진 청양고추를 잔열에 볶아주면 완성'),
(10,'2022-10-31 12:51:12','2022-10-31 12:51:12',10,'조리순서'),
(11,'2022-11-04 16:43:48','2022-11-04 16:54:25',11,'갈비 핏물을 빼주세요\r\n최소 2시간 보통 반나절까지 빼면 충분합니다.@모든 양념을 넣고 잘섞어주세요@당근, 야채 등 을 썰어주새요\r\n손님이 오신다면 모서리를 살짝 둥글게 다듬으면 보기 좋답니다.@핏물을 뺀 갈비를 데쳐요\r\n끓는 물에 불순물이 떠오르면 1분쯤 지나서 물에 행구세요@찬물에 고기를 행구고 양념장을 붓습니다.@이제 한시간이상 푹 익혀야해요\r\n자박자박한 상태가 되도록 물이 너무 없으면 채워주세요@고기가 부드러워질 정도에 야채를 넣어 익히면 완성'),
(12,'2022-11-04 17:58:56','2022-11-04 17:58:56',12,'고기를 먹기 좋은 크기로 썰어주세요@마늘은 반 가르고, 양파는 채썰기\r\n대파는 송송 어슷썰기@모든 양념을 섞어주세요\r\n고춧가루가 있는 경우, 냉장고에 10분정도 숙성해서 쓰면 좋아요@씻은 콩나물을 깔고 그 위에 고기와 대파를 올려주세요\r\n이때 콩나물 1/3은 남겨주세요@고기 위에 다시 콩나물 올리고, 양념을 넣어주세요@물을 넣어주세요\r\n(살짝만 넣어서 들췄을때 깔릴정도로만)@뚜껑을 덮지 말고, 숨이 죽은 콩나물과 재료들이 섞일 때까지 익혀주세요\r\n어느정도 풀어지면 뒤적여주세요@익으면 깨를 뿌려완성, 매운걸 좋아하시면 고춧가루나 청양고추를 추가해보세요');

/*Table structure for table `genFile` */

DROP TABLE IF EXISTS `genFile`;

CREATE TABLE `genFile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `relTypeCode` char(50) NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `originFileName` varchar(100) NOT NULL,
  `fileExt` char(10) NOT NULL,
  `typeCode` char(20) NOT NULL,
  `type2Code` char(20) NOT NULL,
  `fileSize` int(10) unsigned NOT NULL,
  `fileExtTypeCode` char(10) NOT NULL,
  `fileExtType2Code` char(10) NOT NULL,
  `fileNo` smallint(2) unsigned NOT NULL,
  `fileDir` char(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relId` (`relTypeCode`,`relId`,`typeCode`,`type2Code`,`fileNo`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

/*Data for the table `genFile` */

insert  into `genFile`(`id`,`regDate`,`updateDate`,`delDate`,`delStatus`,`relTypeCode`,`relId`,`originFileName`,`fileExt`,`typeCode`,`type2Code`,`fileSize`,`fileExtTypeCode`,`fileExtType2Code`,`fileNo`,`fileDir`) values 
(1,'2022-10-29 17:40:22','2022-10-29 17:40:22',NULL,0,'recipe',1,'감자볶음.jpg','jpg','extra','mainRecipeImg',592203,'img','jpg',1,'2022_10'),
(2,'2022-10-29 17:40:44','2022-10-29 17:40:44',NULL,0,'recipe',2,'소갈비찜.png','png','extra','mainRecipeImg',1026617,'img','png',1,'2022_10'),
(3,'2022-10-29 17:41:44','2022-10-29 17:41:44',NULL,0,'recipe',3,'로제파스타.jpg','jpg','extra','mainRecipeImg',231976,'img','jpg',1,'2022_10'),
(4,'2022-10-29 17:53:52','2022-10-29 17:53:52',NULL,0,'member',2,'이몽룡.jpg','jpg','extra','profileImg',58662,'img','jpg',1,'2022_10'),
(5,'2022-10-29 17:54:13','2022-10-29 17:54:13',NULL,0,'member',3,'성춘향2.jpg','jpg','extra','profileImg',27908,'img','jpg',1,'2022_10'),
(7,'2022-10-30 11:20:22','2022-10-30 11:20:22',NULL,0,'member',4,'user.png','png','extra','profileImg',19456,'img','png',1,'2022_10'),
(8,'2022-10-31 09:24:58','2022-10-31 09:24:58',NULL,0,'recipe',6,'육개장.jpg','jpg','extra','mainRecipeImg',332863,'img','jpg',1,'2022_10'),
(10,'2022-10-31 12:49:52','2022-10-31 12:49:52',NULL,0,'order',9,'가지01.jpg','jpg','extra','recipeOrderImg',27341,'img','jpg',1,'2022_10'),
(11,'2022-10-31 12:49:52','2022-10-31 12:49:52',NULL,0,'order',9,'가지02.jpg','jpg','extra','recipeOrderImg',61360,'img','jpg',3,'2022_10'),
(12,'2022-10-31 12:49:52','2022-10-31 12:49:52',NULL,0,'order',9,'가지03.jpg','jpg','extra','recipeOrderImg',96485,'img','jpg',4,'2022_10'),
(13,'2022-10-31 12:49:52','2022-10-31 12:49:52',NULL,0,'order',9,'가지.jpg','jpg','extra','recipeOrderImg',92210,'img','jpg',5,'2022_10'),
(14,'2022-10-31 13:18:13','2022-10-31 13:18:13',NULL,0,'recipe',9,'가지볶음완성.JPG','jpg','extra','mainRecipeImg',52936,'img','jpg',1,'2022_10'),
(16,'2022-10-31 14:59:04','2022-10-31 14:59:04',NULL,0,'order',9,'양파.jpg','jpg','extra','recipeOrderImg',98721,'img','jpg',2,'2022_10'),
(18,'2022-10-31 15:34:08','2022-10-31 15:34:08',NULL,0,'reply',6,'로제파스타.jpg','jpg','extra','reviewImg',231976,'img','jpg',1,'2022_10'),
(19,'2022-11-04 16:22:10','2022-11-04 16:22:10',NULL,0,'member',6,'홍길동.jpg','jpg','extra','profileImg',128276,'img','jpg',1,'2022_11'),
(20,'2022-11-04 16:43:48','2022-11-04 16:43:48',NULL,0,'recipe',11,'소갈비찜.png','png','extra','mainRecipeImg',1026617,'img','png',1,'2022_11'),
(21,'2022-11-04 16:54:25','2022-11-04 16:54:25',NULL,0,'order',11,'소갈비찜01.JPG','jpg','extra','recipeOrderImg',48476,'img','jpg',1,'2022_11'),
(22,'2022-11-04 16:54:25','2022-11-04 16:54:25',NULL,0,'order',11,'소갈비찜02.JPG','jpg','extra','recipeOrderImg',45183,'img','jpg',2,'2022_11'),
(23,'2022-11-04 16:54:25','2022-11-04 16:54:25',NULL,0,'order',11,'소갈비찜03.JPG','jpg','extra','recipeOrderImg',44154,'img','jpg',3,'2022_11'),
(24,'2022-11-04 16:54:25','2022-11-04 16:54:25',NULL,0,'order',11,'소갈비찜04.JPG','jpg','extra','recipeOrderImg',60687,'img','jpg',4,'2022_11'),
(25,'2022-11-04 16:54:25','2022-11-04 16:54:25',NULL,0,'order',11,'소갈비찜05.JPG','jpg','extra','recipeOrderImg',68288,'img','jpg',5,'2022_11'),
(26,'2022-11-04 16:54:25','2022-11-04 16:54:25',NULL,0,'order',11,'소갈비찜06.JPG','jpg','extra','recipeOrderImg',72557,'img','jpg',6,'2022_11'),
(27,'2022-11-04 16:54:25','2022-11-04 16:54:25',NULL,0,'order',11,'소갈비찜07.JPG','jpg','extra','recipeOrderImg',58298,'img','jpg',7,'2022_11'),
(28,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'recipe',12,'KakaoTalk_20221104_162305059.jpg','jpg','extra','mainRecipeImg',823510,'img','jpg',1,'2022_11'),
(29,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059_08.jpg','jpg','extra','recipeOrderImg',720300,'img','jpg',1,'2022_11'),
(30,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059_07.jpg','jpg','extra','recipeOrderImg',697827,'img','jpg',2,'2022_11'),
(31,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059_06.jpg','jpg','extra','recipeOrderImg',682941,'img','jpg',3,'2022_11'),
(32,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059_04.jpg','jpg','extra','recipeOrderImg',738801,'img','jpg',4,'2022_11'),
(33,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059_03.jpg','jpg','extra','recipeOrderImg',707902,'img','jpg',5,'2022_11'),
(34,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059_02.jpg','jpg','extra','recipeOrderImg',641446,'img','jpg',6,'2022_11'),
(35,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059_01.jpg','jpg','extra','recipeOrderImg',740301,'img','jpg',7,'2022_11'),
(36,'2022-11-04 17:58:56','2022-11-04 17:58:56',NULL,0,'order',12,'KakaoTalk_20221104_162305059.jpg','jpg','extra','recipeOrderImg',823510,'img','jpg',8,'2022_11');

/*Table structure for table `guide` */

DROP TABLE IF EXISTS `guide`;

CREATE TABLE `guide` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `recipeId` int(10) unsigned NOT NULL DEFAULT 0,
  `sortId` int(10) unsigned NOT NULL DEFAULT 0,
  `methodId` int(10) unsigned NOT NULL DEFAULT 0,
  `contentId` int(10) unsigned NOT NULL DEFAULT 0,
  `freeId` int(10) unsigned NOT NULL DEFAULT 0,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '삭제여부(0=삭제전,1=삭제)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `guide` */

insert  into `guide`(`id`,`regDate`,`updateDate`,`recipeId`,`sortId`,`methodId`,`contentId`,`freeId`,`delStatus`) values 
(1,'2022-10-29 17:33:17','2022-10-29 18:09:09',1,1,1,13,0,0),
(2,'2022-10-29 17:33:17','2022-11-04 16:30:03',2,8,4,1,6,0),
(3,'2022-10-29 17:33:17','2022-10-29 18:07:22',3,5,1,12,5,0),
(4,'2022-10-29 18:14:34','2022-10-29 18:14:34',4,0,9,9,0,0),
(5,'2022-10-30 11:38:14','2022-10-30 11:38:14',5,0,0,0,0,0),
(6,'2022-10-31 09:24:58','2022-10-31 09:24:58',6,8,3,1,0,0),
(7,'2022-10-31 11:01:42','2022-10-31 11:01:42',7,8,3,2,0,0),
(8,'2022-10-31 11:10:30','2022-10-31 11:10:30',8,7,0,0,0,0),
(9,'2022-10-31 12:46:19','2022-10-31 14:59:04',9,1,0,9,0,0),
(10,'2022-10-31 12:51:12','2022-10-31 12:51:12',10,0,0,0,0,0),
(11,'2022-11-04 16:43:48','2022-11-04 16:54:25',11,2,4,1,0,0),
(12,'2022-11-04 17:58:56','2022-11-04 17:58:56',12,2,1,2,0,0);

/*Table structure for table `ingredient` */

DROP TABLE IF EXISTS `ingredient`;

CREATE TABLE `ingredient` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `recipeId` int(10) unsigned NOT NULL DEFAULT 0,
  `rowArr` varchar(50) NOT NULL DEFAULT '',
  `rowValueArr` varchar(50) NOT NULL DEFAULT '',
  `sauceArr` varchar(50) NOT NULL DEFAULT '',
  `sauceValueArr` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `ingredient` */

insert  into `ingredient`(`id`,`regDate`,`updateDate`,`recipeId`,`rowArr`,`rowValueArr`,`sauceArr`,`sauceValueArr`) values 
(1,'2022-10-29 17:33:17','2022-10-29 18:09:09',1,'감자,당근,양파','3개,1/3개,1/2개','굴소스(선택),소금,후추','1T,약간,약간'),
(2,'2022-10-29 17:33:17','2022-11-04 16:30:03',2,'소갈비,감자,당근,대파','800g,2개,1/2개,1대','설탕,맛술,진간장,다진마늘,생강,참기름','1/2컵,1/2컵,1컵,1컵'),
(3,'2022-10-29 17:33:17','2022-10-29 18:07:22',3,'파스타면,마늘,베이컨 또는 새우,양파','500원크기,4개,1줌,1/3개','토마토소스,생크림,치즈','120ml,170ml,1장'),
(4,'2022-10-29 18:14:34','2022-10-29 18:14:34',4,'방풍나물','한봉지','들기름,다진마늘','4T,1T'),
(5,'2022-10-30 11:38:14','2022-10-30 11:38:14',5,'양파','1개','',''),
(6,'2022-10-31 09:24:58','2022-10-31 09:24:58',6,'소고기,숙주,대파,표고,고사리','300g,취향껏,3대이상 넉넉히,한줌,한줌','마늘,국간장,소금후추,고춧가루','1T,2T,약간,3T'),
(7,'2022-10-31 11:01:42','2022-10-31 11:01:42',7,'돼지고기,잘익은 김치','반근,1밥그릇','고춧가루,국간장,새우젓','1T,1T,1T'),
(8,'2022-10-31 11:10:30','2022-10-31 11:10:30',8,'양파,피클','1/3개,3T','마요네즈,레몬즙,설탕,소금후추','7T,1T,2T,약간'),
(9,'2022-10-31 12:46:19','2022-10-31 14:59:04',9,'가지,대파 흰부분,양파,청양고추','3개,1대,반개,반개','간장,설탕,고춧가루,다진마늘','2T,1T,1T,1T(크게)'),
(10,'2022-10-31 12:51:12','2022-10-31 12:51:12',10,'재료1','1개','양념4','1T'),
(11,'2022-11-04 16:43:48','2022-11-04 16:54:25',11,'소갈바,당근,표고버섯,감자','2.2kg,1컵,1개,4개','간배,간양파,진간장,설탕,참기름,다진마늘,다진대파,생강(선택),올리고당,후추','1/2개,1/2개,3/4컵,1컵,1/2컵,1/2컵,3큰술,1대,1/2큰술,3큰술'),
(12,'2022-11-04 17:58:56','2022-11-04 17:58:56',12,'돼지고기,대파,콩나물,마늘,양파','500g,1/2대,2줌,10개,1/2개','고추장,고춧가루,간장,설탕,다진마늘','5T,4T,2T,3T,2T');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `loginId` char(30) NOT NULL,
  `loginPw` varchar(100) NOT NULL,
  `authLevel` smallint(2) unsigned DEFAULT 3 COMMENT '(3=일반, 7=관리자)',
  `nickname` char(20) NOT NULL,
  `cellphoneNo` char(30) NOT NULL,
  `email` char(50) NOT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '탈퇴여부(0=탈퇴전, 1=탈퇴)',
  `delDate` datetime DEFAULT NULL COMMENT '탈퇴날짜',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `member` */

insert  into `member`(`id`,`regDate`,`updateDate`,`loginId`,`loginPw`,`authLevel`,`nickname`,`cellphoneNo`,`email`,`delStatus`,`delDate`) values 
(1,'2022-10-29 17:33:17','2022-10-29 17:33:17','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',7,'관리자','010-1234-1234','admin@gmail.com',0,NULL),
(2,'2022-10-29 17:33:17','2022-10-29 17:33:17','test1','1b4f0e9851971998e732078544c96b36c3d01cedf7caa332359d6f1d83567014',3,'몽룡','010-7890-7890','test1@gmail.com',0,NULL),
(3,'2022-10-29 17:33:17','2022-10-29 17:54:13','test2','60303ae22b998861bce3b28f33eec1be758a213c86c93c076dbe9f558c11c752',3,'춘향','010-9631-9631','test2@gmail.com',0,NULL),
(4,'2022-10-30 08:37:22','2022-10-30 11:20:22','user1','0a041b9462caa4a31bac3567e0b6e6fd9100787db2ab433d96f6d178cabfce90',3,'유저A','010-1234-1234','user1@gmail.com',1,'2022-10-30 11:35:28'),
(5,'2022-10-30 11:37:30','2022-10-30 11:37:30','user1','0a041b9462caa4a31bac3567e0b6e6fd9100787db2ab433d96f6d178cabfce90',3,'유저A','010-1234-1234','user1@gmail.com',0,'2022-10-30 11:38:39'),
(6,'2022-11-04 16:22:10','2022-11-04 16:22:10','test3','fd61a03af4f77d870fc21e05e7e80678095c92d808cfb3b5c279ee04c74aca13',3,'홍길동','010-8253-5482','test3@gmail.com',0,NULL);

/*Table structure for table `reactionPoint` */

DROP TABLE IF EXISTS `reactionPoint`;

CREATE TABLE `reactionPoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `point` smallint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `reactionPoint` */

insert  into `reactionPoint`(`id`,`regDate`,`updateDate`,`memberId`,`relTypeCode`,`relId`,`point`) values 
(1,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,'recipe',1,1),
(2,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,'recipe',2,1),
(4,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,'recipe',3,1),
(5,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,'recipe',1,1),
(6,'2022-10-31 13:43:26','2022-10-31 13:43:26',3,'recipe',9,1);

/*Table structure for table `recipe` */

DROP TABLE IF EXISTS `recipe`;

CREATE TABLE `recipe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `title` char(100) NOT NULL,
  `body` text NOT NULL,
  `amount` int(10) unsigned NOT NULL DEFAULT 1,
  `time` int(10) unsigned NOT NULL DEFAULT 5,
  `level` int(10) unsigned NOT NULL DEFAULT 1 COMMENT '(1=누구나, 2=초급, 3=중급, 4=고급)',
  `guideId` int(10) unsigned NOT NULL DEFAULT 0,
  `ingredientId` int(10) unsigned NOT NULL DEFAULT 0,
  `hitCount` int(10) unsigned NOT NULL DEFAULT 0,
  `goodRP` int(10) unsigned NOT NULL DEFAULT 0,
  `scrap` int(10) unsigned NOT NULL DEFAULT 0,
  `tip` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `recipe` */

insert  into `recipe`(`id`,`regDate`,`updateDate`,`memberId`,`title`,`body`,`amount`,`time`,`level`,`guideId`,`ingredientId`,`hitCount`,`goodRP`,`scrap`,`tip`) values 
(1,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,'감자볶음','손쉽게 만들어요.',3,15,1,1,1,475,193,194,NULL),
(3,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,'로제파스타','한번만 먹어본 사람은 없다.',2,20,3,3,3,189,141,186,NULL),
(4,'2022-10-29 18:14:34','2022-10-29 18:14:34',2,'방풍나물무침','향긋하게',1,10,1,4,4,2,0,0,''),
(6,'2022-10-31 09:24:58','2022-10-31 09:24:58',2,'육개장','쌀쌀할때 얼큰하게 한 그릇',5,60,2,6,6,1,0,0,'푹 끓이는게 포인트니깐 여유롭게 시간잡으세요\r\n남은 양을 보관해야 한다면, 상할위험이 있으니 다른 냄비에 덜어서 끓이면 돼요'),
(7,'2022-10-31 11:01:42','2022-10-31 11:01:42',3,'춘향표 김치찌게','내 입맛에 딱',2,15,1,7,7,7,0,1,''),
(8,'2022-10-31 11:10:30','2022-10-31 11:10:30',2,'연어소스','연어에 찍어먹는 새콤한 소스 어렵지 않아요\r\n튀김에도 잘어울려요',1,5,1,8,8,6,0,0,'레몬즙이 없다면 매실액으로 해보세요\r\n매실액이 없다면 설탕 한스푼 한스푼반을 추가해보세요'),
(9,'2022-10-31 12:46:19','2022-10-31 14:59:04',3,'가지볶음','매콤한 가지볶음을 소개합니다.',3,10,1,9,9,20,1,0,''),
(11,'2022-11-04 16:43:48','2022-11-04 16:54:25',2,'야들야들 소갈비찜','생각보다 어렵지 않아요\r\n정성과 시간이 필요할 뿐',4,120,1,11,11,6,0,0,'핏물을 뺄 시간이 부족하면 30분 이우엔 새로 설탕을 섞은 물에 고기를 담가 주세요'),
(12,'2022-11-04 17:58:56','2022-11-04 17:58:56',6,'콩나물 불고기','고기가 부족할때 꽤 좋은 방법 콩나물!',3,20,1,12,12,1,0,1,'처음 넣을땐 콩나물이 넘칠듯해도 금새 숨이 죽으니 걱정말고 넣으세요');

/*Table structure for table `reply` */

DROP TABLE IF EXISTS `reply`;

CREATE TABLE `reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `body` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relTypeCode` (`relTypeCode`,`relId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `reply` */

insert  into `reply`(`id`,`regDate`,`updateDate`,`memberId`,`relTypeCode`,`relId`,`body`) values 
(1,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,'recipe',1,'간단한게 먹기 좋아요 맛있어요!'),
(2,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,'recipe',2,'오늘 저녁에 함 해봐야겠어요.'),
(4,'2022-10-30 17:54:00','2022-10-30 17:54:00',5,'recipe',3,'면은 몇 분정도 삶아야 하나요?'),
(5,'2022-10-30 17:54:42','2022-10-30 17:54:42',5,'recipe',2,'맛있게 잘먹었네요 감사합니다~'),
(6,'2022-10-31 15:22:32','2022-10-31 15:34:08',2,'recipe',3,'베이컨과 새우를 추가해봤어요~~');

/*Table structure for table `scrapPoint` */

DROP TABLE IF EXISTS `scrapPoint`;

CREATE TABLE `scrapPoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `point` smallint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `scrapPoint` */

insert  into `scrapPoint`(`id`,`regDate`,`updateDate`,`memberId`,`relTypeCode`,`relId`,`point`) values 
(1,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,'recipe',1,1),
(2,'2022-10-29 17:33:17','2022-10-29 17:33:17',1,'recipe',2,1),
(3,'2022-10-29 17:33:17','2022-10-29 17:33:17',2,'recipe',1,1),
(4,'2022-10-29 17:33:17','2022-10-29 17:33:17',3,'recipe',3,1),
(5,'2022-10-31 11:13:49','2022-10-31 11:13:49',2,'recipe',7,1),
(7,'2022-11-04 17:59:05','2022-11-04 17:59:05',6,'recipe',12,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
