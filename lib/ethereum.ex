defmodule Ethereum do

  def geb_get_eth_balance(eth_address) do
    encoded_message = Transport.create_message("eth_getBalance", [eth_address, "latest"])
    result = Transport.get_http_result(encoded_message)
    amount = Common.wei_to_eth(Common.hex_to_decimal(result))

    eth_eur_rate = Common.get_eth_eur_rate()
    IO.puts("Balance is: " <> Float.to_string(amount) <> " ETH ~ " <> Integer.to_string(round(amount*eth_eur_rate)) <> " EUR")

    amount
  end

  def emet_execute_my_eth_transaction(to_address, value) do
    eth_eur_rate = Common.get_eth_eur_rate()
    IO.puts("Sending " <> Float.to_string(value) <> " ETH to " <> to_address <> " worth ~" <> Integer.to_string(round(value*eth_eur_rate)) <> " EUR")
    parameters = [%{"from" => Common.my_config(:eth_public_key), "to" => to_address, "value" => Common.decimal_to_hex(value)}]
    encoded_message = Transport.create_message("eth_sendTransaction", parameters)
    Transport.get_http_result(encoded_message)
  end

  def eet_execute_eth_transaction(from_address, to_address, value) do
    eth_eur_rate = Common.get_eth_eur_rate()
    IO.puts("Sending " <> Float.to_string(value) <> " ETH to " <> to_address <> " worth ~" <> Integer.to_string(round(value*eth_eur_rate)) <> " EUR")
    parameters = [%{"from" => from_address, "to" => to_address, "value" => Common.decimal_to_hex(value)}]
    encoded_message = Transport.create_message("eth_sendTransaction", parameters)
    Transport.get_http_result(encoded_message)
  end

  def gtd_get_transaction_details(transaction_hash) do
    eth_eur_rate = Common.get_eth_eur_rate()
    parameters = [transaction_hash]
    encoded_message = Transport.create_message("eth_getTransactionByHash", parameters)
    result = Transport.get_http_result(encoded_message)

    amount_in_eth = Common.wei_to_eth(Common.hex_to_decimal(result["value"]))
    fee_in_eth = Common.wei_to_eth(Common.hex_to_decimal(result["gas"]))

    IO.puts("\n"
      <> "From: \t" <> result["from"] <> "\n"
      <> "To: \t" <> result["to"] <> "\n"
      <> "Amount: " <> Float.to_string(amount_in_eth) <> " ETH ~" <> Integer.to_string(round(amount_in_eth*eth_eur_rate)) <> " EUR\n"
      <> "Fee: \t" <> Float.to_string(fee_in_eth) <> " ETH ~" <> Integer.to_string(round(fee_in_eth*eth_eur_rate)) <> " EUR\n"
      <> "Hash: \t" <> result["hash"] <> "\n")

    result
  end
end
