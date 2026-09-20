-- Funnel Metrics by Category (for converted sessions)
-- Note: Category is only known for sessions that placed an order

select category, count( distinct order_id) as total_orders, count(distinct user_id) as unique_buyers,
		sum(order_amount) as total_gmv,
        avg(order_amount) as aov,
        min(order_amount) as minimum_amount,
        max(order_amount) as maximum_amount,
        round((100*sum(order_amount) / sum(sum(order_amount)) over()),2) as gmv_share_pct
from orders
group by category
order by total_gmv desc

-- Separate: Session-level CVR by device AND category (for converted sessions)

SELECT 
    f.device,
    o.category,
    COUNT(DISTINCT f.session_id) AS converted_sessions,
    SUM(order_amount) AS total_gmv,
    AVG(order_amount) AS aov
FROM
    session_funnel_flags f
        JOIN
    orders o ON f.session_id = o.session_id
GROUP BY f.device , o.category
ORDER BY total_gmv DESC