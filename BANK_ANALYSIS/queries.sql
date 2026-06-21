---1. FIND THE TOP 5 CUSTOMERS BY ACCOUNT BALANCE
SELECT 
customer_id, balance
FROM accounts
ORDER BY balance DESC
LIMIT 5;

INSERT INTO transactions (account_id, transaction_date, transaction_type, amount)
VALUES
(1, '2025-01-05', 'Deposit', 10000),
(1, '2025-01-15', 'Withdrawal', 5000),
(2, '2025-01-08', 'Deposit', 20000),
(3, '2025-01-10', 'Deposit', 50000),
(4, '2025-01-12', 'Withdrawal', 3000),
(5, '2025-01-14', 'Deposit', 25000),
(6, '2025-01-18', 'Deposit', 15000),
(7, '2025-01-20', 'Withdrawal', 7000),
(8, '2025-01-22', 'Deposit', 12000),
(9, '2025-01-25', 'Deposit', 40000),
(10, '2025-01-28', 'Withdrawal', 6000),
(11, '2025-02-03', 'Deposit', 18000),
(12, '2025-02-05', 'Deposit', 60000),
(13, '2025-02-08', 'Withdrawal', 4000),
(14, '2025-02-10', 'Deposit', 22000),
(15, '2025-02-12', 'Deposit', 14000),
(16, '2025-02-15', 'Withdrawal', 8000),
(17, '2025-02-18', 'Deposit', 17000),
(18, '2025-02-20', 'Deposit', 45000),
(19, '2025-02-22', 'Withdrawal', 5000),
(20, '2025-02-25', 'Deposit', 28000);

SELECT COUNT(*) AS total_transactions
FROM transactions;

---2. WHO ARE THE TOP 5 CUSTOMERS WITH HIGHEST BANK BALANCE(JOINS)
SELECT
c.customer_name, a.balance
FROM customers c
JOIN accounts a 
ON c.customer_id = a.customer_id
ORDER BY a.balance DESC
LIMIT 5;

---3. WHICH BRANCH HAS THE MOST CUSTOMERS?
SELECT 
b.branch_name, COUNT(a.customer_id) AS total_customers
FROM branches b
JOIN accounts a
ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY total_customers DESC;

---4. WHICH BRANCH HOLDS THE HIGHEST TOTAL CUATOMER BALANCE?
SELECT
b.branch_name, SUM(a.balance) AS total_balance
FROM branches b
JOIN accounts a
ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY total_balance DESC;

---5. WHCIH CUSTOMERS HAVE A BALANCE GREATER THAN THE AVERAGE BALANCE OF ALL CUSTOMERS?
SELECT
c.customer_name, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.balance>
(
SELECT AVG(balance)
FROM accounts
)
ORDER BY a.balance DESC;

---6. RANK CUSTOMERS BY BALANCE?
SELECT 
c.customer_name, a.balance, RANK() OVER (ORDER BY a.balance DESC)
AS customer_rank
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

---7. Assign a unique row number to each customer
SELECT 
c.customer_name, a.balance, ROW_NUMBER() OVER (ORDER BY a.balance DESC) AS row_num
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

---8. TOP 3 CUSTOMERS USING CTE(COMMON TABLE EXPRESSION)
WITH customer_balances AS(
SELECT
c.customer_name,
a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
)

SELECT * 
FROM customer_balances
ORDER BY balance DESC
LIMIT 3;

---9. WHO IS THE HIGHEST BALANCE CUSTOMER IN EACH BRANCH?
WITH ranked_customers AS(
SELECT
b.branch_name,
c.customer_name,
a.balance,
RANK() OVER(
	PARTITION BY b.branch_name
	ORDER BY a.balance DESC
)AS rank_in_branch
FROM customers c
JOIN accounts a
	ON c.customer_id = a.customer_id
JOIN branches b
	ON a.branch_id = b.branch_id
)
SELECT
branch_name,
customer_name,
balance
FROM ranked_customers
WHERE rank_in_branch = 1
ORDER BY balance DESC;

---10. WHICH IS THE CUMULATIVE BALANCE AS WE MOVE FROM THE HIGHEST BALANCE CUSTOMER TO THE LOWEST?
SELECT 
c.customer_name,
a.balance,
SUM(a.balance) OVER (
ORDER BY a.balance DESC
) AS running_total
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

---11. HOW MUCH MONEY WAS DEPOSITED AND WITHDRAWN?
SELECT 
	transaction_type,
	SUM(amount) AS total_amount
FROM transactions
GROUP BY transaction_type;

---12. WHICH CUSTOMER MADE THE HIGHEST TRANSACTION?
SELECT
c.customer_name,
t.amount
FROM customers c
JOIN accounts a
	ON c.customer_id = a.customer_id
JOIN transactions t
	ON a.account_id = t.account_id
ORDER BY t.amount DESC
LIMIT 1;

