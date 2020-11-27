CREATE TABLE Project
(
	idx BIGINT AUTO_INCREMENT PRIMARY KEY,
	code VARCHAR(6) UNIQUE NOT NULL,
	title VARCHAR(200) NOT NULL
);

CREATE TABLE Problem
(
	idx BIGINT AUTO_INCREMENT PRIMARY KEY,
	code VARCHAR(6) NOT NULL,
	title VARCHAR(200),
	FOREIGN KEY (code) REFERENCES Project(code) 
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE Subproblem
(
	idx BIGINT AUTO_INCREMENT PRIMARY KEY,
	content VARCHAR(200) NOT NULL,
	count BIGINT,
	pro_idx BIGINT NOT NULL,
	FOREIGN KEY (pro_idx) REFERENCES Problem(idx) 
		ON UPDATE CASCADE
		ON DELETE CASCADE
);