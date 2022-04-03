SELECT
  COUNT(session_guid) AS total_sessions,
  COUNT(CASE WHEN (add_to_cart >= 1) OR (checkout >= 1) THEN session_guid ELSE NULL END) AS add_to_cart_checkout_events,
  COUNT(DISTINCT CASE WHEN checkout >= 1 THEN session_guid ELSE NULL END) AS checkout_events
FROM
  {{ ref('int_session_event_types') }}