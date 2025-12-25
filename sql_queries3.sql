1️⃣ Highest Salary in Each Department

Q: Find the highest salary in each department.
A:

SELECT department_id, MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id;

2️⃣ Odd Numbered Rows

Q: Fetch only odd-numbered rows from a table.
A:

SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER(ORDER BY id) rn
    FROM employees
) t
WHERE rn % 2 = 1;

3️⃣ Duplicate Records Based on Name and Email

Q: Find duplicate records based on name and email.
A:

SELECT name, email, COUNT(*)
FROM employees
GROUP BY name, email
HAVING COUNT(*) > 1;

4️⃣ Employees Joined in Last 6 Months

Q: Find employees who joined in the last 6 months.
A:

SELECT *
FROM employees
WHERE join_date >= CURRENT_DATE - INTERVAL '6 MONTH';

5️⃣ Salary Percentage of Total Salary

Q: Calculate salary as percentage of total salary.
A:

SELECT name,
       salary,
       salary * 100.0 / SUM(salary) OVER() AS salary_percentage
FROM employees;

6️⃣ Departments with No Employees

Q: Find departments with no employees.
A:

SELECT d.*
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

7️⃣ First Record per Department

Q: Fetch the first record from each department.
A:

SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY id) rn
    FROM employees
) t
WHERE rn = 1;

8️⃣ Consecutive Login Days

Q: Find users who logged in for 3 consecutive days.
A:

SELECT user_id
FROM (
    SELECT user_id,
           login_date,
           login_date - ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY login_date) AS grp
    FROM logins
) t
GROUP BY user_id, grp
HAVING COUNT(*) >= 3;

9️⃣ Customers with Orders in Multiple Years

Q: Find customers who placed orders in more than one year.
A:

SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM order_date)) > 1;

🔟 Employees Without Manager

Q: Find employees who do not have a manager.
A:

SELECT *
FROM employees
WHERE manager_id IS NULL;