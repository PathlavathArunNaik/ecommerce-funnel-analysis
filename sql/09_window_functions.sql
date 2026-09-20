-- Rank Channels by Drop-off Severity using Window Functions

WITH site_avg AS (
    SELECT ROUND(100.0 * SUM(reached_order) / COUNT(*), 2) AS site_cvr
    FROM session_funnel_flags
),
channel_metrics AS (
    SELECT
        f.channel,
        COUNT(*)                                           AS total_sessions,
        SUM(f.reached_atc)                                 AS sessions_atc,
        SUM(f.reached_checkout)                            AS sessions_checkout,
        SUM(f.reached_order)                               AS sessions_order,
        ROUND(100.0 * SUM(f.reached_order) / COUNT(*), 2) AS overall_cvr_pct,
        ROUND(100.0 * SUM(f.reached_atc) / NULLIF(COUNT(*), 0),          2) AS atc_rate_pct,
        ROUND(100.0 * SUM(f.reached_checkout) / NULLIF(SUM(f.reached_atc), 0), 2) AS atc_to_checkout_pct,
        ROUND(100.0 * SUM(f.reached_order) / NULLIF(SUM(f.reached_checkout), 0), 2) AS checkout_to_order_pct
    FROM session_funnel_flags f
    GROUP BY f.channel
)
SELECT
    cm.channel,
    cm.total_sessions,
    cm.overall_cvr_pct,
    cm.atc_rate_pct,
    cm.atc_to_checkout_pct,
    cm.checkout_to_order_pct,

    -- Rank by worst overall CVR (1 = worst performing channel)
    RANK() OVER(ORDER BY cm.overall_cvr_pct ASC)          AS rank_worst_cvr,

    -- Rank by highest sessions (1 = most traffic)
    RANK() OVER(ORDER BY cm.total_sessions DESC)           AS rank_most_traffic,

    -- Gap vs site average (negative = underperformer)
    ROUND(cm.overall_cvr_pct - sa.site_cvr, 2)            AS cvr_gap_vs_avg,

    -- Priority score: high traffic + low CVR = most urgent to fix
    -- Rank by sessions * CVR gap (bigger negative gap on high traffic = worst)
    RANK() OVER(ORDER BY (cm.total_sessions * (sa.site_cvr - cm.overall_cvr_pct)) DESC) AS priority_rank

FROM channel_metrics cm
CROSS JOIN site_avg sa
ORDER BY priority_rank;