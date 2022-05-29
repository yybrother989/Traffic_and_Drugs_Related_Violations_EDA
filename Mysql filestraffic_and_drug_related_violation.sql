/*Traffic and drug related violations EDA by Mysql*/
/*Topic 1. Violation types and races and genders*/
/* Question 1. Total violations group by types*/
SELECT 
    violation,
    COUNT(violation) AS 'Violation types',
    ROUND((COUNT(violation) * 100 / (SELECT 
                    COUNT(violation)
                FROM
                    traffic_violations)),
            2) AS 'Ratio of total violations %'
FROM
    traffic_violations
WHERE
    violation != ''
GROUP BY violation;
/* The speeding is the main violations happened to the most drivers, which took 64.97% of ratio*/
/* Question 2.Violations distributed by age*/
SELECT 
    ' 12-18 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 12 AND 18 
UNION SELECT 
    ' 18-24 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 18 AND 24 
UNION SELECT 
    ' 24-30 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 24 AND 30 
UNION SELECT 
    ' 30-36 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 30 AND 36 
UNION SELECT 
    ' 36-42 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 36 AND 42 
UNION SELECT 
    ' 42-48 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 42 AND 48 
UNION SELECT 
    ' 48-54 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 48 AND 54 
UNION SELECT 
    ' 54-60 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 54 AND 60 
UNION SELECT 
    ' 60-66 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 60 AND 66 
UNION SELECT 
    ' 66-72 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 66 AND 72 
UNION SELECT 
    ' 72-78 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 72 AND 78 
UNION SELECT 
    ' 78-84 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 78 AND 84 
UNION SELECT 
    ' 84-90 ' AS 'Age Range',
    COUNT(driver_age) AS 'Amount',
    COUNT(driver_age) * 100 / (SELECT 
            COUNT(driver_age)
        FROM
            traffic_violations) AS 'Ratio%'
FROM
    traffic_violations
WHERE
    driver_age BETWEEN 84 AND 90;
/* The age group of 18-24 is the main age group of traffio violations*/
/*Question 3.Traffic violations distributed by race and gender*/
SELECT 
    driver_race AS 'Race',
    driver_gender AS 'Gender',
    COUNT(violation) AS 'Amount'
FROM
    traffic_violations
WHERE
    violation != '' AND driver_gender != ''
GROUP BY driver_race , driver_gender
ORDER BY driver_race;
/* The number of vioations caused by male always more than female regardless race*/
/*Question 4. Stop duration and race and gender.*/
SELECT 
    driver_race AS 'Racve',
    driver_gender AS 'Gender',
    COUNT(violation) AS 'Count',
    stop_duration AS ' Stop Duration'
FROM
    traffic_violations
WHERE
    violation != '' AND driver_gender != ''
GROUP BY stop_duration , driver_race , driver_gender
ORDER BY driver_race , driver_gender;
/* Male always face more stop duration time than female regardless race and the white face more stop duration time than other races*/
/*Topic 2.Arrested rate and race and the type of violation*/
/* Question 5. The average arrested rate */
SELECT 
    SUM(IF(is_arrested = 'True', 1, 0)) * 100 / (SELECT 
            COUNT(is_arrested)
        FROM
            traffic_violations) AS 'Average arrested rate%'
FROM
    traffic_violations;
/*The average arrested rate is 3.7855%*/
/* Question 6. The arrested rate group by race and gender*/
CREATE VIEW total_vio_race AS
    SELECT 
        driver_race, COUNT(violation) AS 'total_violation'
    FROM
        traffic_violations
    WHERE
        violation != ''
    GROUP BY driver_race;

CREATE VIEW total_arrested_race AS
    SELECT 
        driver_race,
        SUM(IF(is_arrested = 'True', 1, 0)) AS 'Total_arrested'
    FROM
        traffic_violations
    WHERE
        violation != ''
    GROUP BY driver_race;

SELECT 
    total_vio_race.driver_race,
    Total_arrested / total_violation AS 'Arrested Rate'
FROM
    total_arrested_race
        LEFT JOIN
    total_vio_race ON total_arrested_race.driver_race = total_vio_race.driver_race;
/*The blacks have the highest arrested rate for traffic violations*/
/* Question 6. Arrested rate and type of violation*/
CREATE VIEW total_vio_type AS
    SELECT 
        violation, COUNT(violation) AS 'total_violation'
    FROM
        traffic_violations
    WHERE
        violation != ''
    GROUP BY violation;
CREATE VIEW total_arrested_type AS
    SELECT 
        violation,
        SUM(IF(is_arrested = 'True', 1, 0)) AS 'total_arrested'
    FROM
        traffic_violations
    WHERE
        violation != ''
    GROUP BY violation;
SELECT 
    total_arrested_type.violation,
    (total_arrested / total_violation) AS ' Arrested_rate_by_type'
FROM
    total_arrested_type
        LEFT JOIN
    total_vio_type USING (violation);
/*The violation of registration/plates have the highest arrested rate*/
/*Topic 3. Drug related stop */
/*Question 7. Drug related stop and race and gender*/
SELECT 
    driver_race,
    driver_gender,
    SUM(IF(drugs_related_stop = 'TRUE', 1, 0)) AS 'total_related_drug'
FROM
    traffic_violations
WHERE driver_gender != ""
GROUP BY driver_race , driver_gender
ORDER BY driver_race , driver_gender;
/*Males were stopped by drug-related reasons always more than females regardless of races and the whites related more drug cases than any other races.
