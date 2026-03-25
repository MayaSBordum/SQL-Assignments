/*
Drop TABLE customers;
Drop TABLE products;
Drop TABLE orders;
Drop TABLE order_items;
*/


CREATE TABLE customers (
	bruger_id SERIAL PRIMARY KEY, 
	navn VARCHAR(30) NOT NULL, 
	email VARCHAR(50) NOT NULL, 
	by VARCHAR(30) NOT NULL, 
	oprettelsesdato date NOT NULL
);
	

CREATE TABLE products (
	produkt_id SERIAL PRIMARY KEY,
	navn VARCHAR(50) NOT NULL,
	kategori VARCHAR(30) NOT NULL, 
	pris INTEGER NOT NULL, 
	lagerantal INTEGER NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    bruger_id INTEGER NOT NULL,
    order_date  DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (bruger_id) REFERENCES customers(bruger_id)
);

CREATE TABLE order_items (
	order_item_id SERIAL PRIMARY KEY,
	order_id INTEGER NOT NULL,
	produkt_id INTEGER NOT NULL,
	antal INT NOT NULL,
	enhedspris INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (produkt_id) REFERENCES products(produkt_id)
);
