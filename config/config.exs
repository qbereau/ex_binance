use Mix.Config

config :ex_binance,
  api_key: System.get_env("BINANCE_API_KEY"),
  secret_key: System.get_env("BINANCE_API_SECRET"),
  domain: System.get_env("BINANCE_API_DOMAIN")

config :exvcr,
  filter_request_headers: [
    "X-MBX-APIKEY"
  ],
  filter_sensitive_data: [
    [pattern: "signature=[A-Z0-9]+", placeholder: "signature=***"]
  ]
