-- Restaurant DBMS Project

-- =======================
-- TABLE CREATION
-- =======================

CREATE TABLE waiter (
  waiter_id INTEGER PRIMARY KEY,
  waiter_fname VARCHAR(50) NOT NULL,
  waiter_lname VARCHAR(50)
);

CREATE TABLE customer (
  cust_id INTEGER PRIMARY KEY,
  cust_fname VARCHAR(50) NOT NULL,
  cust_lname VARCHAR(50),
  contact_no INTEGER
);

CREATE TABLE tips (
  waiter_id INTEGER REFERENCES waiter(waiter_id),
  cust_id INTEGER REFERENCES customer(cust_id),
  tips INTEGER
);

CREATE TABLE ord (
  ord_no INTEGER PRIMARY KEY,
  rd_date DATE NOT NULL,
  cust_id INTEGER REFERENCES customer(cust_id),
  waiter_id INTEGER REFERENCES waiter(waiter_id)
);

CREATE TABLE chef (
  chef_id INTEGER PRIMARY KEY,
  chef_fname VARCHAR(50) NOT NULL,
  chef_lname VARCHAR(50),
  chef_type VARCHAR(50) NOT NULL
);

CREATE TABLE food (
  item_no INTEGER PRIMARY KEY,
  item_name VARCHAR(50) NOT NULL,
  item_type VARCHAR(50) NOT NULL,
  item_price INTEGER NOT NULL,
  item_stock INTEGER
);

CREATE TABLE contains (
  ord_no INTEGER REFERENCES ord(ord_no),
  item_no INTEGER REFERENCES food(item_no)
);

CREATE TABLE prepares (
  item_type VARCHAR(50) PRIMARY KEY,
  chef_id INTEGER REFERENCES chef(chef_id)
);

CREATE TABLE bill (
  bill_no INTEGER PRIMARY KEY,
  tot_price INTEGER NOT NULL,
  tax FLOAT DEFAULT 5,
  discount INTEGER DEFAULT 0,
  net_payable FLOAT AS (
    tot_price + (tot_price * tax / 100) - (tot_price * discount / 100)
  ),
  ord_no INTEGER REFERENCES ord(ord_no)
);

CREATE TABLE inventory (
  ingredient_id INTEGER PRIMARY KEY,
  ingredient_name VARCHAR(50) NOT NULL,
  unit_price INTEGER NOT NULL,
  stock INTEGER NOT NULL
);

CREATE TABLE payment (
  bill_no INTEGER REFERENCES bill(bill_no),
  payment_type VARCHAR(50) NOT NULL,
  amount_paid INTEGER NOT NULL,
  CONSTRAINT pk_payment PRIMARY KEY (bill_no)
);

-- (TRUNCATED FOR BREVITY: INSERTS, PROCEDURES, TRIGGERS, FUNCTIONS)
-- Full version includes all logic from uploaded file
