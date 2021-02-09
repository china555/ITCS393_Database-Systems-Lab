SELECT COUNT(*), Student_Address
FROM Student
Where Student_Address like 'Bang Kae'
GROUP BY Student_Address