create database covid_test;

use covid_test;

create table covid_data (
							Ind_Id INT, 
                            Test_date DATE, 
                            Cough_symptoms varchar(10), 
                            Fever varchar(20) ,
                            Sore_throat varchar(10), 
                            Shortness_of_breath varchar(10), 
                            Headache varchar(10), 
                            Corona varchar(10), 
                            Age_60_above varchar(10), 
                            Sex varchar(10), 
                            Known_contact varchar(30)
                            );


SELECT
	*
FROM
	covid_data;


# Q.1 Find the number of corona patients who faced shortness of breath.

SELECT 
	count(Ind_Id) as NoOfPatients
FROM
	covid_data 
WHERE
	Corona = "positive" 
	AND Shortness_of_breath = "TRUE";

/*
Conclusion :- There are 1162 corona patients who faced shortness of breath.
*/

# Q.2 Find the number of negative corona patients who have fever and sore_throat. 

SELECT 
	count(Ind_Id) as NoOfPatients
FROM 
	covid_data 
WHERE 
	Corona = "negative" 
	AND Fever = "TRUE" 
	AND Sore_throat = "TRUE";

/*
Conclusion :- There are 121 corona negative patients who have fever and Sore throat.
*/

# Q.3 Group the data by month and rank the number of positive cases.

SELECT 
	monthname(Test_date) AS Month,
	count(Ind_Id) as positivecases, 
	RANK() OVER(ORDER BY count(Ind_Id) DESC) AS 'rank'
FROM 
	covid_data
WHERE 
	Corona = "positive"
GROUP BY 
	monthname(Test_date);

/* 
Conclusion :- In April we found most number of corona positive cases(8863), And in march 5863 corona positive cases.
*/

# Q.4 Find the female negative corona patients who faced cough and headache.

SELECT 
	* 
FROM 
	covid_data
WHERE 
	Sex = "female" 
	AND Corona = "negative" 
	AND Cough_symptoms = "TRUE" 
	AND Headache = "TRUE";

/*
Conclusion :- 32 female negative corona patients who faced cough and headache.
*/

# Q.5 How many elderly corona patients have faced breathing problems?

SELECT 
	count(*)
FROM 
	covid_data
WHERE 
	Age_60_above = "Yes"
	AND Shortness_of_breath = "TRUE";

/* 
Conclusion :- 286 elderly corona patients have faced breathing problems.(In problem it's not mentioned corona positive or negative patients)
*/

# Q.6 Which three symptoms were more common among COVID positive patients?

SELECT 
	(SELECT count(*) FROM covid_data WHERE Cough_symptoms = "TRUE" AND corona = "positive") AS Cough_count,
    (SELECT count(*) FROM covid_data WHERE Fever = "TRUE" AND corona = "positive") AS Fever_count,
    (SELECT count(*) FROM covid_data WHERE Sore_throat = "TRUE" AND corona = "positive") AS Sore_count,
    (SELECT count(*) FROM covid_data WHERE Shortness_of_breath = "TRUE" AND corona = "positive") AS shortBreath_count,
    (SELECT count(*) FROM covid_data WHERE Headache = "TRUE" AND corona = "positive") AS headache_count,
    (SELECT count(*) FROM covid_data WHERE corona = "positive") AS positive_count
FROM 
	covid_data
LIMIT
	1;

/* 
Conclusion :- Cough_Symptoms, Fever and Headache are the most common symptoms among Corona positive patients.
*/

# Q.7 Which symptom was less common among COVID negative people?

SELECT 
	(SELECT count(*) FROM covid_data WHERE Cough_symptoms = "TRUE" AND corona = "negative") AS Cough_count,
    (SELECT count(*) FROM covid_data WHERE Fever = "TRUE" AND corona = "negative") AS Fever_count,
    (SELECT count(*) FROM covid_data WHERE Sore_throat = "TRUE" AND corona = "negative") AS Sore_count,
    (SELECT count(*) FROM covid_data WHERE Shortness_of_breath = "TRUE" AND corona = "negative") AS shortBreath_count,
    (SELECT count(*) FROM covid_data WHERE Headache = "TRUE" AND corona = "negative") AS headache_count,
    (SELECT count(*) FROM covid_data WHERE corona = "negative") AS negative_count
FROM 
	covid_data
LIMIT
	1;

/*
Conclusion :- Headache, Shortness of Breath, Sore throat symptom was less common among COVID negative people.
*/

# Q.8 What are the most common symptoms among COVID positive males whose known contact was abroad? 

SELECT 
	(SELECT count(*) FROM covid_data WHERE Cough_symptoms = "TRUE" AND corona = "positive" AND Known_contact like '%Abroad%') AS Cough_count,
    (SELECT count(*) FROM covid_data WHERE Fever = "TRUE" AND corona = "positive" AND Known_contact like '%Abroad%') AS Fever_count,
    (SELECT count(*) FROM covid_data WHERE Sore_throat = "TRUE" AND corona = "positive" AND Known_contact like '%Abroad%') AS Sore_count,
    (SELECT count(*) FROM covid_data WHERE Shortness_of_breath = "TRUE" AND corona = "positive" AND Known_contact like '%Abroad%') AS shortBreath_count,
    (SELECT count(*) FROM covid_data WHERE Headache = "TRUE" AND corona = "positive" AND Known_contact like '%Abroad%') AS headache_count,
    (SELECT count(*) FROM covid_data WHERE corona = "positive" AND Known_contact like '%Abroad%') AS positive_count
FROM 
	covid_data
LIMIT
	1;
/*
Conclusion :- Cough and Fever are the most common symptoms among COVID positive males whose known contact was abroad.
*/