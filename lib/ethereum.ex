defmodule Ethereum do

  def geb_get_eth_balance(eth_address) do
    encoded_message = Transport.create_message("eth_getBalance", [eth_address, "latest"])
    result = Transport.get_http_result(encoded_message)
    Common.wei_to_eth(Common.hex_to_decimal(result))
  end

  def emet_execute_my_eth_transaction(to_address, value) do
    parameters = [%{"from" => Common.my_config(:eth_public_key), "to" => to_address, "value" => Common.decimal_to_hex(value)}]
    encoded_message = Transport.create_message("eth_sendTransaction", parameters)
    Transport.get_http_result(encoded_message)
  end

  def eet_execute_eth_transaction(from_address, to_address, value) do
    parameters = [%{"from" => from_address, "to" => to_address, "value" => Common.decimal_to_hex(value)}]
    encoded_message = Transport.create_message("eth_sendTransaction", parameters)
    Transport.get_http_result(encoded_message)
  end

  def gtd_get_transaction_details(transaction_hash) do
    parameters = [transaction_hash]
    encoded_message = Transport.create_message("eth_getTransactionByHash", parameters)
    result = Transport.get_http_result(encoded_message)

    amount_in_eth = Float.to_string(Common.wei_to_eth(Common.hex_to_decimal(result["value"])))
    fee_in_eth = Float.to_string(Common.wei_to_eth(Common.hex_to_decimal(result["gas"])))

    IO.puts("\n"
      <> "From: \t" <> result["from"] <> "\n"
      <> "To: \t" <> result["to"] <> "\n"
      <> "Amount: " <> amount_in_eth <> " ETH\n"
      <> "Fee: \t" <> fee_in_eth <> " ETH\n"
      <> "Hash: \t" <> result["hash"] <> "\n")

    "Completed successfully"
  end
end
