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

ALTER TABLE `home` ADD (
   `promotion_albums` LONGTEXT NOT NULL,
   `promotion_song` LONGTEXT NOT NULL
);

ALTER TABLE `home` ADD (
   `music_vn` LONGTEXT NOT NULL,
   `music_uk` LONGTEXT NOT NULL
)

CREATE TABLE IF NOT EXISTS `playlist` (
  `playlist_id` int(11) NOT NULL AUTO_INCREMENT,
  `playlist_name` varchar(100) NOT NULL,
  `user_id` int(11),
  `mac_address` varchar(100),
  `createDate` date,
  PRIMARY KEY (`playlist_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `song_playlist` (
  `song_playlist_id` int(11) NOT NULL AUTO_INCREMENT,
  `url_alias_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `playlist_id` int(11) NOT NULL,
  PRIMARY KEY (`song_playlist_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `video_channel` (
  `video_channel_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255),
  `channel_name` varchar(100) NOT NULL,
  `mac_address` text NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`video_channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `album` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `img_src` LONGTEXT NOT NULL,
  `title` varchar(255) NOT NULL,
  `artis` varchar(255) NOT NULL,
  `query` TEXT NOT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;