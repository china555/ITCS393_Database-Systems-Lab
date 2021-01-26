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