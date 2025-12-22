-- ===============================
-- Advanced SQL Practice – Day 1
-- ===============================

-- 1. Find employees whose salary is greater than average salary
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


-- 2. Find second highest salary
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);


-- 3. Find Nth highest salary
-- Replace :N with required number
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = :N;


-- 4. Find employees who earn the same salary
SELECT salary, COUNT(*) AS emp_count
FROM employees
GROUP BY salary
HAVING COUNT(*) > 1;


-- 5. Find departments having less than N employees
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) < :N;


-- 6. Find employees who work in multiple departments
SELECT employee_id, COUNT(DISTINCT department_id) AS dept_count
FROM employee_departments
GROUP BY employee_id
HAVING COUNT(DISTINCT department_id) > 1;



-- 7. Find employees whose salary is in top 10%

SELECT *
FROM employees
WHERE salary >= (
    SELECT DISTINCT salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 1 OFFSET (
        SELECT CAST(0.1 * COUNT(*) AS INT) FROM employees
    )
);

-- 8. Find employees whose manager does not exist
SELECT *
FROM employees e
WHERE manager_id IS NOT NULL
AND manager_id NOT IN (SELECT employee_id FROM employees);


-- 9. Find employees without subordinates
SELECT *
FROM employees
WHERE employee_id NOT IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);


-- 10. Find employees who report to the same manager
SELECT manager_id, COUNT(*) AS emp_count
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING COUNT(*) > 1;
