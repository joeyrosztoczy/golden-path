# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :golden_path,
  ecto_repos: [GoldenPath.Repo]

# Configures the endpoint
config :golden_path, GoldenPathWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4a36Rpsx9nxMn4pij1rpayrRouAubbvj+Rs22MCwJIkD7wW4HbPgJq69XzVcNLiG",
  render_errors: [view: GoldenPathWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GoldenPath.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Add a base libcluster config for Epmd (erlang distribution protocol)
# This will allow libcluster supervisor to work in all envs except prod
# which uses the k8s strategy.
config :libcluster,
  topologies: [
    example: [
      # The selected clustering strategy. Required.
      strategy: Cluster.Strategy.Epmd
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
