-- Time of Day and Day of Week CVR Patterns

with time_patterns as (
select hour(s.session_start_timestamp) as hr_of_day, dayofweek(s.session_start_timestamp) as day_of_week_num,
case dayofweek(s.session_start_timestamp) 
	when 1 then "Sunday"
    when 2 then "Monday"
    when 3 then "Tuesday"
    when 4 then "Wednesday"
    when 5 then "Thursday"
    when 6 then "Friday"
    when 7 then "Saturday"
    end as day_name,
    
-- Time buckets for readability
case when hour(s.session_start_timestamp) between 6 and 11 then "Morning (06-11)"
	when hour(s.session_start_timestamp) between 11 and 17 then "Evening (12-17)"
    when hour(s.session_start_timestamp) between 18 and 22 then "Night (18-22)"
    else "Late Night (23-05)"
    end as time_bucket,
    
    count(*) as total_sessions, 
    round(sum(f.reached_order),2) as converted_session,
    round((100*sum(f.reached_order) / count(*)),2) as converted_pct
    
from sessions s
join session_funnel_flags f
on s.session_id = f.session_id
group by hour(s.session_start_timestamp), dayofweek(s.session_start_timestamp), day_name, time_bucket )

select day_name, time_bucket, sum(total_Sessions) as total_sessions, sum(converted_session) as conversions, round(avg(converted_pct),2) as avg_converted_pct
from time_patterns
group by day_name, time_bucket, day_of_week_num
order by time_bucket, day_of_Week_num


