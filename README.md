# Wrapeth

Wrapeth is a lightweight Elixir wrapper around Ethereumex that extends its functionality by providing WebSocket connection options. This tool simplifies interaction with Ethereum nodes and enables seamless integration of WebSocket communication.

## Installation

Add Wrapeth to your project's dependencies by adding the following lines to your `mix.exs` file:

```elixir
defp deps do
  [
    {:wrapeth, git: "https://github.com/Subvisual-Academy/wrapeth.git", branch: "main"}
  ]
end
```

Then run the following command in your terminal to fetch and compile the new dependency:

```bash
mix deps.get
```

## Configuration

Ensure you have an ethereum node to connect to at the specified url in your config.

For example:

```elixir
config :otp_app_name, ModuleName,
  client_type: Ethereumex.HttpClient,
  node_url: "https://example-node-url.com"
```

Replace "https://example-node-url.com" with the URL of your Ethereum node. You can also set the Ethereumex client type to either `Ethereumex.HttpClient`, `Ethereumex.IpcClient` or `WebSocket`.

## Usage

To use Wrapeth in your module, follow these steps:

1. Define your Provider and use `Wrapeth.Provider`, specifying the OTP application name.

```elixir
defmodule MyProvider do
  use Wrapeth.Provider, otp_app: :otp_app_name
```

2. Implement your functions using your Provider features. For example, to get the latest block number:

```elixir
  def get_latest_block_number do
    {:ok, block_number} = MyProvider.eth_block_number()
    block_number
  end
```

### WebSocket

When using the WebSocket option, make sure to start the WebSocketManager and WebSocket before making calls to Ethereum methods. Use the following method to start them:

```elixir
WebsocketManager.start_websocket_manager_and_websocket(ws_url)
```

Feel free to explore more features provided by Ethereumex and Wrapeth to enhance your interaction with the Ethereum blockchain.

For detailed information on Ethereumex and Wrapeth, refer to their respective documentation:

- [Ethereumex Documentation](https://hexdocs.pm/ethereumex/readme.html)
- [Wrapeth Documentation](https://github.com/Subvisual-Academy/wrapeth)

