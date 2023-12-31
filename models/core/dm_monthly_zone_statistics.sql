{{ config(materialized="table") }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)
    select 
    -- Revenue grouping
    pickup_zone as revenue_zone,
    date_trunc(pickup_datetime, month) as revenue_month,
    service_type,

    -- Additional calculation
    count(tripid) as total_monthly_trips,
    avg(passenger_count) as avg_monthly_passenger_count,
    avg(trip_distance) as avg_monthly_trip_distance,

    from trips_data
    group by 1,2,3