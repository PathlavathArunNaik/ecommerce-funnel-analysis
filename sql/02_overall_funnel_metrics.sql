-- Query 2
-- Overall Funnel Metrics
-- Step-by-step conversion rates using the session_funnel_flags view

with stage_counts as (
select count(*) as total_sessions, sum(reached_pdp) as sessions_with_pdp, sum(reached_atc) as sessions_with_atc, 
		sum(reached_checkout) as sessions_with_checkout, sum(reached_payment) as sessions_with_payment, sum(reached_order) as sessions_with_orders
from session_funnel_flags),

funnel_rates as ( select total_sessions, sessions_with_pdp, sessions_with_atc, 
                sessions_with_checkout, sessions_with_payment, sessions_with_orders,

            -- Step-by-step conversion rates (each stage vs. previous stage)
			round((100*sessions_with_pdp/total_sessions),2) as session_to_pdp_pct,
            round((100*sessions_with_atc/sessions_with_pdp),2) as session_to_atc_pct,
            round((100*sessions_with_checkout/sessions_with_atc),2) as session_to_checkout_pct,
            round((100*sessions_with_payment/sessions_with_checkout),2) as session_to_payment_pct,
            round((100*sessions_with_orders/sessions_with_payment),2) as session_with_orders_pct,

            -- Overall CVR (sessions to order)
			round((100*sessions_with_orders/total_sessions),2) as overall_cvr_pct,

            -- Drop-off counts at each stage (absolute leakage)
			(total_sessions - sessions_with_pdp) as dropped_before_pdp,
            (sessions_with_pdp - sessions_with_atc) as dropped_at_pdp,
            (sessions_with_atc - sessions_with_checkout) as dropped_at_atc,
            (sessions_with_checkout - sessions_with_payment) as dropped_at_checkout,
            (sessions_with_payment - sessions_with_orders) as dropped_at_payment
from stage_counts)

select * from funnel_rates