CREATE DATABASE ICT_tutorial_database;
USE ICT_tutorial_database

CREATE TABLE Student(
	Student_ID int PRIMARY KEY,
	Student_FirstName nvarchar(40) NOT NULL,
	Student_LastName nvarchar(40) NOT NULL,
    Student_Address nvarchar(40) NOT NULL,
    Student_Birthday DATE NOT NULL,
    Student_Email nvarchar(40) DEFAULT 'Student@student.mahidol.edu',
    Student_Phone nvarchar(10) NOT NULL,
    Student_UserID int NOT NULL,
    Student_Password nvarchar(40) NOT NULL,
);

CREATE TABLE Instructor(
	Instructor_ID int PRIMARY KEY,
	Instructor_FirstName nvarchar(40) NOT NULL,
	Instructor_LastName nvarchar(40) NOT NULL,
    Instructor_Address nvarchar(40) NOT NULL,
    Instructor_Birthday DATE NOT NULL,
    Instructor_Email nvarchar(40) DEFAULT 'Instructor@mahidol.edu',
    Instructor_Phone nvarchar(10) NOT NULL,
    Instructor_UserID int NOT NULL,
    Instructor_Password nvarchar(40) NOT NULL,
);

CREATE TABLE Course(
    Course_ID int PRIMARY KEY,
    Instuctor_ID int,
    Course_Name nvarchar(40) NOT NULL,
    Course_Amount nvarchar(40) NOT NULL,
    FOREIGN KEY (Instuctor_ID) REFERENCES Instructor(Instructor_ID),
);

CREATE TABLE BookStocking(
    Book_ID int PRIMARY KEY,
    Course_ID int,
    BookName nvarchar(40) NOT NULL,
    Author nvarchar(40) NOT NULL,
    Remaining int NOT NULL,
    Price int NOT NULL,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
);

CREATE TABLE ElearningVideo(
    Course_ID int,
    Lesson nvarchar(40) NOT NULL,
    Details nvarchar(255) NOT NULL,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
);

CREATE TABLE EnrollCourse(
    Student_ID int,
    Course_ID int,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),

);

CREATE TABLE ExamScore(
    Exam_ID int PRIMARY KEY,
    Score int DEFAULT 0,
);

CREATE TABLE PracticeExam(
    Student_ID int,
    Exam_ID int,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Exam_ID) REFERENCES ExamScore(Exam_ID),
);

CREATE TABLE CheckAttendance(
    Student_ID int,
    Week char(2) DEFAULT '00',
    Day DATE,
    status BIT,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
);

CREATE TABLE Transcation(
    Transcation_ID int PRIMARY KEY,
    Amount int,

);

CREATE TABLE Payment(
    Student_ID int,
    Transcation_ID int,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Transcation_ID) REFERENCES Transcation(Transcation_ID),
);

