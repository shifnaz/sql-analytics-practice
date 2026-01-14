-- Total sales per customer
SELECT customer_id,
       SUM(quantity * price) AS total_sales
FROM orders
GROUP BY customer_id;

-- Customers with more than one order
SELECT customer_id,
       COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- Candidates with all required skills
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3;

-- Employees earning more than company average
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- Top 2 highest paid employees per department
SELECT name, salary, department
FROM (
    SELECT name,
           salary,
           department,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rn
    FROM employees
) t
WHERE rn <= 2;
