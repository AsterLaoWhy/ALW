--1
SELECT *
FROM NAEP;



--2
SELECT * 
FROM NAEP
LIMIT 50;


--3
SELECT state, COUNT(avg_math_4_score) AS counted, AVG(avg_math_4_score) AS avg_score, MIN(avg_math_4_score) AS min_score, MAX(avg_math_4_score) AS max_score
FROM NAEP
GROUP BY state;

--4
SELECT state, COUNT(avg_math_4_score) AS counted, AVG(avg_math_4_score) AS avg_score, MIN(avg_math_4_score) AS min_score, MAX(avg_math_4_score) AS max_score
FROM NAEP
GROUP BY state
HAVING (MAX(avg_math_4_score)-MIN(avg_math_4_score))<=30;



--5
SELECT state  as bottom_10, avg_math_4_score
FROM NAEP
WHERE year = 2000
ORDER BY avg_math_4_score
LIMIT 10;




--6 
SELECT ROUND(AVG(avg_math_4_score), 2)
FROM NAEP
WHERE year = 2000;


--7
SELECT state as below_average_states_y2000, ROUND(AVG(avg_math_4_score), 2) AS state_score
FROM naep
WHERE year = 2000
GROUP BY state
HAVING AVG(avg_math_4_score) < ANY
		   (SELECT AVG(avg_math_4_score)
			FROM naep
			WHERE year = 2000
		   )
ORDER BY state_score;




--8
SELECT state
FROM naep
WHERE year = 2000 AND avg_math_4_score IS NULL
ORDER BY state;

--9
SELECT naep.state, ROUND(naep.avg_math_4_score, 2) AS avg_score, fin.total_expenditure
from naep
LEFT OUTER JOIN finance as fin
ON naep.id = fin.id
WHERE naep.year = 2000
GROUP BY naep.state, avg_score, fin.total_expenditure, naep.avg_math_4_score
HAVING naep.avg_math_4_score IS NOT NULL
ORDER BY fin.total_expenditure DESC;

