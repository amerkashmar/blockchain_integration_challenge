defmodule UtrustChallenge do
  require Integer
  require HTTPoison

  HTTPoison.start

  def geb_get_eth_balance(eth_address) do
    encoded_message = create_message("eth_getBalance", [eth_address, "latest"])
    result = get_http_result(encoded_message)
    wei_to_eth(hex_to_decimal(result))
  end

  def hex_to_decimal(hex_number) do
    hex_sliced = hex_number |> String.slice(2..-1)

    if Integer.is_odd(String.length(hex_sliced)) do
      Base.decode16!("0" <> hex_sliced, case: :lower) |> :binary.decode_unsigned
    else
      Base.decode16!(hex_sliced, case: :lower) |> :binary.decode_unsigned
    end
  end

  def wei_to_eth(wei_number) do
    wei_number/1.0e18
  end

  def get_http_result(encoded_message) do
    url = "http://localhost:7545"

    {:ok,response} = HTTPoison.post(url, encoded_message)
    {:ok,result} = Jason.decode(response.body)
    result["result"]
  end

  def create_message(method_name,parameters) do
    message = %{
      method: method_name,
      params: parameters,
      jsonrpc: "2.0",
      id: 1
    }

    {:ok, encoded_message} = Jason.encode(message)

    encoded_message
  end

end
