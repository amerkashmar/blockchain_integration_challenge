# BlockchainIntegrationChallenge

The goal of the challenge is creating an app that allows issuing transactions in different blockchains.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `blockchain_integration_challenge` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:blockchain_integration_challenge, "~> 0.1.0"}
  ]
end
```

## Configuration

In `config/config.exs`, find below the definition of each parameter.

```elixir
config :blockchain_integration_challenge,
  eth_rpc_server: "http://localhost:7545",
  eth_public_key: "0x0...",
  test_configuration: "This is a test",
  eth_eur_api_key: "5b79d1ff128de09f6313b2c864fcbdd96f8aa3620e1f8ee6476b4009152726f1",
  is_eur_conversion_enabled: true
```
* `eth_rpc_server`: Ethereum RPC server used - i.e. for Ganache "http://localhost:7545"
* `eth_public_key`: ERC-20 address used to send transactions when required 
* `test_configuration`: Property used to test reading configuration values
* `eth_eur_api_key`: Cryptocompare.com API key used to fetch ETH price per EUR
* `is_eur_conversion_enabled`: Will fetch live rate if true, will use 1500 Euros per Eth if false

## Usage

### Available Ethereum functions

* [`geb_get_eth_balance`]
  * Parameters:
    * eth_address: Any ethereum address, can start with 0x or without. i.e. "0x1234..." or "1234..."
  * Returns:
    * Float: Eth balance of address. i.e. 100.25

* [`emet_execute_my_eth_transaction`]
  * Parameters:
    * to_address: Ethereum address receiving the amount. i.e. "0x1234..."
    * value: Eth amount to be sent
  * Returns:
    * String: Hash value of the executed transaction. i.e. "0xabcdef12345..."

* [`eet_execute_eth_transaction`]
  * Parameters:
    * from_address: Ethereum address sending the amount. i.e. "0x1234..."
    * to_address: Ethereum address receiving the amount. i.e. "0x1234..."
    * value: Eth amount to be sent
  * Returns:
    * String: Hash value of the executed transaction. i.e. "0xabcdef12345..."

* [`gtd_get_transaction_details`]
  * Parameters:
    * transaction_hash: Hash value of an existing transaction. i.e. "0xabcdef12345..."
  * Returns:
    * HTTPoisonResponse: HTTP response containing the transaction details, such as:
      * blockHash     i.e. "0x1d59ff54b1eb26b013ce3cb5fc9dab3705b415a67127a003c3e61eb445bb8df2"
      * blockNumber   i.e. "0x5daf3b", // 6139707
      * from          i.e. "0xa7d9ddbe1f17865597fbd27ec712455208b6b76d",
      * to            i.e. "0xf02c1c8e6114b1dbe8937a39260b5b0a374432bb",
      * gas           i.e. "0xc350", // 50000
      * gasPrice      i.e. "0x4a817c800", // 20000000000
      * hash          i.e. "0x88df016429689c079f3b2f6ad39fa052532c56795b733da78a91ebe6a713944b",
      * value         i.e. "0xf3dbb76162000", // 4290000000000000

### Available Elrond functions
