defmodule UtrustChallenge do
  require Integer

  def get_eth_balance(eth_address) do
    {_response_code, hexBalance} = Ethereumex.HttpClient.eth_get_balance(eth_address)

    "Balance: " <> Float.to_string(wei_to_eth(hex_to_decimal(hexBalance))) <> " ETH"
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

end
