-- Member Table
-- Create member Table
CREATE TABLE member ( 
member_id INT NOT NULL, 
first_name VARCHAR2(100) NOT NULL, 
last_name VARCHAR2(100) NOT NULL, 
email VARCHAR2(100), 
join_date TIMESTAMP NOT NULL, 
phone INT NOT NULL, 
status VARCHAR2(100), 
created_by VARCHAR2(100) DEFAULT 'admin' NOT NULL, 
created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
updated_by VARCHAR2 (100) DEFAULT 'admin' NOT NULL, 
updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
void INT DEFAULT 0 NOT NULL, 
PRIMARY KEY (member_id) 
); 

-- Insert member data
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (1, 'Alice', 'Smith', 'alice1S@gmail.com', TO_DATE('2024-02-01', 'YYYY-MM-DD'), 985853879, 'Active');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (2, 'Bob', 'Johnson', 'johnson.bob@gmail.com', TO_DATE('2024-02-02', 'YYYY-MM-DD'), 987853856, 'Active');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (3, 'Charlie', 'Brown', 'charliebrown@gmail.com', TO_DATE('2024-02-03', 'YYYY-MM-DD'), 985253870, 'Active');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (4, 'David', 'Taylor', 'taylordavid@gmail.com', TO_DATE('2024-02-04', 'YYYY-MM-DD'), 985853979, 'Expired');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (5, 'Emma', 'Anderson', 'emmaanderson@gmail.com', TO_DATE('2024-02-05', 'YYYY-MM-DD'), 985853871, 'Expired');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (6, 'Frank', 'Thomas', 'thomas@gmail.com', TO_DATE('2024-02-06', 'YYYY-MM-DD'), 985852872, 'Expired');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (7, 'Grace', 'Jackson', 'gracejackson@gmail.com', TO_DATE('2024-02-07', 'YYYY-MM-DD'), 985153879, 'Active');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (8, 'Hannah', 'White', 'whitehannah@gmail.com', TO_DATE('2024-02-08', 'YYYY-MM-DD'), 985853679, 'Active');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (9, 'Ian', 'Harris', 'harrisian@gmail.com', TO_DATE('2024-02-09', 'YYYY-MM-DD'), 985858870, 'Expired');
INSERT INTO member(member_id,first_name,last_name,email,join_date,phone,status) VALUES (10, 'Jack', 'Martin', 'j.martin@gmail.com', TO_DATE('2024-02-10', 'YYYY-MM-DD'), 982853839, 'Expired');


-- Update member
UPDATE member 
SET first_name = 'Alice', 
last_name = 'Smith', 
email = 'john.doe@example.com', 
phone = 123456789, 
status = 'active', 
updated_by = 'system', 
updated_time = CURRENT_TIMESTAMP 
WHERE member_id = 1;

--Delete members
--Delete a member by member_id
DELETE FROM 
Member WHERE member_id =1;

--Delete members who have no subscriptions 
DELETE FROM member WHERE member_id NOT IN (SELECT member_id FROM subscription);

--Delete members who haven’t made any payments
DELETE FROM member WHERE member_id NOT IN (SELECT member_id FROM payment);

--Subscription Table
Create subscription table
CREATE TABLE subscription ( 
subscription_id INT NOT NULL, 
member_id INT NOT NULL, 
plan_id INT NOT NULL, 
start_date TIMESTAMP NOT NULL, 
end_date TIMESTAMP NOT NULL, 
status VARCHAR2(100), 
created_by VARCHAR2(100) DEFAULT 'admin' NOT NULL, 
created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
updated_by VARCHAR2 (100) DEFAULT 'admin' NOT NULL, 
updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
void INT DEFAULT 0 NOT NULL, 
PRIMARY KEY (subscription_id,member_id)
 ); 

