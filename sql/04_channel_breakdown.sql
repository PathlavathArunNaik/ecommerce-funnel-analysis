-- Funnel breakdown by channel

with channel_funnel as (
SELECT 
    f.channel,
    COUNT(DISTINCT f.session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(f.reached_pdp) AS session_pdp,
    SUM(f.reached_atc) AS session_atc,
    SUM(f.reached_checkout) AS session_checkout,
    SUM(f.reached_payment) AS session_payment,
    SUM(f.reached_order) AS session_orders,
    ROUND(SUM(o.order_amount), 0) AS total_gmv,
    ROUND(AVG(o.order_amount), 0) AS aov
FROM
    session_funnel_flags f
        LEFT JOIN
    orders o ON f.session_id = o.session_id
GROUP BY f.channel )

SELECT 
    channel,
    total_sessions,
    total_orders,
    total_gmv,
    aov,
    ROUND((100 * session_orders / NULLIF(total_sessions, 0)),
            2) AS overall_cvr,
    ROUND((100 * session_atc / NULLIF(total_sessions, 0)),
            2) AS sessions_atc_ptc,
    ROUND((100 * session_checkout / NULLIF(session_atc, 0)),
            2) AS atc_to_checkout,
    ROUND((100 * session_payment / NULLIF(session_checkout, 0)),
            2) AS checkout_to_payment,
    ROUND((total_gmv / NULLIF(total_sessions, 0)),
            2) AS gmv_per_session
FROM
    channel_funnel
ORDER BY total_gmv DESC
