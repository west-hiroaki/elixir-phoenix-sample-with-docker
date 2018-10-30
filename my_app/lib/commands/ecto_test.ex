defmodule MyApp.Commands.EctoTest do
  @moduledoc """
  Ectoテストコマンド
  """
  alias MyApp.{Repo, User}

  @doc """
  Ecto経由でデータinsertし、全件データ取得するサンプル
  """
  @spec main() :: :ok
  def main() do
    # アプリを起動。これを行わないと MyApp.Application が起動しないので Ectoでエラーになる
    # ▸  Evaluation failed: argument error
    # ▸      (stdlib) :ets.lookup_element(Ecto.Registry, nil, 3)
    # ▸      (ecto) lib/ecto/registry.ex:18: Ecto.Registry.lookup/1
    # ▸      (ecto) lib/ecto/adapters/sql.ex:251: Ecto.Adapters.SQL.sql_call/6
    # ▸      (ecto) lib/ecto/adapters/mysql.ex:202: Ecto.Adapters.MySQL.insert/6
    # ▸      (ecto) lib/ecto/repo/schema.ex:547: Ecto.Repo.Schema.apply/4
    # ▸      (ecto) lib/ecto/repo/schema.ex:213: anonymous fn/14 in Ecto.Repo.Schema.do_insert/4
    # ▸      (ecto) lib/ecto/repo/schema.ex:125: Ecto.Repo.Schema.insert!/4
    # ▸      (my_app) lib/my_app/user.ex:58: MyApp.User.insert!/1
    {:ok, _} = Application.ensure_all_started(:my_app)

    %{name: "hiro", email: "user@example.com"}
    |> User.insert!()

    all_users = User |> Repo.all()

    for user <- all_users do
      IO.puts("id=#{user.id}, name=#{user.name}, email=#{user.email}")
    end

    :ok
  end
end
