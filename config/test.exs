import Config

config :wrapeth, Wrapeth.ProviderTest.TestProvider,
  client_type: HttpMock,
  node_url: "https://eth-goerli.g.alchemy.com/v2/example"
