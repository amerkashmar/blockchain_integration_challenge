defmodule UtrustChallenge do



  def get_eth_balance(eth_address) do
    balance = float_to_string(100.00, decimals: 2)
    "Balance of 0x" <> eth_address <> ": " <> balance <> " ETH"
  end

  def execute_eth_transaction do
    "Eth tansaction executed!"
  end

  def get_eth_transaction_details do
    "Eth transaction details"
  end

  def execute_egld_transaction do
    "Egld transaction executed!"
  end

  def get_egld_transaction_details do
    "Egld transaction details"
  end

  def float_to_string(float, options) do
    :erlang.float_to_binary(float, options)
  end
end
