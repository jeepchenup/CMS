CREATE TABLE APP_USER (
   id BIGINT NOT NULL AUTO_INCREMENT,
   sso_id VARCHAR(30) NOT NULL,
   password VARCHAR(100) NOT NULL,
   first_name VARCHAR(30) NOT NULL,
   last_name  VARCHAR(30) NOT NULL,
   email VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (sso_id)
);

CREATE TABLE USER_PROFILE(
   id BIGINT NOT NULL AUTO_INCREMENT,
   type VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (type)
);

CREATE TABLE APP_USER_USER_PROFILE (
    user_id BIGINT NOT NULL,
    user_profile_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, user_profile_id),
    CONSTRAINT FK_APP_USER FOREIGN KEY (user_id) REFERENCES APP_USER (id),
    CONSTRAINT FK_USER_PROFILE FOREIGN KEY (user_profile_id) REFERENCES USER_PROFILE (id)
);

CREATE TABLE persistent_logins (
    username VARCHAR(64) NOT NULL,
    series VARCHAR(64) NOT NULL,
    token VARCHAR(64) NOT NULL,
    last_used TIMESTAMP NOT NULL,
    PRIMARY KEY (series)
);

INSERT INTO USER_PROFILE(type) VALUES ('USER');
  
INSERT INTO USER_PROFILE(type) VALUES ('ADMIN');
  
INSERT INTO USER_PROFILE(type) VALUES ('DBA');

INSERT INTO APP_USER(sso_id, password, first_name, last_name, email)
VALUES ('chens24','$2a$10$N.jZNLyM2M5WIj2Fx2kaTOEimILoN.aQk0x4wWHiPwfYiFhVo0ZSG', 'Steven','Chen','jeepchenup@foxmail.com');

INSERT INTO APP_USER_USER_PROFILE (user_id, user_profile_id)
SELECT user.id, profile.id FROM app_user user, user_profile profile
WHERE user.sso_id='chens24' AND profile.type='ADMIN';