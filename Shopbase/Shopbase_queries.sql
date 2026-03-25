-- C1–C5: SELECT, WHERE, ORDER BY
-- C1 Hent alle produkter, der koster mere end 200 kr. — vis navn, kategori og pris.
SELECT navn, kategori, pris 
FROM products 
WHERE pris > 200;

-- C2 Vis navn og by paa alle kunder fra Aarhus eller Odense (brug IN eller OR).
SELECT navn, by 
FROM Customers
WHERE by IN ('Aarhus', 'Odense');

-- C3 Find alle ordrer med status 'pending', sorteret efter ordredato — nyeste først.
SELECT * FROM orders 
WHERE status = 'pending' 
ORDER BY order_date DESC;

-- C4 Hent de 10 dyreste produkter. Vis kun navn og pris.
SELECT * FROM products
ORDER BY pris
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






