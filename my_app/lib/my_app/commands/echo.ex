defmodule MyApp.Commands.Echo do
  @moduledoc """
  コマンドサンプル
  """

  @doc """
  渡されたパラメータを表示するだけのサンプル
  """
  @spec echo_param(List) :: :ok
  def echo_param(params) do
    IO.inspect(params)
    :ok
  end
end
