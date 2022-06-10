import Config

config :ethereumex,
  url: "http://localhost:8545",
  http_options: [pool_timeout: 8000, receive_timeout: 24_000],
  http_headers: [{"Content-Type", "application/json"}],
  client_type: :ipc,
  ipc_path: "/path/to/ipc",
  ipc_worker_size: 5,
  ipc_max_worker_overflow: 2,
  ipc_request_timeout: 60_000
