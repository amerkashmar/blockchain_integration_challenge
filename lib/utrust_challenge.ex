defmodule UtrustChallenge do



  def get_eth_balance(eth_address) do
    # parameters = [ "0x3b3Cc76c61c4d20f362E992D0024d6d22be7df71", "latest" ]
    # :rpc.call("HTTP://127.0.0.1:7545","2.0.0", "eth_get_balance", parameters)

    eth_address
    # {_response_code, balance} = Ethereumex.HttpClient.eth_get_balance(eth_address)
    # "Balance of 0x" <> eth_address <> ": " <> balance <> " ETH"
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

end
