defmodule ExBinance.Rest.QueryOrder do
  alias ExBinance.Rest.HTTPClient
  alias ExBinance.Timestamp

  @path "/api/v3/order"
  @receiving_window 1000

  def query_order(symbol, order_id, credentials) do
    params = %{
      symbol: symbol,
      orderId: order_id,
      timestamp: Timestamp.now(),
      recvWindow: @receiving_window
    }

    @path
    |> HTTPClient.get_auth(params, credentials)
    |> parse_response()
  end

  defp parse_response({:ok, response}), do: {:ok, ExBinance.Responses.QueryOrder.new(response)}

  defp parse_response({:error, {:binance_error, %{"code" => -2013, "msg" => msg}}}),
    do: {:error, {:not_found, msg}}

  defp parse_response({:error, _} = error), do: error
end
