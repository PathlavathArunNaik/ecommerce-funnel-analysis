-- Revenue Recovery Sizing
-- How much GMV can we recover by fixing cart abandonment?

with base_aov as (SELECT 
    ROUND(AVG(order_amount), 2) AS avg_order_value
FROM
    orders),

abandonment_summary as ( SELECT 
    device,
    channel,
    COUNT(*) abandoned_sessions,
    CASE
        WHEN reached_payment = 1 THEN 'reached_payment'
        WHEN reached_checkout = 1 THEN 'reached_checkout'
        ELSE 'reached_atc'
    END AS abandonment_stage
FROM
    session_funnel_flags
WHERE
    reached_atc = 1 AND reached_order = 0
GROUP BY device , channel , CASE
    WHEN reached_payment = 1 THEN 'reached_payment'
    WHEN reached_checkout = 1 THEN 'reached_checkout'
    ELSE 'reached_atc'
END
)
SELECT 
    a.device,
    a.channel,
    a.abandoned_sessions,
    a.abandonment_stage,
    b.avg_order_value,
    ROUND((a.abandoned_sessions * b.avg_order_value * 0.05 / 1000000),
            2) AS recovery_5pct_M,
    ROUND((a.abandoned_sessions * b.avg_order_value * 0.10 / 1000000),
            2) AS recovery_10pct_M,
    ROUND((a.abandoned_sessions * b.avg_order_value * 0.15 / 1000000),
            2) AS recovery_15pct_M
FROM
    abandonment_summary a
        CROSS JOIN
    base_aov b
ORDER BY a.abandoned_sessions DESC
LIMIT 20;
    
    
-- Total recovery potential summary
SELECT
    COUNT(*) AS total_cart_abandoners,
    (SELECT ROUND(AVG(order_amount), 0) FROM orders) AS proxy_aov,
    ROUND(COUNT(*) * (SELECT AVG(order_amount) FROM orders) * 0.05 / 1000000, 2) AS total_recovery_5pct_M,
    ROUND(COUNT(*) * (SELECT AVG(order_amount) FROM orders) * 0.10 / 1000000, 2) AS total_recovery_10pct_M,
    ROUND(COUNT(*) * (SELECT AVG(order_amount) FROM orders) * 0.15 / 1000000, 2) AS total_recovery_15pct_M
FROM session_funnel_flags
WHERE reached_atc = 1 AND reached_order = 0;