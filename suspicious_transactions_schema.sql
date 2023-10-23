-- schema to create tables for data
-- table information collected from .csv files

-- creates card_holder table
CREATE TABLE card_holder(
    id INT PRIMARY KEY,
    name VARCHAR
);

-- creates credit_card table
CREATE TABLE credit_card(
    card VARCHAR(20) PRIMARY KEY,
    cardholder_id INT,
    FOREIGN KEY (cardholder_id) REFERENCES card_holder(id)
);

-- creates merchant_category table
CREATE TABLE merchant_category(
    id INT PRIMARY KEY,
    name VARCHAR
);

-- creates merchant table
CREATE TABLE merchant(
    id INT PRIMARY KEY,
    name VARCHAR,
    id_merchant_category INT,
    FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

-- creates transaction table
CREATE TABLE transaction(
    id INT PRIMARY KEY,
    date TIMESTAMP,
    amount FLOAT,
    card VARCHAR(20),
    id_merchant INT,
    FOREIGN KEY (id_merchant) REFERENCES merchant(id),
    FOREIGN KEY (card) REFERENCES credit_card(card)
);

DROP TABLE IF EXISTS card_holder CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS merchant CASCADE;
DROP TABLE IF EXISTS merchant_category CASCADE;
DROP TABLE IF EXISTS transaction CASCADE;