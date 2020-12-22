#switch to newly created database
USE live-streaming;

#create users table
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#create videos table
CREATE TABLE `videos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` double DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_videos_users_idx` (`user_id`),
  CONSTRAINT `fk_videos_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO users VALUES
(10, 'letizia', 'letizia', NULL, NULL),
(11, 'plinio', 'plinio', NULL, NULL),
(12, 'senzio', NULL, NULL, NULL),
(13, 'tarquizio', NULL, NULL, NULL),
(14, 'calliope', 'calliope', NULL, NULL);

INSERT INTO videos VALUES
(10, 10, 'Kill Will', 2.5, NULL, NULL, NULL),
(11, 10, 'Kill Will 2', 4.5, 'kill_will_2_url', NULL, NULL),
(12, 13, 'Kill Will 3', 3.5, NULL, NULL, NULL),
(13, 13, 'Kill Will 4', 2.6, NULL, NULL, NULL),
(14, 12, 'Kill Will 5', 110.0, NULL, NULL, NULL)