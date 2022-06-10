import Config

config :ethereumex,
  url: "http://localhost:7545",
  http_options: [pool_timeout: 5000, receive_timeout: 15_000],
  http_headers: [{"Content-Type", "application/json"}]
