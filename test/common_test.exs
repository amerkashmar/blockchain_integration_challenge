defmodule CommonTest do
  use ExUnit.Case
  doctest Common

  test "Hex to Decimal - Conversion correct with null or empty input" do
    assert Common.hex_to_decimal("") == 0
  end

  test "Hex to Decimal - Conversion correct with 0x and even digits" do
    assert Common.hex_to_decimal("0x1111") == 4369
  end

  test "Hex to Decimal - Conversion correct without 0x and even digits" do
    assert Common.hex_to_decimal("1111") == 4369
  end

  test "Hex to Decimal - Conversion correct with 0x and odd digits" do
    assert Common.hex_to_decimal("0x111") == 273
  end

  test "Hex to Decimal - Conversion correct without 0x and odd digits" do
    assert Common.hex_to_decimal("111") == 273
  end

  test "Eth to Wei - Conversion correct" do
    assert Common.eth_to_wei(1.0) == 1.0e18
  end

  test "Wei to Eth - Conversion correct" do
    assert Common.wei_to_eth(1.0e18) == 1.0
  end

  test "Configuration - Reading correct" do
    assert Common.my_config(:test_configuration) == "This is a test"
  end

end
