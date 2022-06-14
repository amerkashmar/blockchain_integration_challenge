defmodule Elrond do
  alias Elrondex.{Account, Transaction, Network, REST}

  def geb_get_egld_balance(egld_address) do
    network = Network.devnet()

    {:ok, egld_balance} = network
      |> REST.get_address_balance(egld_address)

    Common.wei_to_eth(egld_balance)
  end

  def emet_execute_my_egld_transaction(to_address, value) do
    network = Network.devnet()
    value_in_wei = Common.eth_to_wei(value)

    {:ok, transaction} = Common.my_config(:egld_address_1_mnemonic)
      |> Account.from_mnemonic()
      |> Transaction.transaction(to_address, value_in_wei)
      |> Transaction.prepare_network(network)

    signed_transaction = Transaction.sign(transaction)
    response = REST.post_transaction_send(signed_transaction)

    response
  end

  def gtd_get_transaction_details(transaction_hash) do
    network = Network.devnet()

    {:ok, result} = network
      |> REST.get_transaction(transaction_hash)

    {egld_value, ""} = Float.parse(result["value"])
    transaction_gas_price = result["gasPrice"]
    egld_eur_rate = Common.get_egld_eur_rate()

    IO.puts("\n"
    <> "From: \t" <> result["sender"] <> "\n"
    <> "To: \t" <> result["receiver"] <> "\n"
    <> "Amount: " <> Float.to_string(Common.wei_to_eth(egld_value)) <> " EGLD ~" <> Integer.to_string(round(Common.wei_to_eth(egld_value*egld_eur_rate))) <> " EUR\n"
    <> "Fee: \t" <> Float.to_string(Common.wei_to_eth(transaction_gas_price)) <> " EGLD ~" <> Integer.to_string(round(Common.wei_to_eth(transaction_gas_price)*egld_eur_rate)) <> " EUR\n"
    <> "Hash: \t" <> transaction_hash <> "\n")

    result
  end

end
