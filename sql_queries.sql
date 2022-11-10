#remarque : le filtre demandé est du 1er janvier 2019 au 31 décembre 2019 mais l'échantillon des résultats de la requête montre des données en 2020.

SELECT
  CONCAT(SUBSTRING(trans.date,1,6),"20",SUBSTRING(trans.date,7,8)) AS date,
  SUM(trans.prod_price * trans.prod_qty) AS ventes
FROM
  TRANSACTION AS trans
WHERE
  trans.date BETWEEN "01/01/19"
  AND "31/12/19"
GROUP BY
  trans.date
ORDER BY
  trans.date asc
  
;

SELECT
  trans.client_id AS client_id,
  CASE
    WHEN prd_nom.product_type = "MEUBLE" THEN SUM(trans.prod_price * trans.prod_qty)
END
  AS ventes_meuble,
  CASE
    WHEN prd_nom.product_type = "DECO" THEN SUM(trans.prod_price * trans.prod_qty)
END
  AS product_name
FROM
  TRANSACTION AS trans
LEFT JOIN
  PRODUCT_NOMENCLATURE AS prd_nom
ON
  trans.prop_id = prd_nom.product_id
WHERE
  trans.date BETWEEN "01/01/19"
  AND "31/12/19"
GROUP BY
  trans.client_id,
  prd_nom.product_type