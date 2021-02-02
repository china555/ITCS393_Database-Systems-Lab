SELECT Student_ID,Student_FirstName,Student_LastName,2021-YEAR(Student_Birthday) as age
FROM Student
WHERE Student_Email LIKE '%hotmail%'

SELECT Student_FirstName+' '+Student_LastName as FULLNAME,2021-YEAR(Student_Birthday) as age
FROM Student
WHERE 2021-YEAR(Student_Birthday) > 20

SELECT Student_FirstName+' '+Student_LastName as FULLNAME,s.Student_Email,s.Student_Phone
FROM Student as s INNER JOIN Payment as p on s.Student_ID = p.Student_ID
WHERE p.Transcation_ID is null

SELECT s.Student_ID,pe.Exam_ID,Student_FirstName+' '+Student_LastName as FULLNAME,es.Score
FROM Student as s INNER JOIN PracticeExam as pe on s.Student_ID = pe.Student_ID RIGHT JOIN ExamScore as es on pe.Exam_ID = es.Exam_ID

SELECT TOP 1 s.Student_FirstName + ' ' + s.Student_LastName as Full_Name,
e.Score
FROM Student s
JOIN PracticeExam pe ON s.Student_ID = pe.Student_ID
JOIN ExamScore e ON pe.Exam_ID = e.Exam_ID
ORDER BY e.Score DESC;

SELECT TOP 1 i.Instructor_FirstName,i.Instructor_LastName,c.Course_Amount
FROM Instructor as i RIGHT JOIN Course as c on i.Instructor_ID = c.Instuctor_ID 
ORDER BY c.Course_Amount DESC;


SELECT TOP 5 s.Student_FirstName
FROM Student s JOIN EnrollCourse as ec on  s.Student_ID = ec.Student_ID
RIGHT JOIN  Course as c on c.Course_ID = ec.Course_ID
ORDER BY c.Course_Amount DESC;

SELECT c.Course_ID, ev.Course_ID
FROM Course c
LEFT JOIN ElearningVideo ev ON c.Course_ID = ev.Course_ID
WHERE ev.Course_ID IS NULL;



