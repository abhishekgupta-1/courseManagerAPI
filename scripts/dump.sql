drop schema `testdb`;
create schema `testdb`;
use `testdb`;

CREATE TABLE Person(
	PersonID int NOT NULL,
	LastName varchar(50) NOT NULL,
	FirstName varchar(50) NOT NULL,
	EnrollmentDate date NULL,
	Password varchar(50) NOT NULL,
    PRIMARY KEY (PersonID)
);

CREATE TABLE Course(
	CourseID int NOT NULL,
	Title varchar(100) NOT NULL,
	Credits int NOT NULL,
    PRIMARY KEY (CourseID)
);


CREATE TABLE StudentCourses(
	CourseID int NOT NULL,
	StudentID int NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Person(PersonID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
  CONSTRAINT PK_StudentCourses PRIMARY KEY (CourseID,StudentID)
);





INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (1, 'Abercrombie', 'Kim', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (2, 'Barzdukas', 'Gytis', '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (3, 'Justice', 'Peggy', '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (4, 'Fakhouri', 'Fadi', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (5, 'Harui', 'Roger', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (6, 'Li', 'Yan', '2002-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (7, 'Norman', 'Laura', '2003-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (8, 'Olivotto', 'Nino', '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (9, 'Tang', 'Wayne', '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (10, 'Alonso', 'Meredith', '2002-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (11, 'Lopez', 'Sophia', '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (12, 'Browning', 'Meredith', '2000-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (13, 'Anand', 'Arturo', '2003-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (14, 'Walker', 'Alexandra', '2000-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (15, 'Powell', 'Carson', '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (16, 'Jai', 'Damien', '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (17, 'Carlson', 'Robyn', '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (18, 'Zheng', 'Roger', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (19, 'Bryant', 'Carson', '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (20, 'Suarez', 'Robyn', '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (21, 'Holt', 'Roger', '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (22, 'Alexander', 'Carson', '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (23, 'Morgan', 'Isaiah', '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (24, 'Martin', 'Randall', '2005-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (25, 'Kapoor', 'Candace', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (26, 'Rogers', 'Cody', '2002-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (27, 'Serrano', 'Stacy', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (28, 'White', 'Anthony', '2001-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (29, 'Griffin', 'Rachel', '2004-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (30, 'Shan', 'Alicia', '2003-09-01');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (31, 'Stewart', 'Jasmine', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (32, 'Xu', 'Kristen', null);
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (33, 'Gao', 'Erica', '2003-01-30');
INSERT INTO Person (PersonID, LastName, FirstName, EnrollmentDate)
VALUES (34, 'Van Houten', 'Roger', null);









INSERT INTO Course (CourseID, Title, Credits)
VALUES (1050, 'Chemistry', 4);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (1061, 'Physics', 4);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (1045, 'Calculus', 4);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (2030, 'Poetry', 2);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (2021, 'Composition', 3);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (2042, 'Literature', 4);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (4022, 'Microeconomics', 3);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (4041, 'Macroeconomics', 3);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (4061, 'Quantitative', 2);
INSERT INTO Course (CourseID, Title, Credits)
VALUES (3141, 'Trigonometry', 4);






INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2021, 2);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2030, 2);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2021, 3);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2030, 3);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2021, 6);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2042, 6);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2021, 7);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2042, 7);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2021, 8);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (2042, 8);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4041, 9);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4041, 10);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4041, 11);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4041, 12);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4061, 12);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 14);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 13);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4061, 13);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4041, 14);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 15);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 16);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 17);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 19);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4061, 20);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4061, 21);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 22);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4041, 22);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4061, 22);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (4022, 23);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1045, 23);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1061, 24);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1061, 25);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1050, 26);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1061, 26);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1061, 27);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1045, 28);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1050, 28);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1061, 29);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1050, 30);
INSERT INTO StudentCourses (CourseID, StudentID)
VALUES (1061, 30);

update Person set Password = 'a';
