# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lil_links,
  ecto_repos: [LilLinks.Repo]

# Configures the endpoint
config :lil_links, LilLinksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mVa7meyzMHHq1c/ycHGr+H8cC403zCM9FeshHNCp6ClgwZofsbRPpd9015Be9pt1",
  render_errors: [view: LilLinksWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LilLinks.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
