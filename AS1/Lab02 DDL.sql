SELECT *
FROM myFriends

CREATE DATABASE myFriends;
use myFriends;

CREATE TABLE myStudents
(
StudentID INT NOT NULL,
FirstName NVARCHAR(50),
LastName NVARCHAR(50)
)
CREATE TABLE myFriends
(
FriendID INT NOT NULL,
NickName NVARCHAR(20) NOT NULL,
FirstName NVARCHAR(50) ,
LastName NVARCHAR(50),
PhoneNo NCHAR(13)
);
 
CREATE TABLE myProjects
(
ProjNo INT NOT NULL,
FriendMembers INT NOT NULL,
ProjectName NVARCHAR(200),
DueDate date
);

ALTER TABLE myFriends
ADD FOREIGN KEY (FriendID) REFERENCES myStudents(StudentID);

ALTER TABLE myStudents
ADD PRIMARY KEY (StudentID)

ALTER TABLE myProjects
ADD FOREIGN KEY (FriendMembers) REFERENCES myStudents(StudentID);

ALTER TABLE myProjects
ADD PRIMARY KEY (ProjNO,FriendMembers)

ALTER TABLE myFriends
ADD PRIMARY KEY (FriendID,NickName)

    4. Assign "studentID" to be PK for myStudents table.
	5. Assign "FriendID and NickName" to be COMPOSITE PKs for myFriends table.