WITH daily AS (
  SELECT transaction_time::date AS day,
         SUM(transaction_amount) AS total
  FROM transactions
  GROUP BY 1
),
rolling AS (
  SELECT day,
         AVG(total) OVER (ORDER BY day ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3d_avg
  FROM daily
)
SELECT day, ROUND(rolling_3d_avg::numeric, 2) AS rolling_3d_avg
FROM rolling
WHERE day = '2021-01-31';
