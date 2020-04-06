USE `WHEREISMYHOME`;

DROP TABLE IF EXISTS `HOUSING_ESTATE_TYPE`;
CREATE TABLE `HOUSING_ESTATE_TYPE` (
`ID` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`TYPE` ENUM('商业','商业类','住宅','别墅','底商','写字楼') NOT NULL COMMENT '小区类型'
) COMMENT '小区类型';
INSERT INTO `HOUSING_ESTATE_TYPE`(`TYPE`) VALUES('商业'),('商业类'),('住宅'),('别墅'),('底商'),('写字楼');

DROP TABLE IF EXISTS `HOUSING_ESTATE_STATUS`;
CREATE TABLE `HOUSING_ESTATE_STATUS` (
`ID` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`STATUS` ENUM('售罄','未开盘','下期待开','在售') NOT NULL COMMENT '小区状态'
) COMMENT '小区状态';
INSERT INTO `HOUSING_ESTATE_STATUS`(`STATUS`) VALUES('售罄'),('未开盘'),('下期待开'),('在售');

DROP TABLE IF EXISTS `HOUSING_ESTATE`;
CREATE TABLE `HOUSING_ESTATE` (
`ID` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`NAME` VARCHAR(11) NOT NULL COMMENT '小区名字',
`HOUSING_ESTATE_TYPE_ID` INT NOT NULL COMMENT '小区类型ID',
`IS_SECOND_HAND` BOOL NOT NULL DEFAULT FALSE COMMENT '是否二手房',
`AREA_MIN` INT COMMENT '最小面积',
`AREA_MAX` INT COMMENT '最大面积',
`ADDRESS` VARCHAR(128) NOT NULL COMMENT '小区地址',
`LINK` VARCHAR(256) NOT NULL COMMENT '链家地址'
) COMMENT '小区';

ALTER TABLE `HOUSING_ESTATE` ADD CONSTRAINT `FK_TYPE` 
FOREIGN KEY(`HOUSING_ESTATE_TYPE_ID`) REFERENCES `HOUSING_ESTATE_TYPE`(`ID`)
ON UPDATE CASCADE;

DROP TABLE IF EXISTS `HOUSING_ESTATE_PRICE`;
CREATE TABLE `HOUSING_ESTATE_PRICE` (
`HOUSING_ESTATE_ID` INT NOT NULL COMMENT '小区ID',
`HOUSING_ESTATE_STATUS_ID` INT NOT NULL COMMENT '小区状态ID',
`PRICE` INT COMMENT '小区价格',
`UNIT` ENUM('元/平','万/套','未知') NOT NULL COMMENT '单位',
`TIME` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据获取时间'
) COMMENT '小区价格统计';

ALTER TABLE `HOUSING_ESTATE_PRICE` ADD CONSTRAINT `FK_HOUSING_ESTATE_ID` 
FOREIGN KEY (`HOUSING_ESTATE_ID`) REFERENCES `HOUSING_ESTATE`(`ID`)
ON UPDATE CASCADE;

ALTER TABLE `HOUSING_ESTATE_PRICE` ADD CONSTRAINT `FK_STATUS` 
FOREIGN KEY (`HOUSING_ESTATE_STATUS_ID`) REFERENCES `HOUSING_ESTATE_STATUS`(`ID`)
ON UPDATE CASCADE;
