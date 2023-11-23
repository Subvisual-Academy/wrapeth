defmodule EthProvider.Application do
  use Application

  def start(_, _) do
    children = [
      {EthWebSocket.WebsocketManager, Application.get_env(:eth_provider, Application)[:node_url]}
    ]

    opts = [
      strategy: :one_for_one,
      name: EthProvider.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
