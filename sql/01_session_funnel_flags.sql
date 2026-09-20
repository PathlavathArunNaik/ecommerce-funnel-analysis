-- Query 1
-- Session-Level Funnel Flag Table
-- One row per session, binary flags for each funnel stage reached
-- This is our base table — almost every other query will build on it

CREATE VIEW session_funnel_flags AS
    SELECT 
        s.session_id,
        s.user_id,
        s.device,
        s.channel,
        s.session_start_timestamp,
        s.session_end_timestamp,
        s.session_duration_sec,

        -- Stage 1: Did this session have any page view?
        MAX(CASE
            WHEN e.event_type = 'pdp_view' THEN 1
            ELSE 0
        END) AS reached_pdp,

        -- Stage 2: Did this session reach a Product Detail Page?
        MAX(CASE
            WHEN e.event_type = 'add_to_cart' THEN 1
            ELSE 0
        END) AS reached_atc,

        -- Stage 3: Did this session add anything to cart?
        MAX(CASE
            WHEN e.event_type = 'checkout_start' THEN 1
            ELSE 0
        END) AS reached_checkout,

        -- Stage 4: Did this session start checkout?
        MAX(CASE
            WHEN e.event_type = 'payment_initiated' THEN 1
            ELSE 0
        END) AS reached_payment,

        -- Stage 5: Did this session initiate payment?
        MAX(CASE
            WHEN e.event_type = 'order_placed' THEN 1
            ELSE 0
        END) AS reached_order
    FROM
        sessions s
            LEFT JOIN
        events e ON s.session_id = e.session_id
    GROUP BY s.session_id , s.user_id , s.device , s.channel , 
            s.session_start_timestamp , s.session_end_timestamp , s.session_duration_sec;

    
-- Verifing if it worked
SELECT * FROM session_funnel_flags LIMIT 10;
SELECT COUNT(*) AS total_sessions FROM session_funnel_flags;





