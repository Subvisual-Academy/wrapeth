import Config

config :wrapeth, Wrapeth.ProviderTest.TestProvider,
  client_type: HttpMock,
  node_url: System.get_env("ETH_NODE_URL")
