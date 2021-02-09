SELECT COUNT(*) as WHO_LIVE_IN_BKK
FROM Student
WHERE CHARINDEX('Bangkok', Student_Address) > 0
GROUP BY Student_Address


SELECT Count(*) as Summer_child
FROM Student
WHERE MONTH(Student_Birthday) BETWEEN 4 and 7

SELECT Count(*) as Cnt_Courses, i.Instructor_FirstName + ' '+ i.Instructor_LastName as Instrutor_name
FROM Instructor i
    JOIN Course c on c.Instuctor_ID = i.Instructor_ID
GROUP BY i.Instructor_FirstName + ' '+ i.Instructor_LastName

SELECT AVG(e.Score), c.Course_Name as CourseName
FROM Student s
    Join PracticeExam pe on pe.Student_ID = s.Student_ID
    Join ExamScore e on e.Exam_ID = pe.Exam_ID
    JOIN EnrollCourse ec on ec.Student_ID = s.Student_ID
    JOIN Course c on c.Course_ID = ec.Course_ID
GROUP BY c.Course_Name

SELECT SUM (Transcation.Amount) AS Tot_Amount, Student.Student_ID AS StudentID, fullname = Student.Student_Firstname +' '+ Student.Student_Lastname
FROM Transcation
    INNER JOIN Payment ON Payment.Transcation_ID = Transcation.Transcation_ID
    INNER JOIN Student ON Student.Student_ID = Payment.Student_ID
GROUP BY Student.Student_Firstname, Student.Student_Lastname, Student.Student_ID

