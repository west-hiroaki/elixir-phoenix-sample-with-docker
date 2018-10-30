ExUnit.start()

for repo <- Application.fetch_env!(:my_app, :ecto_repos) do
  Ecto.Adapters.SQL.Sandbox.mode(repo, :manual)
end
