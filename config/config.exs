import Config

config EthProvider, EthClient,
  client_type: :http,
  node_url: System.get_env("ETH_NODE_URL")

config PolygonProvider, PolygonClient,
  client_type: :http,
  node_url: System.get_env("POLY_NODE_URL")
