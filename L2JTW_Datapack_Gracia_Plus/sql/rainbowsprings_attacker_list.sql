-- Needs a special attacker table
DROP TABLE IF EXISTS `rainbowsprings_attacker_list`;
CREATE TABLE `rainbowsprings_attacker_list` (
`clanId` INT( 10 ) NULL DEFAULT NULL ,
`war_decrees_count` DOUBLE( 20, 0 ) NULL DEFAULT NULL 
) ENGINE = MYISAM ;

