-- Question 1
USE ICT_tutorial_database
SELECT s.Student_FirstName, s.Student_LastName
FROM EnrollCourse as e
    INNER JOIN Student as s ON e.Student_ID = s.Student_ID
GROUP BY s.Student_FirstName,s.Student_LastName
HAVING COUNT(s.Student_ID)> 0;

-- Question 2
SELECT s.Student_FirstName, t.Amount
FROM Student s
    JOIN Payment pm on s.Student_ID = pm.Student_ID
    JOIN Transcation T on t.Transcation_ID = pm.Transcation_ID
WHERE t.Amount > 50000

-- Question 3
SELECT s.Student_FirstName as name, es.Score
FROM Student s
    JOIN PracticeExam pe on s.Student_ID = pe.Student_ID
    JOIN ExamScore es on pe.Exam_ID = es.Exam_ID
WHERE es.Score > (SELECT AVG(Score)
FROM ExamScore)
GROUP BY s.Student_FirstName, es.Score;

-- Question 4
SELECT i.Instructor_FirstName + ' ' +i.Instructor_LastName as Fullname, c.Course_Name
FROM Instructor i
    LEFT JOIN Course c on c.Instuctor_ID = i.Instructor_ID
WHERE c.Instuctor_ID is null

-- Question 5
SELECT s.Student_FirstName, c.Course_Name, (SELECT SUM(b.Price)
    FROM BookStocking b
    WHERE s.Student_ID = ec.Student_ID and ec.Course_ID = c.Course_ID and c.Course_ID = b.Course_ID)
FROM Student s
    JOIN EnrollCourse ec on s.Student_ID = ec.Student_ID
    JOIN Course c on c.Course_ID = ec.Course_ID

-- Question 6
SELECT TOP 1
    i.Instructor_FirstName+' '+i.Instructor_LastName Fullname, c.Course_Amount
FROM Instructor as i RIGHT JOIN Course as c on i.Instructor_ID = c.Instuctor_ID
ORDER BY c.Course_Amount DESC;

-- Question 7
SELECT AVG(Score) as AverageScore
FROM ExamScore

-- Question 8
SELECT Student_FirstName+' '+Student_LastName as FULLNAME, 2021-YEAR(Student_Birthday) as age
FROM Student
WHERE DAY(Student.Student_Birthday) = 27

-- Question 9
SELECT Student_FirstName+' '+Student_LastName as FULLNAME, 2021-YEAR(Student_Birthday) as age
FROM Student
WHERE Student_FirstName IN('KITTIKORN','NATTAWIPA')

-- Question 10
SELECT TOP 4
    s.Student_FirstName + ' ' + s.Student_LastName as FullName,
    e.Score
FROM Student s
    JOIN PracticeExam pe ON s.Student_ID = pe.Student_ID
    JOIN ExamScore e ON pe.Exam_ID = e.Exam_ID
ORDER BY e.Score DESC;
