-- Funnel Breakdown by Device Type

with device_funnel as (
SELECT device, 
    COUNT(*) AS total_sessions,
    SUM(reached_pdp) AS sessions_with_pdp,
    SUM(reached_atc) AS sessions_with_atc,
    SUM(reached_checkout) AS sessions_with_checkout,
    SUM(reached_payment) AS sessions_with_payment,
    SUM(reached_order) AS sessions_with_orders
FROM
    session_funnel_flags
GROUP BY device)

select device, total_sessions,sessions_with_orders,
-- funnel rates
			round((100*sessions_with_pdp/NULLIF(total_sessions,0)),2) as session_to_pdp_pct,
            round((100*sessions_with_atc/NULLIF(sessions_with_pdp,0)),2) as session_to_atc_pct,
            round((100*sessions_with_checkout/NULLIF(sessions_with_atc,0)),2) as session_to_checkout_pct,
            round((100*sessions_with_payment/NULLIF(sessions_with_checkout,0)),2) as session_to_payment_pct,
            round((100*sessions_with_orders/NULLIF(sessions_with_payment,0)),2) as session_with_orders_pct,
            
            -- share of total sessions
			round((100*total_sessions/sum(total_sessions) over()),1) as session_share_pct,
            
            -- Share of total orders
            round((100*sessions_with_orders/ sum(sessions_with_orders) over()),1) as order_share_pct
from device_funnel
order by total_sessions desc