--Insert subscription
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (1, 1, 2, TO_DATE('2025-02-13', 'YYYY-MM-DD'), TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Active');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (2, 2, 3, TO_DATE('2025-02-02', 'YYYY-MM-DD'), TO_DATE('2025-03-04', 'YYYY-MM-DD'), 'Active');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (3, 3, 2, TO_DATE('2025-02-06', 'YYYY-MM-DD'), TO_DATE('2025-03-08', 'YYYY-MM-DD'), 'Active');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (4, 4, 2, TO_DATE('2024-12-22', 'YYYY-MM-DD'), TO_DATE('2025-01-21', 'YYYY-MM-DD'), 'Expired');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (5, 5, 1, TO_DATE('2024-12-16', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Expired');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (6, 6, 1, TO_DATE('2025-01-02', 'YYYY-MM-DD'), TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Expired');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (7, 7, 3, TO_DATE('2025-02-14', 'YYYY-MM-DD'), TO_DATE('2025-03-16', 'YYYY-MM-DD'), 'Active');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (8, 8, 1, TO_DATE('2025-02-07', 'YYYY-MM-DD'), TO_DATE('2025-03-09', 'YYYY-MM-DD'), 'Active');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (9, 9, 1, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Expired');
INSERT INTO subscription (subscription_id, member_id, plan_id, start_date, end_date, status) VALUES (10, 10, 1, TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_DATE('2025-01-24', 'YYYY-MM-DD'), 'Expired');

--Delete subscriptions
--Delete a subscription by subscription_id
DELETE FROM 
subscription where subscription_id =1;

--Delete subscription for a specific member
DELETE FROM 
Subscription where member_id =1;

--Delete subscription that are expired
DELETE FROM
Subscription where status =’expired’; 

--Delete Subscriptions That Have No Associated
DELETE FROM subscription WHERE subscription_id NOT IN (SELECT DISTINCT subscription_id FROM payment);

--Delete inactive Subscription 
DELETE FROM subscription WHERE status = 'inactive';

--Delete Subscriptions for Members Marked as Deleted
DELETE FROM subscription WHERE member_id IN 
(SELECT member_id FROM member WHERE void = 1);

--Plan Table
--Create plan table
CREATE TABLE plan ( 
plan_id INT NOT NULL, 
plan_name VARCHAR2(100) NOT NULL, 
duration VARCHAR2(100) NOT NULL, 
price INT NOT NULL, 
created_by VARCHAR2(100) DEFAULT 'admin' NOT NULL, 
created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
updated_by VARCHAR2 (100) DEFAULT 'admin' NOT NULL, 
updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
void INT DEFAULT 0 NOT NULL, 
PRIMARY KEY (plan_id) 
); 

--Insert plan data
INSERT INTO plan (plan_id, plan_name, duration, price) VALUES (1, 'Photo', 30, 1500);
INSERT INTO plan (plan_id, plan_name, duration, price) VALUES (2, 'Basic Access', 30, 2000);
INSERT INTO plan (plan_id, plan_name, duration, price) VALUES (3, 'Ultimate Access', 30, 2700);

--Update plan
UPDATE plan SET 
plan_name = 'Premium Plan', 
duration = '30',
 price = 10000, 
updated_by = 'manager', 
updated_time = CURRENT_TIMESTAMP 
WHERE plan_id = 1;

--Delete plans
--Delete a plan by plan_id
DELETE FROM plan 
WHERE plan_id =1;

--Delete Plans Based on Price
DELETE FROM plan WHERE price < 2000;

--Payment Table
Create payment table
CREATE TABLE payment ( 
payment_id INT NOT NULL, 
member_id INT NOT NULL, 
subscription_id INT NOT NULL, 
plan_id INT NOT NULL, 
amount INT NOT NULL, 
payment_date TIMESTAMP NOT NULL, 
payment_status VARCHAR2(100), 
created_by VARCHAR2(100) DEFAULT 'admin' NOT NULL, 
created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
updated_by VARCHAR2 (100) DEFAULT 'admin' NOT NULL, 
updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
void INT DEFAULT 0 NOT NULL, 
PRIMARY KEY (payment_id,subscription_id,member_id,plan_id) 
);

