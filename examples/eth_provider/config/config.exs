import Config

config :wrapeth, EthProvider,
  client_type: Ethereumex.HttpClient,
  node_url: System.get_env("ETH_NODE_URL")
