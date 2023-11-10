import Config

config :eth_provider, EthProvider,
  client_type: Ethereumex.HttpClient,
  node_url: System.get_env("ETH_NODE_URL")

config :eth_provider, WsProvider,
  client_type: WebSocket,
  node_url: System.get_env("ETH_WEB_SOCKET")

config :eth_provider, Subscriber,
  client_type: WebSocket,
  node_url: System.get_env("ETH_WEB_SOCKET")
