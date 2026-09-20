-- Cart Abandonment: Sessions that added to cart but never placed an orde

with cart_abandoners as (SELECT 
    session_id,
    user_id,
    device,
    channel,
    session_start_timestamp,
    session_duration_sec,
    reached_checkout,
    reached_payment,
    CASE
        WHEN reached_payment = 1 THEN 'Dropped at payment'
        WHEN reached_checkout = 1 THEN 'Dropped at checkout'
        WHEN reached_atc = 1 THEN 'Dropped at add to cart'
        ELSE 'Unknown'
    END AS abandonment_stage
FROM
    session_funnel_flags
WHERE
    reached_atc = 1 AND reached_order = 0)

select abandonment_stage, device, channel, count(*) as abandoned_session,
		round((100*count(*)/ sum(count(*)) over()),2) as pct_of_all_abandoners,
        round(avg(session_duration_sec/60),1) as avg_session_min
from cart_abandoners
group by abandonment_stage, device,channel


-- Summary: Total abandonment stat

SELECT 
    COUNT(*) AS total_abandoners,
    SUM(reached_checkout) AS reached_checkout,
    SUM(reached_payment) AS reached_payment,
    ROUND((SUM(reached_checkout) / COUNT(*)), 2) AS pct_reached_checkout,
    ROUND((SUM(reached_payment) / COUNT(*)), 2) AS pct_reached_payment
FROM
    session_funnel_flags
WHERE
    reached_atc = 1 AND reached_order = 0