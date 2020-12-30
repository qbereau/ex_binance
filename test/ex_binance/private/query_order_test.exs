defmodule ExBinance.Private.QueryOrderTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Mock

  setup_all do
    HTTPoison.start()
  end

  @credentials %ExBinance.Credentials{
    api_key: System.get_env("BINANCE_API_KEY"),
    secret_key: System.get_env("BINANCE_API_SECRET")
  }

  describe ".query_order" do
    test "can query an order" do
      use_cassette "query_order" do
        assert {:ok, %ExBinance.Responses.QueryOrder{} = response} =
                  ExBinance.Private.query_order(
                    "BTCUSDT",
                    71586,
                    @credentials
                  )

        assert response.client_order_id != nil
        assert response.executed_qty == "1.00000000"
        assert response.order_id == 71586
        assert response.orig_qty == "1.00000000"
        assert response.price != nil
        assert response.side == "BUY"
        assert response.status == "FILLED"
        assert response.symbol == "BTCUSDT"
        assert response.time_in_force == "GTC"
        assert response.type == "LIMIT"
        assert response.order_list_id == -1
        assert response.cummulative_quote_qty == "1060.53692218"
        assert response.stop_price == "0.00000000"
        assert response.iceberg_qty == "0.00000000"
        assert response.time == 1609339381664
        assert response.update_time == 1609339736341
        assert response.is_working == true
        assert response.orig_quote_order_qty == "0.00000000"
      end
    end
  end
end
