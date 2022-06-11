defmodule UtrustChallenge do
  require Integer
  require HTTPoison

  HTTPoison.start

  def geb_get_eth_balance(eth_address) do
    encoded_message = create_message("eth_getBalance", [eth_address, "latest"])
    result = get_http_result(encoded_message)
    wei_to_eth(hex_to_decimal(result))
  end

  def emet_execute_my_eth_transaction(to_address, value) do
    parameters = [%{"from" => my_config(:public_key), "to" => to_address, "value" => decimal_to_hex(value)}]
    encoded_message = create_message("eth_sendTransaction", parameters)
    get_http_result(encoded_message)
  end

  def eet_execute_eth_transaction(from_address, to_address, value) do
    parameters = [%{"from" => from_address, "to" => to_address, "value" => decimal_to_hex(value)}]
    encoded_message = create_message("eth_sendTransaction", parameters)
    get_http_result(encoded_message)
  end

  def gtd_get_transaction_details(transaction_hash) do
    parameters = [transaction_hash]
    encoded_message = create_message("eth_getTransactionByHash", parameters)
    result = get_http_result(encoded_message)

    amount_in_eth = Float.to_string(wei_to_eth(hex_to_decimal(result["value"])))
    fee_in_eth = Float.to_string(wei_to_eth(hex_to_decimal(result["gas"])))

    IO.puts("\n"
      <> "From: \t" <> result["from"] <> "\n"
      <> "To: \t" <> result["to"] <> "\n"
      <> "Amount: " <> amount_in_eth <> " ETH\n"
      <> "Fee: \t" <> fee_in_eth <> " ETH\n"
      <> "Hash: \t" <> result["hash"] <> "\n")

    "Completed successfully"
  end

  def hex_to_decimal(hex_number) do
    hex_sliced = hex_number |> String.slice(2..-1)

    if Integer.is_odd(String.length(hex_sliced)) do
      Base.decode16!("0" <> hex_sliced, case: :lower) |> :binary.decode_unsigned
    else
      Base.decode16!(hex_sliced, case: :lower) |> :binary.decode_unsigned
    end
  end

  def decimal_to_hex(decimal_number) do
    "0x" <> Integer.to_string(eth_to_wei(decimal_number), 16)
  end

  def wei_to_eth(wei_amount) do
    wei_amount/1.0e18
  end

  def eth_to_wei(eth_amount) do
    trunc(eth_amount*1.0e18)
  end

  def get_http_result(encoded_message) do
    url = my_config(:eth_rpc_server)

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

    # IO.puts("Message request: " <> encoded_message)
    encoded_message
  end

  def my_config(config_name) do
    Application.get_env(:utrust_challenge, config_name)
  end


end
