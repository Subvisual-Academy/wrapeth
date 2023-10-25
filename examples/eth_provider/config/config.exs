import Config

config :wrapeth, EthProvider,
  client_type: Ethereumex.HttpClient,
  node_url: System.get_env("ETH_NODE_URL")

# config :wrapeth, PolygonProvider,
#   client_type: Ethereumex.HttpClient,
#   node_url: System.get_env("POLY_NODE_URL")