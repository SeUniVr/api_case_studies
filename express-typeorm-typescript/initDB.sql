ALTER USER 'user' IDENTIFIED WITH mysql_native_password BY 'password';
flush privileges;

CREATE TABLE UserEntity
(
	userId BIGINT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	active TINYINT(1)
);

delimiter //

CREATE TRIGGER user_username_len_trigger BEFORE INSERT ON UserEntity FOR EACH ROW 
BEGIN

   DECLARE usernameLen INT;
   SET usernameLen = (SELECT LENGTH(NEW.username));

   IF (usernameLen < 1) THEN
     SIGNAL SQLSTATE '45000'
            SET message_text = 'Username too short.';
   END IF;

END; //

delimiter ;

delimiter //

CREATE TRIGGER user_password_len_trigger BEFORE INSERT ON UserEntity FOR EACH ROW 
BEGIN

   DECLARE pwdLen INT;
   SET pwdLen = (SELECT LENGTH(NEW.password));

   IF (pwdLen < 1) THEN
     SIGNAL SQLSTATE '45000'
            SET message_text = 'Password too short.';
   END IF;

END;//

delimiter ;