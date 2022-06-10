defmodule UtrustChallenge do

  def get_eth_balance(eth_address) do
    {_response_code, balance} = Ethereumex.HttpClient.eth_get_balance(eth_address)
    balance |> String.slice(2..-1)

  end

end
