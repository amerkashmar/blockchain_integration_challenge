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
    Application.get_env(:utrust_challenge, config_name)
  end

end
