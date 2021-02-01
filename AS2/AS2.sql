SELECT s.Student_FirstName,s.Student_LastName
FROM EnrollCourse as e 
INNER JOIN Student as s ON e.Student_ID = s.Student_ID
GROUP BY s.Student_FirstName,s.Student_LastName
HAVING COUNT(s.Student_ID)> 0;