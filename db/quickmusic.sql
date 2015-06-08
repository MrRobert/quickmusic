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

CREATE TABLE IF NOT EXISTS `favorite` (
  `favorite_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11),
  `mac_address` varchar(100),
  PRIMARY KEY (`favorite_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `song_favorite` (
  `song_favorite_id` int(11) NOT NULL AUTO_INCREMENT,
  `url_alias_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `favorite_id` int(11) NOT NULL,
  PRIMARY KEY (`song_favorite_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;