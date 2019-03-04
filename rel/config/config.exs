##
## This file is evaluated/executed at RUNTIME.
##
## All environment variables will be loaded at runtime and must use the syntax:
##
##    config_param: System.get_env("ENV_VAR")
##
## To understand why, keep reading.

# Configuration defined here overrides compile-time configuration from the config/ folder.
# This is used exclusively by Distillery and does not apply to running the app with Mix.
#
# Source: https://dockyard.com/blog/2018/08/23/announcing-distillery-2-0
#
# It is recommended that ALL configuration parameters using environment variables set in the
# compile-time configuration files (in config/) be OVERRIDDEN here. This is to prevent the "build"
# environment to leak into the "execution" environment.
#
# Based on the files `config/config.exs` and `config/prod.exs`, here is the list of environment
# variables that should be set in the current file. They will be loaded at runtime and must also
# be available (exported) in the target environment (where the app runs):
#
# From config/config.exs:
#
# From config/prod.exs:
# - PORT            (set by Gigalixir)
# - SECRET_KEY_BASE (set by Gigalixir)
# - APP_HOSTNAME
# - APP_DATABASE_URL (if using a remote like RDS)
#
# FOR USE IN GIGALIXIR REMOTES ONLY (we cluster with EPMD locally for testing):
# - LIBCLUSTER_KUBERNETES_SELECTOR (internal to Gigalixir)
# - LIBCLUSTER_KUBERNETES_NODE_BASENAME (internal to Gigalixir)

use Mix.Config

##
## Override config/config.exs
##

## For example, if you have generic configs like Guardian, Auth0, other stuffs...

##
## Override config/prod.exs
##

# Configure Phoenix.
config :golden_path, GoldenPathWeb.Endpoint,
  # We explicitly set a default b/c of a behavior issue in gigalixir
  #
  # From Jesse (Founder of Gigalixir, in debug email):
  #
  # When determining whether you are running distillery 1.x or 2.x, we
  # run distillery's eval command. It looks like you guys look for the
  # PORT variable and convert it to an integer which breaks here.
  # When we run distillery's eval command, it tries to find the PORT
  # variable and it turns out it doesn't exist during the build phase. It exists during the run phase only.
  http: [port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  url: [host: System.get_env("GOLDENPATH_HOSTNAME")]

# Configure the database.
config :golden_path, GoldenPath.Repo, url: System.get_env("DATABASE_URL")

# Configure node-clustering, with k8s strategy (which Gigalixir uses)
# so we can open up nodes for remote consoles/observers.
config :libcluster,
  topologies: [
    k8s_example: [
      strategy: Cluster.Strategy.Kubernetes,
      config: [
        kubernetes_selector: System.get_env("LIBCLUSTER_KUBERNETES_SELECTOR"),
        kubernetes_node_basename: System.get_env("LIBCLUSTER_KUBERNETES_NODE_BASENAME")
      ]
    ]
  ]
