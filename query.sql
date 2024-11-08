select 
  count(*) as sessions,
  countif(
    regexp_contains(
      (select value.string_value from unnest(event_params) where key = 'page_referrer'),
      r'/.*(\.ai|\.openai|copilot|gpt|chatgpt|neeva|writesonic|outrider|perplexity|google.*bard|bard.*google|bard|edgeservices).*/'
    )
  ) as ai_sessions
from
  `YOUR_PROJECT.YOUR_DATASET.events_*`
where
  (_table_suffix between '20241001' and '20241031') and 
  user_pseudo_id is not null and
  event_name = 'session_start'