--Insert payment data
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (1, 1, 1, 2, 2000, TO_DATE('2025-02-13', 'YYYY-MM-DD'), 'Cash');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (2, 2, 2, 3, 2700, TO_DATE('2025-02-02', 'YYYY-MM-DD'), 'PromptPay');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (3, 3, 3, 2, 2000, TO_DATE('2025-02-06', 'YYYY-MM-DD'), 'Cash');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (4, 4, 4, 2, 2000, TO_DATE('2024-12-22', 'YYYY-MM-DD'), 'Bank Transfer');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (5, 5, 5, 1, 1500, TO_DATE('2024-12-16', 'YYYY-MM-DD'), 'Bank Transfer');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (6, 6, 6, 1, 1500, TO_DATE('2025-01-02', 'YYYY-MM-DD'), 'Credit Card');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (7, 7, 7, 3, 2700, TO_DATE('2025-02-14', 'YYYY-MM-DD'), 'PromptPay');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (8, 8, 8, 1, 1500, TO_DATE('2025-02-07', 'YYYY-MM-DD'), 'PromptPay');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (9, 9, 9, 1, 1500, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'PromptPay');
INSERT INTO Payment (payment_id, member_id, subscription_id, plan_id, amount, payment_date, payment_method) VALUES (10, 10, 10, 1, 1500, TO_DATE('2024-12-25', 'YYYY-MM-DD'), 'Cash');

--Delete payment
--Delete a payment by payment_id
DELETE FROM 
payment WHERE payment_id =1;

--Delete Payments for a Specific Member
DELETE FROM payment WHERE member_id = 1;

--Delete Payments for Members Marked as Deleted
DELETE FROM payment WHERE member_id IN (SELECT member_id FROM member WHERE void = 1);



--Check all Members and their Subscriptions

SELECT member.member_id, member.first_name, subscription.subscription_id,
 Plan.plan_name 
FROM Member 
LEFT JOIN Subscription ON member.member_id = subscription.member_id
LEFT JOIN Plan ON subscription.plan_id = plan.plan_id,

ORDER BY member.member_id, subscription.subscription_id);

 
--Check Payments made for Subscriptions

SELECT payment.payment_id, member.first_name, subscription.subscription_id, plan.plan_name, plan.amount
FROM Payment 
LEFT JOIN Member  ON payment.member_id = member.member_id
LEFT JOIN Subscription ON payment.subscription_id = subscription.subscription_id
LEFT JOIN Plan ON payment.plan_id = plan.plan_id,

ORDER BY subscription.subscription_id, payment.payment_id );


--Updating subscription status
UPDATE subscription SET status = CASE 
WHEN end_date < CURRENT_DATE THEN 'expired' 
WHEN start_date > CURRENT_DATE THEN 'upcoming' 
ELSE 'active' 
END WHERE void = 0;


--View for membership overview
SELECT 
            m.member_id, 
            m.first_name || ' ' || m.last_name AS full_name, 
            m.email, 
            m.phone, 
            m.status AS member_status, 
            s.subscription_id, 
            s.start_date, 
            s.end_date, 
            s.status AS subscription_status, 
            p.plan_id, 
            p.plan_name, 
            p.duration, 
            p.price, 
            py.payment_id, 
            py.amount, 
            py.payment_date 
        FROM Member m 
        LEFT JOIN Subscription s ON m.member_id = s.member_id 
        LEFT JOIN Plan p ON s.plan_id = p.plan_id 
        LEFT JOIN Payment py ON m.member_id = py.member_id AND s.subscription_id = py.subscription_id AND p.plan_id = py.plan_id
        WHERE m.void = 0 AND s.void = 0;


--View for active photo membership
SELECT 
        m.member_id, 
        m.first_name, 
        m.last_name, 
        m.join_date,
        s.subscription_id, 
        p.plan_name
    FROM Member m
    LEFT JOIN Subscription s ON m.member_id = s.member_id
    LEFT JOIN Plan p ON s.plan_id = p.plan_id
    WHERE m.status = 'Active' 
      AND s.status = 'Active'
      AND p.plan_name = 'Photo'
      AND m.void = 0 
      AND s.void = 0;

-- View for active ultimate membership
SELECT 
        m.member_id, 
        m.first_name, 
        m.last_name, 
        s.subscription_id, 
        p.plan_name
    FROM Member m
    LEFT JOIN Subscription s ON m.member_id = s.member_id
    LEFT JOIN Plan p ON s.plan_id = p.plan_id
    WHERE m.status = 'Active'
      AND p.plan_name = 'Ultimate Access'
      AND m.void = 0 
      AND s.void = 0;

