defmodule MyApp.Commands.Echo do
  @moduledoc """
  コマンドサンプル
  """

  @doc """
  渡されたパラメータを表示するだけのサンプル
  """
  @spec echo_param(List) :: :ok
  def echo_param(params) do
    if is_list(params) do
      # 配列の場合はループさせて表示
      for param <- params do
        IO.puts(param)
      end
    else
      IO.puts(params)
    end

    :ok
  end
end
