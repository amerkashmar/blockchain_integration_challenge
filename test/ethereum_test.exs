defmodule EthereumTest do
  use ExUnit.Case
  doctest Ethereum

  test "Get Eth Balance" do
    balance = Ethereum.geb_get_eth_balance("0x0951D9851D9f87fEd0B7aA18AcEFA2cEE2aa546D")
    assert balance == 100.0
  end

  test "Sending 0.5 Eth - Destination Balance Check" do
    start_balance = Ethereum.geb_get_eth_balance("0x63538b04b53BE0d95D7E6DF515fE76174E8dB6FD")
    Ethereum.eet_execute_eth_transaction("0x2EDfB0992B24D86dF4325593BaEc06633aa584D7","0x63538b04b53BE0d95D7E6DF515fE76174E8dB6FD",0.1)
    end_balance = Ethereum.geb_get_eth_balance("0x63538b04b53BE0d95D7E6DF515fE76174E8dB6FD")
    assert (end_balance/(start_balance + 0.1)-1) < 0.00001
  end

  test "Get transaction details" do
    transaction_details = Ethereum.gtd_get_transaction_details("0x249cdef9a7385bb646ee36a08f79599c548f2cd63c758e270ab0cafbea636ce8")
    assert Float.to_string(Common.wei_to_eth(Common.hex_to_decimal(transaction_details["value"]))) == "1.5"
  end

  test "Sending 0.5 Eth - Source Balance Check" do
    start_balance = Ethereum.geb_get_eth_balance("0x2EDfB0992B24D86dF4325593BaEc06633aa584D7")
    transaction_hash = Ethereum.eet_execute_eth_transaction("0x2EDfB0992B24D86dF4325593BaEc06633aa584D7","0x63538b04b53BE0d95D7E6DF515fE76174E8dB6FD",0.1)
    end_balance = Ethereum.geb_get_eth_balance("0x2EDfB0992B24D86dF4325593BaEc06633aa584D7")

    gas = Common.wei_to_eth(Common.hex_to_decimal(Ethereum.gtd_get_transaction_details(transaction_hash)["gasPrice"]))
    gasPrice = Common.wei_to_eth(Common.hex_to_decimal(Ethereum.gtd_get_transaction_details(transaction_hash)["gasPrice"]))

    assert (1-(end_balance/(start_balance - 0.1 - gas - gasPrice))) < 0.00001
  end
end
