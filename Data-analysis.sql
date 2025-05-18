create database Marks;
use Marks;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE Exams (
    exam_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    score INT,
    exam_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students (student_id, name, department) VALUES
(1, 'Amit', 'CS'),
(2, 'Babul', 'CS'),
(3, 'Chiku', 'Math'),
(4, 'David', 'CS');

INSERT INTO Exams (exam_id, student_id, subject, score, exam_date) VALUES
(1, 1, 'DBMS', 90, '2024-01-10'),
(2, 1, 'Networks', 85, '2024-02-15'),
(3, 2, 'DBMS', 75, '2024-01-10'),
(4, 2, 'Networks', 80, '2024-02-15'),
(5, 3, 'Algebra', 95, '2024-01-10'),
(6, 4, 'DBMS', 65, '2024-01-10'),
(7, 4, 'Networks', 70, '2024-02-15');


WITH student_avg AS (
    SELECT 
        s.student_id,
        s.name,
        s.department,
        AVG(e.score) AS avg_score
    FROM 
        Students s
    JOIN 
        Exams e ON s.student_id = e.student_id
    GROUP BY 
        s.student_id, s.name, s.department
),



ranked_students AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY department ORDER BY avg_score DESC) AS dept_rank
    FROM 
        student_avg
)


SELECT 
    student_id,
    name,
    department,
    avg_score
FROM 
    ranked_students
WHERE 
    dept_rank = 1;

