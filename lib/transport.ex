defmodule Transport do
  require HTTPoison

  HTTPoison.start

  def get_http_result(encoded_message) do
    url = Common.my_config(:eth_rpc_server)

    {:ok,response} = HTTPoison.post(url, encoded_message)
    {:ok,result} = Jason.decode(response.body)
    result["result"]
  end

  def create_message(method_name,parameters) do
    message = %{
      jsonrpc: "2.0",
      method: method_name,
      params: parameters,
      id: 1
    }

    {:ok, encoded_message} = Jason.encode(message)

    encoded_message
  end

end
