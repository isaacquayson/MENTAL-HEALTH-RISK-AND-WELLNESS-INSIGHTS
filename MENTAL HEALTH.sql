# DISPLAYING THE WHOLE DATASET
SELECT * FROM mental_health
LIMIT 20;

-- CHECKING FOR TOTAL RECORSDS
SELECT COUNT(*) AS 'TOTAL RECORDS' FROM mental_health;

-- What percentage of employees with a history of mental health issues are currently at high risk?
SELECT 
  COUNT(*) * 100.0 / (SELECT COUNT(*) 
  FROM mental_health 
  WHERE mental_health_history = 'Yes') 
  AS percentage_with_mental_health_issue_and_high_risk
FROM mental_health
WHERE   mental_health_history = 'Yes' AND mental_health_risk = 'high';

-- SINCE A DAY CANT BE 0 VALUE, WE REMOVE IT
DELETE FROM mental_health
WHERE physical_activity_days = 0;

-- Has treatment-seeking behavior improved productivity on average?
SELECT seeks_treatment, AVG(mental_health.productivity_score) AS 'AVG PROD. SCORE'
FROM mental_health
GROUP BY mental_health.seeks_treatment;

-- Which gender group reports the highest average depression scores?
SELECT mental_health.gender, AVG(mental_health.depression_score) AS 'AVERAGE DEPRESSION SCORE'
FROM mental_health
GROUP BY mental_health.gender
ORDER BY AVG(mental_health.depression_score) DESC
LIMIT 1;

-- How does stress level differ across employment types?
SELECT mental_health.employment_status, AVG(mental_health.stress_level) AS 'AVG STRESS LEVEL'
FROM mental_health
GROUP BY 1
ORDER BY 2 DESC;

-- Do people with less than 6 hours of sleep have higher anxiety scores?
SELECT AVG(mental_health.anxiety_score) AS 'AVERAGE ANXIETY SCORE' FROM mental_health
WHERE mental_health.sleep_hours < 6;

-- What age group has the highest proportion of high mental health risk?
SELECT COUNT(*) AS total_high_risk,
    CASE 
        WHEN mental_health.age BETWEEN 18 AND 28 THEN '18 - 28'
        WHEN mental_health.age BETWEEN 29 AND 39 THEN '29 - 39'
        WHEN mental_health.age BETWEEN 40 AND 50 THEN '40 - 50'
        ELSE '51+'
    END AS age_group
FROM mental_health 
WHERE mental_health.mental_health_risk = 'high'
GROUP BY 
    CASE 
        WHEN mental_health.age BETWEEN 18 AND 28 THEN '18 - 28'
        WHEN mental_health.age BETWEEN 29 AND 39 THEN '29 - 39'
        WHEN mental_health.age BETWEEN 40 AND 50 THEN '40 - 50'
        ELSE '51+'
    END
ORDER BY total_high_risk DESC;

-- How many people with low social support are at high risk?
SELECT COUNT(*) AS 'COUNT' FROM mental_health
WHERE mental_health.social_support_score < 40 AND mental_health.mental_health_risk = 'high'; 

-- What’s the average productivity score by work environment?
SELECT mental_health.work_environment, AVG(mental_health.productivity_score) AS 'AVERAGE PRODUCTIVITY SCORE'
FROM mental_health
GROUP BY 1
ORDER BY 2 DESC;

-- Among those with no history of mental illness, how many still seek treatment?
SELECT COUNT(*) AS 'PATIENTS COUNT'
FROM mental_health
WHERE mental_health.mental_health_history = 'NO' AND mental_health.seeks_treatment = 'YES';

