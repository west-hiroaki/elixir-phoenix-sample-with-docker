defmodule MyApp.UserTest do
  use MyAppWeb.ConnCase

  alias MyApp.{Repo, User}

  setup do
    # 全体的な共通処理を行う場所
    %{grobal_message: "grobal message!"}
  end

  describe "Userの登録テスト" do
    setup do
      # describeでの共通処理を行う場所
      %{local_message: "local message!"}
    end

    test "setupが正しく動作していること（動作サンプル）", %{
      grobal_message: grobal_message,
      local_message: local_message
    } do
      assert grobal_message == "grobal message!"
      assert local_message == "local message!"
    end

    test "最初は Userのデータ数がゼロ件であること" do
      assert User |> Repo.all() |> Enum.empty?() == true
    end

    test "データチェックエラーが発生すること" do
      assert_raise ArgumentError, fn ->
        %{name: "hiro", email: "example.com"}
        |> User.insert!()
      end

      assert User |> Repo.all() |> Enum.count() == 0
    end

    test "データのチェック・登録ができること" do
      %{name: "hiro", email: "user@example.com"}
      |> User.insert!()

      assert User |> Repo.all() |> Enum.count() == 1
    end
  end
end
