defmodule MyApp.User do
  @moduledoc """
  ユーザデータを想定したスキーマ。

  以下コマンドで基本を作成。
  ```
  $ mix phx.gen.schema User users \
    name:string \
    email:string \
    bio:string \
    number_of_pets:integer \
    last_logined_at:utc_datetime
  ```
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.{Repo, User}

  schema "users" do
    field(:bio, :string)
    field(:email, :string)
    field(:last_logined_at, :utc_datetime)
    field(:name, :string)
    field(:number_of_pets, :integer)

    timestamps()
  end

  @doc """
  データチェックを行う
  """
  @spec changeset(%{}) :: Ecto.Changeset
  def changeset(attrs) do
    %User{}
    |> cast(attrs, [:name, :email, :bio, :number_of_pets, :last_logined_at])
    |> validate_required([:name, :email])
    |> validate_length(:bio, min: 2)
    |> validate_length(:bio, max: 140)
    |> validate_format(:email, ~r/@/)
  end

  @doc """
  データ登録を行う
  パラメータ例）
  attrs = %User{name: "hiro", email: "user@example.com"}
  """
  @spec insert!(%{}) :: :ok | no_return
  def insert!(attrs) do
    # データチェック
    changeset = changeset(attrs)

    if changeset.valid? == false do
      raise ArgumentError, message: changeset.errors
    end

    changeset
    |> Repo.insert!()

    :ok
  end
end
