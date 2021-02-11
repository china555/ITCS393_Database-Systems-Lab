-- Q4: Find the most expensive course that students have to pay for enroll ment.
--(The results must show the course amount, and students' fullname)
SELECT MAX(C.Course_Amount)
From Course C

SELECT Course,COUNT(*) as VDOs_Record
From Course
JOIN Elea
--Q3----------------------------------------------
SELECT AVG(Convert(int,c.Course_Amount)) as avg_amount_of_course, i.Instructor_FirstName + ' ' + i.Instructor_LastName as Instructor_fullname
FROM Instructor i JOIN Course c
    on i.Instructor_ID = c.Instuctor_ID
WHERE Convert(int,c.Course_Amount) > 50000
GROUP BY i.Instructor_FirstName + ' ' + i.Instructor_LastName