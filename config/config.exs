import Config

config :wrapeth, :eth_client,
  client_type: :http,
  node_url: System.get_env("ETH_NODE_URL")

config :wrapeth, :polygon_client,
  client_type: :http,
  node_url: System.get_env("POLY_NODE_URL")
