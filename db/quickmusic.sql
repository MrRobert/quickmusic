CREATE TABLE IF NOT EXISTS `home` (
  `home_id` int(11) NOT NULL AUTO_INCREMENT,
  `content` LONGTEXT NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`home_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `url_alias` ADD (
   `title` varchar(200) NOT NULL DEFAULT  '',
   `img_src` LONGTEXT,
   `artis` varchar(200)
);