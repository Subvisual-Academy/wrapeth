defmodule Wrapeth.Client.BaseClient do
  @type node_config :: %{client_type: atom(), node_url: String.t()}
  @callback get_config() :: %{client_type: atom(), node_url: String.t()}

  alias Wrapeth.Client.Behaviour

  defmacro __using__(_) do
    quote do
      @behaviour Behaviour
      @type error :: Behaviour.error()
      def get_client_type() do
        config = get_config()
        config[:client_type]
      end

      def get_client() do
        case get_client_type() do
          :http -> Ethereumex.HttpClient
          :ipc -> Ethereumex.IpcClient
          _ -> {:error, :invalid_client_type}
        end
      end

      def client_and_url() do
        config = get_config()
        config[:node_url]
        {get_client(), config[:node_url]}
      end
    end
  end
end
