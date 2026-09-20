-- Executive Summary: 3 Numbers Leadership Cares About

WITH funnel AS (
    SELECT
        COUNT(*)                    AS total_sessions,
        SUM(reached_atc)            AS sessions_atc,
        SUM(reached_checkout)       AS sessions_checkout,
        SUM(reached_order)          AS sessions_order
    FROM session_funnel_flags
),
order_stats AS (
    SELECT
        COUNT(*) AS total_orders,
        ROUND(SUM(order_amount), 0) AS total_gmv,
        ROUND(AVG(order_amount), 0) AS aov
    FROM orders
)
SELECT
    -- Number 1: Overall scale and CVR
    f.total_sessions AS monthly_sessions,
    ROUND(100.0 * f.sessions_order / f.total_sessions, 2) AS overall_cvr_pct,
    os.total_gmv AS current_monthly_gmv,
    os.aov AS average_order_value,

    -- Number 2: Biggest single drop-off point (Cart Abandonment)
    (f.sessions_atc - f.sessions_order) AS cart_abandonment_volume,
    ROUND(100.0 * (f.sessions_atc - f.sessions_order) / NULLIF(f.sessions_atc, 0), 1) AS cart_abandonment_rate_pct,

    -- Number 3: GMV Recovery Opportunity (10% recovery of abandoned carts)
    ROUND((f.sessions_atc - f.sessions_order) * os.aov * 0.10 / 1000000, 2) AS recovery_opportunity_10pct_Mn,
    ROUND((f.sessions_atc - f.sessions_order) * os.aov * 0.15 / 1000000, 2) AS recovery_opportunity_15pct_Mn

FROM funnel f
CROSS JOIN order_stats os;