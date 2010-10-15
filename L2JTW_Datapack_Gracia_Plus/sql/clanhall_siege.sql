-- ------------- --
-- Common Tables --
-- ------------- --
DROP TABLE IF EXISTS `clanhall_siege`;
CREATE TABLE `clanhall_siege` (
`clanhall_id` INT( 3 ) NULL DEFAULT NULL ,
`siege_date` DOUBLE( 20, 0 ) NOT NULL DEFAULT '0' 
) ENGINE = MYISAM ;

INSERT INTO `clanhall_siege` VALUES ('21', '1265857200000');
INSERT INTO `clanhall_siege` VALUES ('34', '1265857200000');
INSERT INTO `clanhall_siege` VALUES ('62', '1286676000000');
INSERT INTO `clanhall_siege` VALUES ('64', '1265943600000');
