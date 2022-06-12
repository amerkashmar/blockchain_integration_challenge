defmodule TransportTest do
  use ExUnit.Case
  doctest Transport

  test "Message creation correct" do
    assert Transport.create_message("eth_getBalance", ["0x0000", "latest"]) == "{\"id\":1,\"jsonrpc\":\"2.0\",\"method\":\"eth_getBalance\",\"params\":[\"0x0000\",\"latest\"]}"
  end

  test "Sending message correct" do
    encoded_message = Transport.create_message("eth_getBalance", ["0x0000", "latest"])
    _result = Transport.get_http_result(encoded_message)
    assert _result = ""
  end

end
