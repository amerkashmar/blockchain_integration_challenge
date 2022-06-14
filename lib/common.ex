defmodule Common do
  require Integer

  def hex_to_decimal(hex_number) do
    if String.trim(hex_number) == "" do
      0
    else
      if String.slice(hex_number, 0..1) == "0x" do
        hex_sliced = hex_number |> String.slice(2..-1)

        if Integer.is_odd(String.length(hex_sliced)) do
          Base.decode16!("0" <> hex_sliced, case: :lower) |> :binary.decode_unsigned
        else
          Base.decode16!(hex_sliced, case: :lower) |> :binary.decode_unsigned
        end

      else
      hex_sliced = hex_number

      if Integer.is_odd(String.length(hex_sliced)) do
          Base.decode16!("0" <> hex_sliced, case: :lower) |> :binary.decode_unsigned
        else
          Base.decode16!(hex_sliced, case: :lower) |> :binary.decode_unsigned
        end
      end
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

  def my_config(config_name) do
    Application.get_env(:blockchain_integration_challenge, config_name)
  end

  def get_eth_eur_rate() do
    if Common.my_config(:is_eur_conversion_enabled) do
      {:ok, response} = Jason.decode(HTTPoison.get!("https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=EUR&api_key=" <> Common.my_config(:eth_eur_api_key)).body)
      response["EUR"]
    else
      1500.0
    end
  end

  def get_egld_eur_rate() do
    if Common.my_config(:is_eur_conversion_enabled) do
      {:ok, response} = Jason.decode(HTTPoison.get!("https://min-api.cryptocompare.com/data/price?fsym=EGLD&tsyms=EUR&api_key=" <> Common.my_config(:eth_eur_api_key)).body)
      response["EUR"]
    else
      43.0
    end
  end
end