CREATE TABLE Seat(
    Seat_ID int PRIMARY KEY,
    Course_ID int, 
    Student_ID int,
    Row char(1),
    Number char(2),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

INSERT INTO Student (Student_ID,Student_FirstName,Student_LastName,Student_Address,Student_Birthday,Student_Email,Student_Phone,Student_UserID,Student_Password)
VALUES (1,'Nattawipa','Saetae','Soi Kamnan Maen','2000-07-27','Nattawipa.Sae@student.mahidol.edu','0951239827',6188089,'Passwordnam'),
(2,'Kittikorn','Keeratikriengkrai','Thra pha','1999-08-27','Kittikorn.kee@student.mahidol.edu','0861036727',6188086,'Password'),
(3,'Patarapong ','Jomkhamsri','Lat Krabang','2000-03-22','Patarapong.jom@student.mahidol.edu','0935459527',6188114,'newpassword'),
(4,'Napatr','Thaithaweewattanakul','Bang Kae','2000-02-21','Napatr.tha@student.mahidol.edu','0662036727',6188128,'armPassword'),
(5,'Sarun','Junbun','Ban Pong','1999-11-11','Sarun.jun@student.mahidol.edu','0861031125',6188080,'markPassword'),
(6,'Ekkawit','Sangruengkit','Bang Kae','1999-03-19','Ekkawit.san@student.mahidol.edu','0871086627',6188122,'bonuspassword'),
(7,'Thanawat','Riamliw','Nakornpathom','2000-01-19','Thanawat.ria@student.mahidol.edu','0869046727',6188019,'fordPassword'),
(8,'Nuttida','Naphakat','Bang Kae','1999-05-19','Nuttida.nap@student.mahidol.edu','0856046727',6188034,'donutPassword'),
(9,'Phakin','A-Yamuang','Thra pha','1999-11-21','Phakin.aya@student.mahidol.edu','0888434727',6188066,'OPassword'),
(10,'Kasadin ','Wisetprasit','Bang Kae','2000-07-1','Kasadin.wis@student.mahidol.edu','0865036727',6188112,'kritPassword');

INSERT INTO Instructor (Instructor_ID,Instructor_FirstName,Instructor_LastName,Instructor_Address,Instructor_Birthday,Instructor_Email,Instructor_Phone,Instructor_UserID,Instructor_Password)
VALUES (1,'Pawitra','Chiravirakul','Nakornpathom','1980-06-21','pawitra.chi@mahidol.ac.th','0655139827',000001,'PasswordAJ'),
(2,'Woraluck','Wongse-Ek','Nakornpathom','1970-02-22','woraluck.won@mahidol.ac.th','0861116727',000002,'PasswordAJ'),
(3,'Preecha','Tangworakitthaworn','Nakornpathom','1980-04-12','preecha.tan@mahidol.ac.th','0935999527',000003,'PasswordAJ'),
(4,'Siripen','Pongpaichet','Nakornpathom','1980-04-20','siripen.pon@mahidol.edu','0666036727',000004,'PasswordAJ'),
(5,'Suppawong','Tuarob','Nakornpathom','1980-10-11','suppawong.tua@mahidol.edu','0861011125',000005,'PasswordAJ'),
(6,'Charnyote','Pluempitiwiriyawej','Nakornpathom','1980-03-19','charnyote.plu@mahidol.ac.th','0875086627',000007,'PasswordAJ'),
(7,'Dolvara','Guna-Tilaka','Nakornpathom','1980-01-19','Dolvara.gun@mahidol.edu','0839046727',000008,'PasswordAJ'),
(8,'Snit','Sanghlao','Nakornpathom','1980-05-19','snit.san@mahidol.ac.th','0856446727',000009,'PasswordAJ'),
(9,'Wudhichart','Sawangphol','Nakornpathom','1980-11-21','wudhichart.saw@mahidol.edu','0888834727',0000010,'PasswordAJ'),
(10,'Jidapa','Kraisangka','Nakornpathom','1980-07-1','jidapa.kra@mahidol.edu','0865536727',000011,'PasswordAJ');

INSERT INTO Course (Course_ID,Instuctor_ID,Course_Name,Course_Amount)
VALUES (393,3,'Database Systems Lab','32000'),
(420,7,'Computer Networks','32000'),
(414,6,'Information Storage and Retrieval','32000'),
(424,8,'Wireless and Mobile Computing','32000'),
(209,5,'Object Oriented Programming','32000'),
(212,10,'Web Programming','32000'),
(361,9,'Management Information Systems','32000'),
(371,2,'Introduction to Software Engineering','32000'),
(337,1,'Human Computer Interaction','32000'),
(241,4,'Database Management Systems','32000');

INSERT INTO BookStocking (Book_ID,Course_ID,BookName,Author,Remaining,Price)
VALUES (100000,393,'Principles of Object-Oriented','Nicholas C. Zakas',20,3200),
(200000,420,'A Top-down Approach','Jim Kurose',15,3500),
(300000,424,'Wireless Networks and Mobile Computing','Bhabani P. Sinha',16,4000),
(400000,414,'Information Storage and Retrieval','Robert R. Korfhage',10,3800),
(500000,209,'Head First Design Patterns','Elisabeth Freeman and Kathy Sierra',40,6000),
(600000,212,'Pro JavaScript for Web Apps','Adam Freeman',6,4800),
(700000,361,'Information Project Management','Kathy Schwalbe',8,4000),
(800000,371,'Introduction to software engineering','Ronald J Leach',13,3000),
(900000,337,'Human-computer Interaction','Alan Dix',3,4200),
(010000,241,'Database Management Systems','Atul Kahate',20,3200);

INSERT INTO ElearningVideo (Course_ID,Lesson,Details)
VALUES (393,'Introduction','learn more Principles of Object-Oriented programming'),
(420,'Introduction','learn network layer '),
(424,'Introduction','LAN WAN'),
(414,'Introduction','relevant of data'),
(209,'Introduction','learn more Principles of OOP'),
(212,'Introduction','learn more about javascript'),
(361,'Introduction','manage data'),
(371,'Introduction','scrum'),
(337,'Introduction','interface'),
(241,'Introduction','learn to design database');

INSERT INTO EnrollCourse (Student_ID,Course_ID)
VALUES (1,393),
(2,420),
(3,424),
(4,414),
(5,209),
(6,212),
(7,361),
(8,371),
(9,337),
(10,241);

INSERT INTO ExamScore (Exam_ID,Score)
VALUES (1,50),
(2,60),
(3,70),
(4,80),
(5,90),
(6,100),
(7,65),
(8,75),
(9,85),
(10,95);

INSERT INTO CheckAttendance VALUES (1,'01','2021-01-27',1),
(2,'01','2021-01-27',1),
(3,'01','2021-01-27',0),
(4,'01','2021-01-27',1),
(5,'01','2021-01-27',0),
(6,'01','2021-01-27',1),
(7,'01','2021-01-27',0),
(8,'01','2021-01-27',1),
(9,'01','2021-01-27',0),
(10,'01','2021-01-27',0);

INSERT INTO Transcation (Transcation_ID,Amount)
VALUES (1,72000),
(2,72000),
(3,72000),
(4,72000),
(5,72000),
(6,72000),
(7,72000),
(8,72000),
(9,72000),
(10,72000);

INSERT INTO Payment (Student_ID,Transcation_ID)
VALUES (1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

INSERT INTO Seat (Seat_ID,Course_ID,Student_ID,Row,Number)
VALUES (1,393,1,'A','01'),
(2,420,1,'A','02'),
(3,414,1,'A','03'),
(4,424,1,'A','04'),
(5,209,2,'B','01'),
(6,393,2,'B','02'),
(7,393,3,'B','03'),
(8,209,3,'C','01'),
(9,414,4,'C','02'),
(10,420,4,'C','03');

INSERT INTO PracticeExam (Student_ID,Exam_ID)
VALUES (1,10),
(2,9),
(3,8),
(4,7),
(5,6),
(6,5),
(7,4),
(8,3),
(9,2),
(10,1);
