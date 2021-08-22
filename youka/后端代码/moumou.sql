/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.34-log : Database - moumou
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`moumou` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `moumou`;

/*Table structure for table `coupon` */

DROP TABLE IF EXISTS `coupon`;

CREATE TABLE `coupon` (
  `yid` int(8) NOT NULL AUTO_INCREMENT COMMENT '优惠券id',
  `ytitle` varchar(30) DEFAULT NULL COMMENT '优惠券名称',
  `pri` int(8) DEFAULT NULL COMMENT '优惠券价格',
  `date` datetime DEFAULT NULL COMMENT '领取时间',
  `day` int(11) DEFAULT NULL COMMENT '有效时间',
  `duetime` datetime DEFAULT NULL COMMENT '到期时间',
  `isling` tinyint(1) DEFAULT '0' COMMENT '是否被领取',
  `btn` varchar(30) DEFAULT NULL COMMENT '立即领取',
  KEY `yid` (`yid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `coupon` */

insert  into `coupon`(`yid`,`ytitle`,`pri`,`date`,`day`,`duetime`,`isling`,`btn`) values 
(1,'新人饮品抵用金',20,NULL,15,NULL,1,'立即领取'),
(2,'满30元抵用金',3,NULL,3,NULL,0,'立即领取'),
(3,'满40元抵用金',5,NULL,5,NULL,0,'立即领取'),
(4,'满50元抵用金',8,NULL,8,NULL,0,'立即领取');

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `class_id` int(11) DEFAULT NULL COMMENT '商品大类',
  `c_id` int(11) DEFAULT NULL COMMENT '商品细类',
  `goods_name` varchar(32) CHARACTER SET gb2312 DEFAULT NULL COMMENT '商品名称',
  `goods_price` varchar(32) CHARACTER SET gb2312 DEFAULT NULL COMMENT '商品单价',
  `goods_status` int(1) DEFAULT NULL COMMENT '0--缺货 1--近期上架 2--上架',
  `goods_path` varchar(32) CHARACTER SET gb2312 DEFAULT NULL COMMENT '商品图片地址',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `goods` */

insert  into `goods`(`goods_id`,`class_id`,`c_id`,`goods_name`,`goods_price`,`goods_status`,`goods_path`) values 
(1,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `goods_category` */

DROP TABLE IF EXISTS `goods_category`;

CREATE TABLE `goods_category` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品种类id',
  `category_name` varchar(30) NOT NULL COMMENT '商品种类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `goods_category` */

insert  into `goods_category`(`id`,`category_name`) values 
(1,'生椰家族'),
(2,'夏日冰咖'),
(3,'瑞纳冰'),
(4,'大师咖啡'),
(5,'甜品小点'),
(6,'元气满满'),
(7,'颜值水杯'),
(8,'糕点零食');

/*Table structure for table `goods_class` */

DROP TABLE IF EXISTS `goods_class`;

CREATE TABLE `goods_class` (
  `class_ids` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `class_name` varchar(16) CHARACTER SET cp1250 DEFAULT NULL COMMENT '商品大类名称',
  `class_id` int(11) DEFAULT NULL COMMENT '商品大类id',
  PRIMARY KEY (`class_ids`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `goods_class` */

/*Table structure for table `goods_details` */

DROP TABLE IF EXISTS `goods_details`;

CREATE TABLE `goods_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品详情id',
  `category_id` smallint(5) NOT NULL COMMENT '商品种类id',
  `goods_name` varchar(30) NOT NULL COMMENT '商品名称',
  `goods_price` decimal(3,1) NOT NULL COMMENT '商品价格',
  `goods_count` smallint(5) DEFAULT NULL COMMENT '商品数量',
  `goods_wendu` varchar(30) DEFAULT '冰' COMMENT '商品温度',
  `goods_img` varchar(50) DEFAULT NULL COMMENT '商品图片',
  `googs_ds` varchar(64) DEFAULT NULL COMMENT '商品描述',
  `love` tinyint(1) DEFAULT '0' COMMENT '收藏',
  `goods_sug` varchar(30) DEFAULT '标准糖',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

/*Data for the table `goods_details` */

insert  into `goods_details`(`id`,`category_id`,`goods_name`,`goods_price`,`goods_count`,`goods_wendu`,`goods_img`,`googs_ds`,`love`,`goods_sug`) values 
(1,1,'瓦尔登蓝椰拿铁',35.0,NULL,'冰','/image/sheng1.png','蓝色梦幻  夏日梦幻',1,'标准糖'),
(8,2,'热恋蜜瓜气泡美式',29.0,NULL,'冰','/image/xia3.png',NULL,0,'标准糖'),
(9,2,'冰海盐芝士厚乳拿铁',32.0,NULL,'冰','/image/xia4.png',NULL,0,'标准糖'),
(10,2,'西柚冰萃咖啡',29.0,NULL,'冰','/image/xia5.png',NULL,0,'标准糖'),
(11,3,'粉荔荔瑞纳冰',38.0,NULL,'冰','/image/rui1.png',NULL,0,'标准糖'),
(12,3,'瓦尔登蓝钻瑞纳冰',38.0,NULL,'冰','/image/rui2.png',NULL,0,'标准糖'),
(13,3,'木瓜厚乳瑞纳冰',32.0,NULL,'冰','/image/rui3.png',NULL,0,'标准糖'),
(14,3,'冰镇杨梅瑞纳冰',38.0,NULL,'冰','/image/rui4.png',NULL,0,'标准糖'),
(15,3,'哈斯牛油果瑞纳冰',38.0,NULL,'冰','/image/rui5.png',NULL,0,'标准糖'),
(19,4,'焦糖标准美式',26.0,NULL,'冰','/image/da4.png',NULL,0,'标准糖'),
(20,4,'焦糖加浓美式',29.0,NULL,'冰','/image/da5.png',NULL,1,'标准糖'),
(21,5,'陨石大福',11.0,NULL,'冰','/image/tian1.png',NULL,0,'标准糖'),
(22,5,'海盐芝士大福',11.0,NULL,'冰','/image/tian2.png',NULL,0,'标准糖'),
(23,5,'提拉米苏大福',10.0,NULL,'冰','/image/tian3.png',NULL,0,'标准糖'),
(24,5,'桃桃大福',10.0,NULL,'冰','/image/tian4.png',NULL,0,'标准糖'),
(25,5,'芒芒大福',10.0,NULL,'冰','/image/tian5.png',NULL,0,'标准糖'),
(26,6,'椰风冰咖',99.0,NULL,'冰','/image/yuan1.png',NULL,0,'标准糖'),
(27,6,'花漾特调',99.0,NULL,'冰','/image/yuan2.png',NULL,0,'标准糖'),
(28,6,'luckin任选两样',69.0,NULL,'冰','/image/yuan3.png',NULL,0,'标准糖'),
(29,6,'挂耳咖啡',49.0,NULL,'冰','/image/yuan4.png',NULL,0,'标准糖'),
(30,6,'风味漫游咖啡',99.0,NULL,'冰','/image/yuan5.png',NULL,0,'标准糖'),
(32,7,'猫咪日式餐具',69.0,NULL,'冰','/image/yan2.png',NULL,0,'标准糖'),
(33,7,'星辰麋鹿杯',69.0,NULL,'冰','/image/yan3.png',NULL,0,'标准糖'),
(34,7,'敦煌九色鹿杯',69.0,NULL,'冰','/image/yan4.png',NULL,0,'标准糖'),
(35,7,'樱花冷水杯',79.0,NULL,'冰','/image/yan5.png',NULL,0,'标准糖'),
(36,8,'黑巧克力豆',24.9,NULL,'冰','/image/gao1.png',NULL,0,'标准糖'),
(37,8,'榴莲千层',98.0,NULL,'冰','/image/gao2.png',NULL,0,'标准糖'),
(38,8,'经典三味曲奇',59.9,NULL,'冰','/image/gao3.png',NULL,0,'标准糖'),
(39,8,'冰淇淋榴莲',78.0,NULL,'冰','/image/gao4.png',NULL,0,'标准糖'),
(40,8,'半熟芝士',84.9,NULL,'冰','/image/gao5.png',NULL,0,'标准糖'),
(41,6,'进口100%椰子水',89.0,NULL,'冰','/image/yuan6.png',NULL,0,'标准糖'),
(42,6,'生气啵啵',49.0,NULL,'冰','/image/yuan7.png',NULL,0,'标准糖'),
(43,6,'冻干柠檬百香果泡茶',29.9,NULL,'冰','/image/yuan8.png',NULL,0,'标准糖'),
(44,2,'橘金气泡美式',29.0,NULL,'冰','/image/xia6.png',NULL,0,'标准糖'),
(46,9,'瓦尔登蓝椰拿铁',35.0,NULL,'冰','/image/sheng1.png','蓝色梦幻  夏日梦幻',0,'标准糖'),
(47,9,'冰淇淋榴莲',78.0,NULL,'冰','/image/gao4.png',NULL,0,'标准糖'),
(48,9,'榴莲千层',98.0,NULL,'冰','/image/gao2.png',NULL,0,'标准糖'),
(49,9,'哈斯牛油果瑞纳冰',38.0,NULL,'冰','/image/rui5.png',NULL,0,'标准糖'),
(50,1,'芝士蓝椰拿铁',40.0,NULL,'冰','/image/sheng2.png',NULL,1,'标准糖'),
(51,1,'冰厚乳拿铁',39.0,NULL,'冰','/image/sheng3.png',NULL,0,'标准糖'),
(52,1,'陨石生椰拿铁',22.0,NULL,'冰','/image/sheng4.png',NULL,0,'标准糖');

/*Table structure for table `kabao` */

DROP TABLE IF EXISTS `kabao`;

CREATE TABLE `kabao` (
  `kid` int(8) NOT NULL AUTO_INCREMENT COMMENT '卡包id',
  `uid` int(8) DEFAULT NULL COMMENT '用户id',
  `mon` int(8) DEFAULT NULL COMMENT '优惠券金额',
  `ktitle` varchar(30) DEFAULT NULL COMMENT '优惠券标题',
  `kday` datetime DEFAULT NULL COMMENT '有效时间',
  `lasttime` datetime DEFAULT NULL COMMENT '到期时间',
  KEY `kid` (`kid`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

/*Data for the table `kabao` */

insert  into `kabao`(`kid`,`uid`,`mon`,`ktitle`,`kday`,`lasttime`) values 
(18,NULL,NULL,NULL,NULL,NULL),
(19,NULL,NULL,NULL,NULL,NULL),
(20,NULL,NULL,NULL,NULL,NULL),
(21,NULL,NULL,NULL,NULL,NULL),
(22,NULL,NULL,NULL,NULL,NULL),
(23,NULL,NULL,NULL,NULL,NULL),
(24,NULL,NULL,NULL,NULL,NULL),
(25,NULL,NULL,NULL,NULL,NULL),
(26,NULL,NULL,NULL,NULL,NULL),
(27,NULL,NULL,NULL,NULL,NULL),
(28,NULL,NULL,NULL,NULL,NULL),
(29,NULL,NULL,NULL,NULL,NULL),
(30,NULL,NULL,NULL,NULL,NULL),
(31,NULL,NULL,NULL,NULL,NULL),
(32,NULL,NULL,NULL,NULL,NULL),
(33,NULL,NULL,NULL,NULL,NULL),
(34,NULL,NULL,NULL,NULL,NULL),
(35,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `order_item` */

DROP TABLE IF EXISTS `order_item`;

CREATE TABLE `order_item` (
  `item_id` int(11) NOT NULL DEFAULT '32' COMMENT '订单详情id',
  `order_id` int(11) DEFAULT NULL COMMENT '订单id',
  `goods_id` int(11) DEFAULT NULL COMMENT '商品id',
  `num` int(11) DEFAULT NULL COMMENT '购买数量',
  `price` int(11) DEFAULT NULL COMMENT '商品单价',
  `total_fee` int(11) DEFAULT NULL COMMENT '商品总价',
  `title` varchar(32) DEFAULT NULL COMMENT '商品标题',
  `goods_path` varchar(32) DEFAULT NULL COMMENT '商品图片地址',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_item` */

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `money` varchar(50) DEFAULT NULL COMMENT '支付金额',
  `status` int(11) DEFAULT NULL COMMENT '0--未支付 1--已支付',
  `pay_time` varchar(30) DEFAULT NULL COMMENT '支付时间',
  `uname` varchar(30) DEFAULT NULL COMMENT '用户名',
  `order_wendu` varchar(8) DEFAULT NULL COMMENT '选择的温度',
  `order_sug` varchar(8) DEFAULT NULL COMMENT '选择的甜度',
  `order_num` int(8) DEFAULT NULL COMMENT '选择的数量',
  `order_name` varchar(30) DEFAULT NULL COMMENT '商品名字',
  `order_img` varchar(128) DEFAULT NULL COMMENT '订单图片',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`order_id`,`money`,`status`,`pay_time`,`uname`,`order_wendu`,`order_sug`,`order_num`,`order_name`,`order_img`) values 
(21,'64',1,'2021年07月27日 18:19:11','xiaoxiao','热','半塘',2,'热恋蜜瓜厚乳拿铁','/image/xia2.png'),
(22,'23',2,'2021年07月27日 18:19:11','xiaoxiao','冰','不加糖',1,'标准美式','/image/da2.png'),
(23,'23',1,'2021年07月27日 19:43:49','xiaoxiao','冰','不加糖',1,'标准美式','/image/da2.png'),
(24,'64',2,'2021年07月27日 19:43:49','xiaoxiao','热','半塘',2,'热恋蜜瓜厚乳拿铁','/image/xia2.png'),
(25,'32',NULL,'2021年07月29日 19:31:51','null','热','半塘',1,'热恋蜜瓜厚乳拿铁','/image/xia2.png'),
(26,'23',NULL,'2021年07月29日 19:31:51','null','冰','不加糖',1,'标准美式','/image/da2.png'),
(27,'70',NULL,'2021年07月29日 19:31:51','null','热','半塘',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(28,'70',NULL,'2021年07月29日 19:31:51','null','冰','不加糖',2,'椰加·生椰家族','/image/sheng2.png'),
(29,'70',NULL,'2021年07月29日 20:28:24','xiaoxiao','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(30,'38',NULL,'2021年07月29日 20:28:24','xiaoxiao','冰','不加糖',1,'粉荔荔瑞纳冰','/image/rui1.png'),
(31,'70',NULL,'2021年07月29日 20:29:45','xiaoxiao','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(32,'38',NULL,'2021年07月29日 20:29:45','xiaoxiao','冰','不加糖',1,'粉荔荔瑞纳冰','/image/rui1.png'),
(33,'70',NULL,'2021年07月29日 20:30:38','xiaoxiao','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(34,'38',NULL,'2021年07月29日 20:30:38','xiaoxiao','冰','不加糖',1,'粉荔荔瑞纳冰','/image/rui1.png'),
(35,'70',NULL,'2021年07月29日 20:32:37','xiaoxiao','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(36,'38',NULL,'2021年07月29日 20:32:37','xiaoxiao','冰','不加糖',1,'粉荔荔瑞纳冰','/image/rui1.png'),
(37,'38',NULL,'2021年07月29日 20:34:12','xiaoxiao','冰','不加糖',1,'粉荔荔瑞纳冰','/image/rui1.png'),
(38,'70',NULL,'2021年07月29日 20:34:12','xiaoxiao','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(39,'70',NULL,'2021年07月29日 20:34:28','xiaoxiao','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(40,'38',NULL,'2021年07月29日 20:34:28','xiaoxiao','冰','不加糖',1,'粉荔荔瑞纳冰','/image/rui1.png'),
(41,'312',NULL,'2021年07月29日 21:07:32','znmdex','冰','不加糖',8,'杨枝甘露椰子冰','/image/sheng5.png'),
(42,'64',NULL,'2021年07月29日 21:07:32','znmdex','冰','不加糖',2,'椰子OK','/image/sheng4.png'),
(43,'105',NULL,'2021年07月29日 21:07:32','znmdex','冰','不加糖',3,'椰加·生椰家族','/image/sheng2.png'),
(44,'312',NULL,'2021年07月29日 21:07:33','znmdex','冰','不加糖',8,'杨枝甘露椰子冰','/image/sheng5.png'),
(45,'64',NULL,'2021年07月29日 21:07:33','znmdex','冰','不加糖',2,'椰子OK','/image/sheng4.png'),
(46,'105',NULL,'2021年07月29日 21:07:33','znmdex','冰','不加糖',3,'椰加·生椰家族','/image/sheng2.png'),
(47,'312',NULL,'2021年07月29日 21:07:33','znmdex','冰','不加糖',8,'杨枝甘露椰子冰','/image/sheng5.png'),
(48,'64',NULL,'2021年07月29日 21:07:33','znmdex','冰','不加糖',2,'椰子OK','/image/sheng4.png'),
(49,'105',NULL,'2021年07月29日 21:07:33','znmdex','冰','不加糖',3,'椰加·生椰家族','/image/sheng2.png'),
(50,'29',NULL,'2021年07月29日 21:21:51','maqi12','冰','不加糖',1,'冰厚乳拿铁','/image/xia1.png'),
(51,'35',NULL,'2021年07月30日 10:50:44','null','冰','不加糖',1,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(52,'29',NULL,'2021年07月30日 10:50:44','null','冰','不加糖',1,'精粹奥瑞白','/image/da1.png'),
(53,'35',NULL,'2021年07月30日 10:51:15','null','冰','不加糖',1,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(54,'29',NULL,'2021年07月30日 10:51:15','null','冰','不加糖',1,'精粹奥瑞白','/image/da1.png'),
(55,'35',NULL,'2021年07月30日 10:51:57','null','冰','不加糖',1,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(56,'29',NULL,'2021年07月30日 10:51:57','null','冰','不加糖',1,'精粹奥瑞白','/image/da1.png'),
(57,'29',NULL,'2021年07月30日 11:21:06','null','冰','不加糖',1,'精粹奥瑞白','/image/da1.png'),
(58,'26',NULL,'2021年07月30日 11:21:06','null','冰','不加糖',1,'加浓美式','/image/da3.png'),
(59,'70',NULL,'2021年07月30日 11:21:06','null','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(60,'70',NULL,'2021年07月30日 11:21:37','null','冰','不加糖',2,'瓦尔登蓝椰拿铁','/image/sheng1.png'),
(61,'29',NULL,'2021年07月30日 11:21:37','null','冰','不加糖',1,'精粹奥瑞白','/image/da1.png'),
(62,'26',NULL,'2021年07月30日 11:21:37','null','冰','不加糖',1,'加浓美式','/image/da3.png'),
(63,'35',NULL,'2021年07月30日 17:07:05','xiaoxiao','冰','不加糖',1,'椰加·生椰家族','/image/sheng2.png'),
(64,'58',NULL,'2021年07月30日 19:32:44','xiaoxiao','冰','不加糖',2,'精粹奥瑞白','/image/da1.png'),
(65,'40',NULL,'2021年07月30日 19:32:44','xiaoxiao','冰','不加糖',1,'芝士蓝椰拿铁','/image/sheng2.png'),
(66,'23',NULL,'2021年07月30日 19:32:44','xiaoxiao','冰','不加糖',1,'标准美式','/image/da2.png'),
(67,'11',NULL,'2021年07月30日 19:32:44','xiaoxiao','冰','不加糖',1,'海盐芝士大福','/image/tian2.png'),
(68,'11',NULL,'2021年07月31日 09:14:21','xiaoyu123','冰','不加糖',1,'陨石大福','/image/tian1.png'),
(69,'76',NULL,'2021年07月31日 09:14:21','xiaoyu123','热','不加糖',2,'粉荔荔瑞纳冰','/image/rui1.png');

/*Table structure for table `scorecard` */

DROP TABLE IF EXISTS `scorecard`;

CREATE TABLE `scorecard` (
  `scid` int(16) NOT NULL AUTO_INCREMENT COMMENT '积分商城id',
  `sc_name` varchar(256) DEFAULT NULL COMMENT '商品名称',
  `sc_num` int(32) DEFAULT NULL COMMENT '剩余数量',
  `sc_surplus` int(64) DEFAULT NULL COMMENT '所需积分',
  `sc_img` varchar(128) DEFAULT NULL COMMENT '商品图片路径',
  `sc_time` date DEFAULT NULL COMMENT '领取有效期',
  `uid` int(16) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`scid`),
  KEY `uid` (`uid`),
  CONSTRAINT `scorecard_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `scorecard` */

insert  into `scorecard`(`scid`,`sc_name`,`sc_num`,`sc_surplus`,`sc_img`,`sc_time`,`uid`) values 
(1,'Foojo u型抱枕',15,2300,'/image/10.jpg','2021-12-31',NULL),
(2,'伊利优酸乳',18,2500,'/image/11.jpg','2021-12-31',NULL),
(3,'哇哈哈AD钙奶',16,2800,'/image/12.jpg','2021-12-31',NULL),
(4,'积分维达抽纸',5,2000,'/image/13.jpg','2021-12-31',NULL),
(5,'蒙牛奶真果粒',10,3000,'/image/14.jpg','2021-12-31',NULL),
(6,'三只松鼠坚果',15,3500,'/image/15.jpg','2021-12-31',NULL);

/*Table structure for table `shopingcart` */

DROP TABLE IF EXISTS `shopingcart`;

CREATE TABLE `shopingcart` (
  `car_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) DEFAULT NULL COMMENT '商品id',
  `shop_num` int(11) DEFAULT NULL COMMENT '购买数量',
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`car_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `shopingcart` */

insert  into `shopingcart`(`car_id`,`goods_id`,`shop_num`,`uid`) values 
(1,1,50,20),
(2,2,100,20);

/*Table structure for table `slideshow` */

DROP TABLE IF EXISTS `slideshow`;

CREATE TABLE `slideshow` (
  `slid` int(16) NOT NULL AUTO_INCREMENT,
  `sli_site` varchar(128) DEFAULT NULL COMMENT '轮播图地址',
  `swid` int(16) DEFAULT NULL COMMENT '轮播商品',
  PRIMARY KEY (`slid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `slideshow` */

insert  into `slideshow`(`slid`,`sli_site`,`swid`) values 
(1,'/image/lb1.jpg',8),
(2,'/image/lb2.jpg',1),
(3,'/image/lb3.jpg',4);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `uid` int(8) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uname` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `upwd` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `uphone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别',
  `adress` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `uphoto` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '头像',
  `nickname` varchar(128) DEFAULT NULL COMMENT '用户昵称',
  `sign` tinyint(4) DEFAULT NULL COMMENT '签到天数',
  `signtime` varchar(16) DEFAULT NULL COMMENT '上次签到时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '签到状态',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`uid`,`uname`,`upwd`,`uphone`,`sex`,`adress`,`uphoto`,`nickname`,`sign`,`signtime`,`status`) values 
(1,'xiaoxiao','e10adc3949ba59abbe56e057f20f883e','15167676721',0,'重庆市江北区红旗河沟','/image/tx1.png','晓晓',1,'1627300043',1),
(3,'dadada','e10adc3949ba59abbe56e057f20f883e','15834345667',1,'重庆市九龙坡区杨家坪','/image/tx3.png','聂桑',NULL,NULL,1),
(4,'aaaaaa','e10adc3949ba59abbe56e057f20f883e','13633339999',1,'重庆市渝北区两路','/image/tx4.png','鄢大少',NULL,NULL,1),
(5,'bbbbbb','e10adc3949ba59abbe56e057f20f883e','13633339999',1,'重庆市巴南区八公里','/image/tx5.png','俞大熊',NULL,NULL,1),
(6,'cccccc','e10adc3949ba59abbe56e057f20f883e','13633331234',0,'重庆市大渡口区大雁','/image/tx6.png','卢晓彤',NULL,NULL,1),
(8,'maqi12','e10adc3949ba59abbe56e057f20f883e','17788507701',1,'重庆市北碚区人民路','/image/tx8.png',NULL,NULL,NULL,1),
(9,'znmdex','e10adc3949ba59abbe56e057f20f883e','13212410000',1,'重庆是渝中区两路口','/image/tx9.png',NULL,NULL,NULL,1),
(10,'zhoujun','e10adc3949ba59abbe56e057f20f883e','13555587494',1,'重庆市江北区观音桥','/image/tx10.png',NULL,NULL,NULL,1),
(11,'xixixi','e10adc3949ba59abbe56e057f20f883e','15187987651',0,'重庆市南岸区弹子石','/image/tx11.png',NULL,NULL,NULL,1),
(12,'xiaoyu123','e10adc3949ba59abbe56e057f20f883e','15196763171',0,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
