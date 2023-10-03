defmodule Wrapeth.Client do
  @type node_config :: %{client_type: atom(), node_url: String.t()}

  @callback get_config() :: node_config()



  defmacro __using__(_) do
    quote do
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

      def get_block_number() do
        config = get_config()
        node_url = config[:node_url]
        module_name = get_client()
        {:ok, block_number} = module_name.eth_block_number(url: node_url)
        block_number
      end
    end
  end
end