---13. WHICH CUSTOMERS HAVE TRANSACTED MOST MONEY?
SELECT
c.customer_name,
SUM(t.amount) AS total_transaction_amount
FROM customers c
JOIN accounts a
	ON c.customer_id = a.customer_id
JOIN transactions t
	ON a.account_id = t.account_id
GROUP BY c.customer_name
ORDER BY total_transaction_amount DESC

---14. WHICH CUSTOMERS HAVE NEVER DONE ANY TRANSACTIONS AT ALL?
SELECT
c.customer_name,
t.transaction_id
FROM customers c
LEFT JOIN accounts a
	ON c.customer_id = a.customer_id
LEFT JOIN transactions t
	ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

---15. WHICH CUSTOMER HAVE A TOTAL TRANSACTION AMOUNT GREATER THAN 50000?
SELECT customer_name
FROM  customers
WHERE customer_id IN(
SELECT a.customer_id
FROM accounts a
JOIN transactions t
	ON a.account_id = t.account_id
GROUP BY a.customer_id
HAVING SUM(t.amount)>50000
);

---SAME QUERY USING CTE
WITH customer_totals AS(
	SELECT 
		a.customer_id,
		SUM(t.amount) AS total_amount
	FROM accounts a
	JOIN transactions t 
		ON a.account_id = t.account_id
	GROUP BY a.customer_id
)

SELECT
	c.customer_id,
	c.customer_name,
	ct.total_amount
FROM customers c
JOIN customer_totals ct
	ON c.customer_id = ct.customer_id
WHERE ct.total_amount > 50000
ORDER BY ct.total_amount DESC;

---16. FOR EACH CUSTOMERS TRANSACTIONS, SHOW THE PREVIOUS TRANSACTION AMOUNT.
SELECT 
 t.account_id,
 t.transaction_date,
 t.amount,
 LAG(t.amount)OVER(
	PARTITION BY t.account_id
	ORDER BY t.transaction_date
 )AS prev_transaction_amount
FROM transactions t;

select * from transactions;

---17. FIND CUSTOMERS WHO HAVE MORE THAN 1 ACCOUNT?
SELECT 
	c.customer_name,
	COUNT (a.account_id) AS total_accounts
FROM customers c 
JOIN accounts a 
ON c.customer_id = a.customer_id
GROUP BY c.customer_name
HAVING COUNT(a.account_id)>1;

---18. SHOW AVERAGE BALANCE PER CITY
SELECT
	c.city,
	AVG(a.balance) AS avg_balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city;

---19. FIND THE HIGHEST TRANSACTION PER ACCOUNT
SELECT *
FROM(
	SELECT
		account_id,
		transaction_date,
		amount,
		RANK()OVER(
			PARTITION BY account_id
			ORDER BY amount DESC NULLS LAST
		)AS rnk
		FROM transactions
)t
WHERE rnk=1;

---CASE WHEN QUERIES
---20. CLASSIFY CUSTOMERS BY AGE
SELECT 
	customer_name,
	age,
	CASE 
		WHEN age<30 THEN 'Young'
		WHEN age BETWEEN 30 and 40 THEN 'Adult'
		ELSE 'senior'
	END AS age_group
FROM customers;

---21. CLASSIFY ACCOUNTS BY BALANCE
SELECT
	account_id,
	balance,
	CASE
		WHEN balance<50000 THEN 'Low'
		WHEN balance BETWEEN 50000 AND 150000 THEN 'Medium'
		ELSE 'High'
	END AS balance_category
FROM accounts;

---22. CLASSIFY TRANSACTIONS
SELECT 
	transaction_id,
	transaction_type,
	amount,
	CASE
		WHEN transaction_type = 'Deposit' THEN 'Credit'
		ELSE 'Debit'
	END AS type_label
FROM transactions;

---23. FIND TOTAL DEPOSITED AND WITHDRAWN MONEY PER ACCOUNT
SELECT
	account_id,
	SUM(CASE WHEN LOWER(transaction_type)='deposit' THEN amount
	ELSE 0
	END) AS total_credit,

	SUM(CASE WHEN LOWER(transaction_type)='withdrawal' THEN amount
	ELSE 0
	END) AS total_debit

FROM transactions
GROUP BY account_id;

---24. NET BALANCE MOVEMENT PER ACCOUNT
SELECT
	account_id,
	SUM(CASE WHEN LOWER(transaction_type)='deposit'
THEN amount
	ELSE-amount
	END)AS net_flow
FROM transactions
GROUP BY account_id;

---25. SHOW EACH CUSTOMER'S TOTAL DEPOSIT AND WITHDRAWAL
SELECT 
	c.customer_name,
	SUM(CASE WHEN LOWER(t.transaction_type)='deposit'
THEN t.amount
	ELSE 0
END)AS total_credit,

	SUM(CASE WHEN LOWER(t.transaction_type)='withdrawal' THEN t.amount
	ELSE 0
	END)AS total_debit
FROM customers c
JOIN accounts a ON c.customer_id=a.customer_id
JOIN transactions t ON a.account_id=t.account_id
GROUP BY c.customer_name;