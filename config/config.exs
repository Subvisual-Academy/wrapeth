import Config

config :wrapeth, EthProvider,
  client_type: :http,
  node_url: System.get_env("ETH_NODE_URL")

config :wrapeth, PolygonProvider,
  client_type: :http,
  node_url: System.get_env("POLY_NODE_URL")

config :wrapeth, :polygon_client,
  client_type: :http,
  node_url: System.get_env("POLY_NODE_URL")
