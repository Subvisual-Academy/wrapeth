import Config

config :wrapeth, :eth_client,
  client_type: :http,
  node_url: System.get_env("ETH_NODE_URL")
