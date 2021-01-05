DROP DATABASE IF EXISTS api_db;
CREATE DATABASE api_db;
USE api_db;

CREATE TABLE project
(
	idx BIGINT AUTO_INCREMENT PRIMARY KEY,
	code VARCHAR(6) UNIQUE NOT NULL,
	title VARCHAR(200) NOT NULL
);

INSERT INTO project VALUES
(10, "proj01", "A project"),
(11, "proj02", "A project"),
(12, "proj03", "Another project"),
(13, "proj04", "A project"),
(14, "proj", "A big project"),
(15, "proj1", "A big project"),
(16, "proj31", "A big project"),
(17, "proj51", "A big project");

CREATE TABLE problem
(
	idx BIGINT AUTO_INCREMENT PRIMARY KEY,
	code VARCHAR(6) NOT NULL,
	title VARCHAR(200),
	FOREIGN KEY (code) REFERENCES project(code) 
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO problem VALUES
(10, "proj01", "A problem"),
(11, "proj02", "A problem"),
(12, "proj02", "Another problem"),
(13, "proj02", "A problem"),
(14, "proj", "A big problem"),
(15, "proj01", "A big problem"),
(16, "proj31", "A big problem"),
(17, "proj31", "A big problem");


CREATE TABLE subproblem
(
	idx BIGINT AUTO_INCREMENT PRIMARY KEY,
	content VARCHAR(200) NOT NULL,
	count BIGINT,
	pro_idx BIGINT NOT NULL,
	FOREIGN KEY (pro_idx) REFERENCES problem(idx) 
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO subproblem VALUES
(10, "Subproblem content description...", 1, 10),
(11, "Subproblem content description...",1, 10),
(12, "Subproblem content description.......", 2, 10),
(13, "Subproblem long long long content description...", 2, 13),
(14, "Subproblem content description...", 0, 14),
(15, "Subproblem content description...", 0, 15);