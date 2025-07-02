-- Step 1: Create the Account Table
CREATE TABLE account (
    acc_id SERIAL PRIMARY KEY,
    fname VARCHAR(100) NOT NULL,
    lname VARCHAR(100) NOT NULL,
    mail_id VARCHAR(255) UNIQUE NOT NULL,
    joined_on TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    modified_on TIMESTAMPTZ
);

-- Step 2: Select All Accounts
SELECT * FROM account;

-- Step 3: Drop the Account Table If Exists
DROP TABLE IF EXISTS account;

-- Step 4: Add a New Column to Account
ALTER TABLE account ADD COLUMN status BOOLEAN;

-- Step 5: Drop the Newly Added Column
ALTER TABLE account DROP COLUMN status;

-- Step 6: Rename Columns
ALTER TABLE account RENAME COLUMN mail_id TO email_address;
ALTER TABLE account RENAME COLUMN email_address TO mail_id;

-- Step 7: Rename Table
ALTER TABLE account RENAME TO profiles;
ALTER TABLE profiles RENAME TO account;

-- Step 8: Create Transaction Table
CREATE TABLE transaction (
    txn_id SERIAL PRIMARY KEY,
    acc_id INT NOT NULL REFERENCES account(acc_id),
    txn_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    txn_code VARCHAR(50) NOT NULL,
    txn_amount DECIMAL(10,2) NOT NULL
);

-- Step 9: Insert a Single Record in Account
INSERT INTO account (fname, lname, mail_id, joined_on, modified_on, status)
VALUES ('aayushi', 'bhatiya', 'aayushi.bhatiya@openbox.com', NOW(), NULL, true);

-- Step 10: Insert Multiple Account Records
INSERT INTO account (fname, lname, mail_id, joined_on, modified_on, status) VALUES
  ('aayush', 'sharma', 'aayush.sharma@example.com', NOW(), NULL, true),
  ('kiara', 'jain', 'kiara.jain@example.com', NOW(), NULL, true),
  ('sidya', 'desai', 'sid.desai@example.com', NOW(), NULL, true),
  ('rohan', 'patel', 'rohan.p@example.com', NOW(), NULL, true),
  ('aryan', 'rao', 'aryan.rao@example.com', NOW(), NULL, false),
  ('vivek', 'kumar', 'vivek.k@example.com', NOW(), NULL, true),
  ('kunal', 'Malahar', 'kunal.mal@example.com', NOW(), NULL, true),
  ('nalini', 'rao', 'avni.rao@example.com', NOW(), NULL, true),
  ('priya', 'Shah', 'priya.s@example.com', NOW(), NULL, false),
  ('Pinal', 'Gavar', 'pihu.g@example.com', NOW(), NULL, false),
  ('Nila', 'Minar', 'nila.minar@example.com', NOW(), NULL, true),
  ('raghav', 'saxsena', 'raghav.s@example.com', NOW(), NULL, true),
  ('riya', 'Shamar', 'riya.s@example.com', NOW(), NULL, false),
  ('piyush', 'rathod', 'rudra.rathod@example.com', NOW(), NULL, false);

-- Step 11: Insert Transactions
INSERT INTO transaction (acc_id, txn_date, txn_code, txn_amount) VALUES
  (1, '2024-02-01', 'TXN001', 50.00),
  (2, '2024-02-01', 'TXN002', 55.00),
  (3, '2024-02-01', 'TXN003', 85.00),
  (4, '2024-02-01', 'TXN004', 41.50),
  (5, '2024-02-01', 'TXN005', 55.75),
  (6, '2024-02-01', 'TXN006', 85.60),
  (7, '2024-02-01', 'TXN007', 95.10),
  (8, '2024-02-01', 'TXN008', 78.20),
  (9, '2024-02-01', 'TXN009', 120.00),
  (10,'2024-02-01', 'TXN010', 66.25),
  (1, '2024-02-02', 'TXN011', 70.00),
  (1, '2024-02-03', 'TXN012', 80.00),
  (2, '2024-02-04', 'TXN013', 67.77),
  (3, '2024-02-04', 'TXN014', 35.00),
  (1, '2024-02-05', 'TXN015', 89.99),
  (2, '2024-02-06', 'TXN016', 38.20),
  (2, '2024-02-07', 'TXN017', 47.00),
  (2, '2024-02-08', 'TXN018', 22.72);

-- Step 12: Basic Select Queries
SELECT fname FROM account;
SELECT fname, lname, mail_id FROM account;
SELECT * FROM account;

-- Step 13: ORDER BY
SELECT fname, lname FROM account ORDER BY fname ASC;
SELECT fname, lname FROM account ORDER BY lname DESC;
SELECT acc_id, fname, lname FROM account ORDER BY fname ASC, lname DESC;

-- Step 14: WHERE Clause
SELECT lname, fname FROM account WHERE fname = 'piyush';
SELECT acc_id, fname, lname FROM account WHERE fname = 'piyush' OR lname = 'jain';
SELECT acc_id, fname, lname FROM account WHERE fname IN ('aayush', 'kunal', 'priya');
SELECT fname, lname FROM account WHERE fname LIKE '%RA%';
SELECT fname, lname FROM account WHERE fname ILIKE '%RA%';

-- Step 15: JOINs
SELECT * FROM transaction AS t INNER JOIN account AS a ON t.acc_id = a.acc_id;
SELECT * FROM account AS a LEFT JOIN transaction AS t ON a.acc_id = t.acc_id;

-- Step 16: Aggregation with GROUP BY
SELECT a.acc_id, a.fname, a.lname, a.mail_id,
       COUNT(t.txn_id) AS txn_count,
       SUM(t.txn_amount) AS total_spent
FROM account AS a
JOIN transaction AS t ON a.acc_id = t.acc_id
GROUP BY a.acc_id;

-- Step 17: GROUP BY with HAVING
SELECT a.acc_id, a.fname, a.lname, a.mail_id,
       COUNT(t.txn_id) AS txn_count,
       SUM(t.txn_amount) AS total_spent
FROM account AS a
JOIN transaction AS t ON a.acc_id = t.acc_id
GROUP BY a.acc_id
HAVING COUNT(t.txn_id) > 2;

-- Step 19: Subqueries
-- IN operator
SELECT * FROM transaction WHERE acc_id IN (
  SELECT acc_id FROM account WHERE status = true
);

-- EXISTS operator
SELECT acc_id, fname, lname, mail_id
FROM account
WHERE EXISTS (
  SELECT 1 FROM transaction WHERE transaction.acc_id = account.acc_id
);

-- Step 20: Update Statement
UPDATE account
SET fname = 'aayushi', lname = 'bhatiya', mail_id = 'aayushi.bhatiya@openbox.com'
WHERE acc_id = 1;

-- Step 21: Delete Statement
DELETE FROM account WHERE acc_id = 11;
