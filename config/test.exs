use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :golden_path, GoldenPathWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :golden_path, GoldenPath.Repo,
  username: "postgres",
  password: "postgres",
  database: "golden_path_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
