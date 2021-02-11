--------------------------------Q1----------------------------------------------
SELECT c.Course_Name, COUNT(*) as VDOs_Record
From Course c
    JOIN ElearningVideo ev on ev.Course_ID = c.Course_ID
GROUP BY c.Course_Name
--------------------------------Q2----------------------------------------------
SELECT i.Instructor_FirstName + ' ' + i.Instructor_LastName as FullName, COUNT(*) as Total_Courses
FROM Instructor i
    JOIN Course c on c.Instuctor_ID = i.Instructor_ID
GROUP BY i.Instructor_FirstName + ' ' + i.Instructor_LastName

--------------------------------Q3----------------------------------------------
SELECT AVG(Convert(int,c.Course_Amount)) as avg_amount_of_course, i.Instructor_FirstName + ' ' + i.Instructor_LastName as Instructor_fullname
FROM Instructor i JOIN Course c
    on i.Instructor_ID = c.Instuctor_ID
WHERE Convert(int,c.Course_Amount) > 50000
GROUP BY i.Instructor_FirstName + ' ' + i.Instructor_LastName
--------------------------------Q4----------------------------------------------
SELECT MAX(c.Course_Amount)as most_expensive_course_amount, s.Student_FirstName + ' ' + s.Student_LastName as Fullname
FROM Student s
    JOIN EnrollCourse  ec on ec.Student_ID = s.Student_ID
    JOIN Course c on c.Course_ID = ec.Course_ID
GROUP BY s.Student_FirstName,s.Student_LastName,c.Course_Amount
--------------------------------Q5----------------------------------------------
SELECT AVG(es.Score), MAX(es.Score), MIN(es.Score), s.Student_FirstName + ' ' + s.Student_LastName as Fullname
FROM ExamScore es
    JOIN PracticeExam pe on pe.Exam_ID = es.Exam_ID
    JOIN Student s on s.Student_ID = pe.Student_ID
GROUP BY s.Student_FirstName,s.Student_LastName