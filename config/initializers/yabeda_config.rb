Yabeda::Prometheus::Exporter.start_metrics_server!

Yabeda.configure do
  counter :user_requests, comment: 'The total number of requests from a user', tags: [:ip]
end