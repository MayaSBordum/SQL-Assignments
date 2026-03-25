-- C1–C5: SELECT, WHERE, ORDER BY
-- C1 Hent alle produkter, der koster mere end 200 kr. — vis navn, kategori og pris.
SELECT navn, kategori, pris FROM products WHERE pris > 200;

-- C2 Vis navn og by paa alle kunder fra Aarhus eller Odense (brug IN eller OR).
SELECT navn, by FROM Customers
WHERE by IN ('Aarhus', 'Odense');

-- C3 Find alle ordrer med status 'pending', sorteret efter ordredato — nyeste først.
SELECT * FROM orders 
WHERE status = 'pending' 
ORDER BY order_date DESC;

-- C4 Hent de 10 dyreste produkter. Vis kun navn og pris.
SELECT * FROM products
ORDER BY pris DESC
FETCH FIRST 10 ROWS ONLY;

-- C5 Vis alle produkter med færre end 5 stk. paa lager — sorteret efter lagerantal stigende
SELECT * FROM products
WHERE lagerantal <= 5
ORDER BY lagerantal ASC;



-- C6–C10: Aggregering og gruppering
-- C6 Tæll hvor mange ordrer der findes af hver status. Vis status og antal.
SELECT status, COUNT(status) AS "Total af Status"
FROM orders 
GROUP BY status;

-- C7 Beregn den samlede omsætning pr. ordre (SUM af quantity * unit_price) 
-- fra order_items — vis ordre-id og totalbeløb, sorteret med den dyreste øverst.
SELECT order_id, SUM(antal * enhedspris) AS total_beløb
FROM order_items
GROUP BY order_id
ORDER BY total_beløb DESC;

-- C8 Find det produkt, der er solgt i flest enheder i alt. Vis kun det ene produkt.
SELECT produkt_id, SUM(antal) AS mest_solgt 
FROM order_items
GROUP BY produkt_id
ORDER BY mest_solgt DESC
LIMIT 1;

-- C9 Vis antal kunder pr. by — kun byer med mere end 1 kunde (brug HAVING).
SELECT COUNT(*) AS people, customers.by
FROM customers
GROUP BY by
HAVING COUNT(by)> 1;

-- C10 Beregn gennemsnitsprisen paa produkter inden for hver kategori — sorteret faldende.
SELECT kategori, AVG(pris) AS gennemsnitspris
FROM products
GROUP BY kategori
ORDER BY gennemsnitspris DESC;


-- C11–C15: JOIN. Brug JOIN til at kombinere data fra flere tabeller.
-- C11 Vis kundenavn, ordredato og status for alle afsluttede ordrer (completed).
SELECT customers.navn, orders.order_date, orders.status
FROM orders
JOIN customers ON orders.bruger_id = customers.bruger_id
WHERE orders.status = 'completed';

-- C12 Vis produktnavn og samlet antal solgte enheder pr. produkt — sorteret faldende.
SELECT products.navn, SUM(order_items.antal) AS solgte_enheder
FROM order_items
JOIN products ON order_items.produkt_id = products.produkt_id
GROUP BY products.navn
ORDER BY solgte_enheder DESC;

-- C13 Find de 5 kunder, der har afgivet flest ordrer — vis navn og antal ordrer.
SELECT customers.navn, COUNT(orders.order_id) AS antal_ordrer
FROM orders
JOIN customers ON orders.bruger_id = customers.bruger_id
GROUP BY customers.bruger_id, customers.navn
ORDER BY antal_ordrer DESC
LIMIT 5;

-- C14 Vis en komplet ordreoversigt: ordre-id, kundenavn, produktnavn, antal og linjepris 
-- (quantity * unit_price). Vis kun completed ordrer.
SELECT 
	orders.order_id, 
	customers.navn AS kundenavn, 
	products.navn AS produktnavn, 
	order_items.antal, 
	(order_items.antal * order_items.enhedspris) AS linjepris
FROM orders
JOIN customers ON orders.bruger_id = customers.bruger_id
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.produkt_id = products.produkt_id
WHERE orders.status = 'completed';

-- C15 Beregn den samlede omsætning pr. kunde (kun completed ordrer) — vis kundenavn og totalbeløb, 
-- sorteret med den højeste øverst.
SELECT 
	customers.navn, 
	SUM(order_items.antal * order_items.enhedspris) AS totalbeløb
FROM customers
JOIN orders ON orders.bruger_id = customers.bruger_id
JOIN order_items ON orders.order_id = order_items.order_id
WHERE orders.status = 'completed'
GROUP BY customers.navn
ORDER BY totalbeløb DESC;



-- C16–C18: Udfordringsopgaver
-- Disse tre opgaver kræver lidt mere. Brug PostgreSQL-dokumentationen, hvis du sidder fast.

-- C16 Find den bedst sælgende produktkategori maalt paa samlet omsætning (kun completed ordrer).
SELECT 
	products.kategori, 
	SUM(order_items.antal * order_items.enhedspris) AS totalbeløb
FROM products
JOIN order_items ON order_items.produkt_id = products.produkt_id
JOIN orders ON orders.order_id = order_items.order_id
WHERE orders.status = 'completed'
GROUP BY products.kategori
ORDER BY totalbeløb DESC
LIMIT 1;

-- C17 Beregn den maanedlige omsætning for hele perioden. Brug DATE_TRUNC('month', order_date) til at 
-- gruppere paa maaned. Vis maaned og omsætning sorteret kronologisk.
SELECT
	DATE_TRUNC('month', orders.order_date) AS måned,
	SUM(order_items.antal * order_items.enhedspris) AS totalbeløb
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY måned
ORDER BY måned ASC;

-- C18 Find kunder, der har afgivet mindst een ordre, men INGEN completed ordrer. 
-- (Hint: brug LEFT JOIN + WHERE status IS NULL, eller NOT EXISTS.)
SELECT * 
FROM customers
WHERE EXISTS (
    SELECT *
    FROM orders 
    WHERE orders.bruger_id = customers.bruger_id
)
AND NOT EXISTS (
    SELECT *
    FROM orders 
    WHERE orders.bruger_id = customers.bruger_id
    AND orders.status = 'completed'
);


-- DEL 5
-- Tæl alle ordrer
SELECT COUNT(order_id)
FROM orders;

-- Beregn den samlede omsætning totalt (kun completed ordrer) — vis kundenavn og totalbeløb, 
-- sorteret med den højeste øverst.
SELECT 
	SUM(order_items.antal * order_items.enhedspris) AS totalbeløb
FROM order_items
JOIN orders ON orders.order_id = order_items.order_id
WHERE orders.status = 'completed';

-- Vis total antal kunder
SELECT COUNT(*)
FROM customers;

-- Vis total lager antal
SELECT 
	SUM(lagerantal)
FROM products;

