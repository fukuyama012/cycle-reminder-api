
-- +migrate Up
CREATE TABLE `users` (
    `id`            BIGINT UNSIGNED AUTO_INCREMENT,
    `email`         VARCHAR(255) NOT NULL ,
    `created_at`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    `updated_at`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk-email`(`email`)
) ENGINE=InnoDB;

-- +migrate Down
DROP TABLE IF EXISTS `users`;