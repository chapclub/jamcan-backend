# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jamstack,
  ecto_repos: [Jamstack.Repo]

# Configures the endpoint
config :jamstack, JamstackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dvf1utiOWkRU8/ir5OGQSF3GYi34h6+UX1rqvrUglZfL6vTRUKsfBtWRKCqeOsM/",
  render_errors: [view: JamstackWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jamstack.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :goth,
  json: "/Users/jorge/projects/jamstack/config/delvaze-e409efb45654.json" |> File.read!

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
