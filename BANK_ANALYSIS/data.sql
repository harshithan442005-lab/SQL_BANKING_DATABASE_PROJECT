INSERT INTO customers (customer_name, gender, age, city, join_date)
VALUES
('Rahul Sharma', 'Male', 28, 'Mumbai', '2023-01-15'),
('Priya Patel', 'Female', 32, 'Ahmedabad', '2022-11-20'),
('Amit Kumar', 'Male', 40, 'Delhi', '2021-06-10'),
('Sneha Reddy', 'Female', 25, 'Hyderabad', '2023-08-05'),
('Arjun Singh', 'Male', 35, 'Bangalore', '2022-03-18'),
('Neha Gupta', 'Female', 29, 'Mumbai', '2022-05-10'),
('Rohan Verma', 'Male', 34, 'Delhi', '2021-09-15'),
('Anjali Mehta', 'Female', 27, 'Ahmedabad', '2023-02-20'),
('Karan Malhotra', 'Male', 38, 'Bangalore', '2020-11-12'),
('Pooja Nair', 'Female', 31, 'Hyderabad', '2022-07-08'),
('Vikram Rao', 'Male', 45, 'Chennai', '2019-04-25'),
('Meera Iyer', 'Female', 26, 'Chennai', '2023-06-14'),
('Suresh Kumar', 'Male', 41, 'Mumbai', '2021-01-18'),
('Divya Sharma', 'Female', 30, 'Delhi', '2022-10-05'),
('Nikhil Jain', 'Male', 33, 'Ahmedabad', '2020-08-30'),
('Kavya Reddy', 'Female', 24, 'Hyderabad', '2024-01-10'),
('Manish Singh', 'Male', 37, 'Bangalore', '2021-03-22'),
('Aisha Khan', 'Female', 28, 'Mumbai', '2023-09-01'),
('Deepak Yadav', 'Male', 36, 'Delhi', '2020-06-17'),
('Shreya Patel', 'Female', 32, 'Ahmedabad', '2022-12-11');

SELECT COUNT(*) AS total_customers
FROM customers;

INSERT INTO branches (branch_name, city) 
VALUES
('Mumbai Central', 'Mumbai'),
('Delhi Main', 'Delhi'),
('Bangalore Tech Park', 'Bangalore'),
('Hyderabad City', 'Hyderabad'),
('Ahmedabad West', 'Ahmedabad');

SELECT COUNT(*) AS total_branches
FROM branches;

INSERT INTO accounts (customer_id, account_type, balance, branch_id)
VALUES
(1, 'Savings', 85000, 1),
(2, 'Current', 120000, 5),
(3, 'Savings', 250000, 2),
(4, 'Savings', 65000, 4),
(5, 'Current', 180000, 3),
(6, 'Savings', 95000, 1),
(7, 'Current', 140000, 2),
(8, 'Savings', 72000, 5),
(9, 'Current', 210000, 3),
(10, 'Savings', 110000, 4),
(11, 'Savings', 155000, 1),
(12, 'Current', 300000, 2),
(13, 'Savings', 45000, 4),
(14, 'Current', 175000, 3),
(15, 'Savings', 98000, 5),
(16, 'Current', 225000, 1),
(17, 'Savings', 135000, 2),
(18, 'Current', 280000, 3),
(19, 'Savings', 125000, 4),
(20, 'Current', 165000, 5);

SELECT * FROM customers;
