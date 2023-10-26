-- create master table by joining other tables
-- use to review and analyze data
SELECT card_holder.name, credit_card.card, transaction.date, transaction.amount, merchant.name AS merchant, merchant_category.name AS category
FROM transaction
JOIN credit_card ON credit_card.card = transaction.card
JOIN card_holder ON card_holder.id = credit_card.cardholder_id
JOIN merchant ON merchant.id = transaction.id_merchant
JOIN merchant_category ON merchant_category.id = merchant.id_merchant_category
ORDER BY card_holder.name;

-- count and keep track of the transactions that < $2
-- to identify any potential fraudulent charges
SELECT COUNT(transaction.amount) AS "Transactions less than to $2.00"
FROM transaction
WHERE transaction.amount < 2;

-- identifies and organizes all transactions less than or equal to $2
SELECT *
FROM transaction
WHERE transaction.amount < 2
ORDER BY transaction.card, transaction.date DESC;

-- review of time between 7 to 9 am
-- what do the transactions during this time look like?
-- how many are there?
SELECT *
FROM transaction
WHERE date_part('hour', transaction.date) >= 7 AND date_part('hour', transaction.date) <= 9
LIMIT 100;

SELECT COUNT(transaction.amount) AS "Transactions less that $2.00 between 7 and 9 am:"
FROM transaction
WHERE transaction.amount < 2 
AND date_part('hour', transaction.date) >= 7 
AND date_part('hour', transaction.date) <= 9;


-- identify top 5 merchants to have this type of activity
SELECT merchant.name AS merchant, merchant_category.name AS category,
        COUNT(transaction.amount) AS micro_transactions
FROM transaction
JOIN merchant ON merchant.id = transaction.id_merchant
JOIN merchant_category ON merchant_category.id = merchant.id_merchant_category
WHERE transaction.amount < 2
GROUP BY merchant.name, merchant_category.name
ORDER BY micro_transactions DESC
LIMIT 5;

-- following are all views for queries

CREATE VIEW transactions_per_card_holder AS
  SELECT card_holder.name, credit_card.card, transaction.date, transaction.amount, merchant.name AS merchant,
          merchant_category.name AS category
  FROM transaction
  JOIN credit_card ON credit_card.card = transaction.card
  JOIN card_holder ON card_holder.id = credit_card.cardholder_id
  JOIN merchant ON merchant.id = transaction.id_merchant
  JOIN merchant_category ON merchant_category.id = merchant.id_merchant_category
  ORDER BY card_holder.name;

CREATE VIEW micro_transactions AS
  SELECT *
  FROM transaction
  WHERE transaction.amount < 2
  ORDER BY transaction.card, transaction.amount DESC;

CREATE VIEW count_micro_transactions AS
  SELECT COUNT(transaction.amount) AS "Transactions less that $2.00"
  FROM transaction
  WHERE transaction.amount < 2;

CREATE VIEW morning_higher_transactions AS
  SELECT *
  FROM transaction
  WHERE date_part('hour', transaction.date) >= 7 AND date_part('hour', transaction.date) <= 9
  ORDER BY amount DESC
  LIMIT 100;

CREATE VIEW count_micro_transactions_morning AS
  SELECT COUNT(transaction.amount) AS "Transactions less that $2.00 during AM"
  FROM transaction
  WHERE transaction.amount < 2 
  AND date_part('hour', transaction.date) >= 7 
  AND date_part('hour', transaction.date) <= 9;

CREATE VIEW top_hacked_merchants_micro_transactions AS
  SELECT merchant.name AS merchant, merchant_category.name AS category,
          COUNT(transaction.amount) AS micro_transactions
  FROM transaction
  JOIN merchant ON merchant.id = transaction.id_merchant
  JOIN merchant_category ON merchant_category.id = merchant.id_merchant_category
  WHERE transaction.amount < 2
  GROUP BY merchant.name, merchant_category.name
  ORDER BY micro_transactions DESC
  LIMIT 5;