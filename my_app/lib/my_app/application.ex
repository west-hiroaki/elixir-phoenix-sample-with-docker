defmodule MyApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # Start the Ecto repository
    repo_children = Application.fetch_env!(:my_app, :ecto_repos)

    # アプリケーション起動タイミングを確認するために埋め込んでおく
    # 1. ローカルサーバ起動時
    #    mix phx.server 実行したタイミング
    # 2. ビルドしたパッケージサーバ起動時
    #    _build/dev/rel/my_app/bin/my_app foreground 実行したタイミング
    # 3. Distillery実行時
    #    各コマンド関数内で「Application.ensure_all_started(:my_app)」を実行したタイミング
    #    Distilleryは明示的にこれを実行しないと起動しない。Ectoなどアプリケーション起動が必要なもので実行しないとエラーになる。
    IO.puts("■■ start application")

    for repo <- repo_children do
      IO.puts(repo)
    end

    # List all child processes to be supervised
    children =
      [
        # Start the endpoint when the application starts
        MyAppWeb.Endpoint
        # Starts a worker by calling: MyApp.Worker.start_link(arg)
        # {MyApp.Worker, arg},
      ] ++ repo_children

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MyAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
