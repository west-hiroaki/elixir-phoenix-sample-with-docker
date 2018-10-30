# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set dev_mode: true

  # true にして erts を入れないと エラー時のスタックトレースの行頭にアプリ名が表示されない
  # あと、supervisor に登録されないかも
  set include_erts: true

  set cookie: :"%My.X!,0bb&L*gGpwIcZl|Jm29@z;HE[bma.d@{LR8n;7;//~0K.i!F2PP9`_!2z"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"hqsp?x|7v^_GD|u[>^DaVkWb3u@W1Hd$S_t/gO:eYbTz{sbXpZ[SC`n^<]CH6j1/"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :my_app do
  set version: current_version(:my_app)

  set post_start_hooks: "rel/hooks/post_start"

  set applications: [
    :runtime_tools
  ]

  set commands: [
    test_echo: "rel/commands/test_echo",
    ecto_test: "rel/commands/ecto_test",
  ]
end

