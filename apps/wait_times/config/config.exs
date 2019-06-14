use Mix.Config

config :wait_times, WaitTimes.Repo,
  database: "dev",
  username: "postgres",
  password: "meh",
  hostname: "localhost",
  port: 2345

config :wait_times, ecto_repos: [WaitTimes.Repo]
