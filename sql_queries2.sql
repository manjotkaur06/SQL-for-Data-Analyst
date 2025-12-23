🤔 Intuition
The problem is asking us to find the customer who has placed the most orders. Each row in the Orders table represents one order placed by a customer. If we count how many times each customer_number appears, we can identify which customer placed the most orders.

🛠️ Approach
Group by customer_number: This allows us to count the number of orders per customer.
Count the orders: Use COUNT(order_number) to get the total number of orders for each customer.
Sort in descending order: Arrange the grouped results so the customer with the largest number of orders comes first.
Pick the top result: Use LIMIT 1 to return only the customer with the highest count.
Since the problem guarantees that exactly one customer has placed the maximum orders, we don’t need to handle ties.

💻 Code
SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY count(order_number) DESC
LIMIT 1;