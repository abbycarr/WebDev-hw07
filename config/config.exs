# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hw07,
  ecto_repos: [Hw07.Repo]

# Configures the endpoint
config :hw07, Hw07Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oAN44Pez3weQiMyQV3gr07b2w3ZjaueDvVsvczZSgpprFAS6tZ4B2/n88XF+xuzZ",
  render_errors: [view: Hw07Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Hw07.PubSub,
  live_view: [signing_salt: "1dwO+/tK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
