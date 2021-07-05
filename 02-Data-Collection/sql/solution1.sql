WITH out1 AS (
  SELECT 
	t1.customerid,
    t1.invoiceid,
    t1.total,
    t2.trackid,
    t2.unitprice,
    t2.quantity
FROM invoices AS t1
LEFT JOIN invoice_items AS t2
ON t1.invoiceid = t2.invoiceid),

out2 AS (
  SELECT 
	o.*,
    tr.Name, 
    tr.albumid,
    tr.composer
FROM out1 AS o
LEFT JOIN tracks AS tr
ON o.trackid = tr.trackid
WHERE composer IS NOT NULL)

SELECT
	Name, 
    Composer, 
    SUM(quantity) AS sum_quantity, 
    SUM(total) AS total_value
FROM out2 
GROUP BY 1, 2
ORDER BY total_value DESC