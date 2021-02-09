-- Q4: Find the most expensive course that students have to pay for enroll ment.
--(The results must show the course amount, and students' fullname)
SELECT MAX(C.Course_Amount)
From Course C

SELECT S.Student_FirstName + ' '+ S.Student_LastName as Fullname, (SELECT MAX(C.Course_Amount)
    From Course C) as course_amount
From Student S
WHERE (SELECT MAX(C.Course_Amount)
From Course C
WHERE MAX(C.Course_Amount) = c.Course_Amount)

UPDATE Course
SET Course_Amount
= 70000 
WHERE Course_ID = 209 